{-

  Copyright 2022-23, Juspay India Pvt Ltd

  This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License

  as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program

  is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY

  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details. You should have received a copy of

  the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
-}

module Screens.HomeScreen.ComponentConfig where

import Language.Strings
import Common.Types.Config
import Common.Types.App (LazyCheck(..), PolylineAnimationConfig)
import Common.Types.App as CommonTypes
import Components.Banner as Banner
import Components.BannerCarousel as BannerCarousel
import Components.ChatView as ChatView
import Components.ErrorModal (primaryButtonConfig)
import Components.GoToLocationModal as GoToLocationModal
import Components.InAppKeyboardModal as InAppKeyboardModal
import Components.MakePaymentModal as MakePaymentModal
import Components.PopUpModal as PopUpModal
import Components.PrimaryButton as PrimaryButton
import Components.RateCard as RateCard
import Components.RatingCard as RatingCard
import Components.RequestInfoCard as RequestInfoCard
import Components.RideActionModal as RideActionModal
import Components.RideCompletedCard as RideCompletedCard
import Components.RideCompletedCard.Controller (Theme(..))
import Components.SelectListModal as SelectListModal
import Components.StatsModel as StatsModel
import Data.Array as DA
import Data.Int (fromString)
import Data.Int as Int
import Data.Maybe (Maybe(..), fromMaybe, isJust, isNothing)
import Data.String as DS
import Engineering.Helpers.Commons as EHC
import Engineering.Helpers.Suggestions (getSuggestionsfromKey, chatSuggestion)
import Font.Size as FontSize
import Font.Style (Style(..))
import Font.Style (Style(..))
import Font.Style as FontStyle
import Helpers.Utils (fetchImage, FetchImageFrom(..), isYesterday, getMerchantVehicleSize, onBoardingSubscriptionScreenCheck)
import Helpers.Utils as HU
import JBridge as JB
import Language.Strings (getString)
import Language.Types (STR(..))
import Prelude (unit, ($), (-), (/), (<), (<=), (<>), (==), (>=), (||), (>), (/=), show, map, (&&), not, bottom, (<>), (*), negate, otherwise, (+))
import PrestoDOM (Gravity(..), Length(..), Margin(..), Padding(..), Visibility(..), Accessiblity(..), cornerRadius, padding, gravity)
import PrestoDOM.Types.DomAttributes as PTD
import Resource.Constants as Const
import Screens.Types (AutoPayStatus(..), SubscriptionBannerType(..), SubscriptionPopupType(..), GoToPopUpType(..))
import Screens.Types as ST
import Services.API as SA
import Services.API (PaymentBreakUp(..), PromotionPopupConfig(..), Status(..))
import Storage (KeyStore(..), getValueToLocalNativeStore, getValueToLocalStore)
import Styles.Colors as Color
import Components.ErrorModal as ErrorModal
import MerchantConfig.Utils as MU
import PrestoDOM.Types.DomAttributes (Corners(..))
import ConfigProvider as CP
import Locale.Utils
import RemoteConfig (RCCarousel(..))
import Mobility.Prelude (boolToVisibility)
import Constants 
import LocalStorage.Cache (getValueFromCache)

--------------------------------- rideActionModalConfig -------------------------------------
rideActionModalConfig :: ST.HomeScreenState -> RideActionModal.Config
rideActionModalConfig state = 
  let
  config = RideActionModal.config
  rideActionModalConfig' = config {
    startRideActive = (state.props.currentStage == ST.RideAccepted || state.props.currentStage == ST.ChatWithCustomer),
    totalDistance = if state.data.activeRide.distance <= 0.0 then "0.0" else if(state.data.activeRide.distance < 1000.0) then HU.parseFloat (state.data.activeRide.distance) 2 <> " m" else HU.parseFloat((state.data.activeRide.distance / 1000.0)) 2 <> " km",
    customerName = if DS.length (fromMaybe "" ((DS.split (DS.Pattern " ") (state.data.activeRide.riderName)) DA.!! 0)) < 4
                      then (fromMaybe "" ((DS.split (DS.Pattern " ") (state.data.activeRide.riderName)) DA.!! 0)) <> " " <> (fromMaybe "" ((DS.split (DS.Pattern " ") (state.data.activeRide.riderName)) DA.!! 1))
                      else
                        (fromMaybe "" ((DS.split (DS.Pattern " ") (state.data.activeRide.riderName)) DA.!! 0)),
    sourceAddress  {
      titleText = fromMaybe "" ((DS.split (DS.Pattern ",") (state.data.activeRide.source)) DA.!! 0),
      detailText = state.data.activeRide.source
    },
    destinationAddress {
      titleText = fromMaybe "" ((DS.split (DS.Pattern ",") (state.data.activeRide.destination)) DA.!! 0),
      detailText = state.data.activeRide.destination
    },
    estimatedRideFare = state.data.activeRide.estimatedFare,
    notifiedCustomer = state.data.activeRide.notifiedCustomer,
    currentStage = state.props.currentStage,
    unReadMessages = state.props.unReadMessages,
    specialLocationTag = state.data.activeRide.specialLocationTag,
    requestedVehicleVariant = state.data.activeRide.requestedVehicleVariant,
    accessibilityTag = state.data.activeRide.disabilityTag,
    appConfig = state.data.config,
    waitTimeStatus = state.props.waitTimeStatus,
    waitTimeSeconds = state.data.activeRide.waitTimeSeconds,
    thresholdTime = state.data.config.waitTimeConfig.thresholdTime
    }
    in rideActionModalConfig'

---------------------------------------- endRidePopUp -----------------------------------------
endRidePopUp :: ST.HomeScreenState -> PopUpModal.Config
endRidePopUp state = let
  config' = PopUpModal.config
  popUpConfig' = config'{
    primaryText {text = (getString END_RIDE)},
    secondaryText {text = (getString ARE_YOU_SURE_YOU_WANT_TO_END_THE_RIDE)},
    option1 {text = (getString GO_BACK), enableRipple = true},
    option2 {text = (getString END_RIDE), enableRipple = true}
  }
in popUpConfig'

------------------------------------------ cancelRideModalConfig ---------------------------------
cancelRideModalConfig :: ST.HomeScreenState -> SelectListModal.Config
cancelRideModalConfig state = let
  config = SelectListModal.config
  lastIndex = ((DA.length state.data.cancelRideModal.selectionOptions) -1)
  cancelRideModalConfig' = config {
    activeIndex = state.data.cancelRideModal.activeIndex,
    hint = (getString HELP_US_WITH_YOUR_REASON),
    strings {
      mandatory = (getString MANDATORY),
      limitReached = ((getString MAX_CHAR_LIMIT_REACHED) <> " 100 " <> (getString OF) <> " 100")
    },
    headingTextConfig{
      text = ((getString CANCEL_RIDE) <> "?")
    },
    subHeadingTextConfig{
      text = (getString PLEASE_TELL_US_WHY_YOU_WANT_TO_CANCEL)
    },
    showAllOptionsText = (getString SHOW_ALL_OPTIONS),
    selectionOptions = state.data.cancelRideModal.selectionOptions,
    isLimitExceeded = ((DS.length (state.data.cancelRideModal.selectedReasonDescription)) >= 100),
    activeReasonCode = Just state.data.cancelRideModal.selectedReasonCode,
    primaryButtonTextConfig {
      firstText = (getString GO_BACK)
    , secondText = (getString CANCEL_RIDE)
    },
    isSelectButtonActive = case state.data.cancelRideModal.activeIndex of
                              Just index -> true
                              Nothing    -> false
  }
  in cancelRideModalConfig'

---------------------------------- statsModelConfig --------------------------------
statsModelConfig :: ST.HomeScreenState -> Boolean -> StatsModel.Config
statsModelConfig state bonusVisibility =
  let
    config = StatsModel.config
    config' = config
      { countTextConfig { text = getString TRIP_COUNT }
      , earningsTextConfig { text = getString TODAYS_EARNINGS }
      , bonusTextConfig { text = getString BONUS_EARNED }
      , textConfig { text = "" }
      , totalRidesOfDay = state.data.totalRidesOfDay
      , totalEarningsOfDay = state.data.totalEarningsOfDay
      , bonusEarned = state.data.bonusEarned
      , showBonus = bonusVisibility
      }
  in config'

-------------------------------------genderBannerConfig------------------------------------
genderBannerConfig :: forall a. ST.HomeScreenState -> (BannerCarousel.Action -> a) -> BannerCarousel.Config  (BannerCarousel.Action -> a)
genderBannerConfig _ action =
  let
    config = BannerCarousel.config action
    config' = config
      {
        backgroundColor = Color.green600,
        title = (getString COMPLETE_YOUR_PROFILE_AND_FIND_MORE_RIDES),
        titleColor = Color.white900,
        actionText = (getString UPDATE_NOW),
        actionTextColor = Color.white900,
        imageUrl = fetchImage FF_ASSET "ny_ic_driver_gender_banner",
        "type" = BannerCarousel.Gender
      }
  in config'

autpPayBannerCarousel :: forall a. ST.HomeScreenState -> (BannerCarousel.Action -> a) -> BannerCarousel.Config (BannerCarousel.Action -> a)
autpPayBannerCarousel state action =
  let config = BannerCarousel.config action
      bannerConfig = autopayBannerConfig state false
  in config {
     backgroundColor = bannerConfig.backgroundColor,
        title = bannerConfig.title,
        titleColor = bannerConfig.titleColor,
        actionText = bannerConfig.actionText,
        actionTextColor = actionTextColor_,
        actionTextBackgroundColour = actionTextBackgroundColour_,
        actionIconUrl = actionIconUrl_,
        actionIconVisibility = true,
        imageUrl = bannerConfig.imageUrl,
        isBanner = bannerConfig.isBanner,
        imageHeight = bannerConfig.imageHeight,
        imageWidth = bannerConfig.imageWidth,
        actionTextStyle = bannerConfig.actionTextStyle,
        actionArrowIconVisibility = false,
        titleStyle = bannerConfig.titleStyle,
        "type" = BannerCarousel.AutoPay,
        imagePadding = bannerConfig.imagePadding
  }
  where
    actionIconUrl_ = (HU.getAssetLink FunctionCall) <> case state.props.autoPayBanner of
                            DUE_LIMIT_WARNING_BANNER -> "ny_ic_money_filled_red.png"
                            CLEAR_DUES_BANNER -> "ny_ic_money_filled.png"
                            LOW_DUES_BANNER -> "ny_ic_money_filled_black.png"
                            _ -> "ny_ic_arrow_right_green.png"

    actionTextBackgroundColour_ = case state.props.autoPayBanner of
          DUE_LIMIT_WARNING_BANNER -> Color.red
          CLEAR_DUES_BANNER -> Color.black900
          LOW_DUES_BANNER -> Color.yellow900
          _ -> Color.white900

    actionTextColor_ = case state.props.autoPayBanner of
          DUE_LIMIT_WARNING_BANNER -> Color.white900
          CLEAR_DUES_BANNER -> Color.white900
          LOW_DUES_BANNER -> Color.black900
          _ -> Color.green600

