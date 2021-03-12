library(shiny)
server <- function(input, output, sesion) {
    
    output$mapBrasil <- plotly::renderPlotly({
        if (input$divisaoBrasil == "Regiões") {
            df_mapBrasil <- regionStates
        } else if (input$divisaoBrasil == "Estados") {
            df_mapBrasil <- states
        }
        
        df_mapBrasil %>% 
            ggplot2::ggplot() +
            ggplot2::geom_sf(ggplot2::aes(fill=confirmed, geometry = geom),
                             color= NA, size=.15) +
            labs(title="Confirmados") +
            scale_fill_distiller(palette = "Oranges",
                                 direction = 1,
                                 limits=c(min(df_mapBrasil$confirmed),
                                          max(df_mapBrasil$confirmed)),
                                 name="Número de Casos Confirmados") +
            theme_void()
    })
    
    output$graBrasil0 <- plotly::renderPlotly({
        brasilCovid %>% 
            ggplot2::ggplot(ggplot2::aes(x = date, y = confirmed_per_day)) +
            ggplot2::geom_line()
    })

    output$graBrasil1 <- plotly::renderPlotly({
        brasilCovid %>% 
            ggplot2::ggplot(ggplot2::aes(x = date, y = confirmed)) +
            ggplot2::geom_line()
    })
    
    output$covidConfirmed <- renderText({
        if (input$tabselectedCovid == 0) {
            df_covidConfirmedAux <- brasilCovid
        }
        df_covidConfirmed <- df_covidConfirmedAux %>% 
            dplyr::filter(is_last == "TRUE") %>% 
            dplyr::select(confirmed)
        return(df_covidConfirmed[[1]])
    })
    
    output$covidDateConfirmedPerDay <- renderText({
        if (input$tabselectedCovid == 0) {
            df_covidDateConfirmedPerDayAux <- brasilCovid
        }
        df_covidDateConfirmedPerDay <- df_covidDateConfirmedPerDayAux %>% 
            dplyr::filter(is_last == "TRUE") %>% 
            dplyr::select(date)
        return(df_covidDateConfirmedPerDay[[1]])
    })
    
    output$covidConfirmedPerDay <- renderText({
        if (input$tabselectedCovid == 0) {
            df_covidConfirmedPerDayAux <- brasilCovid
        }
        df_covidConfirmedPerDay <- df_covidConfirmedPerDayAux %>% 
            dplyr::filter(is_last == "TRUE") %>% 
            dplyr::select(confirmed_per_day)
        return(df_covidConfirmedPerDay[[1]])
    })
}