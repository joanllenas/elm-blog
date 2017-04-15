module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (parseLocation)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location

                routeCmd =
                    Routing.getRouteInitCmd newRoute
            in
                ( { model | route = newRoute }, routeCmd )

        Msgs.OnFetchPosts response ->
            ( { model | posts = response }, Cmd.none )

        Msgs.OnFetchPost response ->
            ( { model | post = response }, Cmd.none )

        Msgs.NoOp ->
            ( model, Cmd.none )
