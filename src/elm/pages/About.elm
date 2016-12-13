module Pages.About exposing (..)

import Html exposing (..)
import Html.Attributes as Attr exposing (href)


main =
    div [] [ text "about page", a [ href "/home.html" ] [ text "home" ] ]
