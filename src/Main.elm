module Main exposing (..)

import Html
import Metrix.RadioButton.Message as Message
import Metrix.RadioButton.Model as Model
import Metrix.RadioButton.Update as Update
import Metrix.RadioButton.Render as Render

main : Program Never Model.Model Message.Message
main =
    Html.program
        { init = (Model.init, Cmd.none)
        , view = Render.radioGroup
        , update = Update.update
        , subscriptions = always Sub.none
        }