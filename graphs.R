library(gganimate)

source("data/merge.R")

# Line Race Plot

covid$date <- as.Date(covid$date, format = "%m/%d/%y")

p <-  covid %>% 
    dplyr::filter(place_type == "state" & state == "MG") %>% 
    ggplot(aes(x = date, y = confirmed)) +
    geom_line(color ="blue", size = 1.0) +
    theme_light() +
    geom_text(aes(label = date), color = "green", vjust = -3) +
    geom_text(aes(label = confirmed), color = "darkblue")
    
p

p <- covid %>% 
    dplyr::filter(place_type == "state" & state == "MG") %>% 
    ggplot(aes(x = date, y = confirmed)) +
    geom_line(color ="blue", size = 1.0) +
    geom_point(color = "black", size = 3.0) +
    theme_light() +
    geom_text(aes(label = date), color = "green", vjust = -2) +
    geom_text(aes(label = confirmed), color = "darkblue", vjust = -3) +
    transition_reveal(date)

x <- covid %>%
    filter(place_type == "state" & state == "MG") %>% 
    count()

gganimate::animate(p, fps = 5, nframes = x$n[1], width = 1200, height = 720,
                   renderer = gifski_renderer("teste.gif"))


# Bar Chart Race Plot

covid$newDate <- as.Date(covid$date)

df <- covid %>% 
    dplyr::filter(place_type == "state") %>% 
    group_by(newDate)

View(df)




staticPlot + geom_point(aes(x = confirmed, y = state))

anim = staticPlot + transition_states(date,
                                      transition_length = 1,
                                      state_length = 1)

gganimate::animate(anim, 200, fps = 30, width = 1200, height = 720,
                   renderer = gifski_renderer("gganim.gif"))
