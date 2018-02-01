#labels and legends

#ggtitle(titulo)
#xlab(eje x)
#ylab(eje y)
#labs(....)

library(ggplot2)
tooth <- read.csv("../data/tema7/ToothGrowth.csv")
head(tooth)

#box plot
ggplot(tooth, aes(x=dose, y=len, fill = as.factor(dose)))+
  geom_boxplot() +
  ggtitle("Crecimiento dental en función de una dosis (mg/día) de vitamina C")+
  xlab("Dosis de vitamina C (mg/día)") +
  ylab("Crecimiento dental (en mm)") +
  labs(fill = "Dosis en mg/día") +
  theme(legend.position = "bottom") +
  guides(fill = F)



ggplot(tooth, aes(x=dose, y = len))+
  geom_boxplot()+
  theme_bw()+
  #theme_dark()+
  #theme_classic()+
  #theme_grey()+
  #theme(plot.background = element_rect(fill="darkblue"))
  theme(axis.text.x = element_text(face = "bold", 
                                   family = "Times",
                                   size = 14,
                                   angle = 45,
                                   color = "#995566"),
        axis.text.y = element_text(face = "italic",
                                   family = "Courier",
                                   size = 16,
                                   angle = 30, 
                                   color = "#449955")
        )+
  theme(panel.border = element_blank())+
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
