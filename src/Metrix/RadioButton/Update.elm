module Metrix.RadioButton.Update exposing (..)

import Metrix.RadioButton.Message as Message
import Metrix.RadioButton.Model as Model

update : Message.Message -> Model.Model -> (Model.Model, Cmd Message.Message)
update msg model =
    case msg of
        Message.ButtonSelected pos ->
            ({ model | selectedIndex = Just pos }, Cmd.none)
            