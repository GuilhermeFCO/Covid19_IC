library(readxl)
library(data.table)
library(R.utils)
library(tidyverse)
library(rgdal)
library(raster)

source("data/brasil_io.R")
source("data/mapsIbge.R")
source("data/idhAtlas.R")

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


shpUF <- rgdal::readOGR("data/maps/UF", 
                        "BR_UF_2019",
                        stringsAsFactors = FALSE,
                        encoding = "UTF-8")
shpUF@data$CD_UF <- as.numeric(shpUF@data$CD_UF)
Encoding(shpUF@data$NM_UF) <- "UTF-8"
names(shpUF@data)[1] <- "city_ibge_code"
names(shpUF@data)[2] <- "Name"
proj4string(shpUF) <- CRS("+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs'")


shpMUN <- rgdal::readOGR("data/maps/MUN",
                         "BR_Municipios_2019",
                         stringsAsFactors = FALSE,
                         encoding = "UTF-8")
shpMUN@data$CD_MUN <- as.numeric(shpMUN@data$CD_MUN)
Encoding(shpMUN@data$NM_MUN) <- "UTF-8"
names(shpMUN@data)[1] <- "city_ibge_code"
names(shpMUN@data)[2] <- "Name"
proj4string(shpMUN) <- CRS("+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +no_defs'")



shpBR <- raster::bind(shpMUN, shpUF)

covid_IDH_IBGE <- merge(shpBR, 
                        covidIDH %>% filter(is_last == "TRUE"))


cityCovidIDH_Last <- covidIDH %>% 
    dplyr::filter(place_type == "city") %>% 
    dplyr::filter(is_last == "TRUE")
stateCovidIDH_Last <- covidIDH %>% 
    dplyr::filter(place_type == "state") %>% 
    dplyr::filter(is_last == "TRUE")