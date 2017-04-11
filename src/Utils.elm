module Utils exposing (..)

import Date
import Date.Extra.Config.Config_en_us
import Date.Extra.Format


stringToDate : String -> Date.Date
stringToDate dateString =
    Date.fromString dateString |> Result.withDefault (Date.fromTime 0)


humanizeDate : Maybe Date.Date -> String
humanizeDate date =
    date
        |> Maybe.map (Date.Extra.Format.format Date.Extra.Config.Config_en_us.config "%b %-d %Y")
        |> Maybe.withDefault ""
