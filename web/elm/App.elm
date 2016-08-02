module App exposing (..)

import Html exposing (text, div, h1, h2, p, br, button)
import Html.App
import Html.Events exposing (onClick)
import Mouse
import Task
import Http
import Json.Decode as Json
import Geolocation exposing (Location, changes)

type alias Loc =
  { latitude : Float
  , longitude : Float
  , timestamp : Float }

type alias Model =
  { location: Loc,
    cmdstatus: String,
    boards: Int }

type Msg
    = FooMsg Int Int
    | LocMsg Location
    | MakeHttpReq
    | HttpRespSuccess
    | HttpRespFail

init : ( Model, Cmd Msg )
init =
    ( { location = { latitude = 0.0, longitude = 0.0, timestamp = 0 }
        , boards = 0
        , cmdstatus = "none" }
      , Cmd.none )


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

view : Model -> Html.Html Msg
view model =
  div [] [
  h1 [] [ text "Welcome to Night Elm App"]
  , p [] [ text (toString model) ]
  , br [] []
  , button [ onClick MakeHttpReq ] [ text "Make Request" ]
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

    MakeHttpReq ->
      (model, fetchNearby)
    HttpRespSuccess ->
      ({model | cmdstatus = "resp success"}, Cmd.none)
    HttpRespFail ->
      ({model | cmdstatus = "resp fail"}, Cmd.none)

fetchNearby : Cmd Msg
fetchNearby =
  let
    url = "/api/test"
  in
    Task.perform (\_ -> HttpRespFail) (\_ -> HttpRespSuccess) (Http.get decodeApiResp url)

decodeApiResp : Json.Decoder String
decodeApiResp =
  Json.at ["data"] Json.string

subscriptions : Model -> Sub Msg
subscriptions model =
  let
    clickToMsg = (\c -> (FooMsg c.x c.y))
  in
    Sub.batch
    [ Mouse.clicks clickToMsg,
      changes LocMsg
    ]
