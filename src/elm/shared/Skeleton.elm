module Skeleton exposing (skeleton)

import Html exposing (..)
import Html.Attributes exposing (..)


(=>) =
    (,)


skeleton tabName content =
    div []
        (header tabName :: content ++ [ footer ])



-- HEADER


header name =
    div [ id "tabs" ]
        [ a
            [ href "/"
            , style
                [ "position" => "absolute"
                , "left" => "1em"
                , "top" => "1em"
                ]
            ]
            []
        , ul [] (List.map (tab name) [ "about", "home" ])
        ]


tab currentName name =
    li []
        [ a
            [ classList [ "tab" => True, "current" => (currentName == name) ]
            , href ("/" ++ name ++ ".html")
            ]
            [ text name ]
        ]



-- FOOTER


footer =
    div [ class "footer" ]
        [ text "I yam footer. — © 2012-2016 Iconcore"
        ]
