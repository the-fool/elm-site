module Pages.Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Core
import Skeleton


(=>) =
    (,)


main =
    Skeleton.skeleton "home"
        [ splash
        , suite
        ]


size height padding =
    style
        [ "font-size" => (toString height ++ "px")
        , "padding" => (toString padding ++ "px 0")
        ]


splash =
    div [ class "splash" ]
        [ div [ size 120 16 ] [ text "IconCore" ]
        , div [ size 26 8 ] [ text "Smarts.  Health. Computers." ]
        , div [ size 16 8 ] [ text "Buy our software." ]
        , br [] []
        ]


suite =
    section [ class "suite-section" ]
        [ h1 [] [ text "Our stuff" ] ]
