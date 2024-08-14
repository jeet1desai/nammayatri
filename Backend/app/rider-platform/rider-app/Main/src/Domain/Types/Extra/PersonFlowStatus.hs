{-# LANGUAGE ApplicativeDo #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-dodgy-exports #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}
{-# OPTIONS_GHC -Wwarn=incomplete-record-updates #-}

module Domain.Types.Extra.PersonFlowStatus where

import Data.Aeson
import Data.OpenApi
import qualified Domain.Types.Booking as DB
import Domain.Types.Common
import qualified Domain.Types.Estimate as DE
import qualified Domain.Types.FarePolicy.FareProductType as DFPT
import qualified Domain.Types.Person as DP
import qualified Domain.Types.Ride as DRide
import qualified Domain.Types.SearchRequest as DSR
import qualified Kernel.External.Maps as Maps
import Kernel.Prelude
import Kernel.Types.Id
import Tools.Beam.UtilsTH (mkBeamInstancesForJSON)

-- Extra code goes here --
data FlowStatus
  = IDLE
  | WAITING_FOR_DRIVER_OFFERS
      { estimateId :: Id DE.Estimate,
        otherSelectedEstimates :: Maybe [Id DE.Estimate],
        validTill :: UTCTime,
        providerId :: Maybe Text
      }
  | WAITING_FOR_DRIVER_ASSIGNMENT
      { bookingId :: Id DB.Booking,
        validTill :: UTCTime,
        fareProductType :: Maybe DFPT.FareProductType, -- TODO :: For backward compatibility, please do not maintain this in future. `fareProductType` is replaced with `tripCategory`.
        tripCategory :: Maybe TripCategory
      }
  deriving (Show, Eq, Ord, Generic)

$(mkBeamInstancesForJSON ''FlowStatus)

flowStatusCustomJSONOptions :: Options
flowStatusCustomJSONOptions =
  defaultOptions
    { sumEncoding =
        TaggedObject
          { tagFieldName = "status",
            contentsFieldName = "info"
          }
    }

instance ToJSON FlowStatus where
  toJSON = genericToJSON flowStatusCustomJSONOptions

instance FromJSON FlowStatus where
  parseJSON = genericParseJSON flowStatusCustomJSONOptions

instance ToSchema FlowStatus where
  declareNamedSchema = genericDeclareNamedSchema $ fromAesonOptions flowStatusCustomJSONOptions
