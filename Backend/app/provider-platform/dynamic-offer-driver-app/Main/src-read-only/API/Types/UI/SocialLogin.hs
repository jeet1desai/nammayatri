{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

module API.Types.UI.SocialLogin where

import Data.OpenApi (ToSchema)
import qualified Domain.Types.Merchant
import EulerHS.Prelude hiding (id)
import qualified Kernel.Prelude
import qualified Kernel.Types.Beckn.Context
import qualified Kernel.Types.Id
import Servant
import Tools.Auth

data OAuthProvider
  = Google
  | IOS
  deriving stock (Eq, Show, Generic)
  deriving anyclass (ToJSON, FromJSON, ToSchema)

data SocialLoginReq = SocialLoginReq
  { email :: Kernel.Prelude.Maybe Kernel.Prelude.Text,
    merchantId :: Kernel.Types.Id.Id Domain.Types.Merchant.Merchant,
    merchantOperatingCity :: Kernel.Types.Beckn.Context.City,
    name :: Kernel.Prelude.Maybe Kernel.Prelude.Text,
    oauthProvider :: API.Types.UI.SocialLogin.OAuthProvider,
    registrationLat :: Kernel.Prelude.Maybe Kernel.Prelude.Double,
    registrationLon :: Kernel.Prelude.Maybe Kernel.Prelude.Double,
    tokenId :: Kernel.Prelude.Text
  }
  deriving stock (Generic)
  deriving anyclass (ToJSON, FromJSON, ToSchema)

data SocialLoginRes = SocialLoginRes {isNew :: Kernel.Prelude.Bool, token :: Kernel.Prelude.Text}
  deriving stock (Generic)
  deriving anyclass (ToJSON, FromJSON, ToSchema)

data SocialUpdateProfileReq = SocialUpdateProfileReq
  { email :: Kernel.Prelude.Text,
    firstName :: Kernel.Prelude.Maybe Kernel.Prelude.Text,
    lastName :: Kernel.Prelude.Maybe Kernel.Prelude.Text,
    mobileCountryCode :: Kernel.Prelude.Maybe Kernel.Prelude.Text,
    mobileNumber :: Kernel.Prelude.Maybe Kernel.Prelude.Text
  }
  deriving stock (Generic)
  deriving anyclass (ToJSON, FromJSON, ToSchema)
