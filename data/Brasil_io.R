temp <- data.table::fread("data/date.csv")
date <- temp$Date1
if ((lubridate::hour(Sys.time()) >= 8 & Sys.Date() > date) | file.exists("data/dataCovidBR.csv") == FALSE) {
    if (file.exists("data/dataCovidBR.csv")) {
        file.remove("data/dataCovidBR.csv")
    }
    temp$Date1 = Sys.Date()
    data.table::fwrite(temp, file = "data/date.csv")
    url <- "https://data.brasil.io/dataset/covid19/caso.csv.gz"
    download.file(url, "data/dataCovidBR.csv.gz")
    R.utils::gunzip("data/dataCovidBR.csv.gz", remove = TRUE)
}
rm(list = ls())