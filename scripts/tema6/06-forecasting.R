inf <- read.csv("../data/tema6/INFY-monthly.csv")
tail(inf)

inf.ts <- ts(inf$Adj.Close, start=c(1999,3), frequency = 12)
inf.ts
plot(inf.ts)
inf.hw <- HoltWinters(inf.ts)

plot(inf.hw, col = "blue", col.predicted = "red")

inf.hw$SSE
inf.hw$alpha
inf.hw$beta
inf.hw$gamma

head(inf.hw$fitted)

install.packages("forecast")
library(forecast)

infy.fore <- forecast(inf.hw, h=24)
plot(infy.fore)

infy.fore$lower
infy.fore$upper
