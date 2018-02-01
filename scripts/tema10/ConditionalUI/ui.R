library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Elecciones condicionales"),
  
  # Sidebar with a slider input for number of bins 
  sidebarPanel(
    selectInput("plot_type", "Plot Type",
                c("Nube de puntos"="scatter",
                  "Histograma"="histogram")),
    conditionalPanel(condition="input.plot_type != 'histogram'",
                     selectInput("x", "Selecciona la variable en el eje X",
                        choices = c("Peso" = "weight", 
                                    "Cilindros" = "cylinders",
                                    "Caballos de Potencia" = "horsepower")))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("plot")
    )
  )
)
