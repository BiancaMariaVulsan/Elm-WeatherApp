module Util exposing (groupBy, maximumBy, maybeToList, minimumBy, zipFilter)

{-| Module containing utility functions
-}
import List exposing (minimum)
import Html exposing (a)
import Set


{-| Description for minimumBy

    minimumBy .x [ { x = 1, y = 2 } ] --> Just {x = 1, y = 2}

    minimumBy .x [] --> Nothing

    minimumBy (modBy 10) [ 16, 23, 14, 5 ] --> Just 23

-}
minimumBy : (a -> comparable) -> List a -> Maybe a
minimumBy f lst =
    case lst of
        [] -> Nothing
        x::xs -> 
            case (minimumBy f xs) of
                Nothing -> Just x
                Just y ->
                    case (f x) < (f y) of
                        True -> Just x
                        False -> Just y


{-| Description for maximumBy

    maximumBy .x [ { x = 1, y = 2 } ] --> Just {x = 1, y = 2}

    maximumBy .x [] --> Nothing

    maximumBy (modBy 10) [ 16, 23, 14, 5 ] --> Just 16

-}
maximumBy : (a -> comparable) -> List a -> Maybe a
maximumBy f lst =
    case lst of
        [] -> Nothing
        x::xs -> 
            case (maximumBy f xs) of
                Nothing -> Just x
                Just y ->
                    case (f x) > (f y) of
                        True -> Just x
                        False -> Just y


{-| Group a list

    groupBy .x [ { x = 1 } ] --> [(1, [{x = 1}])]

    groupBy (modBy 10) [ 11, 12, 21, 22 ] --> [(1, [11, 21]), (2, [12, 22])]

    groupBy identity [] --> []

-}
groupBy : (a -> b) -> List a -> List ( b, List a )
groupBy f lst =
    let
        idList = lst |> List.foldl (\x res -> if List.member (f x) res == True then res else res ++ [(f x)]) []
    in
        idList |> List.map (\x -> (x, (List.filter (\y -> f y == x) lst)))

    -- let
    --     helper : a -> b -> List (b, List a) -> List (b, List a)
    --     helper elem bucket crtList= 
    --         case crtList of
    --             [] -> [(bucket, [elem])]
    --             (b, group)::groups -> 
    --                 if b == bucket then
    --                     (b, (elem :: group)) :: groups
    --                 else
    --                     helper elem bucket groups ++ [(b, group)]
    -- in
    --     case lst of
    --         [] -> []
    --         x::xs -> helper x (f x) (groupBy f xs)
    

    



{-| Transforms a Maybe into a List with one element for Just, and an empty list for Nothing

    maybeToList (Just 1) --> [1]

    maybeToList Nothing --> []

-}
maybeToList : Maybe a -> List a
maybeToList elem =
    case elem of 
        Just a -> [a]
        Nothing -> []


{-| Filters a list based on a list of bools

    zipFilter [ True, True ] [ 1, 2 ] --> [1, 2]

    zipFilter [ False, False ] [ 1, 2 ] --> []

    zipFilter [ True, False, True, False ] [ 1, 2, 3, 4 ] --> [1, 3]

-}
zipFilter : List Bool -> List a -> List a
zipFilter lb lst =
    case (lb, lst) of 
        (y::ys, x::xs) ->
            if y == True then
                x::(zipFilter ys xs)
            else
                (zipFilter ys xs)
        (_, _) -> []
