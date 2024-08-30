{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

module Domain.Action.Dashboard.Management.Payout
  ( getPayoutPayoutReferralHistory,
    getPayoutPayoutHistory,
    postPayoutPayoutVerifyFraudStatus,
    postPayoutPayoutRetryFailed,
    postPayoutPayoutRetryAllWithStatus,
  )
where

import qualified API.Types.ProviderPlatform.Management.Payout as DTP
import qualified Control.Monad.Extra as Control
import qualified Dashboard.Common
import Data.OpenApi (ToSchema)
import qualified Data.Text as T
import Data.Time (LocalTime, addUTCTime, minutesToTimeZone, utcToLocalTime, utctDay)
import qualified Domain.Action.UI.Payout as DAP
import qualified Domain.Types.DailyStats as DDS
import qualified Domain.Types.Extra.MerchantServiceConfig as DEMSC
import qualified Domain.Types.Merchant
import qualified Domain.Types.MerchantOperatingCity as DMOC
import qualified Domain.Types.PayoutConfig as DPC
import qualified Domain.Types.Person as DP
import qualified Domain.Types.Ride as DRide
import qualified Domain.Types.RiderDetails as DR
import qualified Domain.Types.VehicleCategory as DV
import qualified Environment
import EulerHS.Prelude hiding (elem, forM_, id, map, mapM_, whenJust)
import Kernel.Beam.Functions (runInReplica)
import Kernel.External.Encryption (decrypt, decryptItem, encrypt, getDbHash)
import qualified Kernel.External.Payout.Interface as Juspay
import qualified Kernel.External.Payout.Juspay.Types.Payout as TPayout
import qualified Kernel.External.Payout.Types as PT
import Kernel.Prelude
import qualified Kernel.Prelude
import qualified Kernel.Storage.Hedis as Redis
import Kernel.Types.APISuccess (APISuccess (Success))
import qualified Kernel.Types.APISuccess
import qualified Kernel.Types.Beckn.Context
import Kernel.Types.Common
import Kernel.Types.Error
import Kernel.Types.Id
import qualified Kernel.Types.Id
import Kernel.Utils.Common
import qualified Lib.Payment.Domain.Action as Payout
import qualified Lib.Payment.Domain.Types.Common as DLP
import qualified Lib.Payment.Domain.Types.PayoutOrder as PO
import qualified Lib.Payment.Storage.Queries.PayoutOrder as QPayoutOrder
import Servant hiding (throwError)
import qualified Storage.Cac.TransporterConfig as CTC
import qualified Storage.CachedQueries.Merchant as QM
import qualified Storage.CachedQueries.Merchant.MerchantOperatingCity as CQMOC
import qualified Storage.CachedQueries.Merchant.MerchantPushNotification as CPN
import qualified Storage.CachedQueries.Merchant.PayoutConfig as CPC
import qualified Storage.Queries.DailyStats as QDS
import qualified Storage.Queries.DriverInformation as QDI
import qualified Storage.Queries.DriverStats as QDriverStats
import qualified Storage.Queries.Person as QPerson
import qualified Storage.Queries.Ride as QR
import qualified Storage.Queries.RiderDetails as QRD
import qualified Storage.Queries.Vehicle as QVeh
import Tools.Auth
import Tools.Error
import Tools.Notifications
import qualified Tools.Payout as TP
import Utils.Common.Cac.KeyNameConstants

data RiderDetailsWithRide = RiderDetailsWithRide
  { riderDetail :: DR.RiderDetails,
    ride :: Maybe DRide.Ride
  }

getPayoutPayoutReferralHistory :: Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> Kernel.Prelude.Maybe Kernel.Prelude.Bool -> Kernel.Prelude.Maybe Kernel.Prelude.Text -> Kernel.Prelude.Maybe Kernel.Prelude.UTCTime -> Kernel.Prelude.Maybe Kernel.Prelude.Int -> Kernel.Prelude.Maybe Kernel.Prelude.Int -> Kernel.Prelude.Maybe (Kernel.Types.Id.Id Dashboard.Common.Driver) -> Kernel.Prelude.Maybe Kernel.Prelude.UTCTime -> Environment.Flow DTP.PayoutReferralHistoryRes
getPayoutPayoutReferralHistory merchantShortId opCity areActivatedRidesOnly_ mbCustomerPhoneNo mbFrom mbLimit mbOffset mbReferredByDriver mbTo = do
  let limit = min maxLimit . fromMaybe defaultLimit $ mbLimit
      offset = fromMaybe 0 mbOffset
      areActivatedRidesOnly = fromMaybe False areActivatedRidesOnly_
  merchant <- QM.findByShortId merchantShortId >>= fromMaybeM (MerchantDoesNotExist merchantShortId.getShortId)
  merchantOpCity <- CQMOC.findByMerchantIdAndCity merchant.id opCity >>= fromMaybeM (MerchantOperatingCityNotFound $ "merchant-Id-" <> merchant.id.getId <> "-city-" <> show opCity)
  mbMobileNumberHash <- mapM getDbHash mbCustomerPhoneNo
  allRiderDetails <- runInReplica $ QRD.findAllRiderDetailsWithOptions merchant.id limit offset mbFrom mbTo areActivatedRidesOnly (cast <$> mbReferredByDriver) mbMobileNumberHash
  riderDetailsWithRide_ <- mapM getRiderDetailsWithOpCity allRiderDetails
  let riderDetailsWithRide = filter (\rd -> ((rd.ride <&> (.merchantOperatingCityId)) == Just merchantOpCity.id) || isNothing rd.ride) riderDetailsWithRide_
  history <- mapM (buildReferralHistoryItem merchantOpCity) riderDetailsWithRide
  pure $ DTP.PayoutReferralHistoryRes {history}
  where
    maxLimit = 20
    defaultLimit = 10
    buildReferralHistoryItem merchantOpCity riderDetailWithRide = do
      let rd = riderDetailWithRide.riderDetail
      phoneNo <- decrypt rd.mobileNumber
      now <- getCurrentTime
      let rideEndTime = (.tripEndTime) =<< riderDetailWithRide.ride
      transporterConfig <- CTC.findByMerchantOpCityId merchantOpCity.id Nothing >>= fromMaybeM (TransporterConfigDoesNotExist merchantOpCity.id.getId)
      pure $
        DTP.ReferralHistoryItem
          { referralDate = fromMaybe now rd.referredAt,
            customerPhone = Just phoneNo,
            hasTakenValidActivatedRide = isNothing rd.payoutFlagReason && isJust rd.firstRideId,
            riderDetailsId = rd.id.getId,
            dateOfActivation = utcToIst (secondsToMinutes transporterConfig.timeDiffFromUtc) rideEndTime,
            fraudFlaggedReason = castFlagReasonToCommon <$> rd.payoutFlagReason,
            rideId = Id <$> rd.firstRideId,
            referredByDriver = cast <$> rd.referredByDriver,
            isReviewed = isJust rd.isFlagConfirmed
          }
    getRiderDetailsWithOpCity riderDetail = do
      mbRide <- forM riderDetail.firstRideId $ \rideId -> runInReplica $ QR.findById (Id rideId) >>= fromMaybeM (RideDoesNotExist rideId)
      pure RiderDetailsWithRide {riderDetail = riderDetail, ride = mbRide}

utcToIst :: Minutes -> Maybe Kernel.Prelude.UTCTime -> Maybe LocalTime
utcToIst timeZoneDiff = fmap $ utcToLocalTime (minutesToTimeZone timeZoneDiff.getMinutes)

getPayoutPayoutHistory :: Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> Kernel.Prelude.Maybe (Kernel.Types.Id.Id Dashboard.Common.Driver) -> Kernel.Prelude.Maybe Kernel.Prelude.Text -> Kernel.Prelude.Maybe Kernel.Prelude.UTCTime -> Kernel.Prelude.Maybe Kernel.Prelude.Bool -> Kernel.Prelude.Maybe Kernel.Prelude.Int -> Kernel.Prelude.Maybe Kernel.Prelude.Int -> Kernel.Prelude.Maybe Kernel.Prelude.UTCTime -> Environment.Flow DTP.PayoutHistoryRes
getPayoutPayoutHistory merchantShortId opCity mbDriverId mbDriverPhoneNo mbFrom mbIsFailedOnly mbLimit mbOffset mbTo = do
  let limit = min maxLimit . fromMaybe defaultLimit $ mbLimit
      offset = fromMaybe 0 mbOffset
      isFailedOnly = fromMaybe False mbIsFailedOnly
  merchant <- QM.findByShortId merchantShortId >>= fromMaybeM (MerchantDoesNotExist merchantShortId.getShortId)
  merchantOpCity <- CQMOC.findByMerchantIdAndCity merchant.id opCity >>= fromMaybeM (MerchantOperatingCityNotFound $ "merchant-Id-" <> merchant.id.getId <> "-city-" <> show opCity)
  person <- getPerson merchant.id
  unless (person.merchantOperatingCityId == merchantOpCity.id) . throwError $ PersonNotFound "Given driverId / driverPhoneNumber does not belong to the city for the given user"
  let driverId = person.id.getId
  mbMobileNumberHash <- mapM getDbHash mbDriverPhoneNo
  payoutOrders <- runInReplica $ QPayoutOrder.findAllWithOptions limit offset (Just driverId) mbMobileNumberHash mbFrom mbTo isFailedOnly
  historyList <- mapM (getPayoutPayoutHistoryItem person merchantOpCity) payoutOrders
  pure DTP.PayoutHistoryRes {history = historyList}
  where
    maxLimit = 20
    defaultLimit = 10
    getPayoutPayoutHistoryItem person merchantOpCity payoutOrder = do
      phoneNo <- decrypt payoutOrder.mobileNo
      transporterConfig <- CTC.findByMerchantOpCityId merchantOpCity.id (Just (DriverId (cast person.id))) >>= fromMaybeM (TransporterConfigDoesNotExist merchantOpCity.id.getId)
      let timeZoneDiff = secondsToMinutes transporterConfig.timeDiffFromUtc
      pure $
        DTP.PayoutHistoryItem
          { driverName = person.firstName,
            driverPhoneNo = phoneNo,
            driverId = Id payoutOrder.customerId,
            payoutAmount = payoutOrder.amount.amount,
            payoutStatus = show payoutOrder.status,
            payoutTime = utcToLocalTime (minutesToTimeZone timeZoneDiff.getMinutes) payoutOrder.createdAt,
            payoutEntity = castPayoutEntityName <$> payoutOrder.entityName
          }

    getPerson merchantId = case (mbDriverPhoneNo, mbDriverId) of
      (Just phoneNo, _) -> do
        numberHash <- getDbHash phoneNo
        QPerson.findByMobileNumberAndMerchantAndRole "+91" numberHash merchantId DP.DRIVER >>= fromMaybeM (PersonNotFound $ "phoneNoHash-" <> show numberHash <> "-merchantId-" <> merchantId.getId <> "-role-" <> show DP.DRIVER)
      (_, Just driverId) -> QPerson.findById (cast driverId) >>= fromMaybeM (PersonNotFound driverId.getId)
      _ -> throwError $ InvalidRequest "Either driverId or driverPhoneNo is required"

postPayoutPayoutVerifyFraudStatus :: Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> DTP.UpdateFraudStatusReq -> Environment.Flow APISuccess
postPayoutPayoutVerifyFraudStatus merchantShortId opCity req = do
  riderDetails <- QRD.findById (cast $ Id req.riderDetailsId) >>= fromMaybeM (RiderDetailsDoNotExist "Rider Detail Id" req.riderDetailsId)
  when (isJust riderDetails.isFlagConfirmed) $ throwError $ InvalidRequest $ "Already confirmed by dashboard of riderDetails: " <> req.riderDetailsId
  QRD.updateIsFlagConfirmed (Just req.isFlagConfirmed) (cast $ Id req.riderDetailsId)
  if not req.isFlagConfirmed -- pay in case of false
    then do
      merchant <- QM.findByShortId merchantShortId >>= fromMaybeM (MerchantDoesNotExist merchantShortId.getShortId)
      merchantOpCity <- CQMOC.findByMerchantIdAndCity merchant.id opCity >>= fromMaybeM (MerchantOperatingCityNotFound $ "merchant-Id-" <> merchant.id.getId <> "-city-" <> show opCity)
      mbVehicle <- QVeh.findById (cast req.driverId)
      let vehicleCategory = fromMaybe DV.AUTO_CATEGORY ((.category) =<< mbVehicle)
      payoutConfig <- CPC.findByPrimaryKey merchantOpCity.id vehicleCategory >>= fromMaybeM (InternalError $ "Payout config not present for " <> show merchantOpCity.city)
      ride <- QR.findById (cast req.firstRideId) >>= fromMaybeM (RideDoesNotExist req.firstRideId.getId)
      transporterConfig <- CTC.findByMerchantOpCityId merchantOpCity.id (Just (DriverId (cast req.driverId))) >>= fromMaybeM (TransporterConfigDoesNotExist merchantOpCity.id.getId)
      when (isNothing ride.tripEndTime) $ throwError $ InvalidRequest "First Ride is Not Completed by the Referred Customer"
      when (isNothing riderDetails.payoutFlagReason) $ throwError $ InvalidRequest "Cannot Update Flag For Non Fraud Driver"
      whenJust ride.tripEndTime $ \rideEndTime -> do
        now <- getCurrentTime
        dInfo <- QDI.findById (cast req.driverId) >>= fromMaybeM (PersonNotFound req.driverId.getId)
        let localTimeOfThatDay = addUTCTime (secondsToNominalDiffTime transporterConfig.timeDiffFromUtc) rideEndTime
        driverStats <- QDriverStats.findByPrimaryKey (cast req.driverId) >>= fromMaybeM (PersonNotFound req.driverId.getId)
        QDriverStats.updateTotalValidRidesAndPayoutEarnings (driverStats.totalValidActivatedRides + 1) (driverStats.totalPayoutEarnings + payoutConfig.referralRewardAmountPerRide) (cast req.driverId)
        dailyStats <- getDailyStats payoutConfig (cast req.driverId) (utctDay localTimeOfThatDay) ride
        QRD.updatePayoutFlagReason Nothing (cast $ Id req.riderDetailsId) -- mark as non fraud (remove fraud flag) and pay the driver
        unless (utctDay rideEndTime == utctDay now) $ do
          -- don't pay if it's the same day, payout will happen via scheduler
          case dInfo.payoutVpa of
            Just vpa -> do
              uid <- generateGUID
              driver <- QPerson.findById (cast req.driverId) >>= fromMaybeM (PersonNotFound req.driverId.getId)
              mbMerchantPN <- CPN.findMatchingMerchantPN merchantOpCity.id "PAYOUT_REFERRAL_REWARD" driver.language
              whenJust mbMerchantPN $ \merchantPN -> do
                let title = T.replace "{#rewardAmount#}" (show payoutConfig.referralRewardAmountPerRide) merchantPN.title
                    entityData = NotifReq {entityId = driver.id.getId, title = title, message = merchantPN.body}
                notifyDriverOnEvents merchantOpCity.id driver.id driver.deviceToken entityData merchantPN.fcmNotificationType -- Sending PN for Reward
              Redis.withWaitOnLockRedisWithExpiry (DAP.payoutProcessingLockKey req.driverId.getId) 1 1 $ do
                QDS.updatePayoutOrderId (Just uid) dailyStats.id
              createOrderReq <- createReq payoutConfig vpa uid req.driverId payoutConfig.referralRewardAmountPerRide
              let serviceName = DEMSC.PayoutService PT.Juspay
              let entityName = DLP.DAILY_STATS_VIA_DASHBOARD
                  createPayoutOrderCall = TP.createPayoutOrder merchant.id merchantOpCity.id serviceName
              void $ Payout.createPayoutService (Kernel.Types.Id.cast merchant.id) (Kernel.Types.Id.cast req.driverId) (Just [dailyStats.id]) (Just entityName) (show merchantOpCity.city) createOrderReq createPayoutOrderCall
            Nothing -> do
              Redis.withWaitOnLockRedisWithExpiry (DAP.payoutProcessingLockKey req.driverId.getId) 1 1 $ do
                QDS.updatePayoutStatusById DDS.PendingForVpa dailyStats.id
    else pure ()
  return Success
  where
    getDailyStats payoutConfig driverId merchantLocalDate ride = do
      let referralRewardAmount = payoutConfig.referralRewardAmountPerRide
      now <- getCurrentTime
      mbDailyStats <- QDS.findByDriverIdAndDate driverId merchantLocalDate
      case mbDailyStats of
        Nothing -> do
          id <- generateGUIDText
          let dailyStats =
                DDS.DailyStats
                  { id = id,
                    driverId = driverId,
                    totalEarnings = 0.0,
                    numRides = 0,
                    totalDistance = 0,
                    tollCharges = 0.0,
                    bonusEarnings = 0.0,
                    merchantLocalDate = merchantLocalDate,
                    currency = ride.currency,
                    distanceUnit = ride.distanceUnit,
                    activatedValidRides = 1,
                    cancellationCharges = 0.0,
                    tipAmount = 0.0,
                    totalRideTime = 0,
                    referralEarnings = referralRewardAmount,
                    referralCounts = 1,
                    payoutStatus = DDS.Processing,
                    payoutOrderId = Nothing,
                    payoutOrderStatus = Nothing,
                    createdAt = now,
                    updatedAt = now
                  }

          QDS.create dailyStats -- create dstats for that date
          pure dailyStats
        Just ds -> do
          Redis.withWaitOnLockRedisWithExpiry (DAP.payoutProcessingLockKey driverId.getId) 1 1 $ do
            QDS.updateReferralStatsByDriverId (ds.activatedValidRides + 1) (ds.referralEarnings + referralRewardAmount) DDS.Processing driverId merchantLocalDate
          pure $ ds {DDS.activatedValidRides = ds.activatedValidRides + 1, DDS.referralEarnings = ds.referralEarnings + referralRewardAmount, DDS.payoutStatus = DDS.Processing, DDS.updatedAt = now}

postPayoutPayoutRetryFailed :: Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> DTP.FailedRetryPayoutReq -> Environment.Flow APISuccess
postPayoutPayoutRetryFailed merchantShortId opCity req = do
  merchant <- QM.findByShortId merchantShortId >>= fromMaybeM (MerchantDoesNotExist merchantShortId.getShortId)
  merchantOpCity <- CQMOC.findByMerchantIdAndCity merchant.id opCity >>= fromMaybeM (MerchantOperatingCityNotFound $ "merchant-Id-" <> merchant.id.getId <> "-city-" <> show opCity)
  payoutOrder <- QPayoutOrder.findByOrderId req.payoutOrderId >>= fromMaybeM (PayoutOrderNotFound req.payoutOrderId)
  callPayoutAndUpdateDailyStats merchant merchantOpCity payoutOrder
  pure Success

postPayoutPayoutRetryAllWithStatus :: Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> DTP.RetryPayoutsReq -> Environment.Flow APISuccess
postPayoutPayoutRetryAllWithStatus merchantShortId opCity req = do
  merchant <- QM.findByShortId merchantShortId >>= fromMaybeM (MerchantDoesNotExist merchantShortId.getShortId)
  merchantOpCity <- CQMOC.findByMerchantIdAndCity merchant.id opCity >>= fromMaybeM (MerchantOperatingCityNotFound $ "merchant-Id-" <> merchant.id.getId <> "-city-" <> show opCity)
  let entityNames = map castEntityName req.entityNames
  payoutOrders <- runInReplica $ QPayoutOrder.findAllWithStatusAndEntity req.limit req.offset req.status entityNames
  mapM_ (callPayoutAndUpdateDailyStats merchant merchantOpCity) payoutOrders
  pure Success

callPayoutAndUpdateDailyStats :: Domain.Types.Merchant.Merchant -> DMOC.MerchantOperatingCity -> PO.PayoutOrder -> Environment.Flow ()
callPayoutAndUpdateDailyStats merchant merchantOpCity payoutOrder = do
  let driverId = Id payoutOrder.customerId
  when (isNothing payoutOrder.vpa) $ throwError $ InvalidRequest "VPA does not Exist" -- vpa will always exist
  orderStatusRep <- getPayoutOrderStatus (driverId, merchant.id, merchantOpCity.id) payoutOrder
  when (orderStatusRep.status `elem` [TPayout.FULFILLMENTS_FAILURE, TPayout.FULFILLMENTS_CANCELLED, TPayout.FAILURE, TPayout.ERROR]) do
    mbVehicle <- QVeh.findById (cast driverId)
    let vehicleCategory = fromMaybe DV.AUTO_CATEGORY ((.category) =<< mbVehicle)
    payoutConfig <- CPC.findByPrimaryKey merchantOpCity.id vehicleCategory >>= fromMaybeM (InternalError $ "Payout config not present for " <> show merchantOpCity.city)
    uid <- generateGUID
    createOrderReq <- createReq payoutConfig (fromJust payoutOrder.vpa) uid driverId payoutOrder.amount.amount
    let serviceName = DEMSC.PayoutService PT.Juspay
        entityName = DLP.RETRY_VIA_DASHBOARD
        createPayoutOrderCall = TP.createPayoutOrder merchant.id merchantOpCity.id serviceName
    void $ Payout.createPayoutService (Kernel.Types.Id.cast merchant.id) (cast driverId) payoutOrder.entityIds (Just entityName) (show merchantOpCity.city) createOrderReq createPayoutOrderCall
    updateDailyStatsStatus uid (Id payoutOrder.customerId) payoutOrder.entityIds

updateDailyStatsStatus :: Text -> Id Dashboard.Common.Driver -> Maybe [Text] -> Environment.Flow ()
updateDailyStatsStatus newOrderId driverId mbStatsIds = do
  whenJust mbStatsIds $ \statsIds -> do
    forM_ statsIds $ \id -> do
      Redis.withWaitOnLockRedisWithExpiry (DAP.payoutProcessingLockKey driverId.getId) 1 1 $ do
        QDS.updatePayoutOrderIdAndStatus (Just newOrderId) DDS.Processing id

createReq :: DPC.PayoutConfig -> Text -> Text -> Id Dashboard.Common.Driver -> HighPrecMoney -> Environment.Flow Juspay.CreatePayoutOrderReq
createReq payoutConfig vpa uid driverId amount = do
  person <- QPerson.findById (cast driverId) >>= fromMaybeM (PersonNotFound driverId.getId)
  phoneNo <- mapM decrypt person.mobileNumber
  pure
    Juspay.CreatePayoutOrderReq
      { orderId = uid,
        amount = amount,
        customerPhone = fromMaybe "6666666666" phoneNo,
        customerEmail = fromMaybe "dummymail@gmail.com" person.email,
        customerId = person.id.getId,
        orderType = payoutConfig.orderType,
        remark = payoutConfig.remark,
        customerName = person.firstName,
        customerVpa = vpa
      }

getPayoutOrderStatus :: (Id Dashboard.Common.Driver, Id Domain.Types.Merchant.Merchant, Id DMOC.MerchantOperatingCity) -> PO.PayoutOrder -> Environment.Flow Juspay.PayoutOrderStatusResp
getPayoutOrderStatus (driverId, merchantId, merchantOpCityId) payoutOrder = do
  let payoutOrderStatusReq = Juspay.PayoutOrderStatusReq {orderId = payoutOrder.orderId}
      serviceName = DEMSC.PayoutService PT.Juspay
  statusResp <- TP.payoutOrderStatus merchantId merchantOpCityId serviceName payoutOrderStatusReq
  Payout.payoutStatusUpdates statusResp.status payoutOrder.orderId (Just statusResp)
  when (maybe False (`elem` [DLP.DRIVER_DAILY_STATS, DLP.BACKLOG, DLP.DAILY_STATS_VIA_DASHBOARD, DLP.RETRY_VIA_DASHBOARD]) payoutOrder.entityName) do
    whenJust payoutOrder.entityIds $ \dStatsIds -> do
      forM_ dStatsIds $ \dStatsId -> do
        Redis.withWaitOnLockRedisWithExpiry (DAP.payoutProcessingLockKey driverId.getId) 1 1 $ do
          let dPayoutStatus = castPayoutOrderStatus statusResp.status
          QDS.updatePayoutStatusById dPayoutStatus dStatsId
  pure statusResp

castFlagReasonToCommon :: DR.PayoutFlagReason -> DTP.PayoutFlagReason
castFlagReasonToCommon flag = case flag of
  DR.ExceededMaxReferral -> DTP.ExceededMaxReferral
  DR.MinRideDistanceInvalid -> DTP.MinRideDistanceInvalid
  DR.MinPickupDistanceInvalid -> DTP.MinPickupDistanceInvalid
  DR.CustomerExistAsDriver -> DTP.CustomerExistAsDriver
  DR.MultipleDeviceIdExists -> DTP.MultipleDeviceIdExists

castPayoutEntityName :: DLP.EntityName -> DTP.EntityName
castPayoutEntityName entity = case entity of
  DLP.MANUAL -> DTP.MANUAL
  DLP.DRIVER_DAILY_STATS -> DTP.DRIVER_DAILY_STATS
  DLP.BACKLOG -> DTP.BACKLOG
  DLP.DAILY_STATS_VIA_DASHBOARD -> DTP.DAILY_STATS_VIA_DASHBOARD
  DLP.RETRY_VIA_DASHBOARD -> DTP.RETRY_VIA_DASHBOARD

castPayoutOrderStatus :: TPayout.PayoutOrderStatus -> DDS.PayoutStatus
castPayoutOrderStatus payoutOrderStatus =
  case payoutOrderStatus of
    TPayout.SUCCESS -> DDS.Success
    TPayout.FULFILLMENTS_SUCCESSFUL -> DDS.Success
    TPayout.ERROR -> DDS.Failed
    TPayout.FAILURE -> DDS.Failed
    TPayout.FULFILLMENTS_FAILURE -> DDS.Failed
    TPayout.CANCELLED -> DDS.ManualReview
    TPayout.FULFILLMENTS_CANCELLED -> DDS.ManualReview
    TPayout.FULFILLMENTS_MANUAL_REVIEW -> DDS.ManualReview
    _ -> DDS.Processing

castEntityName :: DTP.EntityName -> Maybe DLP.EntityName
castEntityName entity =
  Just $ case entity of
    DTP.MANUAL -> DLP.MANUAL
    DTP.DRIVER_DAILY_STATS -> DLP.DRIVER_DAILY_STATS
    DTP.BACKLOG -> DLP.BACKLOG
    DTP.DAILY_STATS_VIA_DASHBOARD -> DLP.DAILY_STATS_VIA_DASHBOARD
    DTP.RETRY_VIA_DASHBOARD -> DLP.RETRY_VIA_DASHBOARD
