module MyCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, img, h1, a)
import Css.Namespace exposing (namespace)

type CssClasses
    = NavLink
    | Large
    | Selected
    | Content


type CssIds
    = Thumbnails


css =
    (stylesheet << namespace "home")
        [ body
            [ backgroundColor (rgb 44 44 44)
            , color white
            ]
        , img
            [ border3 (px 1) solid white
            , margin (px 5)
            ]
        , (.) Large
            [ width (px 500)
            , float right
            ]
        , (.) Selected
            [ margin zero
            , border3 (px 6) solid someColor
            ]
        , (.) Content
            [ margin2 (px 40) auto
            , width (px 960)
            ]
        , (.) NavLink
            [ margin (px 12)
            , color (rgb 255 255 255)
            ]
        , (#) Thumbnails
            [ width (px 440)
            , float left
            ]
        , h1
            [ fontFamilies  ["Verdana"]
            , color someColor
            ]
        , a
            [ textDecoration none

            , hover
              [ textDecoration underline ]
      ]
        ]

someColor =
    (hex "60b5cc")

white =
    (hex "ffffff")
