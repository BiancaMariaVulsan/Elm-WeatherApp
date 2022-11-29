module View.Day exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (..)
import Util.Time exposing (Date)


{-| Don't modify
-}
type alias DailyData =
    { date : Date
    , highTemp : Maybe Float
    , lowTemp : Maybe Float
    , totalPrecipitaion : Float
    }


{-| Generates Html based on `DailyData`

Some relevant functions:

  - `Util.Time.formatDate`

-}
view : DailyData -> Html msg
view dailyData =
    div [class "day"] [
      p [class "day-date"] [text <| "Date: " ++ Util.Time.formatDate dailyData.date]
    , p [class "day-hightemp"] [text <| "Highest Temperature: " ++ (Maybe.map String.fromFloat dailyData.highTemp |> Maybe.withDefault "unavailable")]
    , p [class "day-lowtemp"] [text <| "Lowest Temperature: " ++ (Maybe.map String.fromFloat dailyData.lowTemp |> Maybe.withDefault "unavailable")]
    , p [class "day-precipitation"] [text <| "Total Precipitation: " ++ String.fromFloat dailyData.totalPrecipitaion]
    ]
