module Post.Detail exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import List.Extra exposing (find)
import RemoteData exposing (..)
import Msgs exposing (Msg)
import Utils exposing (stringToDate)
import Models exposing (Post, PostId)


createPostDetailPage : Maybe Post -> Html Msg
createPostDetailPage post =
    case post of
        Nothing ->
            createPostDetail (Post "" (stringToDate "") "Post not found" "The requested post does not exists.")

        Just post ->
            createPostDetail post


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


view2 : List Post -> PostId -> Html Msg
view2 posts postId =
    let
        maybePost =
            find (\post -> postId == post.id) posts
    in
        div [] [ createPostDetailPage maybePost ]


view : WebData (List Post) -> PostId -> Html Msg
view response postId =
    case response of
        RemoteData.NotAsked ->
            text "---"

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success posts ->
            view2 posts postId

        RemoteData.Failure error ->
            text (toString error)
