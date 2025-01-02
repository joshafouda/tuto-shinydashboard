# Charger les bibliothèques nécessaires
library(dplyr)
library(ggplot2)
library(shiny)
library(shinydashboard)

# Données et fonctions pour tracer les graphiques
source("utils.R")

# Définir l'interface utilisateur
header <- dashboardHeader(title = "Sales Dashboard")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Overview", tabName = "overview", icon = icon("dashboard"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "overview",
            fluidRow(
              valueBoxOutput("total_sales", width = 4),
              valueBoxOutput("top_product", width = 4),
              valueBoxOutput("top_revenue_product", width = 4)
            ),
            fluidRow(
              box(title = "Quantités vendues", status = "primary", solidHeader = TRUE,
                  plotOutput("histogram"), width = 12)
            ),
            fluidRow(
              box(title = "Parts de marché", status = "primary", solidHeader = TRUE,
                  plotOutput("pie_chart"), width = 6),
              box(title = "Ventes moyennes", status = "primary", solidHeader = TRUE,
                  selectInput("product", "Choisissez un produit", choices = unique(sales$product)),
                  plotOutput("avg_sales_curve"), width = 6)
            )
    )
  )
)

# Définir l'interface Utilisateur
ui <- dashboardPage(
  header,
  sidebar,
  body
)

# Définir le serveur
server <- function(input, output) {
  output$total_sales <- renderValueBox({
    valueBox(
      total_sales_fn(), 
      "Total Sales", 
      icon = icon("dollar-sign"), 
      color = "green"
    )
  })
  
  output$top_product <- renderValueBox({
    valueBox(
      top_product_fn(), 
      "Top Product", 
      icon = icon("trophy"), 
      color = "blue"
    )
  })
  
  output$top_revenue_product <- renderValueBox({
    valueBox(
      top_revenue_product_value_fn(), 
      "Top Revenue Product", 
      icon = icon("chart-line"), 
      color = "purple"
    )
  })
  
  output$histogram <- renderPlot({
    plot_histogram()
  })
  
  output$pie_chart <- renderPlot({
    plot_pie_chart()
  })
  
  output$avg_sales_curve <- renderPlot({
    plot_avg_sales_curve(input$product)
  })
  
}

# Créer l'application Shiny
shinyApp(ui, server)
