module Post.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import RemoteData exposing (..)
import Msgs exposing (Msg)
import Models exposing (Post)
import Maybe
import Tuple
import Dict
import Utils exposing (..)


printArchive : List PostWrapper -> Html Msg
printArchive posts =
    div [] (List.map (\post -> text post.year) posts)


type alias PostWrapper =
    { year : String
    , month : String
    , post : Post
    }


buildArchive : List Post -> List PostWrapper
buildArchive posts =
    posts
        |> List.map
            (\post ->
                let
                    ( year, month ) =
                        Utils.postIdToYearMonth post.id
                in
                    PostWrapper year month post
            )
        |> List.sortWith
            (\pa pb ->
                let
                    a =
                        Result.withDefault 0 (String.toInt pa.year)

                    b =
                        Result.withDefault 0 (String.toInt pb.year)
                in
                    case compare a b of
                        LT ->
                            GT

                        EQ ->
                            EQ

                        GT ->
                            LT
            )


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
                    buildArchive posts
            in
                div [ class "content-container" ] [ printArchive postArchive ]

        RemoteData.Failure error ->
            text (toString error)
