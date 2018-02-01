library(shiny)

auto <- read.csv("../../../data/tema10/auto-mpg.csv")

shinyServer(function(input, output) {
  output$output_text <- renderText(paste("mpg ~ ", input$x))
  output$output_plot <- renderPlot(plot(as.formula(paste("mpg ~",input$x)),
                                        data = auto)
                                   )
  output$summary <- renderPrint({
    summary(auto)
    })
  
  output$table <- renderTable({
    data.frame(x=auto)
  })
  
  output$datatable <- renderDataTable({
    auto
  }, options = list(aLengthMenu = c(5,25,50),
                    iDisplayLength = 5)
  )
})
