module Shared exposing (Data, Model, Msg(..), SharedMsg(..), template)

import BackendTask exposing (BackendTask)
import Effect exposing (Effect)
import FatalError exposing (FatalError)
import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events
import Pages.Flags
import Pages.PageUrl exposing (PageUrl)
import Route exposing (Route)
import SharedTemplate exposing (SharedTemplate)
import Tailwind exposing (classes, raw)
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as T
import Tailwind.Utilities as Tw
import UrlPath exposing (UrlPath)
import View exposing (View)


template : SharedTemplate Msg Model Data msg
template =
    { init = init
    , update = update
    , view = view
    , data = data
    , subscriptions = subscriptions
    , onPageChange = Nothing
    }


type Msg
    = SharedMsg SharedMsg
    | MenuClicked


type alias Data =
    ()


type SharedMsg
    = NoOp


type alias Model =
    { showMenu : Bool
    }


init :
    Pages.Flags.Flags
    ->
        Maybe
            { path :
                { path : UrlPath
                , query : Maybe String
                , fragment : Maybe String
                }
            , metadata : route
            , pageUrl : Maybe PageUrl
            }
    -> ( Model, Effect Msg )
init flags maybePagePath =
    ( { showMenu = False }
    , Effect.none
    )


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        SharedMsg globalMsg ->
            ( model, Effect.none )

        MenuClicked ->
            ( { model | showMenu = not model.showMenu }, Effect.none )


subscriptions : UrlPath -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none


data : BackendTask FatalError Data
data =
    BackendTask.succeed ()


view :
    Data
    ->
        { path : UrlPath
        , route : Maybe Route
        }
    -> Model
    -> (Msg -> msg)
    -> View msg
    -> { body : List (Html msg), title : String }
view sharedData page model toMsg pageView =
    { body =
        [ Html.div
            [ classes [ raw "min-h-screen", Tw.flex, Tw.flex_col ] ]
            [ navbar model toMsg
            , Html.main_ [ classes [ Tw.grow ] ] pageView.body
            , footer
            ]
        ]
    , title = pageView.title
    }


navbar : Model -> (Msg -> msg) -> Html msg
navbar model toMsg =
    Html.nav
        [ classes
            [ Tw.bg_simple T.white
            , Tw.shadow_sm
            , Tw.sticky
            , raw "top-0"
            , Tw.z_50
            ]
        ]
        [ Html.div
            [ classes
                [ raw "max-w-6xl"
                , raw "mx-auto"
                , Tw.px T.s6
                , Tw.py T.s4
                ]
            ]
            [ Html.div
                [ classes
                    [ Tw.flex
                    , Tw.items_center
                    , Tw.justify_between
                    ]
                ]
                [ Html.a
                    [ Attr.href "/"
                    , classes
                        [ Tw.flex
                        , Tw.items_center
                        , Tw.gap T.s3
                        ]
                    ]
                    [ Html.div
                        [ classes
                            [ Tw.w T.s8
                            , Tw.h T.s8
                            , Tw.bg_color T.indigo T.s600
                            , Tw.rounded_lg
                            , Tw.flex
                            , Tw.items_center
                            , Tw.justify_center
                            ]
                        ]
                        [ Html.span
                            [ classes
                                [ Tw.text_simple T.white
                                , Tw.font_bold
                                , Tw.text_sm
                                ]
                            ]
                            [ Html.text "Tw" ]
                        ]
                    , Html.span
                        [ classes
                            [ Tw.font_semibold
                            , Tw.text_color T.slate T.s900
                            ]
                        ]
                        [ Html.text "elm-tailwind-classes" ]
                    ]
                , Html.div
                    [ classes
                        [ Tw.hidden
                        , Bp.md [ Tw.flex ]
                        , Tw.items_center
                        , Tw.gap T.s8
                        ]
                    ]
                    [ navLink "Features" "#features"
                    , navLink "Examples" "#examples"
                    , navLink "Get Started" "#get-started"
                    , Html.a
                        [ Attr.href "https://github.com/dillonkearns/elm-tailwind-classes"
                        , Attr.target "_blank"
                        , classes
                            [ Tw.bg_color T.indigo T.s600
                            , Tw.text_simple T.white
                            , Tw.px T.s4
                            , Tw.py T.s2
                            , Tw.rounded_lg
                            , Tw.text_sm
                            , Tw.font_medium
                            , Tw.transition
                            , Bp.hover [ Tw.bg_color T.indigo T.s700 ]
                            ]
                        ]
                        [ Html.text "GitHub" ]
                    ]
                , Html.button
                    [ Html.Events.onClick (toMsg MenuClicked)
                    , classes
                        [ Tw.p T.s2
                        , Tw.rounded_lg
                        , Tw.text_color T.slate T.s600
                        , Tw.transition
                        , Bp.hover [ Tw.bg_color T.slate T.s100 ]
                        , Bp.md [ Tw.hidden ]
                        ]
                    ]
                    [ if model.showMenu then
                        Html.span [ classes [ Tw.text_xl ] ] [ Html.text "x" ]

                      else
                        Html.span [ classes [ Tw.text_xl ] ] [ Html.text "=" ]
                    ]
                ]
            , if model.showMenu then
                Html.div
                    [ classes
                        [ Tw.mt T.s4
                        , Tw.py T.s4
                        , Tw.border_t
                        , Tw.border_color T.slate T.s200
                        , Bp.md [ Tw.hidden ]
                        ]
                    ]
                    [ Html.div
                        [ classes [ Tw.flex, Tw.flex_col, Tw.gap T.s4 ] ]
                        [ mobileNavLink "Features" "#features"
                        , mobileNavLink "Examples" "#examples"
                        , mobileNavLink "Get Started" "#get-started"
                        , Html.a
                            [ Attr.href "https://github.com/dillonkearns/elm-tailwind-classes"
                            , Attr.target "_blank"
                            , classes
                                [ Tw.bg_color T.indigo T.s600
                                , Tw.text_simple T.white
                                , Tw.px T.s4
                                , Tw.py T.s2
                                , Tw.rounded_lg
                                , Tw.text_sm
                                , Tw.font_medium
                                , Tw.text_center
                                ]
                            ]
                            [ Html.text "View on GitHub" ]
                        ]
                    ]

              else
                Html.text ""
            ]
        ]


