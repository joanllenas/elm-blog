module Commands exposing (fetchLatestsPosts)

import Http
import RemoteData
import Msgs exposing (Msg)
import Decoders exposing (postListDecoder)


fetchLatestsPosts : Cmd Msg
fetchLatestsPosts =
    Http.get fetchLatestsPostsUrl postListDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchPosts


fetchLatestsPostsUrl : String
fetchLatestsPostsUrl =
    "data/latest.json"
