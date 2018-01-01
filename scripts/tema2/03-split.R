#split / unsplit
data <- read.csv("../data/tema2/auto-mpg.csv", stringsAsFactors = F)

carslist <- split(data, data$cylinders)
carslist[1]
carslist[[1]]


str(carslist[1])

names(carslist[[1]])
