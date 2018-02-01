#Ficheros ESRI 
install.packages("sp")
install.packages("rgdal")

library(sp)
library(rgdal)

countries.sp <- readOGR("../data/tema12/natural_earth/",
                        "ne_50m_admin_0_countries")

airports.sp <- readOGR("../data/tema12/natural_earth/",
                       "ne_50m_airports")

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