accessbilityBannerConfig :: forall a. ST.HomeScreenState -> (BannerCarousel.Action -> a) -> BannerCarousel.Config  (BannerCarousel.Action -> a)
accessbilityBannerConfig _ action = 
  let 
    config = BannerCarousel.config action
    config' = config  
      {
        backgroundColor = Color.lightPurple,
        title = getString LEARN_HOW_YOU_CAN_HELP_CUSTOMERS_REQUIRING_SPECIAL_ASSISTANCE,
        titleColor = Color.purple,
        actionText = getString LEARN_MORE,
        actionTextColor = Color.purple,
        imageUrl = fetchImage FF_ASSET "ny_ic_purple_badge",
        isBanner = true,
        margin = Margin 0 0 0 0,
        "type" = BannerCarousel.Disability
      }
  in config'

------------------------------------ linkAadhaarPopupConfig -----------------------------
linkAadhaarPopupConfig :: ST.HomeScreenState -> PopUpModal.Config
linkAadhaarPopupConfig state = let
  config' = PopUpModal.config
  popUpConfig' = config'{
    gravity = CENTER,
    margin = MarginHorizontal 24 24 ,
    buttonLayoutMargin = Margin 16 0 16 20 ,
    primaryText {
      text = (getString AADHAAR_LINKING_REQUIRED)
    , margin = Margin 16 24 16 4 },
    secondaryText {
      text = (getString $ AADHAAR_LINKING_REQUIRED_DESCRIPTION "AADHAAR_LINKING_REQUIRED_DESCRIPTION")
    , margin = MarginBottom 24},
    option1 {
      text = (getString LINK_AADHAAR_ID)
    , background = Color.black900
    , color = Color.yellow900
    },
    option2 {
      visibility = false
    },
    backgroundClickable = true,
    dismissPopup = true,
    cornerRadius = (PTD.Corners 15.0 true true true true),
    coverImageConfig {
      imageUrl = fetchImage FF_ASSET "ny_ic_aadhaar_logo"
    , visibility = VISIBLE
    , height = V 178
    , width = V 204
    }
  }
  in popUpConfig'

offerPopupConfig :: Boolean -> PromotionPopupConfig -> PopUpModal.Config
offerPopupConfig isImageUrl  (PromotionPopupConfig ob) = 
  PopUpModal.config {
    gravity = CENTER,
    margin = MarginHorizontal 24 24 ,
    buttonLayoutMargin = Margin 16 0 16 5 ,
    topTitle {
      text = ob.heading
    , visibility = VISIBLE
    },
    primaryText {
      text = ob.title
    , margin = Margin 16 24 16 4 },
    secondaryText {
      text = ob.description
    , margin = MarginBottom 24},
    option1 {
      text = getString JOIN_NOW
    , background = Color.black900
    , color = Color.yellow900
    },
    option2 {
      visibility = false
    },
    backgroundClickable = false,
    cornerRadius = (PTD.Corners 15.0 true true true true),
    coverImageConfig {
      imageUrl = if isImageUrl then "," <> ob.imageUrl else ob.imageUrl
    , visibility = VISIBLE
    , height = V 178
    , width = V 204
    }
  , optionWithHtml  {
    textOpt1 {
      text = getString MAYBE_LATER
    , visibility = VISIBLE
    , textStyle = FontStyle.SubHeading2
    , color = Color.black650
    } 
    , height = V 24
    , margin = MarginBottom 20
    , visibility = true
    , background = Color.white900
    , strokeColor = Color.white900
  }
}

freeTrialEndingPopupConfig :: ST.HomeScreenState -> PopUpModal.Config
freeTrialEndingPopupConfig state = 
  let autoPayStatus = state.data.paymentState.autoPayStatus
      noOfDaysLeft = fromMaybe 0 (fromString (getValueToLocalNativeStore FREE_TRIAL_DAYS)) 
  in
  PopUpModal.config {
    gravity = CENTER,
    margin = MarginHorizontal 24 24 ,
    buttonLayoutMargin = Margin 16 0 16 5 ,
    primaryText {
      text = case noOfDaysLeft of
        3 -> getString FREE_TRIAL_ENDING_IN_2_DAYS
        2 -> getString FREE_TRIAL_ENDING_TOMORROW
        1 -> getString FREE_TRIAL_ENDS_TONIGHT
        _ -> ""
    , margin = Margin 16 16 16 4 },
    secondaryText {
      text = if autoPayStatus == NO_AUTOPAY then getString JOIN_A_PLAN_TO_CONTINUE_TAKING_RIDES else getString SETUP_AUTOPAY_FOR_EASY_PAYMENTS
    , margin = MarginBottom 24
    },
    option1 {
      text = if autoPayStatus == NO_AUTOPAY then getString JOIN_NOW else getString SETUP_AUTOPAY
    , background = Color.black900
    , color = Color.yellow900
    , enableRipple = true
    },
    option2 {
      visibility = false
    },
    backgroundClickable = true,
    cornerRadius = (PTD.Corners 15.0 true true true true),
    coverImageConfig {
      imageUrl = fetchImage FF_ASSET $ case noOfDaysLeft of
        3 -> "ny_ic_2_days_left"
        2 -> "ny_ic_1_days_left"
        1 -> "ny_ic_offer_ends_tonight"
        _ -> ""
    , visibility = VISIBLE
    , height = V 220
    , width = V 280
    , margin = MarginTop 20
    }
  , optionWithHtml  {
    textOpt1 {
      text = getString NOT_NOW
    , visibility = VISIBLE
    , textStyle = FontStyle.SubHeading2
    , color = Color.black650
    } 
    , height = V 24
    , margin = MarginVertical 0 20
    , visibility = true
    , background = Color.white900
    , strokeColor = Color.white900
    }
  }

paymentPendingPopupConfig :: ST.HomeScreenState -> PopUpModal.Config
paymentPendingPopupConfig state =
  let popupType = state.props.subscriptionPopupType
      dues = if state.data.paymentState.totalPendingManualDues /= 0.0 then "( ₹" <> HU.getFixedTwoDecimals state.data.paymentState.totalPendingManualDues <> ") " else ""
      isHighDues = state.data.paymentState.totalPendingManualDues >= state.data.subsRemoteConfig.high_due_warning_limit
  in
  PopUpModal.config {
    gravity = CENTER,
    margin = MarginHorizontal 24 24 ,
    buttonLayoutMargin = Margin 16 0 16 if popupType == LOW_DUES_CLEAR_POPUP then 20 else 5 ,
    dismissPopup = true,
    topTitle {
      text = case popupType of
                GO_ONLINE_BLOCKER -> getString PAYMENT_PENDING_ALERT
                _  -> getString $ if isHighDues then DUES_PENDING else CLEAR_YOUR_DUES_EARLY
    , visibility = VISIBLE
    , gravity = CENTER
    },
    primaryText {
      text = getString case popupType of 
                         LOW_DUES_CLEAR_POPUP -> LOW_DUES_CLEAR_POPUP_DESC 
                         SOFT_NUDGE_POPUP     -> PAYMENT_PENDING_SOFT_NUDGE
                         GO_ONLINE_BLOCKER    -> PAYMENT_PENDING_ALERT_DESC "PAYMENT_PENDING_ALERT_DESC"
                         _                    -> LOW_DUES_CLEAR_POPUP_DESC
    , margin = Margin 16 16 16 4
    , textStyle = SubHeading2
    , color = Color.black700
    , visibility = VISIBLE },
    secondaryText {
      text = "<span style='color:#2194FF'><u>"<> getString WATCH_VIDEO_FOR_HELP <>"</u></span>"
    , textStyle = SubHeading2
    , margin = MarginBottom 24
    , suffixImage = {
        visibility : VISIBLE
        , imageUrl : fetchImage FF_ASSET "ny_ic_youtube"
        , height : (V 24)
        , width : (V 24)
        , margin : MarginLeft 4 
        , padding : Padding 0 0 0 0
      }
    },
    option1 {
      text = getString CLEAR_DUES <> dues
    , background = Color.black900
    , color = Color.yellow900
    , showShimmer = state.data.paymentState.showShimmer
    , enableRipple = true
    },
    option2 {
      visibility = false
    },
    backgroundClickable = true,
    cornerRadius = (PTD.Corners 15.0 true true true true),
    coverImageConfig {
      imageUrl = fetchImage FF_ASSET $ case popupType of
                          GO_ONLINE_BLOCKER  -> "ny_ic_dues_pending"
                          _ ->  if isHighDues 
                                then "ny_ic_dues_pending" 
                                else "ny_ic_clear_dues_early"
    , visibility = VISIBLE
    , height = V 220
    , width = V 280
    }
  , optionWithHtml  {
    textOpt1 {
      text = getString case popupType of
                          SOFT_NUDGE_POPUP  -> GO_ONLINE_POPUP
                          GO_ONLINE_BLOCKER -> VIEW_DUE_DETAILS
                          _ -> VIEW_DUE_DETAILS
    , visibility =  VISIBLE
    , textStyle = FontStyle.SubHeading2
    , color = Color.black650
    } 
    , height = V 24
    , margin = MarginBottom 20
    , visibility = popupType == SOFT_NUDGE_POPUP || popupType == GO_ONLINE_BLOCKER
    , background = Color.white900
    , strokeColor = Color.white900
    }
  }

offerConfigParams :: ST.HomeScreenState -> PromotionPopupConfig
offerConfigParams state = PromotionPopupConfig $ {
  title : getString LIMITED_TIME_OFFER,
  description : getString JOIN_THE_UNLIMITED_PLAN,
  imageUrl : fetchImage FF_ASSET "ny_ic_limited_time_offer",
  buttonText : getString JOIN_NOW,
  heading : getString $ MY_PLAN_TITLE "MY_PLAN_TITLE"
}

------------------------------------ cancelConfirmationConfig -----------------------------
cancelConfirmationConfig :: ST.HomeScreenState -> PopUpModal.Config
cancelConfirmationConfig state = let
  config' = PopUpModal.config
  popUpConfig' = config'{
    gravity = CENTER,
    margin = MarginHorizontal 24 24 ,
    buttonLayoutMargin = Margin 16 24 16 20 ,
    primaryText {
      text = case state.data.activeRide.specialLocationTag of
              Nothing -> getString FREQUENT_CANCELLATIONS_WILL_LEAD_TO_LESS_RIDES
              Just specialLocationTag -> getString $ getCancelAlertText $ (HU.getRideLabelData (Just specialLocationTag)).cancelText
    , margin = Margin 16 24 16 0 },
    secondaryText {
      visibility = if state.data.activeRide.specialLocationTag == (Just "GOTO") then VISIBLE else GONE,
      text = getString GO_TO_CANCELLATION_DESC,
      margin = MarginTop 6
      },
    option1 {
      text = (getString CONTINUE)
    , width = V $ (((EHC.screenWidth unit)-92)/2) 
    , isClickable = state.data.cancelRideConfirmationPopUp.continueEnabled
    , timerValue = state.data.cancelRideConfirmationPopUp.delayInSeconds
    , enableTimer = true
    , background = Color.white900
    , strokeColor = Color.black500
    , color = Color.black700
    , enableRipple = state.data.cancelRideConfirmationPopUp.continueEnabled
    },
    option2 {
      text = (getString GO_BACK)
    , margin = MarginLeft 12
    , width = V $ (((EHC.screenWidth unit)-92)/2)
    , color = Color.yellow900
    , strokeColor = Color.black900
    , background = Color.black900
    , enableRipple = true
    },
    backgroundClickable = false,
    cornerRadius = (PTD.Corners 15.0 true true true true),
    coverImageConfig {
      imageUrl = fetchImage FF_ASSET  if (state.data.activeRide.specialLocationTag == Nothing || (HU.getRequiredTag state.data.activeRide.specialLocationTag) == Nothing) 
                    then "ic_cancel_prevention"
                  else (HU.getRideLabelData state.data.activeRide.specialLocationTag).cancelConfirmImage
    , visibility = VISIBLE
    , margin = Margin 16 20 16 0
    , height = V 178
    },
    timerId = "PopUp"
  }
  in popUpConfig'

