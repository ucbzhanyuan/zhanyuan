###########################################################
# Title: Grade Visualizer
#
# Description:
#   This shiny app contains three tabs (see 'tabsetPanel()'): Barchart, Histogram, and Scatterplot
#   Each tab shows a different sidebar panel.
#   The sibar bar panels are handled with 'conditionalPanel()'
#
# Details:
#   The graphics in each tab are obtained with ggvis
#
# Author: Zhanyuan Zhang
###########################################################

# required packages
library(shiny)
library(ggvis)
library(dplyr)
library(stringr)
# load dataset
cleanscores <- read.csv("../data/cleandata/cleanscores.csv")

# needed function
source("../code/functions.R")

# convert Grade as a factor, for barcharts
cleanscores$Grade <- factor(cleanscores$Grade, levels = c("A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D", "F"))

# Variable names
assignment <- names(cleanscores)

# Grade Distribution
grade_dist <- as.data.frame(table(cleanscores$Grade))
names(grade_dist) <- c("Grade", "Freq")
grade_dist <- mutate(grade_dist, Prop = Freq / sum(Freq))

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Grade Visualizer"),
  
  # Sidebar with different widgets depending on the selected tab
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(condition = "input.tabselected==1",
                       h4("Grades Distribution"),
                       tableOutput("grade_dist")),
      
      conditionalPanel(condition = "input.tabselected==2",
                       selectInput("var", "X-axis variable", assignment[-23], 
                                   selected = "HW1"),
                       sliderInput("width", "Bin Width",
                                   min = 1, max = 10,
                                   value = 10)),
      
      conditionalPanel(condition = "input.tabselected==3",
                       selectInput("xvalue", "X-axis variable", assignment[-23],
                                   selected = "Test1"),
                       selectInput("yvalue", "Y-axis variable", assignment[-23],
                                   selected = "Overall"),
                       sliderInput("opacity", "Opacity", 
                                   min = 0, max = 1, value = 0.5),
                       radioButtons("model", "Show line",
                                    choices = list("none" = 1, "lm" = 2, "loess" = 3),
                                    selected = 1))
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Barchart", value = 1, 
                           ggvisOutput("barchart")),
                  tabPanel("Histogram", value = 2, 
                           ggvisOutput("histogram"),
                           h4("Summary Statistics"),
                           verbatimTextOutput("summary")),
                  tabPanel("Scatterplot", value = 3,
                           ggvisOutput("scatterplot"),
                           h4("Correlation"),
                           wellPanel(textOutput("correlation"))),
                  id = "tabselected")
    )
  )
)


# Define server logic
server <- function(input, output) {
  # Barchart (for the 1st tab)
  vis_barchart <- reactive({
    output$grade_dist <- renderTable(grade_dist)
    cleanscores %>% ggvis(x = ~Grade, fill := "skyblue") %>%
      layer_bars(stroke := 'skyblue',
                 fillOpacity := 0.8, fillOpacity.hover := 1) %>%
      add_axis("y", title = "frequency")
  })
  vis_barchart %>% bind_shiny("barchart")
  
  # Histogram (for the 2nd tab)
  vis_histogram <- reactive({
    var <- prop("x", as.symbol(input$var))
    cleanscores %>% 
      ggvis(x = var, fill := "#abafb5") %>% 
      layer_histograms(stroke := 'white',
                       width = input$width)
  })
  vis_histogram %>% bind_shiny("histogram")
  output$summary <- renderPrint(print_stats(cleanscores[[input$var]]))
  
  # Scatterplot (for the 3rd tab)
  vis_scatter <- reactive({
    xvalue <- prop("x", as.symbol(input$xvalue))
    yvalue <- prop("y", as.symbol(input$yvalue))
    if (input$model == 1) {
      cleanscores %>% 
        ggvis(x = xvalue, y = yvalue, fill := "black") %>% 
        layer_points(fillOpacity := input$opacity)
    } else if (input$model == 2) {
      cleanscores %>% 
        ggvis(x = xvalue, y = yvalue, fill := "black") %>% 
        layer_points(fillOpacity := input$opacity) %>% 
        layer_model_predictions(model = "lm")
    } else if (input$model == 3) {
      cleanscores %>% 
        ggvis(x = xvalue, y = yvalue, fill := "black") %>% 
        layer_points(fillOpacity := input$opacity) %>% 
        layer_model_predictions(model = "loess")
    }
  })
  vis_scatter %>% bind_shiny("scatterplot")
  output$correlation <- renderPrint(cat(cor(cleanscores[[input$xvalue]], cleanscores[[input$yvalue]])))
}

# Run the application 
shinyApp(ui = ui, server = server)
