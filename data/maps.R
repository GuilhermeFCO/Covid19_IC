library(geobr)
library(tidyverse)

# View(list_geobr())

muni <- geobr::lookup_muni(name_muni = "all")
muni$city_ibge_code <- muni$code_muni

states <- geobr::read_state(code_state = "all", year = 2019)
regionStates <- states

i <- NULL
j <- NULL
covidIDH_last$code_region_state <- 0
covidIDH_last$name_region_state <- "A"
for (i in 1:nrow(covidIDH_last))

cityIDH_last <- merge.data.frame(covidIDH_last, muni)
cityIDH_last$place_type <- NULL
rm("muni")
cityIDH_last <- cityIDH_last %>% 
    dplyr::rename("abbrev_state" = "abrev_state")

stateIDH_last <- covidIDH_last %>% 
    filter(place_type == "state")
stateIDH_last$city <- NULL
stateIDH_last$place_type <- NULL
stateIDH_last$code_state <- 0
stateIDH_last$abbrev_state <- "A"
stateIDH_last$name_state <- "A"

i <- NULL
j <- NULL
for (i in 1:nrow(stateIDH_last)) {
    for (j in 1:nrow(cityIDH_last)) {
        if (stateIDH_last$city_ibge_code[i] == cityIDH_last$code_state[j]) {
            stateIDH_last$code_state[[i]] <- cityIDH_last$code_state[[j]]
            stateIDH_last$abbrev_state[[i]] <- cityIDH_last$abbrev_state[[j]]
            stateIDH_last$name_state[[i]] <- cityIDH_last$name_state[[j]]
            break
        }        
    }
}

# ---------------------------------------------------------------------------- #

states$corr <- 1

i <- NULL
for (i in 1:nrow(states)) {
    df <- NULL
    df <- cityIDH_last %>% 
        dplyr::filter(code_state == states$code_state[i])
    states$corr[[i]] <- stats::cor(df$death_rate, df$IDHM)
}

states <- states %>% 
    dplyr::select(code_state, geom, corr) %>% 
    dplyr::rename("city_ibge_code" = "code_state")

states <- merge.data.frame(stateIDH_last, states)

# ---------------------------------------------------------------------------- #

regionStates$corr <- 1

i <- NULL
for (i in 1:nrow(regionStates)) {
    df <- NULL
    df <- cityIDH_last %>% 
        dplyr::filter(code_region_state == regionStates$code_region[i])
    regionStates$corr[[i]] <- stats::cor(df$death_rate, df$IDHM)   
}

# ---------------------------------------------------------------------------- #

meso <- geobr::read_meso_region(code_meso = "all", year = 2019)
meso$abbrev_state <- "A"
meso$code_state <- 0
meso$code_region_state <- 0
meso$name_region_state <- "A"
meso$corr <- 1

i <- NULL
j <- NULL
for (i in 1:nrow(meso)) {
    for (j in 1:nrow(cityIDH_last)) {
        if (meso$code_meso[i] == cityIDH_last$code_meso[j]) {
            meso$abbrev_state[[i]] <- cityIDH_last$abbrev_state[[j]]
            meso$code_state[[i]] <- cityIDH_last$code_state[[j]]
            meso$code_region_state[[i]] <- cityIDH_last$code_region_state[[j]]
            meso$name_region_state[[i]] <- cityIDH_last$name_region_state[[j]]
            break
        }
    }
}

i <- NULL
for (i in 1:nrow(meso)) {
    df <- NULL
    df <- cityIDH_last %>% 
        dplyr::filter(code_meso == meso$code_meso[i])
    meso$corr[[i]] <- stats::cor(df$death_rate, df$IDHM)
}

# ---------------------------------------------------------------------------- #

micro <- geobr::read_micro_region(code_micro = "all", year = 2019)
micro <- micro %>% 
    dplyr::rename("abbrev_state" = "abrev_state")
micro$code_state <- 0
micro$code_meso <- 0
micro$name_meso <- "A"
micro$code_region_state <- 0
micro$name_region_state <- "A"
micro$corr <- 1

i <- NULL
j <- NULL
for (i in 1:nrow(micro)) {
    for (j in 1:nrow(cityIDH_last)) {
        if (micro$code_micro[i] == cityIDH_last$code_micro[j]) {
            micro$code_state[[i]] <- cityIDH_last$code_state[[j]]
            micro$code_meso[[i]] <- cityIDH_last$code_meso[[j]]
            micro$name_meso[[i]] <- cityIDH_last$name_meso[[j]]
            micro$code_region_state[[i]] <- cityIDH_last$code_region_state[[j]]
            micro$name_region_state[[i]] <- cityIDH_last$name_region_state[[j]]
            break
        }
    }
}

i <- NULL
for (i in 1:nrow(micro)) {
    df <- NULL
    df <- cityIDH_last %>% 
        dplyr::filter(code_micro == micro$code_micro[i])
    micro$corr[[i]] <- stats::cor(df$death_rate, df$IDHM)
}

# ---------------------------------------------------------------------------- #

cities <- geobr::read_municipality(code_muni = "all", year = 2019)
cities <- cities %>% 
    dplyr::select(code_muni, geom) %>% 
    dplyr::rename("city_ibge_code" = "code_muni")

cities <- merge.data.frame(cityIDH_last, cities)

# ---------------------------------------------------------------------------- #

rm(df, i, j)