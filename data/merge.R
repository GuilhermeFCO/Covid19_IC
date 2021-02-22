library(data.table)
library(tidyverse)
#-------------------------------------------------------------------------------
source("data/brasil_io.R")
source("data/idhAtlas.R")

covidIDH <- merge.data.frame(covid, mun_uf_IDH2010)

covidIDH_last <- covidIDH %>% 
    dplyr::filter(is_last == "TRUE")
covidIDH_last$is_last <- NULL

rm("mun_uf_IDH2010", "covid")

source("data/maps.R")