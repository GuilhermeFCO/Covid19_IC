library(gganimate)
library(tidyverse)

source("data/merge.R")

# Static Plot

stateDate <- covid %>% dplyr::filter(place_type == "state") 

colnames(stateDate)[1] <- "DATAS"


str(stateDate)

stateDate <- stateDate %>% 
    dplyr::arrange(DATAS)

View(stateDate)

stateDateLast <- stateDate %>% filter(is_last == "TRUE")

p <- stateDateLast %>% 
    ggplot(aes(y = state, x = confirmed)) +
    geom_col()

p
