library(tidyverse)
library(stats)
library(plotly)
#------------------------------------------------------------------------------#
source("data/merge.R")
#------------------------------------------------------------------------------#
# Corr Maps  ------------------------------------------------------------------#

data <- meso %>% filter(abbrev_state == "MG")
p <-  ggplot(data = data) +
     geom_sf(aes(fill=corr, geometry = geom), 
             color= NA, size=.15) +
     labs(title="Correlação dos Estados do Brasil") +
     scale_fill_distiller(palette = "Reds",
                          direction = -1,
                          limits=c(min(data$corr),
                                   max(data$corr)),
                          name="Corr") +
     theme_void()
plotly::ggplotly(p)

# IDH MAPS ====================================================================#

data <- states
ggplot(data = data) +
    geom_sf(aes(fill=death_rate, geometry = geom), color= NA, size=.15) +
    labs(title="IDH dos Estados do Brasil") +
    # scale_fill_distiller(palette = "Blues",
    #                      direction = 1,
    #                      limits=c(min(data$death_rate),max(data$death_rate)),
    #                      name="IDH") +
    theme_void()

#------------------------------------------------------------------------------#


# corr ------------------------------------------------------------------------#

states_IDH_maps <- covid_IDH_Maps %>% 
    dplyr::filter(place_type == "state")
states_IDH_maps$corr <- 1

for (i in 1:nrow(states_IDH_maps)) {
    df <- NULL
    df <- covidIDH_last %>% 
        dplyr::filter(place_type == "city", state == states_IDH_maps$state[i])
    correlation <- NULL
    correlation <- stats::cor(df$death_rate, df$IDHM)
    states_IDH_maps$corr[[i]] <- correlation
}
rm("df", "correlation", "i")


ggplot(data = states_IDH_maps) +
    geom_sf(data = states_IDH_maps, aes(fill=corr, geometry = geom), 
            color= NA, size=.15) +
    labs(title="Correlação dos Estados do Brasil") +
    scale_fill_distiller(palette = "Reds",
                         direction = 1,
                         limits=c(min(states_IDH_maps$corr),
                                  max(states_IDH_maps$corr)),
                         name="Corr") +
    theme_void()

#------------------------------------------------------------------------------#

