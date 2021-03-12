library(geobr)
library(tidyverse)

muni <- geobr::lookup_muni(name_muni = "all")
muni$city_ibge_code <- muni$code_muni

muni <- muni %>% 
    dplyr::rename("abbrev_state" = "abrev_state")

states <- geobr::read_state(code_state = "all", year = 2019)
regionStates <- states

dfRegions <- states %>% 
    dplyr::select(state = abbrev_state, code_region, name_region)
dfRegions$geom <- NULL

covidIDH_last <- dplyr::inner_join(x = covidIDH_last, y = dfRegions, by = "state")

covidIDH <- dplyr::inner_join(x = covidIDH, y = dfRegions, by = "state")

rm("dfRegions")

cityIDH_last <- dplyr::inner_join(covidIDH_last, muni, by = "city_ibge_code")
cityIDH_last$place_type <- NULL

covidIDHState <- covidIDH %>% 
    dplyr::filter(place_type == "state")
covidIDHState$city <- NULL
covidIDHState$place_type <- NULL

covidIDHCity <- covidIDH %>% 
    dplyr::filter(place_type == "city")
covidIDHCity$place_type <- NULL

rm("covidIDH")

covidIDHCity <- full_join(covidIDHCity, muni, by = "city_ibge_code")

rm("muni")
rm("covidIDH_last")

stateIDH_last <- covidIDHState %>% 
    filter(is_last == "TRUE")
stateIDH_last$is_last <- NULL 

dfCitylast <- cityIDH_last %>% 
    select(state, code_state, abbrev_state, name_state)

dfCitylast <- subset(dfCitylast, !duplicated(subset(dfCitylast, select = state)))

stateIDH_last <- dplyr::inner_join(stateIDH_last, dfCitylast, by = "state")

covidIDHState <- dplyr::inner_join(covidIDHState, dfCitylast, by = "state")

rm("dfCitylast")


# ---------------------------------------------------------------------------- #

states$corr <- 1

i <- NULL
for (i in 1:nrow(states)) {
    df <- NULL
    df <- cityIDH_last %>% 
        dplyr::filter(code_state == states$code_state[i])
    states$corr[[i]] <- stats::cor(df$death_rate, df$IDHM)
}
rm("df")

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
        dplyr::filter(code_region == regionStates$code_region[i])
    regionStates$corr[[i]] <- stats::cor(df$death_rate, df$IDHM)   
}
rm("df")

# ---------------------------------------------------------------------------- #

meso <- geobr::read_meso_region(code_meso = "all", year = 2019)
meso$corr <- 1


dfCity <- cityIDH_last %>% 
    select(code_meso, abbrev_state, code_state, code_region, name_region)

dfCity <- subset(dfCity, !duplicated(subset(dfCity, select = code_meso)))

meso <- dplyr::full_join(meso, dfCity, by = "code_meso")

i <- NULL
for (i in 1:nrow(meso)) {
    df <- NULL
    df <- cityIDH_last %>% 
        dplyr::filter(code_meso == meso$code_meso[i])
    meso$corr[[i]] <- stats::cor(df$death_rate, df$IDHM)
}
rm("df")
rm("dfCity")

# ---------------------------------------------------------------------------- #

micro <- geobr::read_micro_region(code_micro = "all", year = 2019)
micro <- micro %>% 
    dplyr::rename("abbrev_state" = "abrev_state")
micro$corr <- 1

dfCity <- cityIDH_last %>% 
    dplyr::select(code_micro ,code_state, code_meso, name_meso, code_region, name_region)

dfCity <- subset(dfCity, !duplicated(subset(dfCity, select = "code_micro")))

micro <- dplyr::full_join(micro, dfCity, by = "code_micro")

i <- NULL
for (i in 1:nrow(micro)) {
    df <- NULL
    df <- cityIDH_last %>% 
        dplyr::filter(code_micro == micro$code_micro[i])
    micro$corr[[i]] <- stats::cor(df$death_rate, df$IDHM)
}
rm("df")
rm("dfCity")

# ---------------------------------------------------------------------------- #

cities <- geobr::read_municipality(code_muni = "all", year = 2019)
cities <- cities %>% 
    dplyr::select(code_muni, geom) %>% 
    dplyr::rename("city_ibge_code" = "code_muni")

cities <- dplyr::full_join(cityIDH_last, cities, by = "city_ibge_code")

# ---------------------------------------------------------------------------- #

rm(i)