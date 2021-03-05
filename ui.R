ui <- navbarPage("Covid-19 no Brasil",
    tabPanel("Descrição",
        
    ),
    tabPanel("Covid",
        sidebarLayout(
            tags$div(style = "width: 1200px;",
                sidebarPanel(
                    width = 4
                )
            ),
            mainPanel(
                fluidPage(
                    fluidRow(
                        column(10,
                            tabsetPanel(
                                tabPanel("Regiões"),
                                tabPanel("Estados"),
                                tabPanel("Cidades"),
                                tabPanel("Mesorregiões"),
                                tabPanel("Microrregiões")
                            )
                        ),
                        column(2,
                            tags$h1("TESTE")
                        )
                    )
                )
            )
        )
    ),
    tabPanel("IDH",
        sidebarLayout(
            tags$div(style = "width: 1200px;",
                     sidebarPanel(
                         width = 4
                     )
            ),
            mainPanel(
                fluidPage(
                    fluidRow(
                        column(10,
                               tabsetPanel(
                                   tabPanel("Regiões"),
                                   tabPanel("Estados"),
                                   tabPanel("Cidades"),
                                   tabPanel("Mesorregiões"),
                                   tabPanel("Microrregiões")
                               )
                        ),
                        column(2,
                               tags$h1("TESTE")
                        )
                    )
                )
            )
        )
    ),
    tabPanel("Correlação",
        sidebarLayout(
            tags$div(style = "width: 1200px;",
                     sidebarPanel(
                         width = 4
                     )
            ),
            mainPanel(
                fluidPage(
                    fluidRow(
                        column(10,
                               tabsetPanel(
                                   tabPanel("Estados"),
                                   tabPanel("Cidades"),
                                   tabPanel("Mesorregiões"),
                                   tabPanel("Microrregiões")
                               )
                        ),
                        column(2,
                               tags$h1("TESTE")
                        )
                    )
                )
            )
        )
    )
)