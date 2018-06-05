module Metrix.RadioButton.Render exposing (..)

{-| -}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Metrix.RadioButton.Message as Message
import Metrix.RadioButton.Model as Model


themeColor =
    "#4a90e2"


defaultColor =
    "#979797"


bullet : Bool -> Bool -> Html a
bullet checked hover =
    let
        color =
            if checked || hover then
                themeColor
            else
                defaultColor
    in
    div
        [ style
            [ ( "width", "13px" )
            , ( "height", "13px" )
            , ( "float", "left" )
            , ( "display", "flex" )
            , ( "align-items", "center" )
            , ( "justify-content", "center" )
            , ( "border-radius", "7.5px" )
            , ( "margin-right", "9px" )
            , ( "border", "solid 1px " ++ color )
            ]
        ]
    <|
        if checked then
            [ bulletInnerDot color ]
        else
            []


bulletInnerDot : String -> Html a
bulletInnerDot color =
    div
        [ style
            [ ( "width", "7px" )
            , ( "height", "7px" )
            , ( "border-radius", "3.5px" )
            , ( "background-color", color )
            ]
        ]
        []


radioButton : Model.Model -> Int -> String -> Html Message.Message
radioButton model index labelText =
    let
        checked =
            Just index == model.selectedIndex

        hover =
            Just index == model.hoveredIndex
    in
    li
        [ Events.onClick (Message.ButtonSelected index)
        , Events.onMouseEnter (Message.ButtonEnter index)
        , Events.onMouseLeave Message.ButtonLeave
        , style
            (textStyle hover checked model.blueWhenChecked
                ++ [ ( "padding-top", "18px" )
                   ]
            )
        ]
        [ bullet checked hover, text labelText ]


radioGroup : Model.Model -> Bool -> Html Message.Message
radioGroup model isInline =
    let
        additionalStyles =
            if isInline then
                [ ( "display", "flex" )
                , ( "justify-content", "space-between" )
                ]
            else
                []
    in
    model.labels
        |> List.indexedMap (radioButton model)
        |> ul
            [ style <|
                [ ( "list-style-type", "none" )
                , ( "margin", "0" )
                , ( "padding", "0" )
                , ( "width", "inherit" )
                ]
                    ++ additionalStyles
            ]


radioGroupTwoRows : Model.Model -> Bool -> Html Message.Message
radioGroupTwoRows model isInline =
    let
        isEven n =
            n % 2 == 0

        len =
            List.length model.labels // 2

        labels =
            model.labels
                |> List.indexedMap (radioButton model)

        topLabels =
            List.take len labels

        bottomLabels =
            List.drop len labels
    in
    ul
        [ style <|
            [ ( "list-style-type", "none" )
            , ( "margin", "0" )
            , ( "padding", "0" )
            , ( "width", "inherit" )
            , ( "display", "flex" )
            ]
        ]
        ([ div [ style [ ( "padding-right", "120px" ) ] ] topLabels ] ++ [ div [] [] ] ++ [ div [] bottomLabels ])


textStyle : Bool -> Bool -> Bool -> List ( String, String )
textStyle hover checked blueWhenChecked =
    let
        hoverColor =
            if hover then
                [ ( "color", "#4a90e2" ) ]
            else
                [ ( "color", "#979797" ) ]

        checkedColor =
            if blueWhenChecked then
                themeColor
            else
                defaultColor

        checkedWeight =
            if checked then
                [ ( "font-weight", "700" ), ( "color", checkedColor ) ]
            else
                [ ( "font-weight", "400" ) ]
    in
    [ ( "font-family", "DINPro" )
    , ( "font-size", "14px" )
    , ( "line-height", "13px" )
    , ( "letter-spacing", "1.1px" )
    , ( "text-align", "left" )
    , ( "user-select", "none" )
    , ( "cursor", "pointer" )
    ]
        ++ hoverColor
        ++ checkedWeight
