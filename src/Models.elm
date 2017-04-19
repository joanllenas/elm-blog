module Models exposing (..)

import RemoteData exposing (WebData)
import Date


type alias PostId =
    String


type alias Post =
    { id : PostId
    , created_at : Date.Date
    , title : String
    , content : String
    }


type alias Model =
    { latest : WebData (List Post)
    , archive : WebData (List Post)
    , post : WebData Post
    , route : Route
    }


type Route
    = LatestPostRoute
    | PostArchiveRoute
    | PostDetailRoute PostId
    | NotFoundRoute


initialModel : Route -> Model
initialModel route =
    { latest = RemoteData.NotAsked
    , archive = RemoteData.NotAsked
    , post = RemoteData.NotAsked
    , route = route
    }
