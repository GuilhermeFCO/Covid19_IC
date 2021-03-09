library(shiny)
library(leaflet)
library(tidyverse)

l <- ls()
f <- "n"
for(i in 1:length(l)){
    if(length(l) == 0)
        break
    else
        if (l[i] == "cities") {
            f <- "y"
        }
}
if (f == "n") 
    source("data/merge.R")