driverRCPopUpConfig :: ST.HomeScreenState -> PopUpModal.Config 
driverRCPopUpConfig state = let 
  config' = PopUpModal.config 
  popUpConfig' = config'{
    backgroundClickable = false,
    gravity = CENTER,
    buttonLayoutMargin =(Margin 0 0 0 0),
    cornerRadius = (PTD.Corners 16.0 true true true true), 
    padding = Padding 16 24 16 16,
    optionButtonOrientation = "VERTICAL",
    margin = MarginHorizontal 24 24, 
    primaryText {
      text =  getString RC_DEACTIVATED, 
      margin = MarginTop 16 
    }, 
    secondaryText {
      text = getString RC_DEACTIVATED_DETAILS, 
      color = Color.black700,
      margin = (Margin 0 0 0 0)
    } ,
    option1 {
      background = Color.black900,
      text = getString GO_TO_VEHICLE_DETAILS,
      color = Color.yellow900, 
      margin = MarginTop 24,
      width = MATCH_PARENT, 
      padding = Padding 16 6 16 6,
      height = WRAP_CONTENT 
    } , 
    option2 {
      background = Color.white900, 
      text = getString CLOSE,
      width = MATCH_PARENT, 
      height = WRAP_CONTENT ,
      color =  Color.black650,
      strokeColor = Color.white900, 
      padding = Padding 16 6 16 6, 
      margin = Margin 0 8 0 0
    }, 
    coverImageConfig {
      visibility = VISIBLE,
      imageUrl = fetchImage FF_ASSET "ny_rc_deactivated",
      height = V 182,
      width = V 280
    }
  }
  in popUpConfig' 

------------------------------------ chatViewConfig -----------------------------
chatViewConfig :: ST.HomeScreenState -> ChatView.Config
chatViewConfig state = let
  config = ChatView.config
  chatViewConfig' = config {
    userConfig {
      userName = state.data.activeRide.riderName,
      appType = "Driver"
    }
    , messages = state.data.messages
    , messagesSize = state.data.messagesSize
    , sendMessageActive = state.props.sendMessageActive
    , vehicleNo = ""
    , chatSuggestionsList = if showSuggestions state then if (state.data.activeRide.notifiedCustomer) then getSuggestionsfromKey chatSuggestion "driverInitialAP" else getSuggestionsfromKey chatSuggestion "driverInitialBP" else state.data.chatSuggestionsList
    , hint = (getString MESSAGE)
    , suggestionHeader = (getString START_YOUR_CHAT_USING_THESE_QUICK_CHAT_SUGGESTIONS)
    , emptyChatHeader = (getString START_YOUR_CHAT_WITH_THE_DRIVER)
    , mapsText = (getString MAPS)
    , languageKey = (getLanguageLocale languageKey)
    , transparentGrey = Color.transparentGrey
    , canSendSuggestion = state.props.canSendSuggestion
    , enableCall = (not (state.data.activeRide.disabilityTag == Just ST.HEAR_IMPAIRMENT))
    , enableSuggestions = state.data.config.feature.enableSuggestions
  }
  in chatViewConfig'

showSuggestions :: ST.HomeScreenState -> Boolean
showSuggestions state = do
  let canShowSuggestions = case (DA.last state.data.messages) of 
                            Just value -> not $ value.sentBy == "Driver"
                            Nothing -> true
  DA.null state.data.chatSuggestionsList && canShowSuggestions && ((show $ DA.length $ JB.getChatMessages FunctionCall) == state.data.messagesSize || state.data.messagesSize == "-1")

silentModeConfig :: ST.HomeScreenState -> PopUpModal.Config
silentModeConfig state = let
  config' = PopUpModal.config
  popUpConfig' = config'{
    gravity = CENTER
  , cornerRadius = (PTD.Corners 15.0 true true true true)
  , backgroundClickable = false
  , margin = (Margin 16 0 16 0)
  , primaryText {
      text = getString TRY_SILENT_MODE
    }
  , secondaryText {
      text =  getString SILENT_MODE_PROMPT
    }
    , option1 {
      text =   getString GO_OFFLINE
      , width = (V 140)
      , enableRipple = true
    }
  , option2 {
      width = (V 170)
      , text =  getString GO_SILENT
      , enableRipple = true
    }
  }
  in popUpConfig'


enterOtpStateConfig :: ST.HomeScreenState -> InAppKeyboardModal.InAppKeyboardModalState
enterOtpStateConfig state = 
  let appConfig = CP.getAppConfig CP.appConfig
      config' = InAppKeyboardModal.config
      inAppModalConfig' = config'{
      otpIncorrect = if (state.props.otpAttemptsExceeded) then false else (state.props.otpIncorrect),
      otpAttemptsExceeded = (state.props.otpAttemptsExceeded),
      inputTextConfig {
        text = state.props.rideOtp,
        focusIndex = state.props.enterOtpFocusIndex
        , textStyle = FontStyle.Heading1
      },
      headingConfig {
        text = getString (ENTER_OTP)
      },
      errorConfig {
        text = if (state.props.otpIncorrect && state.props.wrongVehicleVariant) then (getString OTP_INVALID_FOR_THIS_VEHICLE_VARIANT) else if state.props.otpIncorrect then (getString ENTERED_WRONG_OTP)  else (getString OTP_LIMIT_EXCEEDED),
        visibility = if (state.props.otpIncorrect || state.props.otpAttemptsExceeded) then VISIBLE else GONE
      },
      subHeadingConfig {
        text = getString (PLEASE_ASK_THE_CUSTOMER_FOR_THE_OTP),
        visibility = if (state.props.otpAttemptsExceeded) then GONE else VISIBLE
      , textStyle = FontStyle.Body1
      },
      imageConfig {
        alpha = if(DS.length state.props.rideOtp < 4) then 0.3 else 1.0
      },
      modalType = ST.OTP,
      enableDeviceKeyboard = appConfig.inAppKeyboardModalConfig.enableDeviceKeyboard
      }
      in inAppModalConfig'

driverStatusIndicators :: Array ST.PillButtonState
driverStatusIndicators = [
    {
      status : ST.Offline,
      background : Color.red,
      imageUrl : fetchImage FF_ASSET "ic_driver_status_offline",
      textColor : Color.white900
    },
    {
        status : ST.Silent,
        background : Color.blue800,
        imageUrl : fetchImage FF_ASSET "ic_driver_status_silent",
        textColor : Color.white900
    },
    {
      status : ST.Online,
        background : Color.darkMint,
        imageUrl : fetchImage FF_ASSET "ic_driver_status_online",
        textColor : Color.white900
    }
]
getCancelAlertText :: String -> STR
getCancelAlertText key = case key of
  "ZONE_CANCEL_TEXT_PICKUP" -> ZONE_CANCEL_TEXT_PICKUP
  "ZONE_CANCEL_TEXT_DROP" -> ZONE_CANCEL_TEXT_DROP
  "GO_TO_CANCELLATION_TITLE" -> GO_TO_CANCELLATION_TITLE
  _ -> FREQUENT_CANCELLATIONS_WILL_LEAD_TO_LESS_RIDES

mapRouteConfig :: String -> String -> Boolean -> PolylineAnimationConfig -> JB.MapRouteConfig
mapRouteConfig srcIcon destIcon isAnim animConfig= {
    sourceSpecialTagIcon : srcIcon
  , destSpecialTagIcon : destIcon
  , vehicleSizeTagIcon : (getMerchantVehicleSize unit)
  , isAnimation : isAnim 
  , autoZoom : true
  , polylineAnimationConfig : animConfig
}


specialZonePopupConfig :: ST.HomeScreenState -> RequestInfoCard.Config
specialZonePopupConfig state = let
  config = RequestInfoCard.config
  specialZonePopupConf' = config{
    title {
      text = getString SPECIAL_PICKUP_ZONE 
    }
  , primaryText {
      text = getString SPECIAL_PICKUP_ZONE_POPUP_INFO
    }
  , secondaryText {
      visibility = GONE
    }
  , imageConfig {
      imageUrl = fetchImage FF_ASSET "ny_ic_sp_pickup_zone_map",
      height = V 122,
      width = V 116
    }
  , buttonConfig {
      text = getString GOT_IT
    }
  }
  in specialZonePopupConf'

requestInfoCardConfig :: LazyCheck -> RequestInfoCard.Config
requestInfoCardConfig _ = let
  config = RequestInfoCard.config
  requestInfoCardConfig' = config{
    title {
      text = getString $ WHAT_IS_NAMMA_YATRI_BONUS "WHAT_IS_NAMMA_YATRI_BONUS"
    }
  , primaryText {
      text = getString $ BONUS_PRIMARY_TEXT "BONUS_PRIMARY_TEXT"
    }
  , secondaryText {
      text = getString $ BONUS_SECONDARY_TEXT "BONUS_SECONDARY_TEXT",
      visibility = VISIBLE
    }
  , imageConfig {
      imageUrl = fetchImage FF_ASSET "ny_ic_bonus",
      height = V 122,
      width = V 116
    }
  , buttonConfig {
      text = getString GOT_IT
    }
  }
  in requestInfoCardConfig'

waitTimeInfoCardConfig :: ST.HomeScreenState -> RequestInfoCard.Config
waitTimeInfoCardConfig state = 
  let cityConfig = HU.getCityConfig state.data.config.cityConfig (getValueToLocalStore DRIVER_LOCATION)
  in
    RequestInfoCard.config {
      title {
        text = getString WAIT_TIMER
      }
    , primaryText {
        text = if rideInProgress then 
                getVarString THIS_EXTRA_AMOUNT_THE_CUSTOMER_WILL_PAY [show maxWaitTimeInMinutes] else getString HOW_LONG_WAITED_FOR_PICKUP,
        padding = Padding 16 16 0 0
      }
    , secondaryText {
        text = getString $ CUSTOMER_WILL_PAY_FOR_EVERY_MINUTE ("₹" <> (show cityConfig.waitingCharges)) (show maxWaitTimeInMinutes),
        visibility = if rideInProgress then GONE else VISIBLE,
        padding = PaddingLeft 16
      }
    , imageConfig {
        imageUrl = fetchImage FF_ASSET "ny_ic_waiting_auto",
        height = V 130,
        width = V 130,
        padding = Padding 0 4 1 0
      }
    , buttonConfig {
        text = getString GOT_IT,
        padding = PaddingVertical 16 20
      }
    }
    where rideInProgress = state.data.activeRide.status == SA.INPROGRESS
          maxWaitTimeInMinutes = Int.floor $ Int.toNumber state.data.config.waitTimeConfig.thresholdTime / 60.0

