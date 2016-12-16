
import Html exposing (..)
import Html.CssHelpers exposing (..)
import Html.Attributes exposing (..)
import MyCss exposing (..)

{ id, class, classList } =
    Html.CssHelpers.withNamespace "home"


main =
  view "no model yet"


view model =
  div [ class [Content] ]
      [ h1 [] [ text "Photo Grove" ]
      , div [ id Thumbnails ]
          [ img [ src "http://elm-in-action.com/1.jpeg" ] []
          , img [ src "http://elm-in-action.com/2.jpeg"] []
          , img [ src "http://elm-in-action.com/3.jpeg"] []
          ]
      ]


-- navElems =
--     [ "SPEAKERS", "SCHEDULE", "WORKSHOPS", "VENUE", "BLOG", "CONTACT" ]
--        |> List.map (\name -> span [ class [ NavLink ] ] [ text name ])
