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
        , people
        ]


px : Int -> String
px n =
    toString n ++ "px"


size : Int -> Int -> Attribute msg
size height padding =
    style
        [ "font-size" => (px height)
        , "padding" => (px padding ++ " 0")
        ]


splash =
    div [ class "splash" ]
        [ div [ size 120 16 ] [ text "IconCore" ]
        , div [ size 26 8 ] [ text "Smarts.  Healths. Computers." ]
        , div [ size 16 8 ] [ text "Buy our software." ]
        , br [] []
        ]


suite =
    section [ class "suite-section" ]
        [ h1 [] [ text "Our stuff" ] ]


people =
    section [ class "people-section" ]
        (List.map
            (\name -> h1 [] [ text name ])
            [ "PEOPLE", "Brady", "Jay", "Thomas" ]
        )
