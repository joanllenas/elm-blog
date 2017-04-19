module View exposing (..)

import Html exposing (Html, text, div, img, section, h1, nav, a, i, ul, li)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models exposing (Model, Post)
import Post.List
import Post.Detail


notFoundView : Html Msg
notFoundView =
    div [] [ text "Page Not found" ]


createMenu : Html Msg
createMenu =
    nav [ class "navbar has-docked-nav" ]
        [ div [ class "container" ]
            [ ul [ class "navbar-list" ]
                [ li [ class "navbar-item" ]
                    [ a [ class "navbar-link logo", href "#all" ]
                        [ img [] [] ]
                    ]
                , li [ class "navbar-item" ]
                    [ a [ class "navbar-link", href "#archive" ]
                        [ text "Archive" ]
                    ]
                , li [ class "navbar-item" ]
                    [ a [ class "navbar-link", href "#about" ]
                        [ text "About" ]
                    ]
                ]
            ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ createMenu
        , page model
        ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.LatestPostRoute ->
            div []
                [ createMenu
                , Post.List.view model.latest
                ]

        Models.PostDetailRoute postId ->
            div []
                [ createMenu
                , Post.Detail.view model.post
                ]

        Models.PostArchiveRoute ->
            div []
                [ createMenu
                , Post.List.view model.archive
                ]

        Models.NotFoundRoute ->
            div []
                [ createMenu
                , notFoundView
                ]
