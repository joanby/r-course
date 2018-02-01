
library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("Aplicación simple con Shiny"),
    sidebarPanel(
      p("Vamos a crear plots con el data frame de 'auto'"),
      selectInput("x", "Selecciona el eje de las X",
                  choices = c("weight", "cylinders", 
                              "acceleration", "displacement",
                              "horsepower"))
      ),
    mainPanel(
      tabsetPanel(
        tabPanel("Plot",
                  h3(textOutput("output_text")),
                  plotOutput("output_plot")
                 ),
        tabPanel("Image",
                  img(src="multivariant.png", height = 1000, width=1000)
        ),
        tabPanel("Summary", verbatimTextOutput("summary")),
        tabPanel("Table", tableOutput("table")),
        tabPanel("Data Table", dataTableOutput("datatable"))
      )
    )
  )
)
