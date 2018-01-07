#Bar Graphs 
library(ggplot2)

bike <- read.csv("../data/tema7/daily-bike-rentals.csv")
bike$season <- factor(bike$season, 
                      levels = c(1,2,3,4),
                      labels = c("Invierno", "Primavera", "Verano", "Otoño"))
bike$workingday <- factor(bike$workingday,
                          levels = c(0,1),
                          labels = c("Día libre", "Día de trabajo"))
bike$weathersit <- factor(bike$weathersit,
                          levels = c(1,2,3),
                          labels = c("Buen tiempo", "Día nublado", "Mal tiempo"))

library(dplyr)
bike.sum = bike %>%
  group_by(season, workingday) %>%
  summarize(reantal = sum(cnt))

bike.sum

ggplot(bike.sum, aes(x = season, y = reantal, 
                     fill = workingday, label = scales::comma(reantal))) +
  geom_bar(show.legend = T, stat = "identity", fill="lightblue", colour = "black") + 
  labs(title = "Alquileres de bicicletas por estación y día") +
  scale_y_continuous(labels = scales::comma) +
  geom_text(size = 3, position = position_stack(vjust = 0.5))
