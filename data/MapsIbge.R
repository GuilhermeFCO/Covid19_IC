if (!(file.exists("data/maps/UF/BR_UF_2019.cpg")) |
    !(file.exists("data/maps/UF/BR_UF_2019.dbf")) |
    !(file.exists("data/maps/UF/BR_UF_2019.prj")) |
    !(file.exists("data/maps/UF/BR_UF_2019.shp")) |
    !(file.exists("data/maps/UF/BR_UF_2019.shx")) ) {
    url <- "https://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2019/Brasil/BR/br_unidades_da_federacao.zip"
    download.file(url, "data/maps/UF/UF.zip")
    unzip("data/maps/UF/UF.zip", exdir = "data/maps/UF")
    file.remove("data/maps/UF/UF.zip")
    rm(list=ls())
}
if (!(file.exists("data/maps/MUN/BR_Municipios_2019.cpg")) |
    !(file.exists("data/maps/MUN/BR_Municipios_2019.dbf")) |
    !(file.exists("data/maps/MUN/BR_Municipios_2019.prj")) |
    !(file.exists("data/maps/MUN/BR_Municipios_2019.sbn")) |
    !(file.exists("data/maps/MUN/BR_Municipios_2019.sbx")) |
    !(file.exists("data/maps/MUN/BR_Municipios_2019.shp")) |
    !(file.exists("data/maps/MUN/BR_Municipios_2019.shx")) ) {
    url <- "https://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_municipais/municipio_2019/Brasil/BR/br_municipios_20200807.zip"
    download.file(url, "data/maps/MUN/MUN.zip")
    unzip("data/maps/MUN/MUN.zip", exdir = "data/maps/MUN")
    file.remove("data/maps/MUN/MUN.zip")
    rm(list=ls())
}