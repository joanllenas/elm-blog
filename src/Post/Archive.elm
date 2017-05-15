module Post.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import RemoteData exposing (..)
import Date.Extra.Core as DateCore
import Msgs exposing (Msg)
import Models exposing (Post)
import Maybe
import Tuple
import Dict exposing (Dict)
import Utils exposing (..)


printMonth : Int -> Html Msg
printMonth month =
    let
        m =
            DateCore.intToMonth (month + 1)
    in
        text (toString m)


printPost : PostWrapper -> Html Msg
printPost { year, month, post } =
    li []
        [ a [ href ("#post/" ++ post.id) ] [ text post.title ] ]


printYearPosts : List PostWrapper -> List (Html Msg)
printYearPosts yearPosts =
    let
        postsByMonth =
            Utils.groupBy (\pw -> pw.month) yearPosts

        months =
            List.reverse (Dict.keys postsByMonth)
    in
        List.map
            (\month ->
                let
                    monthPosts : List PostWrapper
                    monthPosts =
                        Dict.get month postsByMonth
                            |> Maybe.withDefault []
                in
                    li []
                        [ printMonth month
                        , ul [] (List.map printPost monthPosts)
                        ]
            )
            months


type alias PostWrapper =
    { year : Int
    , month : Int
    , post : Post
    }


buildArchiveByYear : List Post -> Dict Int (List PostWrapper)
buildArchiveByYear posts =
    let
        wrappedPosts =
            List.map
                (\post ->
                    let
                        ( year, month ) =
                            Utils.postIdToYearMonth2 post.id

                        y =
                            (Result.withDefault 0 (String.toInt year))

                        m =
                            DateCore.monthToInt month
                    in
                        PostWrapper y m post
                )
                posts
    in
        Utils.groupBy (\pw -> pw.year) wrappedPosts


printArchive : List Post -> List (Html Msg)
printArchive posts =
    let
        postsByYear : Dict Int (List PostWrapper)
        postsByYear =
            buildArchiveByYear posts

        years =
            List.reverse (Dict.keys postsByYear)
    in
        List.map
            (\year ->
                let
                    yearPosts : List PostWrapper
                    yearPosts =
                        Dict.get year postsByYear
                            |> Maybe.withDefault []
                in
                    div []
                        [ h2 [] [ text (toString year) ]
                        , ul [] (printYearPosts yearPosts)
                        ]
            )
            years


view : WebData (List Post) -> Html Msg
view response =
    case response of
        RemoteData.NotAsked ->
            text "Waiting..."

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success posts ->
            div [ class "content-container" ] (printArchive posts)

        RemoteData.Failure error ->
            text (toString error)
