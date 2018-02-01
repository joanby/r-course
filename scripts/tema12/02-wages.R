library(RgoogleMaps)
wages <- read.csv("../data/tema12/nj-wages.csv")

head(wages)
wages$wgClass <- cut(wages$Avgwg,
                     quantile(wages$Avgwg, 
                              probs = seq(0,1, 0.2)),
                     labels = F, include.lowest = T)
head(wages)

pal <- palette(rainbow(5))

map <- MapBackground(lat = wages$Lat, lon= wages$Long)

PlotOnStaticMap(map, wages$Lat, wages$Long,
                pch=21, 
                cex = sqrt(wages$wgClass),
                bg=pal[wages$wgClass]
                )

legend("topleft", 
       legend = paste("<=", round(tapply(wages$Avgwg, 
                                         wages$wgClass, max
                                         ),0
                                  )
                      ),
       pch = 21, pt.bg = pal,
       pt.cex = 1.0, bg="gray", title = "Ingresos promedio"
       )
