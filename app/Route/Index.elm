module Route.Index exposing (ActionData, Data, Model, Msg, route)

import BackendTask exposing (BackendTask)
import FatalError exposing (FatalError)
import Head
import Head.Seo as Seo
import Html exposing (Html)
import Html.Attributes as Attr
import Pages.Url
import PagesMsg exposing (PagesMsg)
import Route
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import Tailwind as Tw exposing (classes, raw)
import Tailwind.Breakpoints as Bp
import Tailwind.Theme as T
import UrlPath
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    {}


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single
        { head = head
        , data = data
        }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    BackendTask.succeed {}


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head app =
    Seo.summary
        { canonicalUrlOverride = Nothing
        , siteName = "elm-tailwind-classes"
        , image =
            { url = [ "images", "icon-png.png" ] |> UrlPath.join |> Pages.Url.fromPath
            , alt = "elm-tailwind-classes logo"
            , dimensions = Nothing
            , mimeType = Nothing
            }
        , description = "Type-safe Tailwind CSS for Elm with automatic dead code elimination"
        , locale = Nothing
        , title = "elm-tailwind-classes - Type-safe Tailwind for Elm"
        }
        |> Seo.website


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view app shared =
    { title = "elm-tailwind-classes - Type-safe Tailwind for Elm"
    , body =
        [ heroSection
        , codeExampleSection
        , featuresSection
        , interactiveDemo
        , getStartedSection
        ]
    }


container : List Tw.Tailwind -> List Tw.Tailwind
container extra =
    [ raw "max-w-6xl"
    , raw "mx-auto"
    , Tw.px T.s6
    ]
        ++ extra



-- HERO SECTION


heroSection : Html msg
heroSection =
    Html.section
        [ classes
            [ Tw.bg_simple T.white
            ]
        ]
        [ Html.div
            [ classes
                [ raw "max-w-7xl"
                , raw "mx-auto"
                , Tw.px T.s6
                , Tw.py T.s24
                , Bp.sm [ Tw.py T.s32 ]
                , Bp.lg [ Tw.px T.s8 ]
                ]
            ]
            [ Html.h2
                [ classes
                    [ raw "max-w-2xl"
                    , Tw.text_n4xl
                    , Tw.font_semibold
                    , raw "tracking-tight"
                    , raw "text-balance"
                    , Tw.text_color (T.gray T.s900)
                    , Bp.sm [ Tw.text_n5xl ]
                    ]
                ]
                [ Html.text "Type-safe Tailwind CSS for Elm. Catch errors at compile time." ]
            , Html.div
                [ classes
                    [ Tw.mt T.s10
                    , Tw.flex
                    , Tw.items_center
                    , raw "gap-x-6"
                    ]
                ]
                [ Html.a
                    [ Attr.href "#get-started"
                    , classes
                        [ Tw.rounded_md
                        , Tw.bg_color (T.indigo T.s600)
                        , raw "px-3.5"
                        , Tw.py T.s2_dot_5
                        , Tw.text_sm
                        , Tw.font_semibold
                        , raw "text-white"
                        , raw "shadow-xs"
                        , Bp.hover [ Tw.bg_color (T.indigo T.s500) ]
                        ]
                    ]
                    [ Html.text "Get started" ]
                , Html.a
                    [ Attr.href "https://github.com/dillonkearns/elm-tailwind-classes"
                    , Attr.target "_blank"
                    , classes
                        [ Tw.text_sm
                        , Tw.font_semibold
                        , Tw.text_color (T.gray T.s900)
                        ]
                    ]
                    [ Html.text "Learn more "
                    , Html.span [] [ Html.text "→" ]
                    ]
                ]
            ]
        ]



-- FEATURES SECTION