makePaymentState :: ST.HomeScreenState -> MakePaymentModal.MakePaymentModalState
makePaymentState state = 
  let payableAndGST = EHC.formatCurrencyWithCommas (show state.data.paymentState.payableAndGST)
      useTimeRange = (state.data.config.subscriptionConfig.showLaterButtonforTimeRange && not JB.withinTimeRange "14:00:00" "10:00:00" (EHC.convertUTCtoISC(EHC.getCurrentUTC "") "HH:mm:ss"))
  in 
  {
    title : getString GREAT_JOB,
    description : getDescription state,
    description2 : getString $ COMPLETE_PAYMENT_TO_CONTINUE "COMPLETE_PAYMENT_TO_CONTINUE",
    okButtontext : ( case getLanguageLocale languageKey of
                          "EN_US" -> "Pay ₹" <> payableAndGST <> " now"
                          "HI_IN" -> "अभी ₹" <> payableAndGST <>" का भुगतान करें"
                          "KN_IN" -> "ಈಗ ₹"<> payableAndGST <>" ಪಾವತಿಸಿ"
                          "TA_IN" -> "இப்போது ₹" <> payableAndGST <> " செலுத்துங்கள்"
                          "BN_IN" -> "এখন " <> payableAndGST <> " পে করুন"
                          "TE_IN" -> "చెల్లించండి ₹" <> payableAndGST <> " ఇప్పుడు"
                          _       -> "Pay ₹" <> payableAndGST <> " now"
                      ),
    cancelButtonText : if useTimeRange || state.data.paymentState.laterButtonVisibility then Just $ getString LATER else Nothing,
    ridesCount : state.data.paymentState.rideCount,
    feeItem : [
      { feeType : MakePaymentModal.TOTAL_COLLECTED,
        title : getString TOTAL_MONEY_COLLECTED,
        val : state.data.paymentState.totalMoneyCollected},
      { feeType : MakePaymentModal.EARNED_OF_THE_DAY,
        title : getString FARE_EARNED_OF_THE_DAY,
        val : (state.data.paymentState.totalMoneyCollected - state.data.paymentState.payableAndGST)},
      { feeType : MakePaymentModal.GST_PAYABLE,
        title : getString GST_PLUS_PAYABLE,
        val : state.data.paymentState.payableAndGST}
    ]
  }

getDescription :: ST.HomeScreenState -> String
getDescription state =  case getLanguageLocale languageKey of
                        "EN_US" -> (("You have completed <b>"<> (show state.data.paymentState.rideCount)) <> (if state.data.paymentState.rideCount == 1 then " Ride</b>" else " Rides</b>"))
                        "HI_IN" -> "आपने " <>  show state.data.paymentState.rideCount <> "सवारी पूरी कर ली हैं"
                        "BN_IN" -> "আপনি" <> show state.data.paymentState.rideCount <> "টি রাইড সম্পূর্ণ করেছেন"
                        "TA_IN" -> "நீங்கள்  "<> (show state.data.paymentState.rideCount) <>" சவாரிகளை முடித்துவிட்டீர்கள்!"
                        "KN_IN" -> "ನೀವು ನಿನ್ನೆ "<> (show state.data.paymentState.rideCount) <>" ರೈಡ್‌ಗಳನ್ನು ಪೂರ್ಣಗೊಳಿಸಿದ್ದೀರಿ!"
                        -- "TE_IN" -> ""
                        _       -> (("You have completed <b>"<> (show state.data.paymentState.rideCount)) <> (if state.data.paymentState.rideCount == 1 then " Ride</b>" else " Rides"))

rateCardState :: ST.HomeScreenState -> RateCard.Config
rateCardState state =
  let
    config' = RateCard.config
    rateCardConfig' =
      config'
        { title = getString FEE_BREAKUP
        , description = getString (YATRI_SATHI_FEE_PAYABLE_FOR_DATE "YATRI_SATHI_FEE_PAYABLE_FOR_DATE") <> " " <> state.data.paymentState.date
        , buttonText = Nothing
        , currentRateCardType = CommonTypes.PaymentFareBreakup
        , primaryButtonText = getString GOT_IT
        , additionalStrings = [
          {key : "FEE_CORRESPONDING_TO_DISTANCE", val : getString FEE_CORRESPONDING_TO_THE_DISTANCE},
          {key : "GOT_IT", val : getString GOT_IT},
          {key : "TOTAL_PAYABLE", val : getString TOTAL_PAYABLE},
          {key : "TOTAL_PAYABLE_VAL", val : "₹" <> (show state.data.paymentState.payableAndGST)}]
          
        , fareList = getChargesBreakup state.data.paymentState.chargesBreakup

        }
  in
    rateCardConfig'

getChargesBreakup :: Array PaymentBreakUp -> Array CommonTypes.FareList
getChargesBreakup paymentBreakUpArr = map (\(PaymentBreakUp item) -> {val : "₹" <>  (show item.amount),
  key : case item.component of
        "Government Charges" -> getString GOVERMENT_CHARGES
        "Platform Fee" -> getString PLATFORM_FEE
        _ -> item.component
    } ) paymentBreakUpArr

autopayBannerConfig :: ST.HomeScreenState -> Boolean -> Banner.Config -- Make sure to update the mapping in carousel config also.
autopayBannerConfig state configureImage =
  let
    config = Banner.config
    bannerType = state.props.autoPayBanner
    dues = HU.getFixedTwoDecimals state.data.paymentState.totalPendingManualDues
    config' = config
      {
        backgroundColor = case bannerType of
                        CLEAR_DUES_BANNER -> Color.yellow900
                        DUE_LIMIT_WARNING_BANNER -> Color.pearl
                        LOW_DUES_BANNER -> Color.yellow800
                        _ -> Color.green600,
        title = case bannerType of
                  FREE_TRIAL_BANNER -> getString SETUP_AUTOPAY_BEFORE_THE_TRAIL_PERIOD_EXPIRES 
                  SETUP_AUTOPAY_BANNER -> getString SETUP_AUTOPAY_FOR_EASY_PAYMENTS
                  _ | bannerType == CLEAR_DUES_BANNER || bannerType == LOW_DUES_BANNER -> getVarString CLEAR_DUES_BANNER_TITLE [dues]
                  DUE_LIMIT_WARNING_BANNER -> getVarString DUE_LIMIT_WARNING_BANNER_TITLE [HU.getFixedTwoDecimals state.data.subsRemoteConfig.max_dues_limit]
                  _ -> "",
        titleColor = case bannerType of
                        DUE_LIMIT_WARNING_BANNER -> Color.red
                        _ | bannerType == CLEAR_DUES_BANNER || bannerType == LOW_DUES_BANNER -> Color.black900
                        _ -> Color.white900,
        actionText = case bannerType of
                        _ | bannerType == DUE_LIMIT_WARNING_BANNER || bannerType == CLEAR_DUES_BANNER || bannerType == LOW_DUES_BANNER -> getString PAY_NOW
                        _ -> (getString SETUP_NOW),
        actionTextColor = case bannerType of
                            _ | bannerType == CLEAR_DUES_BANNER || bannerType == LOW_DUES_BANNER -> Color.black900
                            DUE_LIMIT_WARNING_BANNER -> Color.red
                            _ -> Color.white900,
        imageUrl = fetchImage FF_ASSET $ case bannerType of
                      FREE_TRIAL_BANNER -> "ic_free_trial_period" 
                      SETUP_AUTOPAY_BANNER -> "ny_ic_driver_offer"
                      _ | bannerType == CLEAR_DUES_BANNER || bannerType == LOW_DUES_BANNER -> "ny_ic_clear_dues"
                      DUE_LIMIT_WARNING_BANNER -> "ny_ic_due_limit_warning"
                      _ -> "",
        imageHeight = if configureImage then (V 75) else (V 105),
        imageWidth = if configureImage then (V 98) else (V 118),
        actionTextStyle = if configureImage then FontStyle.Body3 else FontStyle.ParagraphText,
        titleStyle = if configureImage then FontStyle.Body4 else FontStyle.Body7,
        imagePadding = case bannerType of
                            _ | bannerType == CLEAR_DUES_BANNER || bannerType == LOW_DUES_BANNER -> PaddingTop 0
                            _ -> PaddingVertical 5 5
      }
  in config'
  
accessibilityPopUpConfig :: ST.HomeScreenState -> PopUpModal.Config
accessibilityPopUpConfig state = 
  let 
    config = PopUpModal.config
    popupData = getAccessibilityPopupData state state.data.activeRide.disabilityTag state.data.activeRide.notifiedCustomer
    config' = config
      {
        gravity = CENTER,
        margin = MarginHorizontal 24 24 ,
        buttonLayoutMargin = Margin 16 0 16 20 ,
        onlyTopTitle = GONE,
        topTitle {
          text = popupData.title
        , gravity = CENTER
        , visibility = boolToVisibility $ popupData.title /= ""
        },
        primaryText {
          text = popupData.primaryText
        , visibility = boolToVisibility $ popupData.primaryText /= ""
        , margin = Margin 16 24 16 4 },
        secondaryText {
          text = popupData.secondaryText
        , visibility = boolToVisibility $ popupData.secondaryText /= ""
        , textStyle = SubHeading2
        , margin = if popupData.primaryText == "" then (MarginVertical 20 24) else (MarginBottom 24)},
        option1 {
          text = getString GOT_IT
        , background = Color.black900
        , color = Color.yellow900
        },
        option2 {
          visibility = false
        },
        backgroundClickable = false,
        cornerRadius = (PTD.Corners 15.0 true true true true),
        coverImageConfig {
          imageUrl = popupData.imageUrl
        , visibility = if popupData.videoUrl /= "" && (state.data.config.purpleRideConfig.showPurpleVideos || (popupData.mediaType /= "Audio")) then GONE else VISIBLE
        , height = V 160
        , width = MATCH_PARENT
        , margin = Margin 16 16 16 0
        },
        coverMediaConfig {
          visibility = boolToVisibility $ state.data.activeRide.disabilityTag == Just ST.SAFETY || (popupData.videoUrl /= "" && (state.data.config.purpleRideConfig.showPurpleVideos || (popupData.mediaType == "Audio")))
        , width = WRAP_CONTENT
        , padding = if popupData.mediaType == "Audio" then Padding 6 6 6 6 else Padding 16 16 16 0
        , mediaType = popupData.mediaType
        , mediaUrl = popupData.videoUrl
        , id = popupData.videoId
        , background = if popupData.mediaType == "Audio" then Color.blue600 else Color.white900
        , stroke = if popupData.mediaType == "Audio" then "1," <> Color.grey900 else Color.white900
        , margin = if popupData.mediaType == "Audio" then Margin 16 0 16 12 else Margin 0 0 0 0
        , height =  if popupData.mediaType == "Audio" then V 60 else WRAP_CONTENT
        , audioAutoPlay = state.props.safetyAudioAutoPlay
        , cornerRadius = 4.0
        , coverMediaText {
            visibility = boolToVisibility $ popupData.coverMediaText /= ""
          , text = popupData.coverMediaText
          }
        }
      }
  in config'

