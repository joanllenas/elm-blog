module Commands exposing (fetchLatestsPosts, fetchPost)

import Http
import Time
import Task
import RemoteData
import Msgs exposing (Msg)
import Models exposing (PostId)
import Utils
import Decoders exposing (postListDecoder, postDecoder)


fetchLatestsPosts : Cmd Msg
fetchLatestsPosts =
    Http.get fetchLatestsPostsUrl postListDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPosts


fetchPost : PostId -> Cmd Msg
fetchPost postId =
    Http.get (fetchPostUrl postId) postDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPost


fetchLatestsPostsUrl : String
fetchLatestsPostsUrl =
    {- Time.now `andThen` (\time -> "data/latest.json?" ++ time) -}
    "data/latest.json?"


fetchPostUrl : PostId -> String
fetchPostUrl postId =
    let
        dateString =
            List.head (String.split "-" postId)
                |> Maybe.withDefault "0"

        year =
            Utils.stringDateToYear dateString

        month =
            Utils.stringDateToMonth dateString
    in
        "data/" ++ year ++ "/" ++ month ++ "/" ++ postId ++ ".json"
