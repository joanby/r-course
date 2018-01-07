s <- read.csv("../data/tema6/ts-example.csv")
head(s)

s.ts <- ts(s)
class(s.ts)
head(s.ts)
plot(s.ts)

s.ts.a <- ts(s, start = 2001)
s.ts.a
plot(s.ts.a)


s.ts.m <- ts(s, start = c(2001,1), frequency = 12)
s.ts.m
plot(s.ts.m)


s.ts.q <- ts(s, start = 2001, frequency = 4)
s.ts.q
plot(s.ts.q)



start(s.ts.m)
end(s.ts.m)
frequency(s.ts.m)

start(s.ts.q)
end(s.ts.q)
frequency(s.ts.q)


prices <- read.csv("../data/tema6/prices.csv")
head(prices)

prices.ts <- ts(prices, start = c(1980,1), frequency = 12)
prices.ts
plot(prices.ts)

plot(prices.ts, plot.type = "single", col = 1:2)
legend("topleft", colnames(prices.ts), col = 1:2, lty = 1)

#log(a*b) = log (a) + log(b)

#Descomposición de una serie temporal 

#stl
#Seasonal Decomposition of Time Series by Loess
flour.l <- log(prices.ts[,1])
flour.stl<- stl(flour.l, s.window = "period")
plot(flour.stl)
flour.stl

gas.l <- log(prices.ts[,2])
gas.stl <- stl(gas.l, s.window = "period")
plot(gas.stl)


#decompose
#Classical Seasonal Decomposition by Moving Averages
flour.dec <- decompose(flour.l)
plot(flour.dec)

gas.dec <- decompose(gas.l)
plot(gas.dec)



gas.season.adjusted <- prices.ts[,2] - (gas.dec$seasonal)
plot(gas.season.adjusted)

n <- 12
gas.f.1 <- filter(prices.ts[,2], filter = rep(1/n, n), sides = 2)
gas.f.2 <- filter(prices.ts[,2], filter = rep(1/n,n), sides = 1)
plot(prices.ts[,2])
lines(gas.f.1, col = "blue", lwd = 3)
lines(gas.f.2, col = "red", lwd = 3)
