install.packages("nnet")

library(nnet)
library(caret)

bn <- read.csv("../data/tema3/banknote-authentication.csv")
bn$class <- factor(bn$class)

t.id <- createDataPartition(bn$class, p= 0.7, list = F)

mod <- nnet(class ~ ., data = bn[t.id,], 
            size = 3, maxit = 10000, decay = .001, rang = 0.05,
            na.action = na.omit, skip = T)
#rang * max(|variables|) ~ 1
apply(bn, 2, max)

pred <- predict(mod, newdata = bn[-t.id,], type = "class")

table(bn[-t.id,]$class, pred,dnn = c("Actual", "Predichos") )

library(ROCR)
pred2 <- predict(mod, newdata = bn[-t.id,], type = "raw")
perf <- performance(prediction(pred2, bn[-t.id,"class"]), 
                    "tpr", "fpr")
plot(perf)
