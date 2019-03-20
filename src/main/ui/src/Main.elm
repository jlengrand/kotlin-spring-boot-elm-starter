module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, button, div, h1, h2, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Http
import Json.Decode
import Url.Builder exposing (absolute, string)



---- MODEL ----


type alias Model =
    { name : String
    }


init : ( Model, Cmd Msg )
init =
    ( { name = "test" }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp
    | SendHttpGetDefaultName
    | GotName (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendHttpGetDefaultName ->
            ( model, getDefaultName model )

        GotName result ->
            case result of
                Ok name ->
                    ( { model | name = name }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


nameDecoder : Json.Decode.Decoder String
nameDecoder =
    Json.Decode.field "name" Json.Decode.string


getDefaultName : Model -> Cmd Msg
getDefaultName model =
    Http.get
        { url = makeGetNameUrl model
        , expect = Http.expectJson GotName nameDecoder
        }


makeGetNameUrl : Model -> String
makeGetNameUrl model =
    absolute
        [ "hello" ]
        []



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        , div []
            [ h2 [] [ text ("Hello " ++ model.name ++ " !") ]
            , button [ onClick SendHttpGetDefaultName ] [ text "Request server for name!" ]
            ]
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
