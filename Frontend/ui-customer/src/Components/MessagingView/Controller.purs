{-
 
  Copyright 2022-23, Juspay India Pvt Ltd
 
  This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License
 
  as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program
 
  is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 
  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details. You should have received a copy of
 
  the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
-}

module Components.MessagingView.Controller where

import MerchantConfig.Types
import MerchantConfig.DefaultConfig as DC
import PrestoDOM (BottomSheetState(..))
import Common.Resources.Constants (chatSuggestion)

data Action = SendMessage
            | SendSuggestion String
            | BackPressed
            | TextChanged String
            | Call
            | NoAction

type Config = 
  { userConfig :: UserConfig
  , messages :: Array ChatComponent
  , messagesSize :: String
  , vehicleNo :: String
  , chatSuggestionsList :: Array String
  , hint :: String
  , languageKey :: String
  , rideConfirmedAt :: String
  , autoGeneratedText :: String
  , driverRating :: String
  , fareAmount :: String
  , config :: AppConfig
  , peekHeight :: Int
  , otp :: String
  , feature :: Feature
  , suggestionKey :: String
  , isKeyBoardOpen :: Boolean
  }

type Feature = 
  { sendMessageActive :: Boolean
  , canSendSuggestion :: Boolean
  , enableSuggestions :: Boolean
  , showAutoGeneratedText :: Boolean
  , showVehicleDetails :: Boolean
  }

type UserConfig =
  { userName :: String
  , receiver :: String
  }

type ChatComponent = {
    message :: String 
  , sentBy :: String 
  , timeStamp :: String
  , type :: String
  , delay :: Int
}

config :: Config
config = 
  { userConfig : 
    { userName : ""
    , receiver : ""
    }
  , feature : 
    { sendMessageActive : false
    , canSendSuggestion : true
    , showAutoGeneratedText : false
    , enableSuggestions : false
    , showVehicleDetails : true
    }
  , messages : []
  , messagesSize : ""
  , vehicleNo : ""
  , chatSuggestionsList : []
  , hint : ""
  , languageKey : ""
  , rideConfirmedAt : ""
  , autoGeneratedText : ""
  , driverRating : ""
  , fareAmount : ""
  , config : DC.config
  , peekHeight : 0
  , otp : ""
  , suggestionKey : chatSuggestion
  , isKeyBoardOpen : false
  }



dummyChatComponent :: ChatComponent
dummyChatComponent = { message : "", sentBy : "", timeStamp : "", type : "", delay : 0 }