library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Elecciones dinámicas de Data Frames"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("dataset", "Selección del Dataset",
                   c("mtcars", "rock", "auto")),
       uiOutput("var")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("plot")
    )
  )
))
