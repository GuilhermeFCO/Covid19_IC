library(data.table)
library(R.utils)
library(lubridate)
library(utils)

temp <- data.table::fread("data/date.csv")
date <- temp$Date1
if ((lubridate::hour(Sys.time()) >= 8 & Sys.Date() > date) | file.exists("data/dataCovidBR.csv") == FALSE) {
    if (file.exists("data/dataCovidBR.csv")) {
        file.remove("data/dataCovidBR.csv")
    }
    temp$Date1 = Sys.Date()
    data.table::fwrite(temp, file = "data/date.csv")
    url <- "https://data.brasil.io/dataset/covid19/caso.csv.gz"
    utils::download.file(url, "data/dataCovidBR.csv.gz")
    R.utils::gunzip("data/dataCovidBR.csv.gz", remove = TRUE)
}
l <- ls()
i <- NULL
for (i in 1:length(l)) {
    if(l[[i]] == "mun_uf_IDH2010") {
        l <- l[-i]
        break
    }
}
rm(list = l, "l", "i")

covid <- data.table::fread("data/dataCovidBR.csv", encoding = "UTF-8")