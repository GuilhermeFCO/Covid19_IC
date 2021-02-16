library(readxl)
library(data.table)
library(tidyverse)
#-------------------------------------------------------------------------------
source("data/brasil_io.R")
source("data/idhAtlas.R")
source("data/maps.R")
#-------------------------------------------------------------------------------

covid <- data.table::fread("data/dataCovidBR.csv", encoding = "UTF-8")
munAtlas <- readxl::read_xlsx("data/Atlas.xlsx", sheet = 2)
ufAtlas <- readxl::read_xlsx("data/Atlas.xlsx", sheet = 3)
BRAtlas <- readxl::read_xlsx("data/Atlas.xlsx", sheet = 4)


ufIDH10 <- ufAtlas %>% 
    dplyr::filter(ANO == "2010") %>% 
    dplyr::select(UF, IDHM, IDHM_E, IDHM_L, IDHM_R, ANO)
names(ufIDH10)[1] <- "city_ibge_code"
names(ufIDH10)[6] <- "ANO_IDH"

munIDH2010 <- munAtlas %>% 
    dplyr::filter(ANO == "2010") %>% 
    dplyr::select(Codmun7, IDHM, IDHM_E, IDHM_L, IDHM_R, ANO)
names(munIDH2010)[1] <- "city_ibge_code"
names(munIDH2010)[6] <- "ANO_IDH"

mun_uf_IDH2010 <- dplyr::bind_rows(munIDH2010, ufIDH10)


covidIDH <- merge(covid, mun_uf_IDH2010)

covidIDH_last <- covidIDH %>% 
    dplyr::filter(is_last == "TRUE")


covid_IDH_Maps <- merge(covidIDH_last, maps)


l <- NULL
l <-  ls()
i <- NULL
for (i in 1:length(l)) {
    if (l[[i]] == "covid_IDH_Maps") {
        l <- l[-i]
        break
    }
}
for (i in 1:length(l)) {
    if (l[[i]] == "covidIDH") {
        l <- l[-i]
        break
    }
}
for (i in 1:length(l)) {
    if (l[[i]] == "covidIDH_last") {
        l <- l[-i]
        break
    }
}
rm("i")
rm(list = l)