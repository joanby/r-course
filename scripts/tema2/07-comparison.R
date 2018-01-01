data <- read.csv("../data/tema2/daily-bike-rentals.csv")

data$season <- factor(data$season, levels = c(1,2,3,4), 
                      labels = c("Invierno", "Primavera", "Verano", "Otoño"))
data$workingday <- factor(data$workingday, levels = c(0,1),
                          labels = c("Festivo", "De trabajo"))
data$weathersit <- factor(data$weathersit, levels = c(1,2,3),
                          labels = c("Despejado", "Nublado", "Lluvia/Nieve ligera"))
data$dteday <- as.Date(data$dteday, format = "%Y-%m-%d")
attach(data)

par(mfrow=c(2,2))
winter <- subset(data, season == "Invierno")$cnt
spring <- subset(data, season == "Primavera")$cnt
summer <- subset(data, season == "Verano")$cnt
fall   <- subset(data, season == "Otoño")$cnt

hist(winter, prob = TRUE, xlab = "Alquiler diario en invierno", main ="")
lines(density(winter))
abline(v = mean(winter), col = "red")
abline(v=median(winter), col = "blue")



hist(spring, prob = TRUE, xlab = "Alquiler diario en primavera", main = "")
lines(density(spring))
abline(v = mean(spring), col="red")
abline(v=median(spring), col="blue")


hist(summer, prob = TRUE, xlab = "Alquiler diario en verano", main = "")
lines(density(summer))
abline(v = mean(summer), col="red")
abline(v=median(summer), col="blue")


hist(fall, prob = TRUE, xlab = "Alquiler diario en otoño", main = "")
lines(density(fall))
abline(v = mean(fall), col="red")
abline(v=median(fall), col="blue")


install.packages("beanplot")
library(beanplot)

par(mfrow=c(1,1))
beanplot(data$cnt ~ data$season, col = c("blue", "red", "yellow"))



#causalidad
library(lattice)
bwplot(cnt ~ weathersit, data = data, 
       layout = c(1,1), 
       xlab = "Pronóstico del tiempo",
       ylab = "Frecuencias",
       panel = function(x,y,...){
         panel.bwplot(x,y,...)
         panel.stripplot(x,y,jitter.data = TRUE,...)
       },
       par.settings = list(box.rectangle = list(fill = c('red', 'yellow', 'green'))))

