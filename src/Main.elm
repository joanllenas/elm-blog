module Main exposing (..)

import Routing
import Navigation exposing (Location)
import Models exposing (Model)
import Msgs exposing (Msg)
import Commands
import Update exposing (update)
import View exposing (view)


init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parseLocation location
    in
        ( Models.initialModel currentRoute, Commands.fetchLatestsPosts )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    Navigation.program Msgs.OnLocationChange
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
