module Decoders
    exposing
        ( postDecoder
        , postListDecoder
        , stringDateDecoder
        )

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline
    exposing
        ( decode
        , required
        , optional
        )
import Models exposing (PostId, Post)
import Date
import Models exposing (Post)


postListDecoder : Decode.Decoder (List Post)
postListDecoder =
    Decode.list postDecoder


postDecoder : Decode.Decoder Post
postDecoder =
    decode Post
        |> required "id" Decode.string
        |> required "created_at" stringDateDecoder
        |> required "title" Decode.string
        |> optional "content" Decode.string ""


stringDateDecoder : Decoder Date.Date
stringDateDecoder =
    Decode.string
        |> Decode.andThen
            (\val ->
                case String.toFloat val of
                    Err err ->
                        Decode.fail err

                    Ok ms ->
                        Decode.succeed <| Date.fromTime ms
            )
