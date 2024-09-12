{-# LANGUAGE ApplicativeDo #-}
{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unused-imports #-}

module Lib.Yudhishthira.Types.UserData where

import Data.Aeson
import Kernel.Prelude
import qualified Kernel.Types.Id
import qualified Lib.Yudhishthira.Types
import qualified Lib.Yudhishthira.Types.Common
import qualified Tools.Beam.UtilsTH

data UserData = UserData
  { chakra :: Lib.Yudhishthira.Types.Chakra,
    id :: Kernel.Types.Id.Id Lib.Yudhishthira.Types.UserData.UserData,
    userDataValue :: Data.Aeson.Value,
    userId :: Kernel.Types.Id.Id Lib.Yudhishthira.Types.Common.User,
    createdAt :: Kernel.Prelude.UTCTime,
    updatedAt :: Kernel.Prelude.UTCTime
  }
  deriving (Generic, Show, ToJSON, FromJSON, ToSchema)
