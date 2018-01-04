library(caret)
auto <- read.csv("../data/tema4/auto-mpg.csv")
auto$cylinders <- factor(auto$cylinders,
                         levels = c(3,4,5,6,8),
                         labels = c("3c", "4c", "5c", "6c", "8c"))

set.seed(2018)
t.id <- createDataPartition(auto$mpg, p = 0.7, list = F)
names(auto)

mod <- lm(mpg ~ ., data = auto[t.id,-c(1,8,9)])

mod

#mpg = 38.607312 +
#     + 7.212652*4c + 5.610350*5c + 3.307172*6c + 6.211343*8c +
#     + 0.006878 * displacement - 0.072209 * horsepower +
#     - 0.005156 * weight + 0.024852 * acceleration

summary(mod)

boxplot(mod$residuals)

sqrt(mean((mod$fitted.values - auto[t.id,]$mpg)^2))

pred <- predict(mod, auto[-t.id, -c(1,8,9)])
sqrt(mean((pred - auto[-t.id,]$mpg)^2))

par(mfrow=c(2,2))
plot(mod)


auto <- within(auto, 
               cylinders <- relevel(cylinders, ref="4c"))
mod <- lm(mpg ~. , data = auto[t.id, -c(1,8,9)])
summary(mod)
pred <- predict(mod, auto[-t.id, -c(1,8,9)])
sqrt(mean((pred-auto[-t.id,]$mpg)^2))
plot(mod)

library(MASS)

mod
summary(mod)

step.model <- stepAIC(mod, direction="backward")
summary(step.model)

