library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$plot <- renderPlot({
    if(input$plot_type == "histogram"){
      hist(auto$mpg)
    } else {
      plot(auto[,input$x], auto$mpg, xlab = input$x, ylab = "mpg")
    }
  })
  
})
