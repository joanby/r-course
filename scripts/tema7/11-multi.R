#Plot Multivariante
library(ggplot2)
install.packages("GGally")
library(GGally)
bike <- read.csv("../data/tema7/daily-bike-rentals.csv")
head(bike)

bike$season = factor(bike$season,
                     levels = c(1,2,3,4),
                     labels = c("Invierno", "Primavera", "Verano", "Otoño"))

bike$weathersit <- factor(bike$weathersit,
                          levels = c(1,2,3),
                          labels = c("Despejado", "Nublado", "Lluvia"))

bike$weekday <- factor(bike$weekday, 
                       levels = 0:6,
                       labels = c("D", "L", "M", "X", "J", "V", "S"))

hist(bike$windspeed)
bike$windspeed.fac <- cut(bike$windspeed, breaks = 3,
                          labels = c("Poco", "Medio", "Elevado"))

head(bike)



ggplot(bike, aes(x=temp, y = cnt))+
  geom_point(size=3, aes(color=windspeed.fac))+
  theme(legend.position = "bottom")+
  geom_smooth(method="lm", se=F, col="red")+
  facet_grid(weekday ~ season)



auto <- read.csv("../data/tema7/auto-mpg.csv", stringsAsFactors = F)
auto$cylinders <- factor(auto$cylinders,
                         labels = c("3C", "4C", "5C", "6C", "8C"))

#postscript(file="multivariant.ps")
#pdf(file="multivariant.pdf")
png(file="multivariant.png", width = 3000, height = 3000, res = 72)
ggpairs(auto[,2:7], 
        aes(colour = cylinders, 
            alpha = 0.4),
        title = "Análisis multivariante de coches",
        upper = list(continuous = "density"),
        lower = list(combo = "denstrip"))+
  theme(plot.title = element_text(hjust = 0.5))  
dev.off()

