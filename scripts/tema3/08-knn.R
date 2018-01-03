install.packages("class")
library(class)
library(caret)

vac <- read.csv("../data/tema3/vacation-trip-classification.csv")
vac$Income.z <- scale(vac$Income)
vac$Family_size.z <- scale(vac$Family_size)

set.seed(2018)
t.ids <- createDataPartition(vac$Result, p=0.5, list = F)
train <- vac[t.ids, ]
temp <- vac[-t.ids, ]
v.ids <- createDataPartition(temp$Result, p=0.5, list = F)
val <- temp[v.ids,]
test <- temp[-v.ids,]


pred1 <- knn(train[,4:5], val[,4:5], train[,3], k = 5)
errmat1 <- table(val$Result, pred1, dnn = c("Actual", "Predichos"))
errmat1

pred2 <- knn(train[,4:5], test[,4:5], train[,3], k = 1)
errmat2 <- table(test$Result, pred2, dnn = c("Actual", "Predichos"))
errmat2


knn.automate <- function(tr_predictors, val_predictors, tr_target,
                         val_target, start_k, end_k){
  for (k in start_k:end_k) {
    pred <- knn(tr_predictors, val_predictors, tr_target, k)
    tab <- table(val_target, pred, dnn = c("Actual", "Predichos") )
    cat(paste("Matriz de confusión para k = ",k,"\n"))
    cat("==============================\n")
    print(tab)
    cat("------------------------------\n")
  }
}

knn.automate(train[,4:5], val[,4:5], train[,3], val[,3], 1,8)


trcntrl <- trainControl(method="repeatedcv", number = 10, repeats = 3)
caret_knn_fit <- train(Result ~ Family_size + Income, data = train,
                       method = "knn", trControl = trcntrl,
                       preProcess = c("center", "scale"),
                       tuneLength = 10)

caret_knn_fit


pred5 <- knn(train[,4:5], val[,4:5], train[,3], k=5, prob = T)
pred5
