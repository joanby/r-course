#distribution plots
library(ggplot2)

geiser <- read.csv("../data/tema7/geiser.csv")
head(geiser)

plot <- ggplot(geiser, aes(x=waiting))
plot + geom_histogram()
plot + geom_histogram(binwidth = 5, 
                      fill="white", colour = "black")

ggplot(geiser, aes(x=waiting, y = ..density..))+
  geom_histogram(fill="cornsilk", color = "grey60", size=.2)+
  geom_density() + xlim(35, 105)


ggplot(geiser, aes(x=eruptions, y = ..density..))+
  geom_histogram(fill="cornsilk", color = "grey60", size=.2)+
  geom_density() + xlim(0,7)
