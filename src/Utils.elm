module Utils exposing (..)

import Date
import Date.Extra.Core
import Date.Extra.Config.Config_en_us
import Date.Extra.Format
import Dict exposing (Dict, empty, update)


stringTimestampToDate : String -> Date.Date
stringTimestampToDate timestampStr =
    timestampStr
        |> String.toInt
        |> Result.withDefault 0
        |> Date.Extra.Core.fromTime


humanizeDate : Maybe Date.Date -> String
humanizeDate date =
    date
        |> Maybe.map (Date.Extra.Format.format Date.Extra.Config.Config_en_us.config "%b %-d %Y")
        |> Maybe.withDefault ""


stringDateToYearString : String -> String
stringDateToYearString dateString =
    stringTimestampToDate dateString
        |> Date.year
        |> toString


stringDateToMonthString : String -> String
stringDateToMonthString dateString =
    stringTimestampToDate dateString
        |> Date.month
        |> toString
        |> String.toLower


postIdToYearMonth : String -> ( String, String )
postIdToYearMonth postId =
    let
        dateString =
            List.head (String.split "-" postId)
                |> Maybe.withDefault "0"

        year =
            stringDateToYearString dateString

        month =
            stringDateToMonthString dateString
    in
        ( year, month )

postIdToYearMonth2 : String -> ( String, Date.Month )
postIdToYearMonth2 postId =
    let
        dateString =
            List.head (String.split "-" postId)
                |> Maybe.withDefault "0"

        year =
            stringDateToYearString dateString

        month =
            stringTimestampToDate dateString
                |> Date.month
    in
        ( year, month )


{- List Utils -}
{-
   list = [1.3, 2.1, 2.4]
   main = text <| toString <| groupBy floor list
   @result Dict.fromList [(1,[1.3]),(2,[2.1,2.4])]
-}


groupBy : (a -> comparable) -> List a -> Dict comparable (List a)
groupBy fun =
    let
        add2Maybe x m =
            case m of
                Nothing ->
                    Just [ x ]

                Just xs ->
                    Just (xs ++ [ x ])

        -- add2Maybe x = -- alternative implementation
        --   Just << (flip (++)) [x] << Maybe.withDefault []
        foldF e =
            update (fun e) (add2Maybe e)
    in
        List.foldl foldF empty
