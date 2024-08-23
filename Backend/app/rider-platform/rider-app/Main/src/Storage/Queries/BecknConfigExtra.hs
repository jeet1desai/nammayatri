{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

module Storage.Queries.BecknConfigExtra where

import qualified BecknV2.OnDemand.Enums
import qualified Domain.Types.BecknConfig
import qualified Domain.Types.Merchant
import Kernel.Beam.Functions
import Kernel.External.Encryption
import Kernel.Prelude
import Kernel.Types.Error
import qualified Kernel.Types.Id
import Kernel.Utils.Common (CacheFlow, EsqDBFlow, MonadFlow, fromMaybeM, getCurrentTime)
import qualified Sequelize as Se
import qualified Storage.Beam.BecknConfig as Beam
import Storage.Queries.OrphanInstances.BecknConfig

-- Extra code goes here --

findByMerchantIdDomainAndVehicle ::
  (EsqDBFlow m r, MonadFlow m, CacheFlow m r) =>
  (Kernel.Prelude.Maybe (Kernel.Types.Id.Id Domain.Types.Merchant.Merchant) -> Kernel.Prelude.Text -> BecknV2.OnDemand.Enums.VehicleCategory -> m (Maybe Domain.Types.BecknConfig.BecknConfig))
findByMerchantIdDomainAndVehicle merchantId domain vehicleCategory = do listToMaybe <$> findAllWithKV [Se.And [Se.Is Beam.merchantId $ Se.Eq (Kernel.Types.Id.getId <$> merchantId), Se.Is Beam.domain $ Se.Eq domain, Se.Is Beam.vehicleCategory $ Se.Eq vehicleCategory]]
