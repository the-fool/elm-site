module Pages.About exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Core
import Skeleton


(=>) =
    (,)


main =
    Skeleton.skeleton "about"
        [ splash
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
        [ div [ size 26 8 ] [ text "We are the best at healths and computers" ]
        , br [] []
        ]


people =
    section [ class "people-section" ]
        (List.map
            (\name -> h1 [] [ text name ])
            [ "PEOPLE", "Brady", "Jay", "Thomas" ]
        )
