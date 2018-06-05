module Metrix.RadioButton.Model exposing (..)


type alias Model =
    { labels : List String
    , selectedIndex : Maybe Int
    , hoveredIndex : Maybe Int
    , blueWhenChecked : Bool
    }


init =
    { labels = [ "first", "second", "third" ]
    , selectedIndex = Nothing
    , hoveredIndex = Nothing
    , blueWhenChecked = False
    }
