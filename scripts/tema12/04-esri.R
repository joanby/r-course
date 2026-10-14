#Ficheros ESRI 
install.packages("sp")
install.packages("sf") # en el vídeo, rgdal: se retiró de CRAN en 2023

library(sp)
library(sf)

# En el vídeo: readOGR("../data/tema12/natural_earth/", "ne_50m_admin_0_countries"). st_read lee lo mismo
# y as(..., "Spatial") lo convierte en el objeto de sp de siempre.
countries.sp <- as(st_read("../data/tema12/natural_earth/",
                           "ne_50m_admin_0_countries", stringsAsFactors = TRUE), "Spatial")

airports.sp <- as(st_read("../data/tema12/natural_earth/",
                          "ne_50m_airports", stringsAsFactors = TRUE), "Spatial")

class(countries.sp)
class(airports.sp)


plot(countries.sp, 
     col = countries.sp@data$admin)

plot(airports.sp, add=TRUE)

spplot(countries.sp, c("economy"))

spplot(countries.sp, c("pop_est"))

plot(countries.sp, 
       col = countries.sp@data$mapcolor13)

str(countries.sp@data)
