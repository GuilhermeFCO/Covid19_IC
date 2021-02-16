library(geobr)
library(tidyverse)
mapsState <- geobr::read_state()
mapsState <- mapsState %>% dplyr::rename("city_ibge_code" = "code_state")
mapsState$name_state <- NULL
mapsState$code_region <- NULL
mapsCity <- geobr::read_municipality()
mapsCity <- mapsCity %>% dplyr::rename("city_ibge_code" = "code_muni")
mapsCity$name_muni <- NULL
mapsCity$code_state <- NULL
mapsCity$name_region <- c(1:nrow(mapsCity))
for (i in 1:nrow(mapsCity)) {
    for (j in 1:nrow(mapsState)) {
        if (mapsCity$abbrev_state[i] == mapsState$abbrev_state[j]) {
            mapsCity$name_region[i] <- mapsState$name_region[j]
        }
    }
}
maps <- dplyr::bind_rows(mapsCity, mapsState)
rm("mapsCity", "mapsState", "i", "j")