featuresSection : Html msg
featuresSection =
    Html.section
        [ Attr.id "features"
        , classes
            [ Tw.py T.s24
            , Tw.bg_color (T.gray T.s50)
            ]
        ]
        [ Html.div
            [ classes (container []) ]
            [ Html.div
                [ classes [ Tw.text_center, Tw.mb T.s16 ] ]
                [ Html.h2
                    [ classes
                        [ Tw.text_sm
                        , Tw.font_semibold
                        , Tw.text_color (T.indigo T.s600)
                        , Tw.uppercase
                        , raw "tracking-wide"
                        ]
                    ]
                    [ Html.text "Features" ]
                , Html.p
                    [ classes
                        [ Tw.mt T.s2
                        , Tw.text_n3xl
                        , Bp.md [ Tw.text_n4xl ]
                        , Tw.font_bold
                        , raw "tracking-tight"
                        , Tw.text_color (T.gray T.s900)
                        ]
                    ]
                    [ Html.text "Why elm-tailwind-classes?" ]
                ]
            , Html.div
                [ classes
                    [ Tw.grid
                    , raw "grid-cols-1"
                    , Bp.md [ raw "grid-cols-2" ]
                    , Tw.gap T.s8
                    ]
                ]
                [ featureCard
                    { color = T.green
                    , title = "Compiler-Verified Styles"
                    , description = "Misspelled bg-bluue-500? The Elm compiler catches it instantly. No more silent failures or hunting for typos in class strings."
                    , codeExample = "Tw.bg_color (T.blue T.s500)"
                    }
                , featureCard
                    { color = T.purple
                    , title = "IDE Superpowers"
                    , description = "Autocomplete every Tailwind utility. Jump to definition. Hover for docs. Discover available classes without leaving your editor."
                    , codeExample = ""
                    }
                , featureCard
                    { color = T.orange
                    , title = "Fearless Refactoring"
                    , description = "Rename a color across your entire codebase with a single refactor. The compiler ensures you don't miss a single usage."
                    , codeExample = "Bp.hover [ Tw.opacity_75 ]"
                    }
                , featureCard
                    { color = T.blue
                    , title = "Zero Runtime Cost"
                    , description = "Generates plain class strings at build time. No CSS-in-JS overhead, no runtime style computation, just fast static CSS."
                    , codeExample = "Tw.p T.s4"
                    }
                ]
            ]
        ]


featureCard :
    { color : T.Shade -> T.Color
    , title : String
    , description : String
    , codeExample : String
    }
    -> Html msg
featureCard { color, title, description, codeExample } =
    Html.div
        [ classes
            [ Tw.bg_simple T.white
            , Tw.rounded_n2xl
            , Tw.p T.s8
            , Tw.shadow_sm
            , raw "ring-1"
            , raw "ring-gray-900/5"
            ]
        ]
        [ Html.div
            [ classes
                [ Tw.w T.s10
                , Tw.h T.s10
                , Tw.rounded_lg
                , Tw.bg_color (color T.s600)
                , Tw.flex
                , Tw.items_center
                , Tw.justify_center
                , Tw.mb T.s4
                ]
            ]
            [ Html.div
                [ classes
                    [ Tw.w T.s5
                    , Tw.h T.s5
                    , Tw.rounded
                    , Tw.bg_simple T.white
                    , Tw.opacity_50
                    ]
                ]
                []
            ]
        , Html.h3
            [ classes
                [ Tw.text_lg
                , Tw.font_semibold
                , Tw.text_color (T.gray T.s900)
                , Tw.mb T.s2
                ]
            ]
            [ Html.text title ]
        , Html.p
            [ classes
                [ Tw.text_color (T.gray T.s600)
                , raw "leading-7"
                ]
            ]
            [ Html.text description ]
        , if String.isEmpty codeExample then
            Html.text ""

          else
            Html.code
                [ classes
                    [ Tw.text_sm
                    , Tw.bg_color (T.gray T.s100)
                    , Tw.text_color (T.gray T.s700)
                    , Tw.px T.s3
                    , Tw.py T.s1
                    , Tw.rounded_md
                    , Tw.font_mono
                    , Tw.mt T.s4
                    , Tw.inline_block
                    ]
                ]
                [ Html.text codeExample ]
        ]



-- CODE EXAMPLE SECTION


