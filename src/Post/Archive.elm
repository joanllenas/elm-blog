module Post.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import RemoteData exposing (..)
import Msgs exposing (Msg)
import Models exposing (Post)
import Maybe
import Tuple
import Utils exposing (humanizeDate)


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
            , div [ class "twelve columns" ]
                [ p [ class "meta" ]
                    [ text (humanizeDate (Maybe.Just post.created_at))
                    ]
                ]
            ]
        , div [ class "row" ]
            [ div [ class "twelve columns" ]
                [ p []
                    [ text post.content ]
                ]
            ]
        ]


buildArchive : ( List Post, List Post ) -> ( List Post, List Post )
buildArchive tuple =
    case Tuple.first tuple of
        [] ->
            ( [], [] )

        hd :: tl ->
            buildArchive ( tl, Tuple.second tuple ++ [ hd ] )


view : WebData (List Post) -> Html Msg
view response =
    case response of
        RemoteData.NotAsked ->
            text "---"

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success posts ->
            let
                postArchive =
                    buildArchive ( posts, [] )
            in
                div [ class "content-container" ] (List.map createPostEntry (Tuple.second postArchive))

        RemoteData.Failure error ->
            text (toString error)
