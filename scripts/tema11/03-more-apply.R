#lapply -> l = lista, se puede aplicar vectores, list, data frame
#sapply -> lista o vector
auto <- read.csv("../data/tema11/auto-mpg.csv", stringsAsFactors = F)
head(auto)

x <- c(1,2,3)
x
lapply(x, sqrt)
sapply(x, sqrt)
class(lapply(x, sqrt))


x <- list(a = 1:10, b = c(1,10,100,1000), c = seq(5,50, by = 5))
x
lapply(x, mean)
class(lapply(x,mean))

sapply(x, mean)
class(sapply(x, mean))


lapply(auto[,2:8], min)
sapply(auto[,2:8], min)

lapply(auto[,2:8], summary)
sapply(auto[,2:8], summary)

sapply(auto[,2:8], range)

sapply(auto[,2:8], min)
sapply(auto[,2],   min)#esto falla porque R trabaja con vector
sapply(as.data.frame(auto[,2]),min, simplify = F)







#tapply
auto$cylinders <- factor(auto$cylinders,
                         levels = c(3,4,5,6,8),
                         labels = c("3C", "4C", "5C", "6C", "8C"))

tapply(auto$mpg, auto$cylinders, mean)
tapply(auto$mpg, list(cyl = auto$cylinders), mean)


by(auto, auto$cylinders,
   function(row){ cor(row$mpg, row$acceleration)} )
