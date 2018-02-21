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
    in
        li [
            Events.onClick (Message.ButtonSelected index),
            style (textStyle ++ [("margin-right", "50px"), ("float", "left")])
        ] [bullet checked, text labelText]

radioGroup : Model.Model -> Html Message.Message
radioGroup model =
    model.labels |>
    List.indexedMap (radioButton model) |>
    ul [style [("list-style-type", "none")]] 

textStyle : List (String, String)
textStyle = [
        ("font-family", "DINPro"),
        ("font-size", "14px"),
        ("font-weight", "300"),
        ("line-height", "13px"),
        ("letter-spacing", "1.1px"),
        ("text-align", "left"),
        ("color", "#979797"),
        ("user-select", "none")
    ]