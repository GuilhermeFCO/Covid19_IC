library(shiny)
server <- function(input, output, sesion) {
    
    output$mapBrasil <- plotly::renderPlotly({
        if (input$divBrasil == "Regiões") {
            dataBrasil <- regionStates
        } else if (input$divBrasil == "Estados") {
            dataBrasil <- states
        } else if (input$divBrasil == "Cidades") {
            dataBrasil <- cities
        } else if (input$divBrasil == "Mesorregiões") {
            dataBrasil <- meso
        } else if (input$divBrasil == "Microrregiões") {
            dataBrasil <- micro
        }
        
        dataBrasil %>% 
            ggplot() +
            geom_sf(aes(fill=confirmed, geometry = geom),
                    color= NA, size=.15) +
            labs(title="Confirmados") +
            scale_fill_distiller(palette = "Oranges",
                                 direction = 1,
                                 limits=c(min(dataBrasil$confirmed),
                                          max(dataBrasil$confirmed)),
                                 name="Número de Casos Confirmados") +
            theme_void()
    })
    
    # output$graBrasil0 <- plotly::plotlyOutput(
    #     
    # )
    # 
    # output$graBrasil1 <- plotly::plotlyOutput(
    #     
    # )
}