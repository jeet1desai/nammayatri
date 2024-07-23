{-# LANGUAGE ApplicativeDo #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

module Domain.Types.WhiteListOrg where

import Data.Aeson
import Domain.Types.Common (UsageSafety (..))
import qualified Domain.Types.Merchant
import qualified Domain.Types.MerchantOperatingCity
import Kernel.Prelude
import qualified Kernel.Types.Beckn.Domain
import qualified Kernel.Types.Id
import qualified Kernel.Types.Registry
import qualified Tools.Beam.UtilsTH

data WhiteListOrgD (s :: UsageSafety) = WhiteListOrg
  { createdAt :: Kernel.Prelude.UTCTime,
    domain :: Kernel.Types.Beckn.Domain.Domain,
    id :: Kernel.Types.Id.Id Domain.Types.WhiteListOrg.WhiteListOrg,
    merchantId :: Kernel.Types.Id.Id Domain.Types.Merchant.Merchant,
    merchantOperatingCityId :: Kernel.Prelude.Maybe (Kernel.Types.Id.Id Domain.Types.MerchantOperatingCity.MerchantOperatingCity),
    subscriberId :: Kernel.Types.Id.ShortId Kernel.Types.Registry.Subscriber,
    updatedAt :: Kernel.Prelude.UTCTime,
    vehicleVariant :: Kernel.Prelude.Maybe Kernel.Prelude.Text
  }
  deriving (Generic, Show)

type WhiteListOrg = WhiteListOrgD 'Safe

instance FromJSON (WhiteListOrgD 'Unsafe)

instance ToJSON (WhiteListOrgD 'Unsafe)

instance FromJSON (WhiteListOrgD 'Safe)

instance ToJSON (WhiteListOrgD 'Safe)
