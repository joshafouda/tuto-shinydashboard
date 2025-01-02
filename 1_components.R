library(shinydashboard)
library(shiny)

header <- dashboardHeader(title = "My first dashboard")

sidebar <- dashboardSidebar()

body <- dashboardBody()

ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
  
}

shinyApp(ui, server)