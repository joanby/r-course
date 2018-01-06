protein <- read.csv("../data/tema5/protein.csv")
rownames(protein) = protein$Country
protein$Country = NULL
protein.scaled = as.data.frame(scale(protein))

library(devtools)
devtools::install_github("kassambara/factoextra")

km <- kmeans(protein.scaled,4)
km


aggregate(protein.scaled, by = list(cluster = km$cluster), mean)

library(factoextra)
fviz_cluster(km, data = protein.scaled)
