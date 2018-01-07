#modelo autorregresivo integrado de media móvil
inf <- read.csv("../data/tema6/INFY-monthly.csv")
inf.ts <- ts(inf$Adj.Close, start = c(1999,3), frequency = 12)
inf.arima <- auto.arima(inf.ts)
summary(inf.arima)

inf.fore <- forecast(inf.arima, h = 12)
plot(inf.fore, col = "red",
     fcol = "green")
