auto <- read.csv("../data/tema2/auto-mpg.csv")
auto$cylinders <- factor(auto$cylinders, 
                         levels = c(3,4,5,6,8),
                         labels = c("3cil", "4cil", "5cil", "6cil", "8cil"))
attach(auto)
head(cylinders)

#Histograma de frecuencias
hist(acceleration,
     col = rainbow(12),
     xlab = "Aceleración",
     ylab = "Frecuencias",
     main = "Histograma de las aceleraciones",
     breaks = 12)

hist(mpg, breaks = 16, prob = T)
lines(density(mpg))


#Boxplots
boxplot(mpg, xlab = "Millas por Galeón")
boxplot(mpg ~ model_year, xlab = "Millas por Galeón (por año)")
boxplot(mpg ~ cylinders, xlab = "Consumo por Número de cilindros")
boxplot(auto)

#Scatterplot
plot(mpg ~ horsepower, type = "n")
linearmodel <- lm(mpg ~ horsepower)
abline(linearmodel)
#Agregar colores para cada cilindrada
with(subset(auto, cylinders=="8cil"), 
     points(horsepower, mpg, col = "red"))
with(subset(auto, cylinders == "6cil"),
     points(horsepower, mpg, col = "yellow"))
with(subset(auto, cylinders == "5cil"),
     points(horsepower, mpg, col = "green"))
with(subset(auto, cylinders == "4cil"),
     points(horsepower, mpg, col = "blue"))
with(subset(auto, cylinders == "3cil"),
     points(horsepower, mpg))
#Matriz de Scatterplots
pairs(~mpg+displacement+horsepower+weight)


#Combinación de plots con par
old.par <- par()
old.par
par(mfrow = c(1,2))

with(auto, {
  plot(mpg ~ weight, main = "Peso vs Consumo")
  plot(mpg ~ acceleration, main = "Aceleración vs Consumo")
}
)

par(old.par)