type ContentConfig = 
  { title :: String,
    coverMediaText :: String,
    primaryText :: String,
    secondaryText :: String,
    imageUrl :: String,
    videoUrl :: String, 
    mediaType :: String,
    videoId :: String,
    background :: String,
    textColor :: String
  }


genericAccessibilityPopUpConfig :: ST.HomeScreenState -> PopUpModal.Config
genericAccessibilityPopUpConfig state = let 
  config' = PopUpModal.config
    {
      gravity = CENTER,
        margin = MarginHorizontal 24 24 ,
        buttonLayoutMargin = Margin 16 0 16 20 ,
        primaryText {
          text = getString WHAT_ARE_PURPLE_RIDES
        , margin = Margin 16 24 16 4 },
        secondaryText {
          text = getString LEARN_HOW_YOU_CAN_HELP_CUSTOMERS_REQUIRING_SPECIAL_ASSISTANCE
        , textStyle = SubHeading2
        , margin = MarginBottom 24},
        option1 {
          text = getString GOT_IT
        , background = Color.black900
        , color = Color.yellow900
        },
        option2 {
          visibility = false
        },
        backgroundClickable = false,
        cornerRadius = (PTD.Corners 15.0 true true true true),
        coverImageConfig {
          visibility = GONE
        },
        coverMediaConfig {
          visibility = VISIBLE
        , height = V 202
        , width = MATCH_PARENT
        , padding = Padding 16 16 16 0
        , mediaType = "PortraitVideoLink"
        , mediaUrl = state.data.config.purpleRideConfig.genericAccessibilityVideo
        , id = "GenericAccessibilityCoverVideo"
        }
    }
  in config'

chatBlockerPopUpConfig :: ST.HomeScreenState -> PopUpModal.Config
chatBlockerPopUpConfig state = let
  config' = PopUpModal.config 
  popUpConfig' = config'{
    gravity = CENTER,
    cornerRadius = (PTD.Corners 24.0 true true true true),
    margin = (MarginHorizontal 16 16),
    primaryText {text = (getString CUSTOMER_HAS_LOW_VISION)},
    secondaryText {text = (getString PLEASE_CONSIDER_CALLING_THEM )},
    option1{ text = (getString GOT_IT),
      width = MATCH_PARENT,
      background = Color.black900,
      strokeColor = Color.black900,
      color = Color.yellow900,
      margin = MarginHorizontal 16 16
      },
    option2{text = (getString PROCEED_TO_CHAT),
      strokeColor = Color.white900,
      color = Color.black650,
      background = Color.white900,
      margin = MarginHorizontal 16 16 ,
      width = MATCH_PARENT},
    optionButtonOrientation = "VERTICAL",
    dismissPopup = true
  }
  in popUpConfig'

accessibilityConfig :: LazyCheck -> ContentConfig
accessibilityConfig dummy = { title : "", coverMediaText : "", primaryText : getString CUSTOMER_MAY_NEED_ASSISTANCE, secondaryText : getString CUSTOMER_HAS_DISABILITY_PLEASE_ASSIST_THEM, videoUrl : "", imageUrl : fetchImage FF_ASSET "ny_ic_disability_illustration", mediaType : "", videoId : "", background : Color.lightPurple, textColor : Color.purple}

getAccessibilityPopupData :: ST.HomeScreenState -> Maybe ST.DisabilityType -> Boolean -> ContentConfig
getAccessibilityPopupData state pwdtype isDriverArrived = 
  let accessibilityConfig' = accessibilityConfig Config
      city = (HU.getCityConfig state.data.config.cityConfig (getValueToLocalStore DRIVER_LOCATION))
      driverLocation = DS.toLower $ getValueToLocalStore DRIVER_LOCATION
      language = getLanguage $ getLanguageLocale languageKey
      videoUrl' = "https://assets.juspay.in/beckn/audios/ny_audio_safety" <> language <> ".mp3"
  in case pwdtype, isDriverArrived of 
      Just ST.BLIND_AND_LOW_VISION, true ->  accessibilityConfig' 
                                              { secondaryText = getString CUSTOMER_HAS_POOR_VISION_SOUND_HORN_AT_PICKUP ,
                                                imageUrl = fetchImage FF_ASSET (getUpdatedAssets city),
                                                videoUrl = "",
                                                mediaType = "",
                                                videoId = ""
                                              }   
      Just ST.BLIND_AND_LOW_VISION, false -> accessibilityConfig'
                                              { secondaryText = getString CUSTOMER_HAS_LOW_VISION_CALL_THEM_INSTEAD_OF_CHATTING,
                                                imageUrl = fetchImage FF_ASSET "ny_ic_blind_pickup",
                                                videoUrl = state.data.config.purpleRideConfig.visualImpairmentVideo,
                                                mediaType = "VideoLink",
                                                videoId = "BlindOrLowVisionCoverVideo"
                                              }
      Just ST.HEAR_IMPAIRMENT, true ->      accessibilityConfig'
                                              { secondaryText = getString CUSTOMER_HAS_POOR_HEARING_MESSAGE_THEM_AT_PICKUP,
                                                imageUrl = fetchImage FF_ASSET (getUpdatedAssets city),
                                                videoUrl = "",
                                                mediaType = "",
                                                videoId = ""
                                              }   
      Just ST.HEAR_IMPAIRMENT, false ->     accessibilityConfig'
                                              { secondaryText= getString CUSTOMER_HAS_POOR_HEARING_CHAT_WITH_THEM_INSTEAD_OF_CALLING ,
                                                imageUrl = fetchImage FF_ASSET "ny_ic_deaf_pickup",
                                                videoUrl = state.data.config.purpleRideConfig.hearingImpairmentVideo,
                                                mediaType = "VideoLink",
                                                videoId = "HearingImpairmentCoverVideo"
                                              }
      Just ST.LOCOMOTOR_DISABILITY, true -> accessibilityConfig'
                                              { secondaryText = getString CUSTOMER_HAS_LOW_MOBILITY_STORE_THEIR_SUPPORT_AT_PICKUP ,
                                                imageUrl = fetchImage FF_ASSET (getUpdatedAssets city),
                                                videoUrl = "",
                                                mediaType = "",
                                                videoId = ""
                                              }    
      Just ST.LOCOMOTOR_DISABILITY, false -> accessibilityConfig' 
                                              { secondaryText = getString CUSTOMER_HAS_LOW_MOBILITY_GO_TO_EXACT_LOC, 
                                                imageUrl = fetchImage FF_ASSET (getUpdatedAssets city),
                                                videoUrl = state.data.config.purpleRideConfig.physicalImpairmentVideo, 
                                                mediaType = "VideoLink",
                                                videoId = "LocomotorDisabilityCoverVideo"
                                              }
      Just ST.SAFETY, _ ->        accessibilityConfig' 
                                  { title = if driverLocation == "bangalore" then getString OUR_SAFETY_PARTNER else "",
                                    primaryText = "",
                                    secondaryText = "",
                                    coverMediaText = getString CUSTOMER_SAFETY_OUR_RESP_HAPPY_RIDE, 
                                    imageUrl = if  driverLocation == "bangalore" then fetchImage FF_COMMON_ASSET "ny_ic_bangalure_city_police" else fetchImage FF_COMMON_ASSET "ny_ic_general_safety" ,
                                    videoUrl = "",
                                    mediaType = "",
                                    videoId = ""
                                  }
      Just ST.SPECIAL_ZONE_PICKUP, _ -> accessibilityConfig' 
                                      { title = getString SPECIAL_PICKUP_ZONE,
                                        primaryText = "",
                                        secondaryText = getString SPECIAL_PICKUP_ZONE_POPUP_INFO,
                                        imageUrl = fetchImage FF_COMMON_ASSET "ny_ic_location_unserviceable_green",
                                        videoUrl = "",
                                        mediaType = "",
                                        videoId = ""
                                      }
      Just ST.OTHER_DISABILITY, _ ->     accessibilityConfig' 
      _ , _-> accessibilityConfig' 

  where 
    getUpdatedAssets :: CityConfig -> String 
    getUpdatedAssets cityConfig = 
      if cityConfig.cityCode == "std:040" then 
        case pwdtype, isDriverArrived of 
          Just ST.BLIND_AND_LOW_VISION, true ->  "ny_ic_blind_arrival_generic" 
          Just ST.HEAR_IMPAIRMENT, true -> "ny_ic_deaf_arrival_generic"
          Just ST.LOCOMOTOR_DISABILITY, true -> "ny_ic_locomotor_arrival_black_yellow"
          Just ST.LOCOMOTOR_DISABILITY, false -> "ny_ic_locomotor_pickup_generic"
          _ , _-> "ny_ic_disability_purple"
        else 
          case pwdtype , isDriverArrived of 
            Just ST.BLIND_AND_LOW_VISION, true ->  "ny_ic_blind_arrival"
            Just ST.HEAR_IMPAIRMENT, true -> "ny_ic_deaf_arrival"
            Just ST.LOCOMOTOR_DISABILITY, true -> "ny_ic_locomotor_arrival"
            Just ST.LOCOMOTOR_DISABILITY, false -> "ny_ic_locomotor_pickup"
            _ , _-> "ny_ic_disability_purple"
    getLanguage :: String -> String
    getLanguage lang = 
      let language = DS.toLower $ DS.take 2 lang
      in if not (DS.null language) then "_" <> language else "_en"

