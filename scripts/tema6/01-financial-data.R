AAPL = read.csv("../data/tema6/AAPL.csv", stringsAsFactors = F)
AMZN = read.csv("../data/tema6/AMZN.csv", stringsAsFactors = F)
FB = read.csv("../data/tema6/FB.csv", stringsAsFactors = F)
GOOG = read.csv("../data/tema6/GOOG.csv", stringsAsFactors = F)

str(AAPL)
#Hacemos el casting a fecha de las mismas...
AAPL$Date = as.Date(AAPL$Date)
AMZN$Date = as.Date(AMZN$Date)
FB$Date = as.Date(FB$Date)
GOOG$Date = as.Date(GOOG$Date)


library(ggplot2)

ggplot(AAPL, aes(Date, Close)) +
  geom_line(aes(color="Apple")) +
  geom_line(data=AMZN, aes(color = "Amazon"))+
  geom_line(data=FB, aes(color="Facebook"))+
  geom_line(data=GOOG, aes(color="Google"))+
  labs(color="Legend")+
  scale_color_manual("", 
                     breaks = c("Apple", "Amazon", "Facebook", "Google" ),
                     values = c("gray", "yellow", "blue", "red"))+
  ggtitle("Comparaciones de cierre de stocks")+
  theme(plot.title = element_text(lineheight = 0.7, face = "bold"))

tail(GOOG)  
  
##cargar datos en tiempo real 
install.packages("quantmod")
library(quantmod)

getSymbols("AAPL")
barChart(AAPL)
chartSeries(AAPL, TA = "NULL")
candleChart(AAPL, up.col = "black", 
            dn.col="red", theme = "white")

head(AAPL)
chartSeries(AAPL[,4],TA = "addMACD()")


getSymbols("NFLX")
barChart(NFLX)
chartSeries(NFLX, TA = "NULL")
chartSeries(NFLX[,4],TA = "addMACD()")
