library(dplyr)
library(ggplot2)

set.seed(123) # Pour la reproductibilité

# Simuler le dataframe des ventes
sales <- tibble(
  sale_id = 1:100,
  product = sample(c("Product A", "Product B", "Product C"), 100, replace = TRUE),
  date = seq.Date(from = as.Date("2023-01-01"), by = "days", length.out = 100),
  quantity = sample(1:20, 100, replace = TRUE),
  price = sample(10:100, 100, replace = TRUE)
) %>% 
  mutate(total = quantity * price)

# Fonction pour obtenir les ventes totales
total_sales_fn <- function() {
  sum(sales$total)
}

# Fonction pour obtenir le produit le plus vendu
top_product_fn <- function() {
  sales %>%
    group_by(product) %>%
    summarize(total_quantity = sum(quantity)) %>%
    arrange(desc(total_quantity)) %>%
    slice(1) %>%
    pull(product)
}

# Fonction pour obtenir le revenu total du produit avec le revenu le plus élevé
top_revenue_product_value_fn <- function() {
  sales %>%
    group_by(product) %>%
    summarize(total_revenue = sum(total)) %>%
    arrange(desc(total_revenue)) %>%
    slice(1) %>%
    pull(total_revenue)
}

# Fonction pour tracer un histogramme des quantités vendues
plot_histogram <- function() {
  ggplot(sales, aes(quantity)) + 
    geom_histogram(bins = 10, fill = 'blue', col = 'white') + 
    labs(title = 'Distribution des quantités vendues', x = 'Quantité', y = 'Fréquence') + 
    theme_classic()
}

# Fonction pour tracer un diagramme circulaire des parts de marché
plot_pie_chart <- function() {
  product_sales <- sales %>%
    group_by(product) %>%
    summarize(total_sales = sum(total))
  
  ggplot(product_sales, aes(x = "", y = total_sales, fill = product)) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar("y", start = 0) +
    labs(title = "Parts de marché par produit", x = "", y = "") +
    theme_void()
}

# Fonction pour tracer la courbe des ventes moyennes par produit
plot_avg_sales_curve <- function(product_filter) {
  avg_sales <- sales %>%
    filter(product == product_filter) %>%
    group_by(date) %>%
    summarize(avg_sales = mean(total))
  
  ggplot(avg_sales, aes(date, avg_sales)) +
    geom_line(color = 'purple') +
    labs(title = paste("Ventes moyennes pour", product_filter), x = 'Date', y = 'Ventes moyennes') +
    theme_classic()
}
