cp <- read.csv("../data/tema3/college-perf.csv")

cp$Perf <- ordered(cp$Perf, 
                   levels = c("Low", "Medium", "High"))
cp$Pred <- ordered(cp$Pred,
                   levels = c("Low", "Medium", "High"))


table <- table(cp$Perf, cp$Pred, 
               dnn =  c("Actual", "Predecido"))
table

prop.table(table)

round(prop.table(table, 1)*100, 2)

round(prop.table(table, 2)*100, 2)

barplot(table, legend = TRUE, 
        xlab = "Nota predecida por el modelo")

mosaicplot(table, main = "Eficiencia del modelo")

summary(table)
