#Conversiones entre DF, Mapas y objetos espaciales
library(maps)

install.packages("maptools")
library(maptools) # carga sp
#SpatialXXXXXXXDataFrame

#maps -> spatial poligons -> spatial poligos data frame
nj.data <- read.csv("../data/tema12/nj-county-data.csv")
rownames(nj.data) <- nj.data$name
nj.data$name <- NULL
head(nj.data)

nj.map <- map("county", "new jersey", fill = T, plot = F)
str(nj.map)

nj.county <- sapply(strsplit(nj.map$names, ","), function(x) x[2])

nj.sp <- map2SpatialPolygons(nj.map, IDs = nj.county,
                             proj4string = CRS("+proj=longlat +ellps=WGS84"))

class(nj.sp)


nj.spdf <- SpatialPolygonsDataFrame(nj.sp, nj.data)
class(nj.spdf)


plot(nj.spdf)
spplot(nj.spdf, "per_capita_income", main = "Renta per Cápita")
spplot(nj.spdf, "population", main = "Población")
spplot(nj.spdf, "median_family_income", main = "Ingresos promedio familiares")
spplot(nj.spdf, c("per_capita_income", "median_family_income"),
       main = "Ingresos")
