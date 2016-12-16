
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Html.CssHelpers exposing (..)
import MyCss exposing (..)

{ id, class, classList } =
    Html.CssHelpers.withNamespace "home"

initialModel =
  { photos =
    [ { url = "1.jpeg" }
    , { url = "2.jpeg" }
    , { url = "3.jpeg" }
    ]
  , selectedUrl = "1.jpeg"
  }

main =
  Html.beginnerProgram
    { model = initialModel
    , view = view
    , update = update
    }

-- Update

update msg model =
  if msg.operation == "SELECT_PHOTO" then
    { model | selectedUrl = msg.data }
  else
    model

-- View

view model =
  div [ class [Content] ]
      [ h1 [] [ text "Photo Grove" ]
      , div [ id Thumbnails ]
          (List.map (viewThumbnail model.selectedUrl) model.photos)
      , img
          [class ["large"]
          , src (urlPrefix ++ "large/" ++ model.selectedUrl)
          ] []
      ]

viewThumbnail selectedUrl thumbnail =
  img [ src (urlPrefix ++ thumbnail.url)
  , classList [ ( "selcted", selectedUrl == thumbnail.url ) ]
  , onClick { operation = "SELECT_PHOTO", data = thumbnail.url }
  ] []

urlPrefix =
  "http://elm-in-action.com/"

-- navElems =
--     [ "SPEAKERS", "SCHEDULE", "WORKSHOPS", "VENUE", "BLOG", "CONTACT" ]
--        |> List.map (\name -> span [ class [ NavLink ] ] [ text name ])
