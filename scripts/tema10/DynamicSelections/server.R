library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  datasetInput <- reactive(
    switch(input$dataset, 
           "rock" = rock,
           "mtcars" = cars,
           "auto" = auto)
  ) 
  
  output$var <- renderUI({
    radioButtons("varname", 
                 "Elige una variable de las siguientes",
                 names(datasetInput()))
  })
  
  output$plot <- renderPlot({
    if(!is.null(input$varname)){
      if(!input$varname %in% names(datasetInput())){
        colname <- names(datasetInput())[1]
      } else {
        colname <- input$varname
      }
      hist(datasetInput()[,colname],
           main = paste("Histograma de ", colname),
           xlab = colname)
    }
  })
  
  
})
