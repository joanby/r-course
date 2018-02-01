#Añadir información a un objeto SP
library(maps)
library(maptools)

nj.map <- map("county", "new jersey", fill=T, plot = F)
nj.county <- sapply(strsplit(nj.map$names,","), function(x) x[2])
nj.sp <- map2SpatialPolygons(nj.map, IDs = nj.county,
                             proj4string = CRS("+proj=longlat +ellps=WGS84"))
nj.df <- read.csv("../data/tema12/nj-county-data.csv")
rownames(nj.df) <- nj.df$name
nj.df$name <- NULL
nj.spdf <- SpatialPolygonsDataFrame(nj.sp, nj.df)

#Calculamos una nueva dimensión
pop.density <- nj.spdf@data$population/nj.spdf@data$area_sq_mi
pop.density
nj.spdf <- spCbind(nj.spdf, pop.density)
names(nj.spdf@data)

spplot(nj.spdf, "pop.density")
