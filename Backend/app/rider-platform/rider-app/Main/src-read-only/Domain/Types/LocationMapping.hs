{-# LANGUAGE ApplicativeDo #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

module Domain.Types.LocationMapping where

import Data.Aeson (eitherDecode)
import qualified Domain.Types.Location
import qualified Domain.Types.Merchant
import qualified Domain.Types.MerchantOperatingCity
import Kernel.Prelude
import qualified Kernel.Types.Id
import qualified Tools.Beam.UtilsTH

data LocationMapping = LocationMapping
  { createdAt :: Kernel.Prelude.UTCTime,
    entityId :: Kernel.Prelude.Text,
    id :: Kernel.Types.Id.Id Domain.Types.LocationMapping.LocationMapping,
    locationId :: Kernel.Types.Id.Id Domain.Types.Location.Location,
    merchantId :: Kernel.Prelude.Maybe (Kernel.Types.Id.Id Domain.Types.Merchant.Merchant),
    merchantOperatingCityId :: Kernel.Prelude.Maybe (Kernel.Types.Id.Id Domain.Types.MerchantOperatingCity.MerchantOperatingCity),
    order :: Kernel.Prelude.Int,
    tag :: Domain.Types.LocationMapping.LocationMappingTags,
    updatedAt :: Kernel.Prelude.UTCTime,
    version :: Kernel.Prelude.Text
  }
  deriving (Generic, Show, ToJSON, FromJSON, ToSchema)

data LocationMappingTags = BOOKING | SEARCH_REQUEST | RIDE deriving (Eq, Ord, Show, Read, Generic, ToJSON, FromJSON, ToSchema)

$(Tools.Beam.UtilsTH.mkBeamInstancesForEnumAndList ''LocationMappingTags)
