library(caret)

bh <- read.csv("../data/tema3/boston-housing-logistic.csv")
bh$CLASS <- factor(bh$CLASS, levels = c(0,1))

set.seed(2018)
t.id <- createDataPartition(bh$CLASS, p=0.7, list = F)

mod <- glm(CLASS ~ ., data = bh[t.id, ], family = binomial)
summary(mod)


bh[-t.id, "PROB_SUCCESS"] <- predict(mod, newdata = bh[-t.id,], type="response")
bh[-t.id, "PRED_50"] <- ifelse(bh[-t.id, "PROB_SUCCESS"]>=0.5, 1, 0)

table(bh[-t.id,"CLASS"], bh[-t.id,"PRED_50"], dnn=c("Actual","Predicho"))
