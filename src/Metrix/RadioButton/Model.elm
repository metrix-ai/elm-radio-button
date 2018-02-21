module Metrix.RadioButton.Model exposing (..)


type alias Model = {
        labels: List String,
        selectedIndex: Maybe Int
    }

init = {labels = ["first", "second", "third"], selectedIndex = Nothing}
