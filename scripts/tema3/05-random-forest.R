install.packages("randomForest")
library(caret)
library(randomForest)

banknote <- read.csv("../data/tema3/banknote-authentication.csv")
banknote$class <- factor(banknote$class)

set.seed(2018)
training.ids <- createDataPartition(banknote$class, p = 0.7, list = F)

mod <- randomForest(x = banknote[training.ids, 1:4],
                    y = banknote[training.ids, 5],
                    ntree = 500,
                    keep.forest = TRUE)

pred <- predict(mod, banknote[-training.ids,], type = "class")
table(banknote[-training.ids,"class"], pred, dnn= c("Actual", "Predicho"))

library(ROCR)
probs <- predict(mod, banknote[-training.ids,], type = "prob")
head(probs)
pred <- prediction(probs[,2], banknote[-training.ids,"class"])
perf <- performance(pred, "tpr", "fpr")
plot(perf)
