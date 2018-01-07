wmt <- read.csv("../data/tema6/WMT.csv", stringsAsFactors = F)
plot(wmt$Adj.Close, type = "l")

d <- diff(wmt$Adj.Close, lag = 2)
head(d)
plot(d, type="l")

hist(d, prob=T, ylim = c(0,0.8), breaks = 30, main = "Walmart Stocks", col = "green")
lines(density(d), lwd=3)

wmt.m <- read.csv("../data/tema6/WMT-monthly.csv", stringsAsFactors = F)
wmt.m <- wmt.m[2:nrow(wmt.m),]
wmt.m$Date <- as.Date(wmt.m$Date)
wmt.m.ts <- ts(wmt.m$Adj.Close)

wmt.m.ts
d <- diff(as.numeric(wmt.m.ts))
d
wmt.m.return <- d / lag(as.numeric(wmt.m.ts), k = -1)
View(wmt.m.return)
hist(wmt.m.return, prob = T, col = "blue")
