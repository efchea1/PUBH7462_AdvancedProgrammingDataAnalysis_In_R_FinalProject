library(shiny)
library(tidyverse)
# source("Functions.R") #this fuction is not needed to run the code

library(shiny)
library(ggplot2)
library(readr)
library(kableExtra)
library(dplyr)
library(tidyverse)

Diwali <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-11-14/diwali_sales_data.csv')

## hard coded data
# Data <- read_csv("C:/Users/Payne/Desktop/Spring2024/PubH7462/FinalProject/diwali_sales_data.csv")
# SalesData <- Data[-c(844,1274),]
SalesData <- Diwali[,-2] #removes column with peoples' names, had Ascii characters

# Here we are rearrangiing the data to be easier to read
SalesData <- SalesData %>%
  mutate(State = as.factor(State), Gender = as.factor(Gender), Zone = as.factor(Zone), Occupation = as.factor(Occupation), Product_Category = as.factor(Product_Category), AgeGroup = as.factor(SalesData$`Age Group`)) %>%
  select(-(`Age Group`))

ages <- (levels(SalesData$AgeGroup)) #saves the ages in order for better looking ui
states <- (levels(SalesData$State)) #saves  for better looking ui
zones <- (levels(SalesData$Zone)) #saves for better looking ui
Occup <- (levels(SalesData$Occupation)) #saves for better looking ui

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # App title ----
  titlePanel("Diwali Sales Data"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      #Add buttons to pick plot
      radioButtons("plots", "Plotting Type:",
                   c("BarPlot" = "BarPlot",
                     "Scatter" = "Scatter",
                     "Occupation" = "Occupation")),
      
      # br() element to introduce extra vertical spacing ----
      
      selectInput("states","State:",
                  c("All", states))
      ,
      selectInput("zones","Zone:",
                  c("All", zones))
      ,
      selectInput("agegroups","AgeGroup:",
                  c("All", ages))
      ,
      selectInput("occupation","Occupation:",
                  c("All", Occup))
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Tabset w/ plot, table, and summary ----
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("plot"),
                           br(),
                           p("Above are some of the general plots we made to intrepret some of the data from Diwali Sales. 
                           We created three, a boxplot, a scatter plot, and a barchart. 
                           Each of these graphs are affected by the tabs on the left side, giving the abilty to generally visualize the data from Diwali Sales.
                           (Note: When choosing a State or Zone, they need to exist in each for the plot to render. i.e. Zone = Central and State = Dheli will work, but not Zone = Central and State = Bihar.) 
                             ", style = "font-family: 'times'; font-si16pt"),
                           # strong("strong() makes bold text."),
                           # em("em() creates italicized (i.e, emphasized) text."),
                           # br(),
                           # code("code displays your text similar to computer code"),
                           # div("div creates segments of text with a similar style. This division of text is all blue because I passed the argument 'style = color:blue' to div", style = "color:blue"),
                           # br(),
                           # p("span does the same thing as div, but it works with",
                           #   span("groups of words", style = "color:blue"),
                           #           "that appear inside a paragraph.")
                  ),
                  tabPanel("Table", DT::dataTableOutput("table")),
                  tabPanel("Summary", tableOutput("kable_out"))
                  
      )
      
      
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Generate a plot of the data ----
  output$plot <-renderPlot({
    
    #I think if this is changed to a reactive variable we can reduce the number of if statements
    #if statements make it so it only shows chosen attributes
    data <- SalesData
    if (input$states != "All") {
      data <- data[data$State == input$states,]
    }
    if (input$zones != "All") {
      data <- data[data$Zone == input$zones,]
    }
    if (input$agegroups != "All") {
      data <- data[data$AgeGroup == input$agegroups,]
    }
    if (input$occupation != "All") {
      data <- data[data$Occupation == input$occupation,]
    }
    
    # if statement to choose type of plot
    if (input$plots == "BarPlot") { # plots number of orders by gender and age group
      data %>%
        group_by(Gender, AgeGroup) %>%
        summarise(`Number of Orders` = n()) %>%
        ggplot(aes(x = AgeGroup, y = `Number of Orders` , fill = Gender)) +
        geom_bar(position = "dodge", stat = "identity") +
        theme_classic() +
        ggtitle(paste(input$plots))+
        labs( caption = "Plots number of orders by gender and age group, changing the inputs for Age and Gender will affect this plot.")
    } 
    else if (input$plots == "Scatter") { # plots number of orders by product category and age
      data %>%
        group_by(Product_Category, Age) %>%
        summarise(`Number of Orders` = n()) %>%
        ggplot(aes(Age, `Number of Orders`)) +
        geom_point(aes(color = Product_Category)) +
        theme_classic() +
        ggtitle(paste(input$plots))+
        labs( caption = "Plots number of orders by product category and age, changing the inputs for Age will affect this plot")
    } 
    else { # plots how many customers there are per occupation
      data %>%
        ggplot(aes( Occupation , fill = Occupation)) +
        geom_bar() +
        theme_classic() +
        theme(axis.text.x = element_blank())+
        ggtitle(paste(input$plots))+
        ylab("Number of customers")+
        labs( caption = "Plots how many customers there are per occupation.")
    }
    
  })
  
  # Generate summary of specfied data
  output$kable_out <- function() {
    data <- SalesData
    if (input$states != "All") {
      data <- data[data$State == input$states,]
    }
    if (input$zones != "All") {
      data <- data[data$Zone == input$zones,]
    }
    if (input$agegroups != "All") {
      data <- data[data$AgeGroup == input$agegroups,]
    }
    if (input$occupation != "All") {
      data <- data[data$Occupation == input$occupation,]
    }
    out <- data %>%
      select( Age, State, Zone, Orders, Amount ) %>%
      group_by(State, Zone) %>%
      summarise(across(everything(), list(min = min, max = max, Median = median), na.rm = TRUE))
    
    print(kable(out) %>%
            kable_styling(bootstrap_options = c("striped", "hover", "condensed")))
  }
  
  # # Generate an HTML table view of the data ----
  output$table <- DT::renderDataTable(DT::datatable({
    data <- SalesData
    if (input$states != "All") {
      data <- data[data$State == input$states,]
    }
    if (input$zones != "All") {
      data <- data[data$Zone == input$zones,]
    }
    if (input$agegroups != "All") {
      data <- data[data$AgeGroup == input$agegroups,]
    }
    if (input$occupation != "All") {
      data <- data[data$Occupation == input$occupation,]
    }
    data #basic table from DT::datatable had the best render
  }))
  
}

# Run the application
shinyApp(ui = ui, server = server)