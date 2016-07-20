module App exposing (..)

import Html exposing (text, div, h1, h2, p)

main : Html.Html a
main =
  div [] [
  h1 [] [ text "Welcome to Elm App"]
  , h2 [] [ text "Make Elm Things"]
  , p [] [ text "Hooray!"]
  ]
