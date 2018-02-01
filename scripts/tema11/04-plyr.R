#split -> apply -> combine
#plyr 
#XYply X,Y = a -> array, d -> data.frame, l -> list, _ -> no output

auto <- read.csv("../data/tema11/auto-mpg.csv", stringsAsFactors = F)
auto$cylinders <- factor(auto$cylinders, levels = c(3,4,5,6,8),
                         labels = c("3C", "4C", "5C", "6C", "8C"))

install.packages("plyr")
library(plyr)

ddply(auto, "cylinders", function(df) { mean(df$mpg)})
ddply(auto, ~cylinders, function(df){ mean(df$mpg)})

ddply(auto, c("cylinders", "model_year"),
      function(df){
        c(mean= mean(df$mpg),
          min = min(df$mpg),
          max = max(df$mpg))
      })

ddply(auto, ~cylinders + model_year,
      function(df){
        c(mean= mean(df$mpg),
          min = min(df$mpg),
          max = max(df$mpg))
      })


ddply(auto, .(cylinders), summarize, 
      freq = length(cylinders), meanmpg = mean(mpg))


par(mfrow=c(3,2))
d_ply(auto, "cylinders", summarise,
      hist(mpg, xlab="Millas por galeón", 
           main = "Histograma de frecuencias", breaks = 5))


autos <- list(auto, auto)
auto.big <- ldply(autos, I)

mat <- matrix(seq(1,9),3,3)
mat
apply(mat, 1, sum)

x <- list(a=1, b= 1:5, x= 10:50)
x
lapply(x, FUN = length)
sapply(x, FUN = length)

mapply(sum, 1:5, 1:10, 1:20, 1:100)


x <- 1:25
y <- factor(rep(letters[1:5], each = 5))
y
tapply(x, y, sum)



#dplyr
#SELECT   -> select()
#WHERE    -> filter()
#GROUP BY -> group_by() / summarise()
#ORDER BY -> arrange()
#JOIN     -> join()
#COLUMN ALIAS -> mutate()

install.packages("dplyr")
library(dplyr)

subset.auto <- select(auto, mpg, horsepower, acceleration)
head(subset.auto)

auto.80 <- filter(auto, model_year>80)
head(auto.80)

auto.norm <- mutate(auto, mpg.norm = round((mpg-mean(mpg))/sd(mpg),2))
head(auto.norm)

summarise(group_by(auto, cylinders), mean(mpg))

summarise(group_by(auto, model_year), mean(mpg))


auto %>%
  filter(model_year<78) %>%
  group_by(cylinders) %>%
  summarise(mean(mpg))



