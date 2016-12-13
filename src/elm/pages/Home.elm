module Pages.Home exposing (..)

import Html exposing (..)
import Html.Attributes as Attr exposing (href)


main =
    div [] [ text "home", a [ href "/about.html" ] [ text "about" ] ]
