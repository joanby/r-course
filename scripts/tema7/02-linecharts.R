#Line Charts 
library(ggplot2)
mtcars <- read.csv("../data/tema7/mtcars.csv", stringsAsFactors = F)
head(mtcars)

plot <- ggplot(mtcars, aes(wt, mpg))
plot + geom_line()
plot + geom_line(linetype = "dashed", color = "red")

plot + geom_line(aes(color = as.factor(carb)))
