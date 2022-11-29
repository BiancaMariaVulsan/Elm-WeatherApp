module Util exposing (groupBy, maximumBy, maybeToList, minimumBy, zipFilter)

{-| Module containing utility functions
-}
import List exposing (minimum)
import Html exposing (a)



{-| Description for minimumBy

    minimumBy .x [ { x = 1, y = 2 } ] --> Just {x = 1, y = 2}

    minimumBy .x [] --> Nothing

    minimumBy (modBy 10) [ 16, 23, 14, 5 ] --> Just 23

-}
minimumBy : (a -> comparable) -> List a -> Maybe a
minimumBy f lst =
    lst |> List.map (\x -> (x, f x)) |> List.sortBy (\x -> Tuple.second x) |> List.head |> Maybe.map Tuple.first


{-| Description for maximumBy

    maximumBy .x [ { x = 1, y = 2 } ] --> Just {x = 1, y = 2}

    maximumBy .x [] --> Nothing

    maximumBy (modBy 10) [ 16, 23, 14, 5 ] --> Just 16

-}
maximumBy : (a -> comparable) -> List a -> Maybe a
maximumBy f lst =
    lst |> List.map (\x -> (x, f x)) |> List.sortBy (\x -> Tuple.second x) |> List.reverse |> List.head |> Maybe.map Tuple.first


{-| Group a list

    groupBy .x [ { x = 1 } ] --> [(1, [{x = 1}])]

    groupBy (modBy 10) [ 11, 12, 21, 22 ] --> [(1, [11, 21]), (2, [12, 22])]

    groupBy identity [] --> []

-}
groupBy : (a -> b) -> List a -> List ( b, List a )
groupBy f lst =
    let
        idList = lst |> List.foldl (\x res -> if (List.member (f x) res) == True then res else res ++ [(f x)]) []
    in
        idList |> List.map (\x -> (x, (List.filter (\y -> f y == x) lst)))



{-| Transforms a Maybe into a List with one element for Just, and an empty list for Nothing

    maybeToList (Just 1) --> [1]

    maybeToList Nothing --> []

-}
maybeToList : Maybe a -> List a
maybeToList elem =
    case elem of 
        Just a -> 
            [a]
        Nothing -> 
            []


{-| Filters a list based on a list of bools

    zipFilter [ True, True ] [ 1, 2 ] --> [1, 2]

    zipFilter [ False, False ] [ 1, 2 ] --> []

    zipFilter [ True, False, True, False ] [ 1, 2, 3, 4 ] --> [1, 3]

-}
zipFilter : List Bool -> List a -> List a
zipFilter lb lst =
    lst |> List.map2 Tuple.pair lb |> List.filter (\x -> (Tuple.first x) == True) |> List.map (\x -> Tuple.second x)
