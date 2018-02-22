module Metrix.RadioButton.Render exposing (..)
{-| -}
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Metrix.RadioButton.Message as Message
import Metrix.RadioButton.Model as Model

checkedColor = "#4a90e2"
uncheckedColor = "#979797"

bullet : Bool -> Html a
bullet checked =
    let
        color = if checked then checkedColor else uncheckedColor
    in
        div [style [
            ("width", "13px"),
            ("height", "13px"),
            ("float", "left"),
            ("display", "flex"),
            ("align-items", "center"),
            ("justify-content", "center"),
            ("border-radius", "7.5px"),
            ("margin-right", "9px"),
            ("border", "solid 1px " ++ color)
        ]] <| if checked then [bulletInnerDot color] else []

bulletInnerDot : String -> Html a
bulletInnerDot color =
    div [style [
            ("width", "7px"),
            ("height", "7px"),
            ("border-radius", "3.5px"),
            ("background-color", color)
    ]] []

radioButton : Model.Model -> Int -> String -> Html Message.Message
radioButton model index labelText =
    let
        checked = Just index == model.selectedIndex
        hover = Just index == model.hoveredIndex
    in
        li [
            Events.onClick (Message.ButtonSelected index),
            Events.onMouseEnter (Message.ButtonEnter index),
            Events.onMouseLeave (Message.ButtonLeave),
            style ((textStyle hover) ++ [("margin-right", "50px"), ("float", "left")])
        ] [bullet checked, text labelText]

radioGroup : Model.Model -> Html Message.Message
radioGroup model =
    model.labels |>
    List.indexedMap (radioButton model) |>
    ul [style [("list-style-type", "none")]]

textStyle : Bool -> List (String, String)
textStyle hover =
  [
      ("font-family", "DINPro"),
      ("font-size", "14px"),
      ("font-weight", "400"),
      ("line-height", "13px"),
      ("letter-spacing", "1.1px"),
      ("text-align", "left"),
      ("user-select", "none"),
      ("cursor", "pointer")
  ] ++
  if hover
    then
      [
          ("color", "#4a90e2")
      ]
    else
      [
          ("color", "#979797")
      ]
