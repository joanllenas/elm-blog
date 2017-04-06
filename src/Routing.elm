module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PostId, Route(..))
import UrlParser exposing (..)


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
