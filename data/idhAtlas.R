if (!(file.exists("data/Atlas.xlsx"))) {
    url <- "https://github.com/GuilhermeFCO/downloadCensoBR/raw/main/Atlas.zip"
    download.file(url, "data/Atlas.zip")
    unzip("data/Atlas.zip", exdir = "data")
    file.remove("data/Atlas.zip")
    rm(list=ls())
}