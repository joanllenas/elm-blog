module Msgs exposing (..)

import Navigation exposing (Location)
import Models exposing (Post)
import RemoteData exposing (WebData)


type Msg
    = NoOp
    | OnLocationChange Location
    | OnFetchPosts (WebData (List Post))
    | OnFetchPost (WebData Post)
