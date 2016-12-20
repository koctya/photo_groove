module Main exposing (..)

import Array exposing (Array)
import Random
import Http
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)


-- import Html.CssHelpers exposing (..)
-- import MyCss exposing (..)
--{ id, class, classList } =
--    Html.CssHelpers.withNamespace "home"


type alias Photo =
    { url : String }


type alias Model =
    { photos : List Photo
    , selectedUrl : Maybe String
    , loadingError : Maybe String
    , chosenSize : ThumbnailSize
    }


type Msg
    = SelectByUrl String
    | SelectByIndex Int
    | SurpriseMe
    | SetSize ThumbnailSize
    | LoadPhotos (Result Http.Error String)


type ThumbnailSize
    = Small
    | Medium
    | Large


initialModel : Model
initialModel =
    { photos = []
    , selectedUrl = Nothing
    , loadingError = Nothing
    , chosenSize = Medium
    }


initialCmd : Cmd Msg
initialCmd =
    "Http://elm-in-action.com/photos/list"
        |> Http.getString
        |> Http.send LoadPhotos


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, initialCmd )
        , view = viewOrError
        , update = update
        , subscriptions = (\_ -> Sub.none)
        }



{- }
   getPhotoUrl : Int -> Maybe String
   getPhotoUrl index =
       case Array.get index photoArray of
           Just photo ->
               Just photo.url

           Nothing ->
               Nothing
-}
-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectByIndex index ->
            let
                newSelectedUrl : Maybe String
                newSelectedUrl =
                    model.photos
                        |> Array.fromList
                        |> Array.get index
                        |> Maybe.map .url
            in
                ( { model | selectedUrl = newSelectedUrl }, Cmd.none )

        SelectByUrl url ->
            ( { model | selectedUrl = Just url }, Cmd.none )

        SurpriseMe ->
            let
                randomPhotoPicker =
                    Random.int 0 (List.length model.photos - 1)
            in
                ( model, Random.generate SelectByIndex randomPhotoPicker )

        SetSize size ->
            ( { model | chosenSize = size }, Cmd.none )

        LoadPhotos (Ok responseStr) ->
            let
                urls =
                    String.split "," responseStr

                photos =
                    List.map Photo urls
            in
                ( { model
                    | photos = photos
                    , selectedUrl = List.head urls
                  }
                , Cmd.none
                )

        LoadPhotos (Err _) ->
            ( { model
                | loadingError = Just "Error! (Try turniing it off and on again?)"
              }
            , Cmd.none
            )


viewOrError : Model -> Html Msg
viewOrError model =
    case model.loadingError of
        Nothing ->
            view model

        Just errorMessage ->
            div [ class "error-message" ]
                [ h1 [] [ text "Photo Grove" ]
                , p [] [ text errorMessage ]
                ]



-- View


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Grove" ]
        , button
            [ onClick SurpriseMe ]
            [ text "Surprise Me!" ]
        , h3 [] [ text "Thumbnail Size:" ]
        , div [ id "choose-size" ]
            (List.map viewSizeChooser [ Small, Medium, Large ])
        , div [ id "thumbnails", class (sizeToString model.chosenSize) ]
            (List.map (viewThumbnail model.selectedUrl) model.photos)
        , viewLarge model.selectedUrl
        ]


viewThumbnail : Maybe String -> Photo -> Html Msg
viewThumbnail selectedUrl thumbnail =
    img
        [ src (urlPrefix ++ thumbnail.url)
        , classList [ ( "selcted", selectedUrl == Just thumbnail.url ) ]
        , onClick (SelectByUrl thumbnail.url)
        ]
        []


viewLarge : Maybe String -> Html Msg
viewLarge maybeUrl =
    case maybeUrl of
        Nothing ->
            text ""

        Just url ->
            img [ class "large", src (urlPrefix ++ "large/" ++ url) ] []


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
