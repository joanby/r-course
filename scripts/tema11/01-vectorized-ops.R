names.first <- c("Juan Gabriel", "Zach", "Jack", "Sansa")
names.last <- c("Gomila", "Effron", "Sparrow", "Stark")

#La función paste, combina los dos vectores como si 
#hubieramos hecho un bucle for
paste(names.first, names.last)

single.surname <- c("Zuccherberg")

#La función paste sirve para combinar incluso
#vectores de diferente tamaño!
paste(names.first, single.surname)


username <- function(first, last){
  tolower(paste0(last, substr(first, 1, 2)))
}

username(names.first, names.last)


auto <- read.csv("../data/tema11/auto-mpg.csv")

head(auto)
auto$dmpg <- auto$mpg * 2.0
auto$kmpg <- auto$mpg * 1.609
head(auto)

sum(auto$mpg)
min(auto$mpg)
max(auto$mpg)
range(auto$mpg)
prod(auto$mpg)

mean(auto$mpg)
median(auto$mpg)
var(auto$mpg)
sd(auto$mpg)

(auto$mpg - mean(auto$mpg))/sd(auto$mpg)
