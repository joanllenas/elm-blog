module Post.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Msgs exposing (Msg)
import Models exposing (Post)


createPostEntry : Post -> Html Msg
createPostEntry post =
    section [ class "post-excerpt" ]
        [ div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ h1 []
                    [ a [ href ("#post/" ++ post.id) ]
                        [ text post.title ]
                    ]
                ]
            ]
        , div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ text post.content ]
            ]
        ]


view : List Post -> Html Msg
view posts =
    div [] (List.map createPostEntry posts)
