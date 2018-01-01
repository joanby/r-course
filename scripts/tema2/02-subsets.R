data <- read.csv("../data/tema2/auto-mpg.csv", stringsAsFactors = F)

#Index by position
data[1:5, 8:9]
data[1:5, c(8,9)]

#Index by Name
data[1:5, c("model_year", "car_name")]

# & : AND
# | : OR
# ! : NOT
# ==
##Min / Max de mpg
data[data$mpg == max(data$mpg) | data$mpg == min(data$mpg),]

#Filtros con condiciones
data[data$mpg>30 & data$cylinders == 6, c("car_name", "mpg")]

data[data$mpg>30 & data$cyl == 6, c("car_name", "mpg")]

#subset
subset(data, mpg>30 & cylinders == 6, select = c("car_name", "mpg"))




##FALLOS A TENER EN CUENTA
data[data$mpg>30]
# error porque le falta la coma después de la condición en filas




#Excluir columnas
data[1:5,c(-1,-9)]
data[1:5, -c(1,9)]
#data[1:5, -c("No", "car_name")]
data[1:5, !names(data) %in% c("No", "car_name")]

data[data$mpg %in% c(15,20), c("car_name", "mpg")]


data[c(F,F,F,F,T), c(F, F, T)]
