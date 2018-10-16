module MyCss exposing (CssClasses(..), CssIds(..), css, someColor, white)

import Css exposing (..)
import Css.Elements exposing (a, body, button, h1, h3, img, label)
import Css.Namespace exposing (namespace)


type CssClasses
    = NavLink
    | Large
    | Selected
    | Content


type CssIds
    = Thumbnails
    | ChooseSize
    | ActivateGroove


css =
    (stylesheet << namespace "home")
        [ body
            [ fontFamilies [ "Verdana" ]
            , backgroundColor (rgb 44 44 44)
            , color (rgb 250 250 250)
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
        , (#) ChooseSize
            [ marginLeft (px 20)
            , float left
            ]
        , (#) ActivateGroove
            [ marginRight (px 20)
            , marginTop (px 15)
            , float right
            ]
        , h1
            [ marginBottom zero
            , color someColor
            ]
        , h3
            [ margin zero
            , float left
            ]
        , label [ verticalAlign bottom ]
        , a
            [ textDecoration none
            , hover
                [ textDecoration underline ]
            ]
        , button
            [ float right
            , backgroundColor someColor
            , border zero
            , color (rgb 44 44 44)
            , fontSize (px 24)
            , cursor pointer
            , padding2 (px 10) (px 30)
            ]
        ]



-- #thumbnails.small img { width: 50px; }
-- #thumbnails.med img { width: 100px; }
-- #thumbnails.large img { width: 200px; }
-- #choose-size { float: left; margin-left: 20px; }
-- #choose-size > span { display: inline-block; margin: 0 10px; }
-- button:hover {
--   background-color: white;
-- }
-- #thumbnails, img.large, #choose-size, h3 { margin-top: 20px; }


someColor =
    hex "60b5cc"


white =
    hex "ffffff"
