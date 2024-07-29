{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

module API.Types.UI.FollowRide where

import Data.OpenApi (ToSchema)
import qualified Data.Text
import qualified Domain.Types.Booking
import EulerHS.Prelude hiding (id)
import qualified Kernel.Prelude
import qualified Kernel.Types.Id
import Servant
import Tools.Auth

data Followers = Followers {bookingId :: Kernel.Types.Id.Id Domain.Types.Booking.Booking, mobileNumber :: Data.Text.Text, name :: Kernel.Prelude.Maybe Data.Text.Text, priority :: Kernel.Prelude.Int}
  deriving stock (Generic)
  deriving anyclass (ToJSON, FromJSON, ToSchema)

data ShareRideReq = ShareRideReq {emergencyContactNumbers :: [Data.Text.Text]}
  deriving stock (Generic)
  deriving anyclass (ToJSON, FromJSON, ToSchema)
