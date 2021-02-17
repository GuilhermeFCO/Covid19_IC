library(tidyverse)
library(stats)
#------------------------------------------------------------------------------#
source("data/merge.R")
#------------------------------------------------------------------------------#
# Teste Mapa ------------------------------------------------------------------#


teste <- covid_IDH_Maps %>% 
    dplyr::filter(place_type == "city", state == "MG")

ggplot(data = teste) +
    geom_sf(data = teste, aes(fill=corr, geometry = geom), color= NA, size=.15) +
    labs(title="IDH dos Municipíos de MG") +
    scale_fill_distiller(palette = "Reds",
                         direction = 1,
                         limits=c(min(teste$corr),max(teste$corr)),
                         name="IDH")  +
    theme_void()

#==============================================================================#

teste2 <- covid_IDH_Maps %>% 
    dplyr::filter(place_type == "state")

ggplot(data = teste2) +
    geom_sf(data = teste2, aes(fill=IDHM, geometry = geom), color= NA, size=.15) +
    labs(title="IDH dos Estados do Brasil") +
    scale_fill_distiller(palette = "Blues",
                         direction = 1,
                         limits=c(min(teste2$IDHM),max(teste2$IDHM)),
                         name="IDH") +
    theme_void()

#------------------------------------------------------------------------------#
# Regressão Linear ------------------------------------------------------------#

city_covid <- covidIDH_last %>% 
    dplyr::filter(place_type == "city")

fitCity0 <- stats::lm(confirmed ~ estimated_population_2019 +
                     IDHM + IDHM_E + IDHM_L + IDHM_R, data = city_covid)
summary(fitCity0)

fitCity1 <- stats::lm(confirmed ~ estimated_population_2019, data = city_covid)
summary(fitCity1)

fitCity2 <- stats::lm(confirmed ~ IDHM, data = city_covid)
summary(fitCity2)

fitCity3 <- stats::lm(confirmed ~ estimated_population_2019 + IDHM, data = city_covid)
summary(fitCity3)

#==============================================================================#

state_covid <- covidIDH_last %>% 
    dplyr::filter(place_type == "state")

fitState0 <- stats::lm(confirmed ~ estimated_population_2019 +
                          IDHM + IDHM_E + IDHM_L + IDHM_R, data = state_covid)
summary(fitState0)

fitState1 <- stats::lm(confirmed ~ estimated_population_2019, data = state_covid)
summary(fitState1)

fitState2 <- stats::lm(confirmed ~ IDHM, data = state_covid)
summary(fitState2)

fitState3 <- stats::lm(confirmed ~ estimated_population_2019 + 
                           IDHM, data = state_covid)
summary(fitState3)

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

