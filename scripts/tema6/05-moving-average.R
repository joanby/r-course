s <- read.csv("../data/tema6/ts-example.csv")
s$sales
plot(s$sales, type = "l")

n <- 7
weights <- rep(1/n, n)
weights

s.fil.1 <- filter(s$sales, filter = weights, sides = 2)
lines(s.fil.1, col = "blue", lwd = 3)

s.fil.2 <- filter(s$sales, filter = weights, sides = 1)
lines(s.fil.2, col = "red", lwd = 3)
