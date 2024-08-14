{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

module API.Action.ProviderPlatform.Management.Merchant
  ( API,
    handler,
  )
where

import qualified API.Types.ProviderPlatform.Management.Merchant
import qualified Dashboard.Common
import qualified Dashboard.Common.Merchant
import qualified Domain.Action.ProviderPlatform.Management.Merchant
import qualified "lib-dashboard" Domain.Types.Merchant
import qualified "lib-dashboard" Environment
import EulerHS.Prelude hiding (sortOn)
import qualified Kernel.Prelude
import qualified Kernel.Types.APISuccess
import qualified Kernel.Types.Beckn.Context
import qualified Kernel.Types.Common
import qualified Kernel.Types.Id
import Kernel.Utils.Common hiding (INFO)
import qualified Lib.Types.SpecialLocation
import Servant
import Storage.Beam.CommonInstances ()
import Tools.Auth.Api

type API = ("merchant" :> (PostMerchantUpdate :<|> GetMerchantConfigCommon :<|> PostMerchantConfigCommonUpdate :<|> GetMerchantConfigDriverPool :<|> PostMerchantConfigDriverPoolUpdate :<|> PostMerchantConfigDriverPoolCreate :<|> GetMerchantConfigDriverIntelligentPool :<|> PostMerchantConfigDriverIntelligentPoolUpdate :<|> GetMerchantConfigOnboardingDocument :<|> PostMerchantConfigOnboardingDocumentUpdate :<|> PostMerchantConfigOnboardingDocumentCreate :<|> GetMerchantServiceUsageConfig :<|> PostMerchantServiceConfigMapsUpdate :<|> PostMerchantServiceUsageConfigMapsUpdate :<|> PostMerchantServiceConfigSmsUpdate :<|> PostMerchantServiceUsageConfigSmsUpdate :<|> PostMerchantServiceConfigVerificationUpdate :<|> PostMerchantConfigFarePolicyDriverExtraFeeBoundsCreate :<|> PostMerchantConfigFarePolicyDriverExtraFeeBoundsUpdate :<|> PostMerchantConfigFarePolicyPerExtraKmRateUpdate :<|> PostMerchantConfigFarePolicyUpdate :<|> PostMerchantConfigFarePolicyUpsert :<|> PostMerchantConfigOperatingCityCreate :<|> PostMerchantSchedulerTrigger :<|> PostMerchantUpdateOnboardingVehicleVariantMapping :<|> PostMerchantSpecialLocationUpsert :<|> DeleteMerchantSpecialLocationDelete :<|> PostMerchantSpecialLocationGatesUpsert :<|> DeleteMerchantSpecialLocationGatesDelete))

handler :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> Environment.FlowServer API)
handler merchantId city = postMerchantUpdate merchantId city :<|> getMerchantConfigCommon merchantId city :<|> postMerchantConfigCommonUpdate merchantId city :<|> getMerchantConfigDriverPool merchantId city :<|> postMerchantConfigDriverPoolUpdate merchantId city :<|> postMerchantConfigDriverPoolCreate merchantId city :<|> getMerchantConfigDriverIntelligentPool merchantId city :<|> postMerchantConfigDriverIntelligentPoolUpdate merchantId city :<|> getMerchantConfigOnboardingDocument merchantId city :<|> postMerchantConfigOnboardingDocumentUpdate merchantId city :<|> postMerchantConfigOnboardingDocumentCreate merchantId city :<|> getMerchantServiceUsageConfig merchantId city :<|> postMerchantServiceConfigMapsUpdate merchantId city :<|> postMerchantServiceUsageConfigMapsUpdate merchantId city :<|> postMerchantServiceConfigSmsUpdate merchantId city :<|> postMerchantServiceUsageConfigSmsUpdate merchantId city :<|> postMerchantServiceConfigVerificationUpdate merchantId city :<|> postMerchantConfigFarePolicyDriverExtraFeeBoundsCreate merchantId city :<|> postMerchantConfigFarePolicyDriverExtraFeeBoundsUpdate merchantId city :<|> postMerchantConfigFarePolicyPerExtraKmRateUpdate merchantId city :<|> postMerchantConfigFarePolicyUpdate merchantId city :<|> postMerchantConfigFarePolicyUpsert merchantId city :<|> postMerchantConfigOperatingCityCreate merchantId city :<|> postMerchantSchedulerTrigger merchantId city :<|> postMerchantUpdateOnboardingVehicleVariantMapping merchantId city :<|> postMerchantSpecialLocationUpsert merchantId city :<|> deleteMerchantSpecialLocationDelete merchantId city :<|> postMerchantSpecialLocationGatesUpsert merchantId city :<|> deleteMerchantSpecialLocationGatesDelete merchantId city

