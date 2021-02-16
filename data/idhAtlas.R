library(utils)
if (!(file.exists("data/Atlas.xlsx"))) {
    url <- "https://github.com/GuilhermeFCO/downloadCensoBR/raw/main/Atlas.zip"
    utils::download.file(url, "data/Atlas.zip")
    utils::unzip("data/Atlas.zip", exdir = "data")
    file.remove("data/Atlas.zip")
    rm(list=ls())
}