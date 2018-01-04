install.packages("FNN")

library(dummies)
library(FNN)
library(scales)
library(caret)

edu <- read.csv("../data/tema4/education.csv")
dms <- dummy(edu$region, sep = "_")
edu <- cbind(edu, dms)

edu$urban.s <- rescale(edu$urban)
edu$income.s <- rescale(edu$income)
edu$under18.s <- rescale(edu$under18)


set.seed(2018)
t.id <- createDataPartition(edu$expense, p=0.6, list = F)
tr <- edu[t.id, ]
temp <- edu[-t.id, ]
v.id <- createDataPartition(temp$expense, p=0.5, list = F)
val <- temp[v.id,]
test <- temp[-v.id,]


reg1 <- knn.reg(tr[,7:12], val[,7:12], tr$expense, k=1,
                algorithm = "brute")
rmse1 <- sqrt(mean((reg1$pred-val$expense)^2))
rmse1

reg2 <- knn.reg(tr[,7:12], val[,7:12], tr$expense, k=2,
                algorithm = "brute")
rmse2 <- rmse(val$expense, reg2$pred)
rmse2

reg3 <- knn.reg(tr[,7:12], val[,7:12], tr$expense, k=3,
                algorithm = "brute")
rmse3 <- rmse(val$expense, reg3$pred)
rmse3

df = data.frame(actual = val$expense, pred = reg3$pred)
plot(df)
abline(0,1)



reg4 <- knn.reg(tr[,7:12], val[,7:12], tr$expense, k=4,
                algorithm = "brute")
rmse4 <- rmse(val$expense, reg4$pred)
rmse4

errors = c(rmse1, rmse2, rmse3, rmse4)

plot(errors, type = 'o', xlab = "k", ylab = "RMSE")


reg.test <- knn.reg(tr[,7:12], test[,7:12], tr$expense, k=3,
                algorithm = "brute")
rmse.test <- rmse(test$expense, reg.test$pred)
rmse.test

df = data.frame(actual = test$expense, pred = reg.test$pred)
plot(df)
abline(0,1)

t.id <- createDataPartition(edu$expense, p = 0.7, list = F)
tr <- edu[t.id, ]
val <- edu[-t.id,]
reg <- knn.reg(tr[,7:12], test = NULL, y = tr$expense,
               k = 3, algorithm = "brute")
rmse.reg <- sqrt(mean(reg$residuals^2))
rmse.reg

##Función para automatizar KNN
rda.knn.reg <- function(tr_predictor, val_predictors,
                          tr_target, val_target, k){
  library(FNN)
  res <- knn.reg(tr_predictor, val_predictors,
                 tr_target, k, algorithm = "brute")
  rmserror <- sqrt(mean((val_target - res$pred)^2))
  cat(paste("RMSE para k = ", toString(k), ": ", rmserror,"\n", sep = ""))
  rmserror
}

##Función para realizar múltiples KNN
rda.knn.reg.multi <- function(tr_predictors, val_predictors,
                                tr_target, val_target, start_k, end_k){
  rms_errors <- vector()
  for(k in start_k:end_k){
    rms_error <- rdacb.knn.reg(tr_predictors, val_predictors,
                               tr_target, val_target, k)
    rms_errors <- c(rms_errors, rms_error)
  }
  plot(rms_errors, type = 'o', xlab = "k", ylab = "RMSE")
}


rda.knn.reg.multi(tr[,7:12], val[,7:12], 
                    tr$expense, val$expense, 1,10)