getAccessibilityHeaderText :: ST.HomeScreenState -> ContentConfig
getAccessibilityHeaderText state = 
  let config = accessibilityConfig Config
    in if state.data.activeRide.status == NEW then 
                        case state.data.activeRide.disabilityTag, state.data.activeRide.notifiedCustomer of   
                          Just ST.HEAR_IMPAIRMENT, false -> config {primaryText = getString CUSTOMER_HAS_HEARING_IMPAIRMENT, secondaryText = getString PLEASE_CHAT_AND_AVOID_CALLS, imageUrl = fetchImage FF_ASSET "ny_ic_poor_hearing"}
                          Just ST.BLIND_AND_LOW_VISION, false -> config {primaryText = getString CUSTOMER_HAS_LOW_VISION, secondaryText = getString PLEASE_CALL_AND_AVOID_CHATS, imageUrl = fetchImage FF_ASSET "ic_accessibility_vision"}
                          Just ST.LOCOMOTOR_DISABILITY, false -> config {primaryText = getString CUSTOMER_HAS_LOW_MOBILITY, secondaryText = getString PLEASE_GO_TO_EXACT_PICKUP,  imageUrl = fetchImage FF_ASSET "ny_ic_disability_purple"}
                          Just ST.OTHER_DISABILITY, false -> config {primaryText = getString CUSTOMER_HAS_DISABILITY, secondaryText = getString PLEASE_ASSIST_THEM_IF_NEEDED, imageUrl = fetchImage FF_ASSET "ny_ic_disability_purple"}
                          Nothing, false -> config {primaryText = getString CUSTOMER_HAS_DISABILITY, secondaryText = getString PLEASE_ASSIST_THEM_IF_NEEDED, imageUrl = fetchImage FF_ASSET "ny_ic_disability_purple"}
                      -- else if state.data.activeRide.isDriverArrived then
                          -- case state.data.activeRide.disabilityTag of   
                          Just ST.HEAR_IMPAIRMENT, true -> config {primaryText = getString CUSTOMER_HAS_HEARING_IMPAIRMENT, secondaryText = getString MESSAGE_THEM_AT_PICKUP, imageUrl = fetchImage FF_ASSET "ny_ic_poor_hearing"}
                          Just ST.BLIND_AND_LOW_VISION, true -> config {primaryText = getString CUSTOMER_HAS_LOW_VISION, secondaryText = getString SOUND_HORN_ONCE_AT_PICKUP, imageUrl = fetchImage FF_ASSET "ic_accessibility_vision"}
                          Just ST.LOCOMOTOR_DISABILITY, true -> config {primaryText = getString CUSTOMER_HAS_LOW_MOBILITY, secondaryText = getString HELP_WITH_THEIR_MOBILITY_AID, imageUrl = fetchImage FF_ASSET "ny_ic_disability_purple"}
                          Just ST.OTHER_DISABILITY, true -> config {primaryText = getString CUSTOMER_HAS_DISABILITY, secondaryText = getString PLEASE_ASSIST_THEM_IF_NEEDED, imageUrl = fetchImage FF_ASSET "ny_ic_disability_purple"}
                          Just ST.SAFETY, _ -> config {primaryText = getString CUSTOMER_SAFETY_FIRST, secondaryText = getString LETS_ENSURE_SAFE_RIDE, imageUrl = fetchImage FF_COMMON_ASSET "ny_ic_green_sheild", background = Color.green100, textColor = Color.green900}
                          Just ST.SPECIAL_ZONE_PICKUP, _ -> config {primaryText = getString SPECIAL_PICKUP_ZONE, secondaryText = getString PRIORITY_RIDE_EXPIERENCE, imageUrl = fetchImage FF_COMMON_ASSET "ny_ic_sp_zone_green",background = Color.green100, textColor = Color.green900}
                          Nothing, true -> config {primaryText = getString CUSTOMER_HAS_DISABILITY, secondaryText = getString PLEASE_ASSIST_THEM_IF_NEEDED, imageUrl = fetchImage FF_ASSET "ny_ic_disability_purple"}
                      else 
                        case state.data.activeRide.disabilityTag of   
                          Just ST.HEAR_IMPAIRMENT -> config {primaryText = getString CUSTOMER_HAS_HEARING_IMPAIRMENT, secondaryText = getString PLEASE_HELP_THEM_AS_YOU_CAN, imageUrl = fetchImage FF_ASSET "ny_ic_poor_hearing"}
                          Just ST.BLIND_AND_LOW_VISION -> config {primaryText = getString CUSTOMER_HAS_LOW_VISION, secondaryText = getString PLEASE_HELP_THEM_AS_YOU_CAN, imageUrl = fetchImage FF_ASSET "ic_accessibility_vision"}
                          Just ST.LOCOMOTOR_DISABILITY -> config {primaryText = getString CUSTOMER_HAS_LOW_MOBILITY, secondaryText = getString PLEASE_HELP_THEM_AS_YOU_CAN, imageUrl = fetchImage FF_ASSET "ny_ic_disability_purple"}
                          Just ST.OTHER_DISABILITY -> config {primaryText = getString CUSTOMER_HAS_DISABILITY, secondaryText = getString PLEASE_HELP_THEM_AS_YOU_CAN, imageUrl = fetchImage FF_ASSET "ny_ic_disability_purple"}
                          Just ST.SAFETY -> config {primaryText =  getString CUSTOMER_SAFETY_FIRST, secondaryText = getString LETS_ENSURE_SAFE_RIDE, imageUrl = fetchImage FF_COMMON_ASSET "ny_ic_green_sheild", background = Color.green100, textColor = Color.green900}
                          Just ST.SPECIAL_ZONE_PICKUP -> config {primaryText = getString SPECIAL_PICKUP_ZONE, secondaryText = getString PRIORITY_RIDE_EXPIERENCE, imageUrl = fetchImage FF_COMMON_ASSET "ny_ic_sp_zone_green", background = Color.green100, textColor = Color.green900}
                          Nothing -> config {primaryText = getString CUSTOMER_HAS_DISABILITY, secondaryText = getString PLEASE_HELP_THEM_AS_YOU_CAN, imageUrl = fetchImage FF_ASSET "ny_ic_disability_purple"}

getRideCompletedConfig :: ST.HomeScreenState -> RideCompletedCard.Config 
getRideCompletedConfig state = let 
  config = RideCompletedCard.config
  autoPayBanner = state.props.autoPayBanner
  autoPayStatus = state.data.paymentState.autoPayStatus
  payerVpa = state.data.endRideData.payerVpa
  bannerConfig = autopayBannerConfig state false
  disability = state.data.endRideData.disability /= Nothing
  specialZonePickup = isJust $ state.data.endRideData.specialZonePickup
  topPillConfig = constructTopPillConfig disability specialZonePickup
  showDriverBottomCard = state.data.config.rideCompletedCardConfig.showSavedCommission || isJust state.data.endRideData.tip
  viewOrderConfig = [ {condition : autoPayBanner == DUE_LIMIT_WARNING_BANNER, elementView :  RideCompletedCard.BANNER },
                      {condition : autoPayStatus == ACTIVE_AUTOPAY && payerVpa /= "", elementView :  RideCompletedCard.QR_VIEW },
                      {condition : not (autoPayStatus == ACTIVE_AUTOPAY) && state.data.config.subscriptionConfig.enableSubscriptionPopups && (getValueToLocalNativeStore SHOW_SUBSCRIPTIONS == "true"), elementView :  RideCompletedCard.NO_VPA_VIEW },
                      {condition : autoPayBanner /= DUE_LIMIT_WARNING_BANNER, elementView :  RideCompletedCard.BANNER },
                      {condition : disability, elementView :  RideCompletedCard.BADGE_CARD },
                      {condition : showDriverBottomCard, elementView :  RideCompletedCard.DRIVER_BOTTOM_VIEW}
                    ]
  pspIcon = (Const.getPspIcon payerVpa)
  config' = config{
    isFreeRide = state.props.isFreeRide,
    primaryButtonConfig {
      width = MATCH_PARENT,
      margin = MarginTop 0,
      textConfig {
        text = getString FARE_COLLECTED
      },
      enableRipple = true,
      rippleColor = Color.rippleShade
    },
    topCard {
      title = getString COLLECT_VIA_UPI_QR_OR_CASH,
      finalAmount = state.data.endRideData.finalAmount,
      initalAmount = state.data.endRideData.finalAmount,
      fareUpdatedVisiblity = state.props.isFreeRide,
      gradient =  ["#F5F8FF","#E2EAFF"],
      infoPill {
        text = getString COLLECT_VIA_CASE_UPI,
        color = Color.white900,
        cornerRadius = 100.0,
        padding = Padding 16 16 16 16,
        margin = MarginTop 16,
        background = Color.peacoat,
        stroke = "1," <> Color.peacoat,
        alpha = 0.8,
        fontStyle = Body1,
        visible = if state.props.isFreeRide then VISIBLE else GONE
      },
      topPill = topPillConfig,
      bottomText = getString RIDE_DETAILS
    },
    driverBottomCard {
      visible = showDriverBottomCard,
      savedMoney = (if state.data.config.rideCompletedCardConfig.showSavedCommission then [{amount  : (state.data.endRideData.finalAmount * 18) / 100 , reason : getString SAVED_DUE_TO_ZERO_COMMISSION}] else []) <> (case state.data.endRideData.tip of 
                            Just val -> [{amount : val, reason : getString TIP_EARNED_FROM_CUSTOMER}]
                            Nothing -> [])
    },
    contactSupportPopUpConfig{
      gravity = CENTER,
      cornerRadius = PTD.Corners 15.0 true true true true,
      margin = MarginHorizontal 16 16,
      padding = PaddingTop 24,
      buttonLayoutMargin = Margin 0 0 0 0,
      primaryText {
        text = getString CONTACT_SUPPORT <> "?",
        margin = MarginBottom 12
      },
      secondaryText {
        text = getString $ YOU_ARE_ABOUT_TO_CALL_NAMMA_YATRI_SUPPORT "YOU_ARE_ABOUT_TO_CALL_NAMMA_YATRI_SUPPORT",
        margin = MarginBottom 16
      },
      option1 {
        text = getString CANCEL
      },
      option2 {
        text = getString CALL_SUPPORT
      }
    },
    badgeCard{
      visible = disability,
      image = fetchImage FF_ASSET "ny_ic_disability_confetti_badge",
      imageWidth = V 152, 
      imageHeight = V 106,
      text1 = getString BADGE_EARNED,
      text2 = getString PURPLE_RIDE_CHAMPION,
      background = Color.mangolia
    },
    showContactSupportPopUp = state.props.showContactSupportPopUp,
    driverUpiQrCard {
      text = getString GET_DIRECTLY_TO_YOUR_BANK_ACCOUNT,
      id = "renderQRViewOnRideComplete",
      vpa = payerVpa,
      vpaIcon = fetchImage FF_ASSET pspIcon,
      collectCashText = getString OR_COLLECT_CASH_DIRECTLY
    },
    noVpaCard {
      title = getString SETUP_AUTOPAY_TO_ACCEPT_PAYMENT,
      collectCashText = getString COLLECT_CASH_DIRECTLY
    },
    accessibility = DISABLE,
    theme = LIGHT,
    isPrimaryButtonSticky = true,
    bannerConfig = bannerConfig{isBanner = autoPayBanner /= NO_SUBSCRIPTION_BANNER},
    viewsByOrder = map (_.elementView) (DA.filter (_.condition) viewOrderConfig),
    lottieQRAnim {
      visible = state.data.config.rideCompletedCardConfig.lottieQRAnim,
      url = (HU.getAssetsBaseUrl FunctionCall) <> "lottie/end_ride_qr_anim.json"
    }
  }
  in config'

type TopPillConfig = {
  visible :: Boolean,
  text :: String,
  textColor :: String,
  background :: String,
  icon :: Maybe String
}

