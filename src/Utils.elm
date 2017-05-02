module Utils exposing (..)

import Date
import Date.Extra.Core
import Date.Extra.Config.Config_en_us
import Date.Extra.Format


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


stringDateToYear : String -> String
stringDateToYear dateString =
    stringTimestampToDate dateString
        |> Date.year
        |> toString


stringDateToMonth : String -> String
stringDateToMonth dateString =
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
            stringDateToYear dateString

        month =
            stringDateToMonth dateString
    in
        ( year, month )
