protein <- read.csv("../data/tema5/protein.csv")

data <- as.data.frame(scale(protein[,-1]))
data$Country = protein$Country
rownames(data) = data$Country
hc <- hclust(dist(data, method = "euclidean"),
             method = "ward.D2")
hc

plot(hc, hang = -0.01, cex = 0.7)

fit <- cutree(hc, k=4)

table(fit)

rect.hclust(hc, k=4, border="red")



hc2 <- hclust(dist(data, method = "euclidean"),
              method = "single")
plot(hc2, hang=-0.01, cex = 0.7)

hc3 <- hclust(dist(data, method = "euclidean"),
              method = "complete")
plot(hc3, hang=-0.01, cex = 0.7)
hc3$merge

hc4 <- hclust(dist(data, method = "euclidean"),
              method = "average")
plot(hc4, hang=-0.01, cex = 0.7)
hc4$merge

d <- dist(data, method = "euclidean")

d 

alb<-data["Albania",-10]
aus<-data["Austria",-10]
sqrt(sum((alb-aus)^2))
sum(abs(alb-aus))


install.packages("cluster")
library(cluster)
dv <- diana(data, metric = "euclidean")
par(mfrow=c(1,2))
plot(dv)

