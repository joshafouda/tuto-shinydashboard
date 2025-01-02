library(shiny)
library(shinydashboard)

header <- dashboardHeader(
  title = "Analysis results for global soccer tournament",
  titleWidth = 400,
  dropdownMenu(type = "messages",
               messageItem("Colleage", "Hello world!")),
  dropdownMenu(type = "notifications",
               notificationItem("Have you rested today?"),
               taskItem("Dashboard completion", value = 20)))

sidebar <- dashboardSidebar(
  sidebarMenu(
    width = 400,
    id = "pages",
    menuItem("Match details", tabName = "matches", icon = icon("futbol"),
             badgeLabel = "New content!", badgeColor = "green"),
    menuItem("Overall results", tabName = "overall", 
             menuSubItem("Charts", tabName = "charts"),
             menuSubItem("Data table", tabName = "datatable", icon=icon("file-excel"))),
    menuItem("A slider",  sliderInput("slider", "Number of goals", min=0, max=10, value = 2))
  )
)

body <- dashboardBody(
  # Add three boxes with widths 2, 2 and 8
  fluidRow(box("Some buttons go here", width = 2, height = 100), 
           box("Checkboxes go here", width = 2, height = 50),
           box("A chart goes here", width = 8, height = 150)),
  # Add one box that fills the entire row and has height 200
  fluidRow(box("Data table goes here"), width = 12, height = 200),
  # Add a third row containing two boxes with equal widths
  fluidRow(box("A slider goes here", width = 6), 
           box("Some info boxes go here", width = 6)),
  
  tabItems(
    tabItem("matches", "Match information goes here"),
    # Link the datatable page and add text "Data table goes here"
    tabItem("datatable", "Data table goes here"),
    # Link the charts page and add text "Charts go here"
    tabItem("charts", "Charts go here")
  )
)

ui <- dashboardPage(header, sidebar, body)

server <- function(input, output){}

shinyApp(ui, server)