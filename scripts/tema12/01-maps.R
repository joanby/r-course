#R Google Maps
library(RgoogleMaps)

lat <- 39.637492
lon <- 2.644557

uib.map <- GetMap(center = c(lat, lon), zoom = 17,
                  destfile = "tema12/uib.pdf",
                  format = "pdf",
                  maptype = "terrain")
PlotOnStaticMap(uib.map)

#satellite, roadmap, terrain