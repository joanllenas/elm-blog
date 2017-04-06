module Post.Detail exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import List.Extra exposing (find)
import Msgs exposing (Msg)
import Models exposing (Post, PostId)


createPostDetailPage : Maybe Post -> Html Msg
createPostDetailPage post =
    case post of
        Nothing ->
            createPostDetail (Post "" "Post not found" "The requested post does not exists.")

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


view : List Post -> PostId -> Html Msg
view posts postId =
    let
        maybePost =
            find (\post -> postId == post.id) posts
    in
        div [] [ createPostDetailPage maybePost ]
