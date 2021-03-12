library(shiny)
library(plotly)

ui <- fluidPage(includeCSS("styles/style.css"), 
navbarPage("Covid-19 no Brasil",
    tabPanel("Descrição"),
    tabPanel("Covid",
        sidebarLayout(
            tags$div(style = "width: 1200px;",
            sidebarPanel(
                conditionalPanel(condition = "input.tabselectedCovid == 0",
                    selectInput(
                        inputId = "divisaoBrasil",
                        label = "Divisão por:",
                        choices = c("Regiões",
                                    "Estados"),
                        selected = "Estados",
                        selectize = TRUE
                    ),
                    radioButtons(
                        inputId = "confirOrDeathBrasil",
                        label = "",
                        choices = c("Confirmados",
                                    "Mortes"),
                        inline = TRUE
                    )
                ),
                conditionalPanel(condition = "input.tabselectedCovid == 1",
                                 h1("TESTE1")
                ),
                conditionalPanel(condition = "input.tabselectedCovid == 2",
                                 h1("TESTE2")
                ),
                conditionalPanel(condition = "input.tabselectedCovid == 3",
                                 h1("TESTE3")
                ),
                conditionalPanel(condition = "input.tabselectedCovid == 4",
                                 h1("TESTE4")
                ),
                conditionalPanel(condition = "input.tabselectedCovid == 5",
                                 h1("TESTE5")
                )
            )),
            mainPanel(
                fluidPage(
                    fluidRow(
                        column(10,
                            tabsetPanel(id = "tabselectedCovid",
                                tabPanel("Brasil", value = 0,
                                     fluidRow(
                                        column(10,
                                            plotly::plotlyOutput(
                                                outputId = "mapBrasil"
                                            )
                                        )    
                                     ),
                                     fluidRow(
                                         column(5,
                                             plotly::plotlyOutput(
                                                 outputId = "graBrasil0",
                                                 width = 300
                                             )
                                         ),
                                         column(5,
                                             plotly::plotlyOutput(
                                                 outputId = "graBrasil1",
                                                 width = 300
                                             )
                                         )
                                     )
                                ),
                                tabPanel("Regiões", value = 1),
                                tabPanel("Estados", value = 2),
                                tabPanel("Cidades", value = 3),
                                tabPanel("Mesorregiões", value = 4),
                                tabPanel("Microrregiões", value = 5)
                            )
                        ),
                        column(2,
                            tags$div(
                                tags$div(id = "box1",
                                    tags$div(id = "boxTitle",
                                             "Numero de Confirmados Total"
                                    ),
                                    tags$br(),
                                    tags$div(id = "numberBox",
                                             textOutput(
                                                 outputId = "covidConfirmed"
                                             )
                                    )
                                ),
                                tags$div(id = "box1",
                                         tags$div(id = "boxTitle",
                                                  "Número de casos confirmados na data ",
                                                  textOutput(
                                                      outputId = "covidDateConfirmedPerDay"
                                                  )
                                                  
                                         ),
                                         tags$br(),
                                         tags$div(id = "numberBox",
                                                  textOutput(
                                                      outputId = "covidConfirmedPerDay"
                                                  )
                                         )
                                ),
                                tags$div(id = "box1",
                                         tags$div(id = "boxTitle",
                                                  "Confirmados"
                                         ),
                                         tags$br(),
                                         tags$div(id = "numberBox",
                                                  "9 567 998"
                                         )
                                ),
                                tags$div(id = "box1",
                                         tags$div(id = "boxTitle",
                                                  "Confirmados"
                                         ),
                                         tags$br(),
                                         tags$div(id = "numberBox",
                                                  "9 567 998"
                                         )
                                )
                            )
                        )
                    )
                )
            )
        )
    ),
    tabPanel("IDH"),
    tabPanel("Correlação")
))