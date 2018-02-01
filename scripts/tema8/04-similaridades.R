install.packages("lsa")
library(lsa)
mtcars <- read.csv("../data/tema8/mtcars.csv")
head(mtcars)
mtcars$X <- NULL



##Distáncia Euclidea

coche1 <- mtcars[1,]
coche2 <- mtcars[2,]

sqrt(sum((coche1 - coche2) * (coche1 - coche2)))
dist(coche1, coche2, method="euclidean")



x1 <- rnorm(100)
x2 <- rnorm(100)
dist(rbind(x1,x2), method = "euclidean")


##Coseno
v1 <- c(1,0,1,1,0,1,1,0,0,1)
v2 <- c(0,1,1,1,0,0,1,0,1,0)
cosine(v1, v2)

cosine(as.vector(t(coche1)), as.vector(t(coche2)))

## Correlación de Pearson
pear <- cor(mtcars, method = "pearson")
pear
