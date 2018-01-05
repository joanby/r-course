#k-fold cross validation
bh <- read.csv("../data/tema4/BostonHousing.csv")


kfold.crossval.reg <- function(df, nfolds){
  fold <- sample(1:nfolds, nrow(df), replace = T)
  cat(fold)
  
  mean.sqr.errs <- sapply(1:nfolds, 
                          kfold.cval.reg.iter,
                          df, fold)
  
  list("MSE "= mean.sqr.errs,
       "Overall_Mean_Sqr_Error" = mean(mean.sqr.errs),
       "Std_Mean_Sqr_Error" = sd(mean.sqr.errs))
}

kfold.cval.reg.iter <- function(k, df, fold){
  
  tr.ids <- !fold %in% c(k)
  test.ids <- fold %in% c(k)
  mod <- lm(MEDV ~., data = df[tr.ids,])
  pred <- predict(mod, df[test.ids,])
  sqr.errs <- (pred - df[test.ids,"MEDV"])^2
  mean(sqr.errs)
}


res <- kfold.crossval.reg(bh, 5)

res


loocv.reg <- function(df){
  mean.sqr.errors <- sapply(1:nrow(df), 
                            loocv.reg.iter, df)
  list("MSE"=mean.sqr.errors,
       "overall_mean_sqr_errors" = mean(mean.sqr.errors),
       "sd_mean_sqr_errors" = sd(mean.sqr.errors))
}

loocv.reg.iter <- function(k, df){
  mod <- lm(MEDV~., data = df[-k,])
  pred <- predict(mod, df[k,])
  sqr.error <- (pred - df[k,"MEDV"])^2
  sqr.error
}


res <- loocv.reg(bh)


res