constructTopPillConfig :: Boolean -> Boolean -> TopPillConfig
constructTopPillConfig disability specialZonePickup
  | disability = {
      visible: true,
      text: getString PURPLE_RIDE,
      textColor: Color.white900,
      background: Color.blueMagenta,
      icon : Nothing
    }
  | specialZonePickup = {
      visible: true,
      text: "Zone pickup",
      textColor: Color.white900,
      background: Color.green900,
      icon : Just "ny_ic_location_pin_white"
    }
  | otherwise = {
      visible: false,
      text: "",
      textColor: Color.white900,
      background: Color.blueMagenta,
      icon : Nothing
    }

getRatingCardConfig :: ST.HomeScreenState -> RatingCard.RatingCardConfig
getRatingCardConfig state = RatingCard.ratingCardConfig {
    data {
      rating = state.data.endRideData.rating
    },
    primaryButtonConfig {
      textConfig {
        text = getString SUBMIT_FEEDBACK
      },
      isClickable = if state.data.endRideData.rating > 0 then true else false,
      alpha = if state.data.endRideData.rating > 0 then 1.0 else 0.4,
      id = "RatingCardPrimayButton"
    },
    title = getString RATE_YOUR_RIDE_WITH1 <> " " <> state.data.endRideData.riderName <> " " <>  getString RATE_YOUR_RIDE_WITH2,
    feedbackPlaceHolder = getString HELP_US_WITH_YOUR_FEEDBACK,
    closeImgVisible = VISIBLE
  }

subsBlockerPopUpConfig :: ST.HomeScreenState -> PopUpModal.Config
subsBlockerPopUpConfig state = PopUpModal.config {
    cornerRadius = PTD.Corners 15.0 true true true true
    , buttonLayoutMargin = MarginTop 0
    , margin = MarginHorizontal 16 16
    , padding = Padding 16 16 16 16
    , gravity = CENTER
    , backgroundColor =  Color.black9000
    , backgroundClickable = false
    , optionButtonOrientation = "HORIZONTAL"
  ,primaryText {
      text = getString JOIN_A_PLAN_TO_START_EARNING
    , margin = Margin 16 16 16 0
    , color = Color.black800
    , textStyle = Heading2
    },
    option1 {
      text = getString JOIN_NOW
    , color = Color.yellow900
    , background = Color.black900
    , visibility = true
    , margin = MarginTop 16
    , width = MATCH_PARENT

    },
    coverImageConfig {
      imageUrl = fetchImage FF_ASSET "ny_ic_sub_save_more"
    , visibility = VISIBLE
    , width = V 280
    , height = V 250
    },
  secondaryText {visibility = GONE},
  option2 { 
    visibility = false
  },
  optionWithHtml {
    textOpt1 {
      color = Color.black650
      , text = getString NEED_HELP
      , textStyle = SubHeading2
      , visibility = VISIBLE
    }
    , textOpt2 {
      color = Color.blue800
      , textStyle = SubHeading2
      , text = getString CALL_SUPPORT
      , visibility = VISIBLE
    } 
    , image {
        imageUrl = fetchImage FF_ASSET "ny_ic_phone_filled_blue"
        , height = V 16
        , width = V 16
        , visibility = VISIBLE
        , margin = Margin 3 1 3 0
      }
    , strokeColor = Color.white900
    , margin = MarginHorizontal 16 16
    , background = Color.white900
    , visibility = true
    , isClickable = true
    },
  dismissPopup = false
    }

gotoKnowMoreConfig :: ST.HomeScreenState-> PopUpModal.Config
gotoKnowMoreConfig state = PopUpModal.config {
    optionButtonOrientation = "HORIZONTAL",
    buttonLayoutMargin = Margin 16 0 16 20,
    gravity = CENTER,
    margin = MarginHorizontal 20 20,
    cornerRadius = PTD.Corners 15.0 true true true true,
    primaryText{ text = getString KNOW_MORE},
    secondaryText{text = getString THIS_FEATURE_WILL_BE_APPLICABLE,
    margin = MarginVertical 16 20,
    color = Color.black600},
    option1 {
      text = getString GO_BACK,
      margin = MarginHorizontal 16 16,
      color = "#339DFF",
      background = Color.white900,
      strokeColor = Color.white900,
      width = MATCH_PARENT
    },
    option2 {
      visibility = false
    }
  }
-------------------------------------------------DriverRequestPopuop------------------------------------------

gotoRequestPopupConfig :: ST.HomeScreenState -> PopUpModal.Config
gotoRequestPopupConfig state = PopUpModal.config {
    gravity = CENTER,
    optionButtonOrientation = "HORIZONTAL",
    buttonLayoutMargin = Margin 16 0 16 20,
    margin = MarginHorizontal 20 20, 
    primaryText {
      text = strings.primaryText
    , textStyle = Heading2
    , margin = Margin 16 0 16 10},
    secondaryText{
      text = strings.secondaryText
    , textStyle = Body5
    , margin = MarginBottom 20 },
    option1 {
      text = strings.buttonText
    , color = Color.yellow900
    , background = Color.black900
    , strokeColor = Color.transparent
    , textStyle = FontStyle.SubHeading1
    , width = MATCH_PARENT
    },
    option2 { visibility = false
    },
    cornerRadius = PTD.Corners 15.0 true true true true,
    coverImageConfig {
      imageUrl = strings.imageURL
    , visibility = VISIBLE
    , margin = Margin 16 20 16 24
    , width = MATCH_PARENT
    , height = V 270
    }
  }
  where (PopupReturn strings) = gotoCounterStrings state.data.driverGotoState.goToPopUpType

newtype PopupReturn = PopupReturn {
  primaryText :: String,
  secondaryText :: String,
  imageURL :: String,
  buttonText :: String
} 

gotoCounterStrings :: GoToPopUpType -> PopupReturn
gotoCounterStrings popupType = 
  case popupType of 
    MORE_GOTO_RIDES -> PopupReturn { primaryText : getString MORE_GOTO_RIDE_COMING
                              , secondaryText : getString MORE_GOTO_RIDE_COMING_DESC
                              , imageURL : getImage "ny_ic_goto_more_rides" ",https://assets.juspay.in/beckn/jatrisaathi/driver/images/ny_ic_goto_more_rides.png"
                              , buttonText : getString OKAY
                              }
    REDUCED 0 -> PopupReturn { primaryText : getString GOTO_REDUCED_TO_ZERO
                              , secondaryText : getString DUE_TO_MULTIPLE_CANCELLATIONS <> " 0."
                              , imageURL : getImage "ny_ic_gotodriver_zero" "ny_ic_gotodriver_zero,https://assets.juspay.in/beckn/jatrisaathi/driver/images/ny_ic_gotodriver_zero.png"
                              , buttonText : getString OK_GOT_IT
                              }
    REDUCED n -> PopupReturn { primaryText : getString GOTO_REDUCED_TO <> " " <> show n
                              , secondaryText : getString DUE_TO_MULTIPLE_CANCELLATIONS <> " " <> show  n <> "."
                              , imageURL : getImage "ny_ic_gotodriver_one" "ny_ic_gotodriver_one,https://assets.juspay.in/beckn/jatrisaathi/driver/images/ny_ic_gotodriver_one.png"
                              , buttonText : getString OK_GOT_IT
                              }
    VALIDITY_EXPIRED -> PopupReturn { primaryText : getString VALIDITY_EXPIRED_STR
                              , secondaryText : getString VALIDITY_EXPIRED_DESC
                              , imageURL : fetchImage FF_ASSET "ny_ic_validity_expired"
                              , buttonText : getString OK_GOT_IT
                              }
    REACHED_HOME -> PopupReturn { primaryText : getString GOTO_LOC_REACHED
                              , secondaryText : getString YOU_ARE_ALMOST_AT_LOCATION
                              , imageURL : getImage "ny_ic_goto_arrived" ",https://assets.juspay.in/beckn/jatrisaathi/driver/images/ny_ic_goto_arrived.png"
                              , buttonText : getString OK_GOT_IT
                              }
    NO_POPUP_VIEW -> PopupReturn { primaryText : "" , secondaryText : "" , imageURL : "" , buttonText : "" }
  where 
    getImage current new = 
      let isVehicleRickshaw = (getValueFromCache (show VEHICLE_VARIANT) JB.getKeyInSharedPrefKeys) == "AUTO_RICKSHAW"
      in if isVehicleRickshaw then fetchImage FF_ASSET current else new

------------------------------------------------------------------------------gotoLocInRange------------------------------------------------------------------------------------
gotoLocInRangeConfig :: ST.HomeScreenState-> PopUpModal.Config
gotoLocInRangeConfig _ = PopUpModal.config {
    optionButtonOrientation = "HORIZONTAL",
    buttonLayoutMargin = Margin 16 0 16 20,
    gravity = CENTER,
    margin = MarginHorizontal 20 20,
    cornerRadius = PTD.Corners 15.0 true true true true,
    primaryText{ text = getString YOU_ARE_VERY_CLOSE},
    secondaryText{
      text = getString GOTO_IS_APPLICABLE_FOR,
      margin = MarginVertical 16 20,
      color = Color.black600},
    option1 {
      text = getString GOT_IT,
      margin = MarginHorizontal 16 16,
      color = Color.yellow900,
      background = Color.black900,
      strokeColor = Color.white900,
      width = MATCH_PARENT
    },
    option2 {
      visibility = false
    }
  }

disableGotoConfig :: ST.HomeScreenState-> PopUpModal.Config
disableGotoConfig _ = PopUpModal.config {
  optionButtonOrientation = "VERTICAL",
  buttonLayoutMargin = Margin 16 0 16 20,
  gravity = CENTER,
  backgroundClickable = false,
  margin = MarginHorizontal 20 20,
  cornerRadius = PTD.Corners 15.0 true true true true,
  primaryText{ text = getString DISABLE_GOTO_STR},
  secondaryText{text = getString YOU_STILL_HAVE_TIME_LEFT,
  margin = Margin 0 16 0 20,
  color = Color.black600},
  option1 {
    text = getString YES_DISABLE,
    margin = MarginHorizontal 16 16,
    color = Color.yellow900,
    background = Color.black900,
    strokeColor = Color.white900,
    width = MATCH_PARENT
  },
  option2 {
    text = getString CANCEL,
    margin = MarginHorizontal 16 16,
    color = Color.black650,
    background = Color.white900,
    strokeColor = Color.white900,
    width = MATCH_PARENT
  }
}


locationListItemConfig :: ST.GoToLocation -> ST.HomeScreenState -> GoToLocationModal.GoToModalConfig
locationListItemConfig state homeScreenState = GoToLocationModal.config 
  { id = state.id,
    lat = state.lat,
    lon = state.lon,
    address = state.address,
    tag = state.tag,
    isSelectable = true,
    isEditEnabled = false,
    isSelected = homeScreenState.data.driverGotoState.selectedGoTo == state.id,
    removeAcText = Nothing,
    editAcText = Nothing,
    disabled = state.disabled
  }