navLink : String -> String -> Html msg
navLink label href =
    Html.a
        [ Attr.href href
        , classes
            [ Tw.text_color T.slate T.s600
            , Tw.text_sm
            , Tw.font_medium
            , Tw.transition
            , Bp.hover [ Tw.text_color T.indigo T.s600 ]
            ]
        ]
        [ Html.text label ]


mobileNavLink : String -> String -> Html msg
mobileNavLink label href =
    Html.a
        [ Attr.href href
        , classes
            [ Tw.text_color T.slate T.s700
            , Tw.font_medium
            , Tw.py T.s2
            ]
        ]
        [ Html.text label ]


footer : Html msg
footer =
    Html.footer
        [ classes
            [ Tw.bg_color T.slate T.s900
            , Tw.text_color T.slate T.s400
            , Tw.py T.s12
            , Tw.px T.s6
            ]
        ]
        [ Html.div
            [ classes
                [ raw "max-w-6xl"
                , raw "mx-auto"
                ]
            ]
            [ Html.div
                [ classes
                    [ Tw.flex
                    , Tw.flex_col
                    , Bp.md [ Tw.flex_row ]
                    , Tw.justify_between
                    , Tw.items_center
                    , Tw.gap T.s6
                    ]
                ]
                [ Html.div
                    [ classes [ Tw.flex, Tw.items_center, Tw.gap T.s3 ] ]
                    [ Html.div
                        [ classes
                            [ Tw.w T.s8
                            , Tw.h T.s8
                            , Tw.bg_color T.indigo T.s600
                            , Tw.rounded_lg
                            , Tw.flex
                            , Tw.items_center
                            , Tw.justify_center
                            ]
                        ]
                        [ Html.span
                            [ classes
                                [ Tw.text_simple T.white
                                , Tw.font_bold
                                , Tw.text_sm
                                ]
                            ]
                            [ Html.text "Tw" ]
                        ]
                    , Html.span
                        [ classes [ Tw.font_semibold, Tw.text_simple T.white ] ]
                        [ Html.text "elm-tailwind-classes" ]
                    ]
                , Html.div
                    [ classes
                        [ Tw.flex
                        , Tw.gap T.s6
                        , Tw.text_sm
                        ]
                    ]
                    [ Html.a
                        [ Attr.href "https://github.com/dillonkearns/elm-tailwind-classes"
                        , Attr.target "_blank"
                        , classes
                            [ Tw.transition
                            , Bp.hover [ Tw.text_simple T.white ]
                            ]
                        ]
                        [ Html.text "GitHub" ]
                    , Html.a
                        [ Attr.href "https://elm-doc-preview.netlify.app/Tailwind?repo=dillonkearns%2Felm-tailwind-classes&version=main"
                        , Attr.target "_blank"
                        , classes
                            [ Tw.transition
                            , Bp.hover [ Tw.text_simple T.white ]
                            ]
                        ]
                        [ Html.text "Docs" ]
                    , Html.a
                        [ Attr.href "https://tailwindcss.com"
                        , Attr.target "_blank"
                        , classes
                            [ Tw.transition
                            , Bp.hover [ Tw.text_simple T.white ]
                            ]
                        ]
                        [ Html.text "Tailwind CSS" ]
                    ]
                ]
            , Html.div
                [ classes
                    [ Tw.mt T.s8
                    , Tw.pt T.s8
                    , Tw.border_t
                    , Tw.border_color T.slate T.s800
                    , Tw.text_center
                    , Tw.text_sm
                    ]
                ]
                [ Html.text "Built with Elm and Tailwind CSS. Type-safe styling for the win." ]
            ]
        ]
