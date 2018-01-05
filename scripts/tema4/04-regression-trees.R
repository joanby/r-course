install.packages("rpart.plot")

library(rpart)
library(rpart.plot)
library(caret)

bh <- read.csv("../data/tema4/BostonHousing.csv")
t.id <- createDataPartition(bh$MEDV, p = .7, list = F)

bfit <- rpart(MEDV ~., data = bh[t.id,])
bfit

par(mfrow=c(1,1))

prp(bfit, type = 2, nn=T,
    fallen.leaves = T, faclen = 4,
    varlen = 8, shadow.col = "gray")

bfit$cptable

plotcp(bfit)


bfitpruned <- prune(bfit, cp = 0.02343779)


prp(bfitpruned, type = 2, nn=T,
    fallen.leaves = T, faclen = 4,
    varlen = 8, shadow.col = "gray")


preds <- predict(bfit, bh[t.id,])
sqrt(mean((preds - bh[t.id,]$MEDV)^2))

preds <- predict(bfit, bh[-t.id, ])
sqrt(mean((preds - bh[-t.id,]$MEDV)^2))

preds <- predict(bfitpruned, bh[t.id,])
sqrt(mean((preds - bh[t.id,]$MEDV)^2))

preds <- predict(bfitpruned, bh[-t.id, ])
sqrt(mean((preds - bh[-t.id,]$MEDV)^2))





#predictores categóricos

ed <- read.csv("../data/tema4/education.csv")
ed$region <- factor(ed$region)
t.id <- createDataPartition(ed$expense, p = 0.7, list = F)
fit <- rpart(expense ~ region+urban+income+under18, data = ed[t.id,])
prp(fit, type = 2, nn=T, fallen.leaves = T, 
    faclen=4, varlen=8, shadow.col = "gray")

#Bagging 
install.packages("ipred")
library(ipred)
bagging.fit <- bagging(MEDV~., data=bh[t.id, ])
prediction.t <- predict(bagging.fit, bh[t.id,])
sqrt(mean((prediction.t-bh[t.id,]$MEDV)^2))

prediction.v <- predict(bagging.fit, bh[-t.id,])
sqrt(mean((prediction.v-bh[-t.id,]$MEDV)^2))

#Boosting
install.packages("gbm")
library(gbm)

gbmfit <- gbm(MEDV~., data = bh, distribution = "gaussian")
prediction.t <- predict(gbmfit, bh)
