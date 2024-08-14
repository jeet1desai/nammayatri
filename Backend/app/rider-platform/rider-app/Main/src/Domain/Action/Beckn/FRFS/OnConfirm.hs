{-
 Copyright 2022-23, Juspay India Pvt Ltd

 This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License

 as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program

 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY

 or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details. You should have received a copy of

 the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
-}

module Domain.Action.Beckn.FRFS.OnConfirm where

import qualified Beckn.ACL.FRFS.Cancel as ACL
import qualified Beckn.ACL.FRFS.Utils as Utils
import qualified BecknV2.FRFS.Enums as Spec
import qualified BecknV2.OnDemand.Enums as OnDemandEnums
import qualified Data.Text as T
import Domain.Action.Beckn.FRFS.Common
import qualified Domain.Action.Beckn.FRFS.OnCancel as DOnCancel
import Domain.Types.BecknConfig
import qualified Domain.Types.FRFSRecon as Recon
import qualified Domain.Types.FRFSTicket as Ticket
import qualified Domain.Types.FRFSTicketBooking as Booking
import qualified Domain.Types.FRFSTicketBooking as DFRFSTicketBooking
import qualified Domain.Types.FRFSTicketBookingPayment as DFRFSTicketBookingPayment
import Domain.Types.Merchant as Merchant
import Environment
import EulerHS.Prelude ((+||), (||+))
import Kernel.Beam.Functions
import Kernel.Beam.Functions as B
import Kernel.External.Encryption
import Kernel.Prelude
import qualified Kernel.Storage.Hedis as Redis
import Kernel.Types.Error
import Kernel.Types.Id
import Kernel.Utils.Common
import qualified Lib.Payment.Storage.Queries.PaymentTransaction as QPaymentTransaction
import qualified SharedLogic.CallFRFSBPP as CallBPP
import qualified SharedLogic.MessageBuilder as MessageBuilder
import Storage.Beam.Payment ()
import qualified Storage.CachedQueries.Merchant as QMerch
import qualified Storage.CachedQueries.Person as CQP
import qualified Storage.Queries.BecknConfig as QBC
import qualified Storage.Queries.FRFSQuote as QFRFSQuote
import qualified Storage.Queries.FRFSRecon as QRecon
import qualified Storage.Queries.FRFSSearch as QSearch
import qualified Storage.Queries.FRFSTicket as QTicket
import qualified Storage.Queries.FRFSTicketBokingPayment as QFRFSTicketBookingPayment
import qualified Storage.Queries.FRFSTicketBooking as QTBooking
import qualified Storage.Queries.Person as QPerson
import qualified Storage.Queries.PersonStats as QPS
import qualified Storage.Queries.Station as QStation
import qualified Tools.SMS as Sms

validateRequest :: DOrder -> Flow (Merchant, Booking.FRFSTicketBooking)
validateRequest DOrder {..} = do
  _ <- runInReplica $ QSearch.findById (Id transactionId) >>= fromMaybeM (SearchRequestDoesNotExist transactionId)
  booking <- runInReplica $ QTBooking.findById (Id messageId) >>= fromMaybeM (BookingDoesNotExist messageId)
  let merchantId = booking.merchantId
  now <- getCurrentTime

  if booking.validTill < now
    then do
      -- Booking is expired
      bapConfig <- QBC.findByMerchantIdDomainAndVehicle (Just merchantId) (show Spec.FRFS) OnDemandEnums.METRO >>= fromMaybeM (InternalError "Beckn Config not found")
      void $ QTBooking.updateBPPOrderIdAndStatusById (Just bppOrderId) Booking.FAILED booking.id
      void $ QFRFSTicketBookingPayment.updateStatusByTicketBookingId DFRFSTicketBookingPayment.REFUND_PENDING booking.id
      let updatedBooking = booking {Booking.bppOrderId = Just bppOrderId}
      callBPPCancel updatedBooking bapConfig Spec.CONFIRM_CANCEL merchantId
      throwM $ InvalidRequest "Booking expired, initated cancel request"
    else do
      -- Booking is valid, proceed to onConfirm handler
      merchant <- QMerch.findById merchantId >>= fromMaybeM (MerchantNotFound merchantId.getId)
      return (merchant, booking)

