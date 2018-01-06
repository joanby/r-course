install.packages(c("fpc", "NbClust"))

library(factoextra)
library(cluster)
library(fpc)
library(NbClust)

protein <- read.csv("../data/tema5/protein.csv")
rownames(protein) = protein$Country
protein$Country = NULL
protein.scaled <- as.data.frame(scale(protein))

nb <- NbClust(protein.scaled, distance = "euclidean",
              min.nc = 2, max.nc = 12, 
              method = "ward.D2", index = "all")

fviz_nbclust(nb) + theme_minimal()

km.res <- kmeans(protein.scaled, 3)
sil.km <- silhouette(km.res$cluster, 
                     dist(protein.scaled))

sil.sum <- summary(sil.km)
sil.sum

fviz_silhouette(sil.km)

fviz_cluster(km.res, data = protein.scaled)


dd <- dist(protein.scaled, method = "euclidean")
km_stats <- cluster.stats(dd, km.res$cluster)
km_stats$within.cluster.ss
km_stats$clus.avg.silwidths
km_stats$dunn

km_stats$corrected.rand

km_stats$vi

kmed <- pam(protein.scaled, 3)
sil.kmed <- silhouette(kmed$clustering, 
                     dist(protein.scaled))
fviz_cluster(kmed, data = protein.scaled)

fviz_silhouette(sil.kmed)

kmed_stats <- cluster.stats(dd, kmed$clustering)
kmed_stats$within.cluster.ss
kmed_stats$clus.avg.silwidths
kmed_stats$dunn


kmed_stats$corrected.rand

kmed_stats$vi


res.com <- cluster.stats(dd, km.res$cluster, 
                         kmed$clustering)
res.com$corrected.rand
res.com$vi
