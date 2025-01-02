# *Your First Shiny Dashboard: A Beginner’s Guide to shinydashboard in R*

## **Introduction:**  
In today’s data-driven world, creating visually appealing and interactive dashboards is a highly sought-after skill. While paid tools like PowerBI and Tableau offer robust solutions, they often come with steep learning curves and licensing costs that might not be feasible for everyone. This is where **R** and its versatile ecosystem shine, particularly with the **shinydashboard** package.

**shinydashboard** is an extension of R’s popular **Shiny** framework, designed to help you create professional dashboards with minimal effort. Unlike other tools, shinydashboard allows you to build fully functional dashboards using only R code—no need to dive into additional programming languages or expensive software suites. The package streamlines the layout and design of dashboards, offering pre-built components like menus, boxes, and tabbed content, so you can focus on showcasing your data and insights.

Advantages of using shinydashboard over paid tools include:  
- **Cost:** Completely free and open-source, eliminating the need for licensing fees.  
- **Flexibility:** Seamlessly integrates with the vast R ecosystem, allowing you to leverage R's powerful data manipulation and visualization capabilities.  
- **Customization:** Unlike fixed templates in paid tools, you can fully customize the functionality and aesthetics of your dashboard with R and CSS.  
- **Portability:** Dashboards can be hosted on your own server, shared through Shinyapps.io, or embedded in existing websites.  
- **Transparency:** Being open-source, you have full control over your code, ensuring reproducibility and transparency in your work.  

This guide will walk you through the steps to build your very first dashboard using shinydashboard. Whether you’re an analyst, data scientist, or curious beginner, you’ll see just how easy and rewarding it is to create a dashboard that’s not only functional but also visually impressive—all without spending a dime.


## **Section 1: Understanding the Overall Structure of a shinydashboard Application**  

![](./images/components.png)

Building a dashboard with **shinydashboard** begins with understanding its fundamental structure. Like all Shiny applications, a shinydashboard app consists of two main components: the **UI (User Interface)** and the **server** logic. These components work together to define the layout, appearance, and functionality of your dashboard. Let’s break down the code step by step to see how it all comes together.  

### Code Overview  
Here’s a simple script that serves as the skeleton for a shinydashboard app:  

```R
library(shinydashboard)
library(shiny)

header <- dashboardHeader(title = "My first dashboard")

sidebar <- dashboardSidebar()

body <- dashboardBody()

ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
  
}

shinyApp(ui, server)
```  

### Explanation  

#### 1. **Loading Required Libraries**  
```R
library(shinydashboard)
library(shiny)
```  
The **shinydashboard** package is an extension of the **shiny** package, so both libraries are essential. The `shinydashboard` library provides prebuilt components and layouts specifically designed for dashboards, while `shiny` handles the core functionality of the app.  

#### 2. **Defining the Dashboard Components**  
A shinydashboard app is structured around three main layout components:  
- **Header:** Defines the top bar of the dashboard.  
- **Sidebar:** Contains navigation elements like menus and links.  
- **Body:** The main area where the content (e.g., plots, tables, text) is displayed.  

```R
header <- dashboardHeader(title = "My first dashboard")
```  
The `dashboardHeader()` function creates the header of the dashboard. Here, we’ve specified a title, “My first dashboard,” which will appear prominently in the header.  

```R
sidebar <- dashboardSidebar()
```  
The `dashboardSidebar()` function defines the sidebar. In this example, it’s currently empty, but later, you can populate it with navigation menus, input controls, or other elements.  

```R
body <- dashboardBody()
```  
The `dashboardBody()` function specifies the main content area. Like the sidebar, it’s currently empty, but you’ll soon add widgets, plots, and more to make your dashboard interactive and informative.  

#### 3. **Assembling the UI**  
```R
ui <- dashboardPage(header, sidebar, body)
```  
The `dashboardPage()` function combines the header, sidebar, and body into a cohesive layout. This creates the UI (User Interface) for the dashboard.  

#### 4. **Defining the Server Logic**  
```R
server <- function(input, output) {
  
}
```  
The `server` function is where you define the logic for your dashboard. It connects inputs (like dropdowns or sliders) to outputs (like plots or tables). In this basic example, the server is empty, as there’s no interactive functionality yet.  