codeExampleSection : Html msg
codeExampleSection =
    Html.section
        [ classes
            [ Tw.py T.s24
            , Tw.bg_simple T.white
            ]
        ]
        [ Html.div
            [ classes (container []) ]
            [ Html.div
                [ classes [ Tw.text_center, Tw.mb T.s16 ] ]
                [ Html.h2
                    [ classes
                        [ Tw.text_sm
                        , Tw.font_semibold
                        , Tw.text_color (T.indigo T.s600)
                        , Tw.uppercase
                        , raw "tracking-wide"
                        ]
                    ]
                    [ Html.text "Developer Experience" ]
                , Html.p
                    [ classes
                        [ Tw.mt T.s2
                        , Tw.text_n3xl
                        , Bp.md [ Tw.text_n4xl ]
                        , Tw.font_bold
                        , raw "tracking-tight"
                        , Tw.text_color (T.gray T.s900)
                        ]
                    ]
                    [ Html.text "Write Elm, Get Tailwind" ]
                , Html.p
                    [ classes
                        [ Tw.mt T.s4
                        , Tw.text_lg
                        , Tw.text_color (T.gray T.s600)
                        , raw "max-w-2xl"
                        , raw "mx-auto"
                        ]
                    ]
                    [ Html.text "Type-safe Tailwind with IDE autocomplete, compile-time checks, and zero runtime overhead. Plain CSS output—no CSS-in-JS performance penalty." ]
                ]
            , Html.div
                [ classes
                    [ Tw.bg_color (T.gray T.s900)
                    , Tw.rounded_n2xl
                    , Tw.overflow_hidden
                    , Tw.shadow_xl
                    , raw "ring-1"
                    , raw "ring-white/10"
                    ]
                ]
                [ Html.div
                    [ classes
                        [ Tw.flex
                        , Tw.items_center
                        , Tw.gap T.s2
                        , Tw.px T.s4
                        , Tw.py T.s3
                        , raw "border-b"
                        , raw "border-white/10"
                        ]
                    ]
                    [ Html.div [ classes [ Tw.w T.s3, Tw.h T.s3, Tw.rounded_full, Tw.bg_color (T.red T.s500) ] ] []
                    , Html.div [ classes [ Tw.w T.s3, Tw.h T.s3, Tw.rounded_full, Tw.bg_color (T.yellow T.s500) ] ] []
                    , Html.div [ classes [ Tw.w T.s3, Tw.h T.s3, Tw.rounded_full, Tw.bg_color (T.green T.s500) ] ] []
                    , Html.span
                        [ classes [ Tw.ml T.s4, Tw.text_sm, Tw.text_color (T.gray T.s400) ] ]
                        [ Html.text "Button.elm" ]
                    ]
                , Html.pre
                    [ classes
                        [ Tw.p T.s6
                        , Tw.text_sm
                        , Tw.overflow_x_auto
                        , Tw.font_mono
                        ]
                    ]
                    [ Html.code
                        [ classes [ Tw.text_color (T.gray T.s300) ] ]
                        [ Html.span [ classes [ Tw.text_color (T.pink T.s400) ] ] [ Html.text "import " ]
                        , Html.text "Tailwind "
                        , Html.span [ classes [ Tw.text_color (T.pink T.s400) ] ] [ Html.text "as " ]
                        , Html.text "Tw "
                        , Html.span [ classes [ Tw.text_color (T.pink T.s400) ] ] [ Html.text "exposing " ]
                        , Html.text "(classes)\n"
                        , Html.span [ classes [ Tw.text_color (T.pink T.s400) ] ] [ Html.text "import " ]
                        , Html.text "Tailwind.Theme "
                        , Html.span [ classes [ Tw.text_color (T.pink T.s400) ] ] [ Html.text "as " ]
                        , Html.text "T\n"
                        , Html.span [ classes [ Tw.text_color (T.pink T.s400) ] ] [ Html.text "import " ]
                        , Html.text "Tailwind.Breakpoints "
                        , Html.span [ classes [ Tw.text_color (T.pink T.s400) ] ] [ Html.text "as " ]
                        , Html.text "Bp\n\n"
                        , Html.span [ classes [ Tw.text_color (T.sky T.s400) ] ] [ Html.text "button " ]
                        , Html.text "=\n    Html.button\n        [ "
                        , Html.span [ classes [ Tw.text_color (T.yellow T.s300) ] ] [ Html.text "classes" ]
                        , Html.text "\n            [ "
                        , Html.span [ classes [ Tw.text_color (T.green T.s400) ] ] [ Html.text "Tw.px T.s6" ]
                        , Html.text "\n            , "
                        , Html.span [ classes [ Tw.text_color (T.green T.s400) ] ] [ Html.text "Tw.py T.s3" ]
                        , Html.text "\n            , "
                        , Html.span [ classes [ Tw.text_color (T.green T.s400) ] ] [ Html.text "Tw.bg_color (T.indigo T.s600)" ]
                        , Html.text "\n            , "
                        , Html.span [ classes [ Tw.text_color (T.green T.s400) ] ] [ Html.text "Tw.text_simple T.white" ]
                        , Html.text "\n            , "
                        , Html.span [ classes [ Tw.text_color (T.green T.s400) ] ] [ Html.text "Tw.rounded_lg" ]
                        , Html.text "\n            , "
                        , Html.span [ classes [ Tw.text_color (T.purple T.s400) ] ] [ Html.text "Bp.hover" ]
                        , Html.text " [ "
                        , Html.span [ classes [ Tw.text_color (T.green T.s400) ] ] [ Html.text "Tw.bg_color (T.indigo T.s500)" ]
                        , Html.text " ]\n            ]\n        ]\n        [ Html.text "
                        , Html.span [ classes [ Tw.text_color (T.orange T.s300) ] ] [ Html.text "\"Click me\"" ]
                        , Html.text " ]"
                        ]
                    ]
                ]
            ]
        ]



