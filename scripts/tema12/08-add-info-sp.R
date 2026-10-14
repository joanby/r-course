#Añadir información a un objeto SP
library(maps)
library(sp) # en el vídeo, library(maptools), retirado de CRAN en 2023

nj.map <- map("county", "new jersey", fill=T, plot = F)
nj.county <- sapply(strsplit(nj.map$names,","), function(x) x[2])
# En el vídeo: map2SpatialPolygons(nj.map, IDs = nj.county, proj4string = CRS("+proj=longlat +ellps=WGS84"))
nj.sp <- spChFIDs(as(sf::st_geometry(sf::st_as_sf(nj.map)), "Spatial"), nj.county)
nj.df <- read.csv("../data/tema12/nj-county-data.csv")
rownames(nj.df) <- nj.df$name
nj.df$name <- NULL
nj.spdf <- SpatialPolygonsDataFrame(nj.sp, nj.df)

#Calculamos una nueva dimensión
pop.density <- nj.spdf@data$population/nj.spdf@data$area_sq_mi
pop.density
nj.spdf$pop.density <- pop.density # en el vídeo, spCbind(nj.spdf, pop.density)
names(nj.spdf@data)

spplot(nj.spdf, "pop.density")