primaryButtonConfig :: ST.HomeScreenState -> PrimaryButton.Config
primaryButtonConfig _ = PrimaryButton.config
  { textConfig
      { text = getString ADD_LOCATION}
    , margin = (Margin 16 15 16 24)
    , height = V 52
  }


enableButtonConfig :: ST.HomeScreenState -> PrimaryButton.Config
enableButtonConfig state = PrimaryButton.config
  { textConfig 
    { text = getString YES_ENABLE
    , textStyle = SubHeading1
    , weight = Just 1.0
    }
  , height = WRAP_CONTENT
  , gravity = CENTER
  , cornerRadius = 8.0
  , padding = Padding 10 14 10 15
  , margin = MarginLeft 0
  , id = "EnableGoto"
  , alpha = if state.data.driverGotoState.selectedGoTo /= "" then 1.0 else 0.5
  , isClickable = state.data.driverGotoState.selectedGoTo /= ""
  , enableLoader = JB.getBtnLoader "EnableGoto"
  , lottieConfig 
    { lottieURL = (HU.getAssetsBaseUrl FunctionCall) <> "lottie/primary_button_loader.json"
    , width = V 90
    , height = V 50
    }
  }

cancelButtonConfig :: ST.HomeScreenState -> PrimaryButton.Config
cancelButtonConfig _ = PrimaryButton.config
  { textConfig
    { text = getString CANCEL
    , gravity = LEFT
    , height = WRAP_CONTENT
    , textStyle = SubHeading1
    , weight = Just 1.0
    , color = Color.black900
    }
  , height = WRAP_CONTENT
  , gravity = CENTER
  , cornerRadius = 8.0
  , padding = Padding 10 14 10 15
  , margin = MarginLeft 0
  , stroke = "1," <> Color.grey800
  , background = Color.white900
  }

gotoButtonConfig :: ST.HomeScreenState -> PrimaryButton.Config
gotoButtonConfig state = PrimaryButton.config
  { textConfig 
    { text = if (state.data.driverGotoState.isGotoEnabled) then state.data.driverGotoState.timerInMinutes else getString GO_TO
    , textStyle = Tags
    , weight = Just 1.0
    , gravity = CENTER
    , color = gotoTimer.textColor
    }
  , height = WRAP_CONTENT
  , gravity = CENTER
  , cornerRadius = 22.0
  , width = WRAP_CONTENT
  , padding = if (state.data.driverGotoState.isGotoEnabled) then Padding 16 11 16 11 else Padding 24 11 24 11
  , margin = MarginLeft 0
  , isPrefixImage = true
  , stroke = "0," <> Color.black900
  , background = gotoTimer.bgColor
  , prefixImageConfig
    { imageUrl = gotoTimer.imageString
    , height = V 15
    , width = V 15
    , margin = MarginRight 5
    }
  , id = "GotoClick"
  , alpha = if state.data.driverGotoState.gotoCount == 0 then 0.3 else 1.0
  , enableLoader = JB.getBtnLoader "GotoClick"
  , enableRipple = true
  , rippleColor = Color.rippleShade
  , lottieConfig 
    { lottieURL = (HU.getAssetsBaseUrl FunctionCall) <> "lottie/primary_button_loader.json"
    , width = V 100
    , height = V 35
    , autoDisableLoader = false
    }
  }
  where gotoTimer = gotoTimerConfig state.data.driverGotoState.isGotoEnabled

gotoTimerConfig :: Boolean -> {bgColor :: String , imageString :: String, textColor :: String }
gotoTimerConfig enabled 
  | enabled = {bgColor : Color.green900, imageString : fetchImage FF_ASSET "ny_pin_check_white", textColor : Color.white900}
  | otherwise = {bgColor : Color.white900, imageString : fetchImage FF_ASSET "ny_ic_goto_icon_map_pin_check", textColor : Color.black800}

sourceUnserviceableConfig :: ST.HomeScreenState -> ErrorModal.Config
sourceUnserviceableConfig state =
  let
    config = ErrorModal.config
    errorModalConfig' =
      config
        { height = if state.data.config.enableMockLocation && state.props.isMockLocation then MATCH_PARENT else WRAP_CONTENT
        , background = Color.white900
        , corners = (Corners 24.0 true true false false)
        , stroke = ("1," <> Color.borderGreyColor)
        , imageConfig
          { imageUrl = fetchImage FF_ASSET "ny_ic_location_unserviceable"
          , height = V 99
          , width = V 133
          , margin = (Margin 0 50 0 20)
          }
        , errorConfig
          { text = getString UNABLE_TO_GET_YOUR_LOCATION
          , color = Color.black800
          , margin = (MarginBottom 5)
          }
        , errorDescriptionConfig
          { text = getString TURN_OFF_ANY_MOCK_LOCATION_APP_AND_RESTART
          , color = Color.black700
          , margin = (Margin 20 0 20 (40 + EHC.safeMarginBottom))
          }
        , buttonConfig
          { text = (getString CHANGE_LOCATION)
          , margin = (Margin 16 0 16 (20 + EHC.safeMarginBottom))
          , background = state.data.config.primaryBackground
          , color = state.data.config.primaryTextColor
          , visibility = GONE
          }
        }
  in
    errorModalConfig'

accountBlockedPopup :: ST.HomeScreenState -> PopUpModal.Config
accountBlockedPopup state = PopUpModal.config {
    gravity = CENTER,
    backgroundClickable = false,
    optionButtonOrientation = "VERTICAL",
    buttonLayoutMargin = Margin 16 0 16 20,
    margin = MarginHorizontal 25 25, 
    primaryText {
      text = getString ACCOUNT_BLOCKED
    , textStyle = Heading2
    , margin = Margin 16 0 16 10},
    secondaryText{
      text = getString YOU_HAVE_BEEN_BLOCKED_FROM_TAKING_RIDES
    , textStyle = Body5
    , margin = Margin 16 0 16 15 },
    option1 {
      text = getString CALL_SUPPORT
    , color = Color.yellow900
    , background = Color.black900
    , strokeColor = Color.transparent
    , textStyle = FontStyle.SubHeading1
    , width = MATCH_PARENT
    },
    option2 {
    text = getString DISMISS,
    margin = MarginHorizontal 16 16,
    color = Color.black650,
    background = Color.white900,
    strokeColor = Color.white900,
    width = MATCH_PARENT
  },
    cornerRadius = PTD.Corners 15.0 true true true true,
    coverImageConfig {
      imageUrl = fetchImage FF_ASSET "ny_failed"
    , visibility = VISIBLE
    , margin = Margin 16 20 16 24
    , width = V 160
    , height = V 118
    }
  }

vehicleNotSupportedPopup :: ST.HomeScreenState -> PopUpModal.Config
vehicleNotSupportedPopup state = 
  let cityConfig = HU.getCityConfig state.data.config.cityConfig $ getValueToLocalStore DRIVER_LOCATION
  in PopUpModal.config {
      gravity = CENTER,
      backgroundClickable = false,
      optionButtonOrientation = "HORIZONTAL",
      buttonLayoutMargin = Margin 16 0 16 20,
      margin = MarginHorizontal 25 25, 
      primaryText {
        text = getString WE_ARE_CURRENTLY_LIVE_WITH_VEHICLE
      , textStyle = Heading2
      , margin = Margin 16 0 16 10},
      secondaryText{
        text = getString WE_ARE_CURRENTLY_LIVE_WITH_VEHICLE_DESC
      , textStyle = Body5
      , margin = Margin 16 0 16 15 },
      option1 {
        text = getString OKAY
      , color = Color.yellow900
      , background = Color.black900
      , strokeColor = Color.transparent
      , textStyle = FontStyle.SubHeading1
      , width = MATCH_PARENT
      },
      option2 {
      visibility = false
    },
      cornerRadius = PTD.Corners 15.0 true true true true,
      coverImageConfig {
        imageUrl = fetchImage FF_ASSET cityConfig.vehicleNSImg
      , visibility = VISIBLE
      , margin = MarginHorizontal 16 16
      , width = V 300
      , height = V 315
      }
    }

bgLocPopup :: ST.HomeScreenState -> PopUpModal.Config
bgLocPopup state = 
  PopUpModal.config {
      gravity = CENTER,
      backgroundClickable = false,
      optionButtonOrientation = "HORIZONTAL",
      buttonLayoutMargin = Margin 16 0 16 20,
      margin = MarginHorizontal 25 25, 
      primaryText {
        text = getString ENABLE_LOC_PERMISSION_TO_GET_RIDES
      , textStyle = Heading2
      , margin = Margin 16 0 16 10},
      secondaryText{
        text = getString ENABLE_LOC_PER_FROM_SETTINGS
      , textStyle = Body5
      , margin = Margin 16 0 16 15 },
      option1 {
        text = getString ENABLE_PERMISSION_STR
      , color = Color.yellow900
      , background = Color.black900
      , strokeColor = Color.transparent
      , textStyle = FontStyle.SubHeading1
      , width = MATCH_PARENT
      , enableRipple = true
      },
      option2 {
      visibility = false
    },
      cornerRadius = PTD.Corners 15.0 true true true true,
      coverImageConfig {
        imageUrl = fetchImage FF_ASSET "ny_ic_bgloc"
      , visibility = VISIBLE
      , width = V 300
      , height = V 315
      }
    }
  
    
introducingCoinsPopup :: ST.HomeScreenState -> PopUpModal.Config
introducingCoinsPopup state = PopUpModal.config {
    cornerRadius = PTD.Corners 15.0 true true true true
    , buttonLayoutMargin = MarginTop 0
    , margin = MarginHorizontal 16 16
    , padding = Padding 16 16 16 16
    , gravity = CENTER
    , backgroundColor =  Color.black9000
    , backgroundClickable = false
    , optionButtonOrientation = "HORIZONTAL"
  ,primaryText {
      text = getString INTRODUCING_YATRI_COINS <> " 🎉"
    , margin = MarginHorizontal 16 16
    , color = Color.black800
    , textStyle = Heading2
    },
    option1 {
      text = getString CHECK_NOW
    , color = Color.yellow900
    , background = Color.black900
    , visibility = true
    , margin = MarginTop 16
    , width = MATCH_PARENT

    },
    coverImageConfig {
      imageUrl = fetchImage FF_ASSET "ny_ic_coin_balance"
    , visibility = VISIBLE
    , width = V 280
    , height = V 250
    },
  secondaryText {
    text = getString NOW_EARN_COINS_FOR_EVERY_RIDE_AND_REFERRAL_AND_USE_THEM_TO_GET_REWARDS
    , margin = Margin 16 4 16 0
    , color = Color.black700
    , textStyle = SubHeading2
  },
  option2 { 
    visibility = false
  },
  optionWithHtml {
    textOpt1 {
      color = Color.black650
      , text = getString MAYBE_LATER
      , textStyle = SubHeading2
      , visibility = VISIBLE
    }
    , strokeColor = Color.white900
    , margin = MarginHorizontal 16 16
    , background = Color.white900
    , visibility = true
    , isClickable = true
    },
  dismissPopup = false
    }
