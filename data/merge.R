library(data.table)
library(tidyverse)
#-------------------------------------------------------------------------------
source("data/brasil_io.R")
source("data/idhAtlas.R")

covidIDH <- dplyr::full_join(covid, mun_uf_IDH2010, by = "city_ibge_code")

covidIDH_last <- covidIDH %>% 
    dplyr::filter(is_last == "TRUE")
covidIDH_last$is_last <- NULL

rm("mun_uf_IDH2010", "covid")

source("data/maps.R")

dates <- subset(x = covidIDHState,
                subset = !duplicated(subset(covidIDHState, select = "date")),
                select = c(date, is_last))
dates <- dates %>% 
    dplyr::arrange(desc(date))

i <- NULL
df <- NULL
for (i in 1:nrow(dates)) {
    df <- covidIDHState %>% 
        filter(date == dates$date[[i]])
    if(i == 1) {
        brasilCovid <- data.frame(date = dates$date[[i]], 
                                  confirmed = sum(df$confirmed),
                                  is_last = dates$is_last[[i]],
                                  deaths = sum(df$deaths),
                                  confirmed_per_100k_inhabitants = sum(df$confirmed_per_100k_inhabitants),
                                  death_rate = sum(df$death_rate))
    } else {
        dx <- NULL
        dx <- data.frame(date = dates$date[[i]], 
                         confirmed = sum(df$confirmed),
                         is_last = dates$is_last[[i]],
                         deaths = sum(df$deaths),
                         confirmed_per_100k_inhabitants = sum(df$confirmed_per_100k_inhabitants),
                         death_rate = sum(df$death_rate))
        brasilCovid <- dplyr::bind_rows(brasilCovid, dx)
    }
}
rm(i, df, dx)

brasilCovid <- brasilCovid %>% 
    dplyr::arrange(desc(date))
brasilCovid$confirmed_per_day <- 0
brasilCovid$deaths_per_day <- 0

i <- NULL
for (i in 1:nrow(brasilCovid)) {
    if(i != nrow(brasilCovid)) {
        brasilCovid$confirmed_per_day[[i]] <- brasilCovid$confirmed[[i]] - brasilCovid$confirmed[[(i+1)]]
        brasilCovid$deaths_per_day[[i]] <- brasilCovid$deaths[[i]] - brasilCovid$deaths[[(i+1)]]
    } else {
        brasilCovid$deaths_per_day[[i]] <- brasilCovid$deaths[[i]]
    }
}
rm(i)