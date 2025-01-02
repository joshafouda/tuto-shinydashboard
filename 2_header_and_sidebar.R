library(shinydashboard)
library(shiny)

header <- dashboardHeader(
  title = "Analysis for global soccer tournament",
  titleWidth = 400, # Argument pour étendre l'espace pour les titres longs
  dropdownMenu(
    type = "messages",
    messageItem("Data division",
                "Keep up the good work!",
                time = "5 mins"),
    messageItem("Twitter",
                "You have a Tweet!",
                time = "1 hour",
                icon = icon("twitter")),
    notificationItem("This is a notification."),
    taskItem(value = 30, color = "blue", "Dashboard construction")
  ),
  dropdownMenu(type = "notifications",
               notificationItem("Have you rested today?"),
               taskItem("Dashboard completion", value = 20))
)

sidebar <- dashboardSidebar(
  width = 400, # pour definier la largeur de la barre latérale
  #disable = TRUE, # TRUE = supprimer la barre latérale
  sidebarMenu(
    id = "pages",
    menuItem("Many charts",
             icon = icon("chart-line"),
             tabName = "charts",
             badgeLabel = "New content!",
             badgeColor = "green"),
    menuItem("Statistics",
             icon = icon("file-excel"),
             tabName = "stats",
             badgeLabel = "Urgent",
             badgeColor = "red"),
    menuItem("A couple of checkboxes",
             checkboxGroupInput(
               "checkboxes",
               "Day of the week",
               choices = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"),
               selected = c("Mon", "Tue", "Wed", "Thu", "Fri")
             )),
    menuItem("Overall results", tabName = "overall", 
             # Add two subtabs called "Charts" and "Data table"
             menuSubItem("Charts", tabName = "charts"),
             menuSubItem("Data table", tabName = "datatable", icon=icon("file-excel")))
  )
)

body <- dashboardBody()

ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
  
}

shinyApp(ui, server)