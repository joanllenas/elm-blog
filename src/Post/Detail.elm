module Post.Detail exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import RemoteData exposing (..)
import Msgs exposing (Msg)
import Models exposing (Post, PostId)


createPostDetail : Post -> Html Msg
createPostDetail post =
    section [ class "post-excerpt" ]
        [ div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ h1 [] [ text post.title ] ]
            ]
        , div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ text post.content ]
            ]
        ]


view : WebData Post -> Html Msg
view response =
    case response of
        RemoteData.NotAsked ->
            text "---"

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success post ->
            div [ class "content-container" ] [ createPostDetail post ]

        RemoteData.Failure error ->
            text (toString error)
