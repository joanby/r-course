bh <- read.csv("../data/tema5/BostonHousing.csv")

install.packages("corrplot")
library(corrplot)
corr <- cor(bh[,-14])
corr

corrplot(corr, method = "circle")
#scale = T, matriz de correlaciones
#scale = F, matriz de covarianzas
bh.acp <- prcomp(bh[,-14], scale = T)

summary(bh.acp)

plot(bh.acp)
plot(bh.acp, type = "lines")

biplot(bh.acp, col = c("gray", "red"))


head(bh.acp$x,5)

bh.acp$rotation

bh.acp$sdev
