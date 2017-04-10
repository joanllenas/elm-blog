module Models exposing (..)

import RemoteData exposing (WebData)


type alias PostId =
    String


type alias Post =
    { id : PostId
    , title : String
    , content : String
    }


type alias Model =
    { posts : WebData (List Post)
    , route : Route
    }


type Route
    = PostListRoute
    | PostDetailRoute PostId
    | NotFoundRoute


initialModel : Route -> Model
initialModel route =
    { posts = RemoteData.NotAsked
    , route = route
    }
