module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PostId, Route(..))
import UrlParser exposing (..)
import Commands exposing (..)
import Msgs exposing (Msg)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map LatestPostRoute top
        , map PostDetailRoute (s "post" </> string)
        , map LatestPostRoute (s "all")
        , map PostArchiveRoute (s "archive")
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
        LatestPostRoute ->
            Commands.fetchLatestsPosts

        PostDetailRoute postId ->
            Commands.fetchPost postId
        
        PostArchiveRoute ->
            Commands.fetchPostArchive

        NotFoundRoute ->
            Cmd.none
