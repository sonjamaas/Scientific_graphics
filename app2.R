#install.packages("colourpicker")
library(ggplot2)
library(shiny)
library(colourpicker)


# function that makes plot, non-shiny code outside app
make_plot <- function(mean, sd, abline = FALSE, colour = "orange"){
  df <- data.frame(
    x=rnorm(n = 1000, mean, sd),
    y=rnorm(n = 1000, mean, sd)
    )
  ggplot(df)+
    geom_point(aes(x=x, y=y), colour = colour)+
    if(abline) geom_abline() else NULL
}

# UI
ui <- fluidPage(
  fluidRow(
    column(
      width = 4,
      numericInput("mean", "Mean Value", value = 1), # first input with id mean, label Mean value and standard value 1
      sliderInput("sd", "Standard Deviation", min = 0, max = 100, value = 50), # slider input for sd
      checkboxInput("abline", "Show Abline", value = FALSE), # checkbox input for showing abline
      colourInput("colour", "Select Colour", value = "orange"), # add colour options
      actionButton("generate", label = "Show Plot")
           ),
    column(
      width = 8,
      plotOutput("dist") # standard plot in browser
    )
  )
)

# server
server <- function(input, output, session){
  # timer <- reactiveTimer(1000) # plot is supposed to renew after a certain time
  # myplot <- reactive({  #reactive variable to create plot
  # timer()
  # input$generate
  # make_plot(input$mean, input$sd, input$abline, input$colour)
  # })
  observeEvent(input$generate, { # only if button is pressed the plot is generated and printed
    myplot <- make_plot(input$mean, input$sd, input$abline, input$colour)
    output$dist <- renderPlot(
      print(myplot) # plot has to be printed to ui
    )
  })
}

shinyApp(ui, server)
