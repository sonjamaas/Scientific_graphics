#install.packages("shiny")
library(shiny)
#library(ggplot2)
#install.packages("colourpicker")
#library(colourpicker)

pkgs <- installed.packages()
pkgs_avail <- available.packages()


# ui side
ui <- fluidPage(
  actionButton("show", label = "Show my R packages"), # simple button
  uiOutput("elements"), # an UI segment

  #selectInput("pkg", label = "Package", choices = rownames(pkgs)), #create dropdown menu
  verbatimTextOutput("summary"),
  verbatimTextOutput("update")
)



# server side
server <- function(input, output, session){

  output$elements <- renderUI({
    input$show # chekc if button has been clicked
    if(input$show > 0) selectInput("pkgs", label = "Package", choices = rownames(pkgs))
  })

  # reactive function that processes our user input
  selected <- reactive({
    pkgs[rownames(pkgs)==input$pkg,]
    })

  # render a console print if a user selects a package using our selected() function
  output$summary <- renderPrint({
    input$show # wait for button click
    if(input$show > 0){
      cat(paste0(mapply(x = selected(), y = names(selected()), function(x,y){
        paste0(y, ":", x)
      }), collapse = "\n"))
    }

  })

  # render console print based on current and available version
  output$update <- renderPrint({
    input$show
    if(input$show > 0){
    current_version <- selected()["Version"]
    avail_version <- pkgs_avail[rownames(pkgs_avail)==input$pkg, "Version"]

    if(current_version != avail_version) cat("NEW VERSION AVAILABLE!\n")
    cat(paste0("Current version:", current_version, ". Available Version:", avail_version))
    }
  })
}


shinyApp(ui,server)
