# interactivity in shiny apps
# Data Viewer
library(shiny)
install.packages("mapview")
library(shinydashboard)
library(leaflet)
library(mapview)
library(colourpicker)

# UI
ui <- navbarPage(
  title="Data Viewer", position = "fixed-top", collapsible = T,
  fluid = T, id = "tabs",
  tabPanel(
    title = "Map", icon = icon("map"),      # icons from fontawesome
    div(style = "padding-top:64px;",
      leafletOutput("map_viewer", width = "100%", height = "90vh") # 100vh = whole viewport
    )
  ),
  tabPanel(
    title = "Settings", icon = icon("sliders"),
    div(style = "padding-top:64px;",
      box(width= 4,
          selectInput("dataset", label = "Select Dataset",
                      choices = c("Breweries", "Franconia"),
                      selected = "Breweries", width = "100%")
         )
    ),
    box(width=4,
        colourInput("colour", label = "Select Clolour", value = "darkblue", width = "100%")
  ),
  box(width = 4,
      selectInput("basemap", label = "Select Basemap", choices = c("CartoDB.Positron", "OpenStreetMap", "Esri.WorldImagery"),
      width = "100%")
)))

# server
server <- function(input, output, session){
  map <- reactive({
    if(input$dataset == "Breweries"){
    data("breweries", package = "mapview")
    map_data <- breweries
    }
    if(input$dataset == "Franconia"){
      data("franconia", package = "mapview")
      map_data <- franconia
    }

    mapview(map_data, layer.name = input$dataset, col.regions = input$colour,
            map.types = input$basemap)@map    #@map for just the leaflet map
  })
  output$map_viewer <- renderLeaflet({
    map()
  })
}

shinyApp(ui, server)
