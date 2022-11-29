module View.WeatherItems exposing (view)

import Html exposing (..)
import Html.Attributes as HA exposing (class, style, type_)
import Html.Events exposing (..)
import Model.WeatherItems exposing (SelectedWeatherItems, WeatherItem(..))
import View.WeatherChart exposing (ShownItems)


checkbox : String -> Bool -> (WeatherItem -> Bool -> msg) -> WeatherItem -> Html msg
checkbox name state msg category =
    div [ style "display" "inline", class "checkbox" ]
        [ input [ HA.type_ "checkbox", onCheck (msg category), HA.checked state ] []
        , text name
        ]


type alias MsgMap msg =
    { onChangeSelection : WeatherItem -> Bool -> msg }


view : MsgMap msg -> SelectedWeatherItems -> Html msg
view message selectedItems =
    div [] [checkbox "Temperature" selectedItems.temperature message.onChangeSelection Temperature
        , checkbox "Precipitation" selectedItems.precipitation message.onChangeSelection Precipitation
        , checkbox "High and Low points" selectedItems.minMax message.onChangeSelection MinMax
        , checkbox "Current time" selectedItems.currentTime message.onChangeSelection CurrentTime
    ]
