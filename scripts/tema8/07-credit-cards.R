library(caret)
install.packages(c("pROC", "DMwR", "caTools"))
library(pROC)
library(DMwR)
library(caTools)

ccdata <- read.csv("../data/tema8/creditcard.csv")

head(ccdata)
ccdata$Class <- factor(ifelse(ccdata$Class==0, "0", "1"))
table(ccdata$Class)

t.id <- createDataPartition(ccdata$Class, p = 0.7, list = F, times = 1)
training <- ccdata[t.id,]
test <- ccdata[-t.id,]
table(training$Class)
table(test$Class)

training <- SMOTE(Class ~ ., training, perc.under = 100, perc.over = 200)
table(training$Class)

training$Class <- as.numeric(training$Class)
trControl <- trainControl(method = "cv", number = 10)
model <- train(Class ~., data = training, method = "treebag",
               trControl = trControl)
model

predictors <- names(training)[names(training)!='Class']
pred <- predict(model$finalModel, test[,predictors])

auc <- roc(test$Class, pred)
auc

plot(auc, ylim = c(0,1), print.thres= T, 
     main = paste("AUC con SMOTE: ", round(auc$auc[[1]],2)) )
abline(h=1, col = "green", lwd=2)
abline(h=0, col = "red", lwd = 2)