type PostMerchantUpdate = (ApiAuth ('DRIVER_OFFER_BPP_MANAGEMENT) ('MERCHANT) ('MERCHANT_UPDATE) :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantUpdate)

type GetMerchantConfigCommon = (ApiAuth ('DRIVER_OFFER_BPP_MANAGEMENT) ('MERCHANT) ('MERCHANT_COMMON_CONFIG) :> API.Types.ProviderPlatform.Management.Merchant.GetMerchantConfigCommon)

type PostMerchantConfigCommonUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('MERCHANT_COMMON_CONFIG_UPDATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigCommonUpdate
  )

type GetMerchantConfigDriverPool = (ApiAuth ('DRIVER_OFFER_BPP_MANAGEMENT) ('MERCHANT) ('DRIVER_POOL_CONFIG) :> API.Types.ProviderPlatform.Management.Merchant.GetMerchantConfigDriverPool)

type PostMerchantConfigDriverPoolUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('DRIVER_POOL_CONFIG_UPDATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigDriverPoolUpdate
  )

type PostMerchantConfigDriverPoolCreate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('DRIVER_POOL_CONFIG_CREATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigDriverPoolCreate
  )

type GetMerchantConfigDriverIntelligentPool =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('DRIVER_INTELLIGENT_POOL_CONFIG)
      :> API.Types.ProviderPlatform.Management.Merchant.GetMerchantConfigDriverIntelligentPool
  )

type PostMerchantConfigDriverIntelligentPoolUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('DRIVER_INTELLIGENT_POOL_CONFIG_UPDATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigDriverIntelligentPoolUpdate
  )

type GetMerchantConfigOnboardingDocument =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('ONBOARDING_DOCUMENT_CONFIG)
      :> API.Types.ProviderPlatform.Management.Merchant.GetMerchantConfigOnboardingDocument
  )

type PostMerchantConfigOnboardingDocumentUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('ONBOARDING_DOCUMENT_CONFIG_UPDATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigOnboardingDocumentUpdate
  )

type PostMerchantConfigOnboardingDocumentCreate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('ONBOARDING_DOCUMENT_CONFIG_CREATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigOnboardingDocumentCreate
  )

type GetMerchantServiceUsageConfig = (ApiAuth ('DRIVER_OFFER_BPP_MANAGEMENT) ('MERCHANT) ('SERVICE_USAGE_CONFIG) :> API.Types.ProviderPlatform.Management.Merchant.GetMerchantServiceUsageConfig)

type PostMerchantServiceConfigMapsUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('MAPS_SERVICE_CONFIG_UPDATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantServiceConfigMapsUpdate
  )

type PostMerchantServiceUsageConfigMapsUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('MAPS_SERVICE_USAGE_CONFIG_UPDATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantServiceUsageConfigMapsUpdate
  )

type PostMerchantServiceConfigSmsUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('SMS_SERVICE_CONFIG_UPDATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantServiceConfigSmsUpdate
  )

type PostMerchantServiceUsageConfigSmsUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('SMS_SERVICE_USAGE_CONFIG_UPDATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantServiceUsageConfigSmsUpdate
  )

type PostMerchantServiceConfigVerificationUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('VERIFICATION_SERVICE_CONFIG_UPDATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantServiceConfigVerificationUpdate
  )

type PostMerchantConfigFarePolicyDriverExtraFeeBoundsCreate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('CREATE_FP_DRIVER_EXTRA_FEE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigFarePolicyDriverExtraFeeBoundsCreate
  )

type PostMerchantConfigFarePolicyDriverExtraFeeBoundsUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('UPDATE_FP_DRIVER_EXTRA_FEE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigFarePolicyDriverExtraFeeBoundsUpdate
  )

type PostMerchantConfigFarePolicyPerExtraKmRateUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('UPDATE_FP_PER_EXTRA_KM_RATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigFarePolicyPerExtraKmRateUpdate
  )

type PostMerchantConfigFarePolicyUpdate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('UPDATE_FARE_POLICY)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigFarePolicyUpdate
  )

type PostMerchantConfigFarePolicyUpsert =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('UPSERT_FARE_POLICY)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigFarePolicyUpsert
  )

type PostMerchantConfigOperatingCityCreate =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('CREATE_MERCHANT_OPERATING_CITY)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantConfigOperatingCityCreate
  )

type PostMerchantSchedulerTrigger = (ApiAuth ('DRIVER_OFFER_BPP_MANAGEMENT) ('MERCHANT) ('SCHEDULER_TRIGGER) :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantSchedulerTrigger)

type PostMerchantUpdateOnboardingVehicleVariantMapping =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('UPDATE_ONBOARDING_VEHICLE_VARIANT_MAPPING)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantUpdateOnboardingVehicleVariantMapping
  )

type PostMerchantSpecialLocationUpsert =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('UPSERT_SPECIAL_LOCATION)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantSpecialLocationUpsert
  )

type DeleteMerchantSpecialLocationDelete =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('DELETE_SPECIAL_LOCATION)
      :> API.Types.ProviderPlatform.Management.Merchant.DeleteMerchantSpecialLocationDelete
  )

type PostMerchantSpecialLocationGatesUpsert =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('UPSERT_SPECIAL_LOCATION_GATE)
      :> API.Types.ProviderPlatform.Management.Merchant.PostMerchantSpecialLocationGatesUpsert
  )

type DeleteMerchantSpecialLocationGatesDelete =
  ( ApiAuth
      ('DRIVER_OFFER_BPP_MANAGEMENT)
      ('MERCHANT)
      ('DELETE_SPECIAL_LOCATION_GATE)
      :> API.Types.ProviderPlatform.Management.Merchant.DeleteMerchantSpecialLocationGatesDelete
  )

postMerchantUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> API.Types.ProviderPlatform.Management.Merchant.MerchantUpdateReq -> Environment.FlowHandler API.Types.ProviderPlatform.Management.Merchant.MerchantUpdateRes)
postMerchantUpdate merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantUpdate merchantShortId opCity apiTokenInfo req

getMerchantConfigCommon :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Environment.FlowHandler API.Types.ProviderPlatform.Management.Merchant.MerchantCommonConfigRes)
getMerchantConfigCommon merchantShortId opCity apiTokenInfo = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.getMerchantConfigCommon merchantShortId opCity apiTokenInfo

postMerchantConfigCommonUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> API.Types.ProviderPlatform.Management.Merchant.MerchantCommonConfigUpdateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantConfigCommonUpdate merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigCommonUpdate merchantShortId opCity apiTokenInfo req

getMerchantConfigDriverPool :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Prelude.Maybe (Kernel.Types.Common.Meters) -> Kernel.Prelude.Maybe (Kernel.Types.Common.HighPrecDistance) -> Kernel.Prelude.Maybe (Kernel.Types.Common.DistanceUnit) -> Environment.FlowHandler API.Types.ProviderPlatform.Management.Merchant.DriverPoolConfigRes)
getMerchantConfigDriverPool merchantShortId opCity apiTokenInfo tripDistance tripDistanceValue distanceUnit = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.getMerchantConfigDriverPool merchantShortId opCity apiTokenInfo tripDistance tripDistanceValue distanceUnit

postMerchantConfigDriverPoolUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Prelude.Maybe (Kernel.Types.Common.HighPrecDistance) -> Kernel.Prelude.Maybe (Kernel.Types.Common.DistanceUnit) -> Kernel.Prelude.Maybe (Dashboard.Common.VehicleVariant) -> Kernel.Prelude.Maybe (Kernel.Prelude.Text) -> Kernel.Types.Common.Meters -> Lib.Types.SpecialLocation.Area -> API.Types.ProviderPlatform.Management.Merchant.DriverPoolConfigUpdateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantConfigDriverPoolUpdate merchantShortId opCity apiTokenInfo tripDistanceValue distanceUnit vehicleVariant tripCategory tripDistance area req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigDriverPoolUpdate merchantShortId opCity apiTokenInfo tripDistanceValue distanceUnit vehicleVariant tripCategory tripDistance area req

postMerchantConfigDriverPoolCreate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Prelude.Maybe (Kernel.Types.Common.HighPrecDistance) -> Kernel.Prelude.Maybe (Kernel.Types.Common.DistanceUnit) -> Kernel.Prelude.Maybe (Dashboard.Common.VehicleVariant) -> Kernel.Prelude.Maybe (Kernel.Prelude.Text) -> Kernel.Types.Common.Meters -> Lib.Types.SpecialLocation.Area -> API.Types.ProviderPlatform.Management.Merchant.DriverPoolConfigCreateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantConfigDriverPoolCreate merchantShortId opCity apiTokenInfo tripDistanceValue distanceUnit vehiclevariant tripCategory tripDistance area req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigDriverPoolCreate merchantShortId opCity apiTokenInfo tripDistanceValue distanceUnit vehiclevariant tripCategory tripDistance area req

getMerchantConfigDriverIntelligentPool :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Environment.FlowHandler API.Types.ProviderPlatform.Management.Merchant.DriverIntelligentPoolConfigRes)
getMerchantConfigDriverIntelligentPool merchantShortId opCity apiTokenInfo = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.getMerchantConfigDriverIntelligentPool merchantShortId opCity apiTokenInfo

postMerchantConfigDriverIntelligentPoolUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> API.Types.ProviderPlatform.Management.Merchant.DriverIntelligentPoolConfigUpdateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantConfigDriverIntelligentPoolUpdate merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigDriverIntelligentPoolUpdate merchantShortId opCity apiTokenInfo req

getMerchantConfigOnboardingDocument :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Prelude.Maybe (API.Types.ProviderPlatform.Management.Merchant.DocumentType) -> Kernel.Prelude.Maybe (Dashboard.Common.VehicleCategory) -> Environment.FlowHandler API.Types.ProviderPlatform.Management.Merchant.DocumentVerificationConfigRes)
getMerchantConfigOnboardingDocument merchantShortId opCity apiTokenInfo documentType vehicleCategory = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.getMerchantConfigOnboardingDocument merchantShortId opCity apiTokenInfo documentType vehicleCategory

postMerchantConfigOnboardingDocumentUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> API.Types.ProviderPlatform.Management.Merchant.DocumentType -> Dashboard.Common.VehicleCategory -> API.Types.ProviderPlatform.Management.Merchant.DocumentVerificationConfigUpdateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantConfigOnboardingDocumentUpdate merchantShortId opCity apiTokenInfo documentType category req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigOnboardingDocumentUpdate merchantShortId opCity apiTokenInfo documentType category req

postMerchantConfigOnboardingDocumentCreate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> API.Types.ProviderPlatform.Management.Merchant.DocumentType -> Dashboard.Common.VehicleCategory -> API.Types.ProviderPlatform.Management.Merchant.DocumentVerificationConfigCreateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantConfigOnboardingDocumentCreate merchantShortId opCity apiTokenInfo documentType category req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigOnboardingDocumentCreate merchantShortId opCity apiTokenInfo documentType category req

getMerchantServiceUsageConfig :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Environment.FlowHandler Dashboard.Common.Merchant.ServiceUsageConfigRes)
getMerchantServiceUsageConfig merchantShortId opCity apiTokenInfo = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.getMerchantServiceUsageConfig merchantShortId opCity apiTokenInfo

postMerchantServiceConfigMapsUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Dashboard.Common.Merchant.MapsServiceConfigUpdateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantServiceConfigMapsUpdate merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantServiceConfigMapsUpdate merchantShortId opCity apiTokenInfo req

postMerchantServiceUsageConfigMapsUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Dashboard.Common.Merchant.MapsServiceUsageConfigUpdateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantServiceUsageConfigMapsUpdate merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantServiceUsageConfigMapsUpdate merchantShortId opCity apiTokenInfo req

postMerchantServiceConfigSmsUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Dashboard.Common.Merchant.SmsServiceConfigUpdateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantServiceConfigSmsUpdate merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantServiceConfigSmsUpdate merchantShortId opCity apiTokenInfo req

postMerchantServiceUsageConfigSmsUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Dashboard.Common.Merchant.SmsServiceUsageConfigUpdateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantServiceUsageConfigSmsUpdate merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantServiceUsageConfigSmsUpdate merchantShortId opCity apiTokenInfo req

postMerchantServiceConfigVerificationUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Dashboard.Common.Merchant.VerificationServiceConfigUpdateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantServiceConfigVerificationUpdate merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantServiceConfigVerificationUpdate merchantShortId opCity apiTokenInfo req

postMerchantConfigFarePolicyDriverExtraFeeBoundsCreate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Types.Id.Id Dashboard.Common.FarePolicy -> Kernel.Prelude.Maybe (Kernel.Types.Common.HighPrecDistance) -> Kernel.Prelude.Maybe (Kernel.Types.Common.DistanceUnit) -> Kernel.Types.Common.Meters -> API.Types.ProviderPlatform.Management.Merchant.CreateFPDriverExtraFeeReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantConfigFarePolicyDriverExtraFeeBoundsCreate merchantShortId opCity apiTokenInfo farePolicyId startDistanceValue distanceUnit startDistance req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigFarePolicyDriverExtraFeeBoundsCreate merchantShortId opCity apiTokenInfo farePolicyId startDistanceValue distanceUnit startDistance req

postMerchantConfigFarePolicyDriverExtraFeeBoundsUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Types.Id.Id Dashboard.Common.FarePolicy -> Kernel.Prelude.Maybe (Kernel.Types.Common.HighPrecDistance) -> Kernel.Prelude.Maybe (Kernel.Types.Common.DistanceUnit) -> Kernel.Types.Common.Meters -> API.Types.ProviderPlatform.Management.Merchant.CreateFPDriverExtraFeeReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantConfigFarePolicyDriverExtraFeeBoundsUpdate merchantShortId opCity apiTokenInfo farePolicyId startDistanceValue distanceUnit startDistance req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigFarePolicyDriverExtraFeeBoundsUpdate merchantShortId opCity apiTokenInfo farePolicyId startDistanceValue distanceUnit startDistance req

postMerchantConfigFarePolicyPerExtraKmRateUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Types.Id.Id Dashboard.Common.FarePolicy -> Kernel.Types.Common.Meters -> API.Types.ProviderPlatform.Management.Merchant.UpdateFPPerExtraKmRateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantConfigFarePolicyPerExtraKmRateUpdate merchantShortId opCity apiTokenInfo farePolicyId startDistance req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigFarePolicyPerExtraKmRateUpdate merchantShortId opCity apiTokenInfo farePolicyId startDistance req

postMerchantConfigFarePolicyUpdate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Types.Id.Id Dashboard.Common.FarePolicy -> API.Types.ProviderPlatform.Management.Merchant.UpdateFarePolicyReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantConfigFarePolicyUpdate merchantShortId opCity apiTokenInfo farePolicyId req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigFarePolicyUpdate merchantShortId opCity apiTokenInfo farePolicyId req

postMerchantConfigFarePolicyUpsert :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> API.Types.ProviderPlatform.Management.Merchant.UpsertFarePolicyReq -> Environment.FlowHandler API.Types.ProviderPlatform.Management.Merchant.UpsertFarePolicyResp)
postMerchantConfigFarePolicyUpsert merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigFarePolicyUpsert merchantShortId opCity apiTokenInfo req

postMerchantConfigOperatingCityCreate :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Dashboard.Common.Merchant.CreateMerchantOperatingCityReq -> Environment.FlowHandler Dashboard.Common.Merchant.CreateMerchantOperatingCityRes)
postMerchantConfigOperatingCityCreate merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantConfigOperatingCityCreate merchantShortId opCity apiTokenInfo req

postMerchantSchedulerTrigger :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> API.Types.ProviderPlatform.Management.Merchant.SchedulerTriggerReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantSchedulerTrigger merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantSchedulerTrigger merchantShortId opCity apiTokenInfo req

postMerchantUpdateOnboardingVehicleVariantMapping :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> API.Types.ProviderPlatform.Management.Merchant.UpdateOnboardingVehicleVariantMappingReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantUpdateOnboardingVehicleVariantMapping merchantShortId opCity apiTokenInfo req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantUpdateOnboardingVehicleVariantMapping merchantShortId opCity apiTokenInfo req

postMerchantSpecialLocationUpsert :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Prelude.Maybe ((Kernel.Types.Id.Id Lib.Types.SpecialLocation.SpecialLocation)) -> Dashboard.Common.Merchant.UpsertSpecialLocationReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantSpecialLocationUpsert merchantShortId opCity apiTokenInfo specialLocationId req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantSpecialLocationUpsert merchantShortId opCity apiTokenInfo specialLocationId req

deleteMerchantSpecialLocationDelete :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Types.Id.Id Lib.Types.SpecialLocation.SpecialLocation -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
deleteMerchantSpecialLocationDelete merchantShortId opCity apiTokenInfo specialLocationId = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.deleteMerchantSpecialLocationDelete merchantShortId opCity apiTokenInfo specialLocationId

postMerchantSpecialLocationGatesUpsert :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Types.Id.Id Lib.Types.SpecialLocation.SpecialLocation -> Dashboard.Common.Merchant.UpsertSpecialLocationGateReq -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
postMerchantSpecialLocationGatesUpsert merchantShortId opCity apiTokenInfo specialLocationId req = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.postMerchantSpecialLocationGatesUpsert merchantShortId opCity apiTokenInfo specialLocationId req

deleteMerchantSpecialLocationGatesDelete :: (Kernel.Types.Id.ShortId Domain.Types.Merchant.Merchant -> Kernel.Types.Beckn.Context.City -> ApiTokenInfo -> Kernel.Types.Id.Id Lib.Types.SpecialLocation.SpecialLocation -> Kernel.Prelude.Text -> Environment.FlowHandler Kernel.Types.APISuccess.APISuccess)
deleteMerchantSpecialLocationGatesDelete merchantShortId opCity apiTokenInfo specialLocationId gateName = withFlowHandlerAPI' $ Domain.Action.ProviderPlatform.Management.Merchant.deleteMerchantSpecialLocationGatesDelete merchantShortId opCity apiTokenInfo specialLocationId gateName
