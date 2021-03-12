library(shiny)
server <- function(input, output, sesion) {
    
    output$mapBrasil <- plotly::renderPlotly({
        
        if (input$divisaoBrasil == "Regiões") {
            df_mapBrasil <- regionStates
        } else if (input$divisaoBrasil == "Estados") {
            df_mapBrasil <- states
        }
        
        if (input$confirOrDeathBrasil == "Confirmados") {
            df_mapBrasil <-  df_mapBrasil %>% 
                dplyr::rename("variable_mapBrasil" = "confirmed")
            name_mapBrasil <- "Número de Casos Confirmados"
        } else if (input$confirOrDeathBrasil == "Mortes") {
            df_mapBrasil <-  df_mapBrasil %>% 
                dplyr::rename("variable_mapBrasil" = "deaths")
            name_mapBrasil <- "Número de Mortes"
        }
        
        df_mapBrasil %>% 
            ggplot2::ggplot() +
            ggplot2::geom_sf(ggplot2::aes(fill = variable_mapBrasil, geometry = geom),
                             color= NA, size=.15) +
            labs(title = input$confirOrDeathBrasil) +
            scale_fill_distiller(palette = "Oranges",
                                 direction = 1,
                                 limits = c(min(df_mapBrasil$variable_mapBrasil),
                                          max(df_mapBrasil$variable_mapBrasil)),
                                 name = name_mapBrasil) +
            theme_void()
    })
    
    output$graBrasil0 <- plotly::renderPlotly({
        
        df_graBrasil0 <- brasilCovid
        
        if (input$confirOrDeathBrasil == "Confirmados") {
            df_graBrasil0 <-  df_graBrasil0 %>% 
                dplyr::rename("variable_graBrasil0" = "confirmed_per_day")
        } else if (input$confirOrDeathBrasil == "Mortes") {
            df_graBrasil0 <-  df_graBrasil0 %>% 
                dplyr::rename("variable_graBrasil0" = "deaths_per_day")
        }
        
        df_graBrasil0 %>% 
            ggplot2::ggplot(ggplot2::aes(x = date, y = variable_graBrasil0)) +
            ggplot2::geom_line()
    })

    output$graBrasil1 <- plotly::renderPlotly({
        
        df_graBrasil1 <- brasilCovid
        
        if (input$confirOrDeathBrasil == "Confirmados") {
            df_graBrasil1 <-  df_graBrasil1 %>% 
                dplyr::rename("variable_graBrasil1" = "confirmed")
        } else if (input$confirOrDeathBrasil == "Mortes") {
            df_graBrasil1 <-  df_graBrasil1 %>% 
                dplyr::rename("variable_graBrasil1" = "deaths")
        }
        
        df_graBrasil1 %>% 
            ggplot2::ggplot(ggplot2::aes(x = date, y = variable_graBrasil1)) +
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
    
    output$covidDeaths <- renderText({
        
        if (input$tabselectedCovid == 0) {
            df_covidDeathsAux <- brasilCovid
        }
        df_covidDeaths <- df_covidDeathsAux %>% 
            dplyr::filter(is_last == "TRUE") %>% 
            dplyr::select(deaths)
        return(df_covidDeaths[[1]])
    })
    
    output$covidDateDeathsPerDay <- renderText({
        
        if (input$tabselectedCovid == 0) {
            df_covidDateDeathsPerDayAux <- brasilCovid
        }
        df_covidDateDeathsPerDay <- df_covidDateDeathsPerDayAux %>% 
            dplyr::filter(is_last == "TRUE") %>% 
            dplyr::select(date)
        return(df_covidDateDeathsPerDay[[1]])
    })
    
    output$covidDeathsPerDay <- renderText({
        
        if (input$tabselectedCovid == 0) {
            df_covidDeathsPerDayAux <- brasilCovid
        }
        df_covidDeathsPerDay <- df_covidDeathsPerDayAux %>% 
            dplyr::filter(is_last == "TRUE") %>% 
            dplyr::select(deaths_per_day)
        return(df_covidDeathsPerDay[[1]])
    })
}