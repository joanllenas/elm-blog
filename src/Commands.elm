module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Msgs exposing (Msg)
import Models exposing (PostId, Post)
import RemoteData


fetchPosts : Cmd Msg
fetchPosts =
    Http.get fetchPostsUrl postsDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPosts


prependBaseUrl : String -> String
prependBaseUrl url =
    "http://localhost:3000/" ++ url


fetchPostsUrl : String
fetchPostsUrl =
    prependBaseUrl "data/latest.json"


postsDecoder : Decode.Decoder (List Post)
postsDecoder =
    Decode.list postDecoder


postDecoder : Decode.Decoder Post
postDecoder =
    decode Post
        |> required "id" Decode.string
        |> required "title" Decode.string
        |> required "content" Decode.string
