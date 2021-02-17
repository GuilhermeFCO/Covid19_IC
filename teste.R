library(geobr)
library(tidyverse)

df <- geobr::read_meso_region(code_meso = "MG", year = 2010)

mg <- covid_IDH_Maps %>% filter(state == "MG")


bh <- geobr::lookup_muni(code_muni = "all")