-- INTERACTIVE DEMO


interactiveDemo : Html msg
interactiveDemo =
    Html.section
        [ Attr.id "examples"
        , classes
            [ Tw.py T.s24
            , Tw.bg_color (T.gray T.s50)
            ]
        ]
        [ Html.div
            [ classes (container []) ]
            [ Html.div
                [ classes [ Tw.text_center, Tw.mb T.s16 ] ]
                [ Html.h2
                    [ classes
                        [ Tw.text_sm
                        , Tw.font_semibold
                        , Tw.text_color (T.indigo T.s600)
                        , Tw.uppercase
                        , raw "tracking-wide"
                        ]
                    ]
                    [ Html.text "Live Examples" ]
                , Html.p
                    [ classes
                        [ Tw.mt T.s2
                        , Tw.text_n3xl
                        , Bp.md [ Tw.text_n4xl ]
                        , Tw.font_bold
                        , raw "tracking-tight"
                        , Tw.text_color (T.gray T.s900)
                        ]
                    ]
                    [ Html.text "See It In Action" ]
                , Html.p
                    [ classes
                        [ Tw.mt T.s4
                        , Tw.text_lg
                        , Tw.text_color (T.gray T.s600)
                        ]
                    ]
                    [ Html.text "This entire page is styled using elm-tailwind-classes." ]
                ]
            , Html.div
                [ classes
                    [ Tw.grid
                    , raw "grid-cols-1"
                    , Bp.md [ raw "grid-cols-2" ]
                    , Tw.gap T.s8
                    ]
                ]
                [ demoCard "Buttons with Hover States"
                    [ Html.div
                        [ classes [ Tw.flex, Tw.flex_wrap, Tw.gap T.s3 ] ]
                        [ Html.button
                            [ classes
                                [ Tw.px T.s4
                                , Tw.py T.s2
                                , Tw.bg_color (T.indigo T.s600)
                                , Tw.text_simple T.white
                                , Tw.rounded_lg
                                , Tw.text_sm
                                , Tw.font_semibold
                                , Tw.shadow_sm
                                , Tw.transition
                                , Bp.hover [ Tw.bg_color (T.indigo T.s500) ]
                                ]
                            ]
                            [ Html.text "Primary" ]
                        , Html.button
                            [ classes
                                [ Tw.px T.s4
                                , Tw.py T.s2
                                , Tw.bg_simple T.white
                                , Tw.text_color (T.gray T.s900)
                                , Tw.rounded_lg
                                , Tw.text_sm
                                , Tw.font_semibold
                                , Tw.shadow_sm
                                , raw "ring-1"
                                , raw "ring-gray-300"
                                , Tw.transition
                                , Bp.hover [ Tw.bg_color (T.gray T.s50) ]
                                ]
                            ]
                            [ Html.text "Secondary" ]
                        , Html.button
                            [ classes
                                [ Tw.px T.s4
                                , Tw.py T.s2
                                , Tw.bg_color (T.red T.s600)
                                , Tw.text_simple T.white
                                , Tw.rounded_lg
                                , Tw.text_sm
                                , Tw.font_semibold
                                , Tw.shadow_sm
                                , Tw.transition
                                , Bp.hover [ Tw.bg_color (T.red T.s500) ]
                                ]
                            ]
                            [ Html.text "Danger" ]
                        ]
                    ]
                , demoCard "Typography Scale"
                    [ Html.div
                        [ classes [ Tw.flex, Tw.flex_col, Tw.gap T.s1 ] ]
                        [ Html.span [ classes [ Tw.text_xs, Tw.text_color (T.gray T.s900) ] ] [ Html.text "text_xs - The quick brown fox" ]
                        , Html.span [ classes [ Tw.text_sm, Tw.text_color (T.gray T.s900) ] ] [ Html.text "text_sm - The quick brown fox" ]
                        , Html.span [ classes [ Tw.text_base, Tw.text_color (T.gray T.s900) ] ] [ Html.text "text_base - The quick brown fox" ]
                        , Html.span [ classes [ Tw.text_lg, Tw.text_color (T.gray T.s900) ] ] [ Html.text "text_lg - The quick brown fox" ]
                        , Html.span [ classes [ Tw.text_xl, Tw.text_color (T.gray T.s900) ] ] [ Html.text "text_xl - The quick brown fox" ]
                        ]
                    ]
                , demoCard "Spacing Utilities"
                    [ Html.div [ classes [ Tw.flex, Tw.gap T.s3, Tw.items_end ] ]
                        [ spacingBox T.s2 "s2"
                        , spacingBox T.s4 "s4"
                        , spacingBox T.s6 "s6"
                        , spacingBox T.s8 "s8"
                        , spacingBox T.s10 "s10"
                        , spacingBox T.s12 "s12"
                        ]
                    ]
                ]
            ]
        ]


