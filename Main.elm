module Main exposing (..)

import Array exposing (Array)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Html.CssHelpers exposing (..)
import MyCss exposing (..)


{ id, class, classList } =
    Html.CssHelpers.withNamespace "home"


type alias Photo =
    { url : String }


type alias Model =
    { photos : List Photo
    , selectedUrl : String
    , chosenSize : ThumbnailSize
    }


type Msg
    = SelectByUrl String
    | SurpriseMe
    | SetSize ThumbnailSize


type ThumbnailSize
    = Small
    | Medium
    | Large


initialModel : Model
initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedUrl = "1.jpeg"
    , chosenSize = Medium
    }


photoArray : Array Photo
photoArray =
    Array.fromList initialModel.photos


main =
    Html.beginnerProgram
        { model = initialModel
        , view = view
        , update = update
        }


getPhotoUrl : Int -> String
getPhotoUrl index =
    case Array.get index photoArray of
        Just photo ->
            photo.url

        Nothing ->
            ""



-- Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectByUrl url ->
            { model | selectedUrl = url }

        SurpriseMe ->
            { model | selectedUrl = "2.jpeg" }

        SetSize size ->
            { model | chosenSize = size }



-- View


view : Model -> Html Msg
view model =
    div [ class [ Content ] ]
        [ h1 [] [ text "Photo Grove" ]
        , button
            [ onClick SurpriseMe ]
            [ text "Surprise Me!" ]
        , h3 [] [ text "Thumbnail Size:" ]
        , div [ id "choose-size" ]
            (List.map viewSizeChooser [ Small, Medium, Large ])
        , div [ id Thumbnails, class [ (sizeToString model.chosenSize) ] ]
            (List.map (viewThumbnail model.selectedUrl) model.photos)
        , img
            [ class [ "large" ]
            , src (urlPrefix ++ "large/" ++ model.selectedUrl)
            ]
            []
        ]


viewThumbnail : String -> Photo -> Html Msg
viewThumbnail selectedUrl thumbnail =
    img
        [ src (urlPrefix ++ thumbnail.url)
        , classList [ ( "selcted", selectedUrl == thumbnail.url ) ]
        , onClick (SelectByUrl thumbnail.url)
        ]
        []


urlPrefix : String
urlPrefix =
    "http://elm-in-action.com/"


viewSizeChooser : ThumbnailSize -> Html Msg
viewSizeChooser size =
    label []
        [ input [ type_ "radio", name "size", onClick (SetSize size) ] []
        , text (sizeToString size)
        ]


sizeToString : ThumbnailSize -> String
sizeToString size =
    case size of
        Small ->
            "small"

        Medium ->
            "med"

        Large ->
            "large"



-- navElems =
--     [ "SPEAKERS", "SCHEDULE", "WORKSHOPS", "VENUE", "BLOG", "CONTACT" ]
--        |> List.map (\name -> span [ class [ NavLink ] ] [ text name ])
