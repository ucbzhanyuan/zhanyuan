# Zhanyuan Zhang
# Shiny App: P(Z is odd) Simulation
# Inputs:
#   repetitions: number of sampling
#   seed: random seed
#
# Outputs:
#   frequency plot of number of odd z
#   approximate P(Z is odd)

library(shiny)
library(ggplot2)
# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("P(Z is odd)"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("times",
                  "Number of sampling:",
                  min = 1,
                  max = 100000,
                  value = 50000),
      numericInput("seed",
                   "Choose a random seed",
                   value = 42)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("freqPlot"),
      wellPanel(textOutput("prob"))
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$freqPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    repetitions = input$times
    set.seed(input$seed)
    x <- runif(repetitions, min = 0, max = 1)
    y <- runif(repetitions, min = 0, max = 1)
    z <- round(y/x, digits = 0)
    
    is_odd <- rep(0, repetitions)
    for (i in 1:repetitions) {
      if (z[i] %% 2 != 0) {
        is_odd[i] <- 1
      } else {
        is_odd[i] <- 0
      }
    }
    freq <- cumsum(is_odd) / 1:repetitions
    
    ggplot(data = as.data.frame(freq), aes(x = 1:input$times, y = freq)) +
      geom_path() +
      ylim(low = 0, high = 1) +
      geom_hline(yintercept = 0.5, color = "gray50") +
      ylab("frequency") +
      xlab("number of sampling")
  })
  output$prob <- renderPrint({
    repetitions = input$times
    set.seed(input$seed)
    x <- runif(repetitions, min = 0, max = 1)
    y <- runif(repetitions, min = 0, max = 1)
    z <- round(y/x, digits = 0)
    
    is_odd <- rep(0, repetitions)
    for (i in 1:repetitions) {
      if (z[i] %% 2 != 0) {
        is_odd[i] <- 1
      } else {
        is_odd[i] <- 0
      }
    }
    freq <- cumsum(is_odd) / 1:repetitions
    
    cat("P(Z is odd) is approximately ", freq[repetitions])
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