#### 5. **Running the App**  
```R
shinyApp(ui, server)
```  
The `shinyApp()` function takes the `ui` and `server` components and launches the app. Running this script will generate a simple, empty dashboard with a header, sidebar, and body.  

---

This structure serves as the foundation for any shinydashboard application. By filling in the sidebar and body with menus, inputs, and outputs, and defining interactions in the server, you’ll transform this skeleton into a fully functional and visually appealing dashboard.  

In the next section, we’ll explore how to customize the sidebar and add interactive elements to make the dashboard come alive!  


## **Section 2: Customizing the Header and Sidebar in shinydashboard**  

Once the foundational structure of a **shinydashboard** application is in place, you can begin customizing its components to fit your needs. Two of the most visually prominent and interactive elements of a dashboard are the **header** and **sidebar**. This section explores various options available for these components, using the `2_header_and_sidebar.R` script as a guide.

---

### **1. Customizing the Header**  
The **header** is the top bar of the dashboard and serves as a space for titles, branding, and notifications.  

```R
header <- dashboardHeader(
  title = "Analysis for global soccer tournament",
  titleWidth = 400,
  dropdownMenu(
    type = "messages",
    messageItem("Data division", "Keep up the good work!", time = "5 mins"),
    messageItem("Twitter", "You have a Tweet!", time = "1 hour", icon = icon("twitter")),
    notificationItem("This is a notification."),
    taskItem(value = 30, color = "blue", "Dashboard construction")
  ),
  dropdownMenu(
    type = "notifications",
    notificationItem("Have you rested today?"),
    taskItem("Dashboard completion", value = 20)
  )
)
```

#### Key Features:  
1. **Title and Width**  
   - The `title` argument sets the text displayed in the header.  
   - `titleWidth` adjusts the space allocated for the title, useful for longer text like "Analysis for global soccer tournament."  

2. **Dropdown Menus**  
   - The `dropdownMenu()` function adds interactive dropdown menus for **messages**, **notifications**, or **tasks**.  
   - Each dropdown menu can include specific items:
     - **`messageItem`**: Displays a message with optional metadata like time and an icon.  
     - **`notificationItem`**: Adds a simple notification to the dropdown.  
     - **`taskItem`**: Shows a progress indicator with a value and color to represent task completion.  
   - Here, the header includes two dropdown menus: one for messages and one for notifications.  

---

### **2. Configuring the Sidebar**  
The **sidebar** is a vertical navigation panel where you can add menus, inputs, and other controls.  

```R
sidebar <- dashboardSidebar(
  width = 400,
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
    menuItem("Overall results", 
             tabName = "overall", 
             menuSubItem("Charts", tabName = "charts"),
             menuSubItem("Data table", tabName = "datatable", icon = icon("file-excel")))
  )
)
```

#### Key Features:  
1. **Width and Visibility**  
   - `width`: Sets the sidebar’s width. In this example, it’s expanded to 400 pixels.  
   - `disable`: Can be set to `TRUE` to hide the sidebar entirely.  

2. **Sidebar Menu**  
   - `sidebarMenu()` organizes navigation items into a hierarchy.  
   - The `id` parameter allows the app to track which menu item is selected.  

3. **Menu Items**  
   - `menuItem()`: Creates navigation links. Each item can have:  
     - **`tabName`**: Links the menu item to a specific tab in the dashboard body.  
     - **`icon`**: Adds an icon (using Font Awesome) to the menu item for better visualization.  
     - **Badges**: `badgeLabel` and `badgeColor` add a label with a customizable color to highlight menu items (e.g., "New content!").  

4. **Inputs in the Sidebar**  
   - The sidebar can include interactive inputs. For example, `checkboxGroupInput()` adds checkboxes for selecting days of the week.  

5. **Submenus**  
   - `menuSubItem()`: Creates nested items under a main menu item. For instance, the “Overall results” menu has two subtabs: “Charts” and “Data table.”  

---

### **Summary**  
This section of the dashboard showcases how flexible and customizable the header and sidebar are in shinydashboard. The header can serve as a hub for messages, notifications, and branding, while the sidebar is perfect for organizing navigation and controls. Together, these elements enhance user experience and make your dashboard intuitive and visually appealing.

In the next section, we’ll populate the **body** with content, such as plots, tables, and interactive elements, to bring the dashboard to life!  