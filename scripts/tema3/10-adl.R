install.packages("MASS")
library(MASS)
library(caret)

bn<- read.csv("../data/tema3/banknote-authentication.csv")
bn$class <- factor(bn$class)

set.seed(2018)
t.id <- createDataPartition(bn$class, p=0.7, list = F)

mod <- lda(bn[t.id,1:4], bn[t.id,5])
#mod <- lda(class ~., data = bn[t.id,])

bn[t.id, "Pred"] <- predict(mod, bn[t.id, 1:4])$class

table(bn[t.id, "class"], bn[t.id, "Pred"], dnn = c("Actual", "Predichos"))

bn[-t.id, "Pred"] <- predict(mod, bn[-t.id, 1:4])$class 
table(bn[-t.id, "class"], bn[-t.id, "Pred"], dnn = c("Actual", "Predichos"))


