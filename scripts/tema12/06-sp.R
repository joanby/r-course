# Conversión entre data frame y datos espaciales
library(sp)

nj <- read.csv("../data/tema12/nj-wages.csv")
class(nj)
head(nj)
#Coordinates sirve para indicar cuales serán las dos columnas
#con la info de las coordenadas (long, lat)
coordinates(nj) <- c("Long", "Lat")
class(nj)

plot(nj)

spatial_lines <- function(spdf, name = "dummy"){
  temp <- SpatialLines(
    list(
      Lines(
        list(Line(coordinates(spdf))), name)
      )
    )
  return(temp)
}

sp <- spatial_lines(nj.lines)
plot(sp)
