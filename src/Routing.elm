module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PostId, Route(..))
import UrlParser exposing (..)
import Commands exposing (..)
import Msgs exposing (Msg)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PostListRoute top
        , map PostDetailRoute (s "post" </> string)
        , map PostListRoute (s "all")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


getRouteInitCmd : Route -> Cmd Msg
getRouteInitCmd route =
    case route of
        PostListRoute ->
            Commands.fetchLatestsPosts

        PostDetailRoute postId ->
            Commands.fetchLatestsPosts

        NotFoundRoute ->
            Cmd.none
