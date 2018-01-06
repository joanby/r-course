protein <- read.csv("../data/tema5/protein.csv")
rownames(protein) = protein$Country
protein$Country = NULL
protein.scaled <- as.data.frame(scale(protein))

library(cluster)
library(factoextra)

km <- pam(protein.scaled, 4)
km


fviz_cluster(km)


clarafit <- clara(protein.scaled, 4, samples = 6)
clarafit

fviz_cluster(clarafit)