onConfirm :: Merchant -> Booking.FRFSTicketBooking -> DOrder -> Flow ()
onConfirm merchant booking' dOrder = do
  let booking = booking' {Booking.bppOrderId = Just dOrder.bppOrderId}
  let discountedTickets = fromMaybe 0 booking.discountedTickets
  tickets <- createTickets booking dOrder.tickets discountedTickets
  void $ QTicket.createMany tickets
  void $ QTBooking.updateBPPOrderIdAndStatusById (Just dOrder.bppOrderId) Booking.CONFIRMED booking.id
  person <- runInReplica $ QPerson.findById booking.riderId >>= fromMaybeM (PersonNotFound booking.riderId.getId)
  mRiderNumber <- mapM decrypt person.mobileNumber
  buildReconTable merchant booking dOrder tickets mRiderNumber
  void $ sendTicketBookedSMS mRiderNumber person.mobileCountryCode
  void $ QPS.incrementTicketsBookedInEvent booking.riderId booking.quantity
  void $ CQP.clearPSCache booking.riderId
  return ()
  where
    sendTicketBookedSMS :: Maybe Text -> Maybe Text -> Flow ()
    sendTicketBookedSMS mRiderNumber mRiderMobileCountryCode =
      whenJust booking'.partnerOrgId $ \pOrgId -> do
        fork "send ticket booked sms" $
          withLogTag ("SMS:FRFSBookingId:" <> booking'.id.getId) $ do
            mobileNumber <- mRiderNumber & fromMaybeM (PersonFieldNotPresent "mobileNumber")
            smsCfg <- asks (.smsCfg)
            let mocId = booking'.merchantOperatingCityId
                countryCode = fromMaybe "+91" mRiderMobileCountryCode
                phoneNumber = countryCode <> mobileNumber
                sender = smsCfg.sender
            mbMsg <-
              MessageBuilder.buildFRFSTicketBookedMessage pOrgId $
                MessageBuilder.BuildFRFSTicketBookedMessageReq
                  { countOfTickets = booking'.quantity,
                    bookingId = booking'.id
                  }
            if isJust mbMsg
              then do
                let message = fromJust mbMsg
                logDebug $ "SMS Message:" +|| message ||+ ""
                Sms.sendSMS booking'.merchantId mocId (Sms.SendSMSReq message phoneNumber sender) >>= Sms.checkSmsResult
              else do
                logError $ "SMS not sent, SMS template not found for partnerOrgId:" <> pOrgId.getId

buildReconTable :: Merchant -> Booking.FRFSTicketBooking -> DOrder -> [Ticket.FRFSTicket] -> Maybe Text -> Flow ()
buildReconTable merchant booking _dOrder tickets mRiderNumber = do
  bapConfig <- QBC.findByMerchantIdDomainAndVehicle (Just merchant.id) (show Spec.FRFS) OnDemandEnums.METRO >>= fromMaybeM (InternalError "Beckn Config not found")
  quote <- runInReplica $ QFRFSQuote.findById booking.quoteId >>= fromMaybeM (QuoteNotFound booking.quoteId.getId)
  fromStation <- runInReplica $ QStation.findById booking.fromStationId >>= fromMaybeM (InternalError "Station not found")
  toStation <- runInReplica $ QStation.findById booking.toStationId >>= fromMaybeM (InternalError "Station not found")
  transactionRefNumber <- booking.paymentTxnId & fromMaybeM (InternalError "Payment Txn Id not found in booking")
  txn <- runInReplica $ QPaymentTransaction.findById (Id transactionRefNumber) >>= fromMaybeM (InvalidRequest "Payment Transaction not found for approved TicketBookingId")
  paymentBooking <- B.runInReplica $ QFRFSTicketBookingPayment.findNewTBPByBookingId booking.id >>= fromMaybeM (InvalidRequest "Payment booking not found for approved TicketBookingId")
  let paymentBookingStatus = paymentBooking.status
  now <- getCurrentTime
  bppOrderId <- booking.bppOrderId & fromMaybeM (InternalError "BPP Order Id not found in booking")
  let finderFee :: Price = mkPrice Nothing $ fromMaybe 0 $ (readMaybe . T.unpack) =<< bapConfig.buyerFinderFee -- FIXME
      finderFeeForEachTicket = modifyPrice finderFee $ \p -> HighPrecMoney $ (p.getHighPrecMoney) / (toRational booking.quantity)
  tOrderPrice <- totalOrderValue paymentBookingStatus booking
  let tOrderValue = modifyPrice tOrderPrice $ \p -> HighPrecMoney $ (p.getHighPrecMoney) / (toRational quote.quantity)
  settlementAmount <- tOrderValue `subtractPrice` finderFeeForEachTicket
  let reconEntry =
        Recon.FRFSRecon
          { Recon.id = "",
            Recon.beneficiaryIFSC = booking.bppBankCode,
            Recon.beneficiaryBankAccount = booking.bppBankAccountNumber,
            Recon.buyerFinderFee = finderFee,
            Recon.collectorIFSC = bapConfig.bapIFSC,
            Recon.collectorSubscriberId = bapConfig.subscriberId,
            Recon.date = show now,
            Recon.destinationStationCode = toStation.code,
            Recon.differenceAmount = Nothing,
            Recon.fare = quote.price,
            Recon.frfsTicketBookingId = booking.id,
            Recon.message = Nothing,
            Recon.mobileNumber = mRiderNumber,
            Recon.networkOrderId = bppOrderId,
            Recon.receiverSubscriberId = booking.bppSubscriberId,
            Recon.settlementAmount,
            Recon.settlementDate = Nothing,
            Recon.settlementReferenceNumber = Nothing,
            Recon.sourceStationCode = fromStation.code,
            Recon.transactionUUID = txn.txnUUID,
            Recon.ticketNumber = "",
            Recon.ticketQty = booking.quantity,
            Recon.time = show now,
            Recon.txnId = txn.txnId,
            Recon.totalOrderValue = tOrderValue,
            Recon.transactionRefNumber = transactionRefNumber,
            Recon.merchantId = Just booking.merchantId,
            Recon.merchantOperatingCityId = Just booking.merchantOperatingCityId,
            Recon.createdAt = now,
            Recon.updatedAt = now,
            Recon.ticketStatus = Nothing,
            Recon.providerId = booking.providerId,
            Recon.providerName = booking.providerName
          }

  reconEntries <- mapM (buildRecon reconEntry) tickets
  void $ QRecon.createMany reconEntries

totalOrderValue :: DFRFSTicketBookingPayment.FRFSTicketBookingPaymentStatus -> Booking.FRFSTicketBooking -> Flow Price
totalOrderValue paymentBookingStatus booking =
  if paymentBookingStatus == DFRFSTicketBookingPayment.REFUND_PENDING || paymentBookingStatus == DFRFSTicketBookingPayment.REFUNDED
    then booking.price `addPrice` refundAmountToPrice -- Here the `refundAmountToPrice` value is in Negative
    else pure $ booking.price
  where
    refundAmountToPrice = mkPrice (Just INR) (fromMaybe (HighPrecMoney $ toRational (0 :: Int)) booking.refundAmount)

mkTicket :: Booking.FRFSTicketBooking -> DTicket -> Bool -> Flow Ticket.FRFSTicket
mkTicket booking dTicket isTicketFree = do
  now <- getCurrentTime
  ticketId <- generateGUID
  (_, status) <- Utils.getTicketStatus booking dTicket

  return
    Ticket.FRFSTicket
      { Ticket.frfsTicketBookingId = booking.id,
        Ticket.id = ticketId,
        Ticket.qrData = dTicket.qrData,
        Ticket.riderId = booking.riderId,
        Ticket.status = status,
        Ticket.ticketNumber = dTicket.ticketNumber,
        Ticket.validTill = dTicket.validTill,
        Ticket.merchantId = booking.merchantId,
        Ticket.merchantOperatingCityId = booking.merchantOperatingCityId,
        Ticket.partnerOrgId = booking.partnerOrgId,
        Ticket.partnerOrgTransactionId = booking.partnerOrgTransactionId,
        Ticket.createdAt = now,
        Ticket.updatedAt = now,
        Ticket.isTicketFree = Just isTicketFree
      }

createTickets :: Booking.FRFSTicketBooking -> [DTicket] -> Int -> Flow [Ticket.FRFSTicket]
createTickets booking dTickets discountedTickets = go dTickets discountedTickets []
  where
    go [] _ acc = return (reverse acc)
    go (d : ds) freeTicketsLeft acc = do
      let isTicketFree = freeTicketsLeft > 0
      ticket <- mkTicket booking d isTicketFree
      let newFreeTickets = if isTicketFree then freeTicketsLeft - 1 else freeTicketsLeft
      go ds newFreeTickets (ticket : acc)

buildRecon :: Recon.FRFSRecon -> Ticket.FRFSTicket -> Flow Recon.FRFSRecon
buildRecon recon ticket = do
  now <- getCurrentTime
  reconId <- generateGUID
  return
    recon
      { Recon.id = reconId,
        Recon.ticketNumber = ticket.ticketNumber,
        Recon.ticketStatus = Just ticket.status,
        Recon.createdAt = now,
        Recon.updatedAt = now
      }

callBPPCancel :: DFRFSTicketBooking.FRFSTicketBooking -> BecknConfig -> Spec.CancellationType -> Id Merchant -> Environment.Flow ()
callBPPCancel booking bapConfig cancellationType merchantId = do
  fork "FRFS Cancel Req" $ do
    providerUrl <- booking.bppSubscriberUrl & parseBaseUrl & fromMaybeM (InvalidRequest "Invalid provider url")
    merchantOperatingCity <- getMerchantOperatingCityFromBooking booking
    ttl <- bapConfig.cancelTTLSec & fromMaybeM (InternalError "Invalid ttl")
    when (cancellationType == Spec.CONFIRM_CANCEL) $ Redis.setExp (DOnCancel.makecancelledTtlKey booking.id) True ttl
    bknCancelReq <- ACL.buildCancelReq booking bapConfig Utils.BppData {bppId = booking.bppSubscriberId, bppUri = booking.bppSubscriberUrl} cancellationType merchantOperatingCity.city
    logDebug $ "FRFS CancelReq " <> encodeToText bknCancelReq
    void $ CallBPP.cancel providerUrl bknCancelReq merchantId
