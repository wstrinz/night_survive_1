module App exposing (..)

import Html exposing (text, div, h1, h2, p)
import Html.App
import Mouse
import Geolocation exposing (Location, changes)



type alias Loc =
  { latitude : Float
  , longitude : Float
  , timestamp : Float }

type alias Model =
  { location: Loc,
    boards: Int }
type Msg
    = FooMsg Int Int
    | LocMsg Location

init : ( Model, Cmd Msg )
init =
    ( { location = {
          latitude = 0.0, longitude = 0.0, timestamp = 0
        },
        boards = 0 }, Cmd.none )


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

view : Model -> Html.Html a
view model =
  div [] [
  h1 [] [ text "Welcome to Night Elm App"]
  , p [] [ text (toString model) ]
  ]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    FooMsg x y ->
      ({model | boards = model.boards + 1}, Cmd.none)

    LocMsg l ->
      let
        old = model.location
        newloc = { old |
          latitude = l.latitude,
          longitude = l.longitude,
          timestamp = l.timestamp }
      in
        ({model | location = newloc }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  let
    clickToMsg = (\c -> (FooMsg c.x c.y))
  in
    Sub.batch
    [ Mouse.clicks clickToMsg,
      changes LocMsg
    ]
