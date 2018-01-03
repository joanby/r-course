install.packages("e1071")
library(caret)
library(e1071)

banknote <- read.csv("../data/tema3/banknote-authentication.csv")
banknote$class = factor(banknote$class)
set.seed(2018)
t.ids <- createDataPartition(banknote$class, p = 0.7, list = F)
mod <- svm(class ~ ., data = banknote[t.ids, ], 
           class.weights = c("0"=0.3, "1"=0.7),
           cost=1000)
table(banknote[t.ids,"class"], fitted(mod), dnn = c("Actual", "Predicho"))
pred <- predict(mod, banknote[-t.ids,])
table(banknote[-t.ids, "class"], pred, dnn = c("Actual", "Predicho"))

plot(mod, data = banknote[t.ids,], skew ~ variance)
plot(mod, data = banknote[-t.ids,], skew ~ variance)


tuned <- tune.svm(class ~ ., data = banknote[t.ids,], 
                  gamma = 10^(-6:-1), cost = 10^(1:2))
summary(tuned)