demoCard : String -> List (Html msg) -> Html msg
demoCard title content =
    Html.div
        [ classes
            [ Tw.bg_simple T.white
            , Tw.rounded_n2xl
            , Tw.p T.s6
            , Tw.shadow_sm
            , raw "ring-1"
            , raw "ring-gray-900/5"
            ]
        ]
        [ Html.h3
            [ classes
                [ Tw.text_sm
                , Tw.font_semibold
                , Tw.text_color (T.gray T.s900)
                , Tw.mb T.s4
                ]
            ]
            [ Html.text title ]
        , Html.div [] content
        ]


spacingBox : T.Spacing -> String -> Html msg
spacingBox spacing label =
    Html.div
        [ classes [ Tw.flex, Tw.flex_col, Tw.items_center, Tw.gap T.s1 ] ]
        [ Html.div
            [ classes
                [ Tw.w spacing
                , Tw.h spacing
                , Tw.bg_color (T.indigo T.s600)
                , Tw.rounded_md
                ]
            ]
            []
        , Html.span
            [ classes
                [ Tw.text_xs
                , Tw.text_color (T.gray T.s500)
                ]
            ]
            [ Html.text label ]
        ]



-- GET STARTED SECTION


getStartedSection : Html msg
getStartedSection =
    Html.section
        [ Attr.id "get-started"
        , classes
            [ Tw.py T.s24
            , Tw.bg_simple T.white
            ]
        ]
        [ Html.div
            [ classes (container []) ]
            [ Html.div
                [ classes [ Tw.text_center, Tw.mb T.s16 ] ]
                [ Html.h2
                    [ classes
                        [ Tw.text_sm
                        , Tw.font_semibold
                        , Tw.text_color (T.indigo T.s600)
                        , Tw.uppercase
                        , raw "tracking-wide"
                        ]
                    ]
                    [ Html.text "Installation" ]
                , Html.p
                    [ classes
                        [ Tw.mt T.s2
                        , Tw.text_n3xl
                        , Bp.md [ Tw.text_n4xl ]
                        , Tw.font_bold
                        , raw "tracking-tight"
                        , Tw.text_color (T.gray T.s900)
                        ]
                    ]
                    [ Html.text "Get Started in Minutes" ]
                , Html.p
                    [ classes
                        [ Tw.mt T.s4
                        , Tw.text_lg
                        , Tw.text_color (T.gray T.s600)
                        ]
                    ]
                    [ Html.text "Add elm-tailwind-classes to your Vite project and start using type-safe Tailwind in your Elm code." ]
                ]
            , Html.div
                [ classes
                    [ Tw.bg_color (T.gray T.s900)
                    , Tw.rounded_xl
                    , Tw.p T.s4
                    , Tw.mb T.s12
                    , raw "max-w-xl"
                    , raw "mx-auto"
                    ]
                ]
                [ Html.code
                    [ classes
                        [ Tw.text_color (T.gray T.s300)
                        , Tw.font_mono
                        , Tw.text_sm
                        ]
                    ]
                    [ Html.span [ classes [ Tw.text_color (T.gray T.s500) ] ] [ Html.text "$ " ]
                    , Html.text "npm install github:dillonkearns/elm-tailwind-classes # install beta"
                    ]
                ]
            , Html.div
                [ classes
                    [ Tw.grid
                    , raw "grid-cols-1"
                    , Bp.md [ raw "grid-cols-3" ]
                    , Tw.gap T.s8
                    , raw "max-w-4xl"
                    , raw "mx-auto"
                    ]
                ]
                [ stepCard 1 "Install" "Add elm-tailwind-classes and @tailwindcss/vite to your project."
                , stepCard 2 "Configure" "Add .elm-tailwind to elm.json sources and add Vite plugins."
                , stepCard 3 "Code" "Import the generated modules and start styling with full type safety."
                ]
            , Html.div
                [ classes [ Tw.text_center, Tw.mt T.s12 ] ]
                [ Html.a
                    [ Attr.href "https://github.com/dillonkearns/elm-tailwind-classes#readme"
                    , Attr.target "_blank"
                    , classes
                        [ Tw.inline_flex
                        , Tw.items_center
                        , Tw.gap T.s2
                        , Tw.bg_color (T.indigo T.s600)
                        , Tw.text_simple T.white
                        , Tw.px T.s6
                        , Tw.py T.s3
                        , Tw.rounded_lg
                        , Tw.font_semibold
                        , Tw.shadow_sm
                        , Tw.transition
                        , Bp.hover [ Tw.bg_color (T.indigo T.s500) ]
                        ]
                    ]
                    [ Html.text "Read the Documentation" ]
                ]
            ]
        ]


stepCard : Int -> String -> String -> Html msg
stepCard number title description =
    Html.div
        [ classes
            [ Tw.relative
            , Tw.text_center
            ]
        ]
        [ Html.div
            [ classes
                [ Tw.w T.s12
                , Tw.h T.s12
                , Tw.rounded_full
                , Tw.bg_color (T.indigo T.s600)
                , Tw.text_simple T.white
                , Tw.flex
                , Tw.items_center
                , Tw.justify_center
                , Tw.font_bold
                , Tw.text_lg
                , raw "mx-auto"
                , Tw.mb T.s4
                ]
            ]
            [ Html.text (String.fromInt number) ]
        , Html.h3
            [ classes
                [ Tw.font_semibold
                , Tw.text_color (T.gray T.s900)
                , Tw.text_lg
                , Tw.mb T.s2
                ]
            ]
            [ Html.text title ]
        , Html.p
            [ classes [ Tw.text_color (T.gray T.s600), Tw.text_sm ] ]
            [ Html.text description ]
        ]
