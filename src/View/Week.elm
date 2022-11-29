module View.Week exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (..)
import Util.Time exposing (Date, formatDate)
import View.Day exposing (DailyData)
import Time


type alias WeeklyData =
    { dailyData : List DailyData
    }


{-| Generates Html based on `WeeklyData`

Some relevant functions:

  - `Util.Time.formatDate`

-}
view : WeeklyData -> Html msg
view weeklyData =
  case weeklyData.dailyData of
      [] -> div [class "week"] [h2 [] [text "No data"]]
      _ ->
        let
            firstDay = weeklyData.dailyData |> List.head
            lastDay = weeklyData.dailyData |> List.reverse |> List.head

            getDay : Maybe DailyData -> String
            getDay day = 
              case day of
                  Just a -> Util.Time.formatDate (.date a)
                  Nothing -> "No date"

        in
          div [class "week"] [
          h2 [] [text <| "Weather from " ++ 
          getDay firstDay
          ++ " to " ++
          getDay lastDay
          ]
          , ul []  (weeklyData.dailyData |> List.foldr (\x res -> p [style "margin" "0.5px", style "border" "solid 0.5px", style "border-radius" "1%"] [View.Day.view x] :: res) [])
          ]