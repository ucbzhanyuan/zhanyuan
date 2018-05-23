#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  # Uniform sampling
  rv <- reactiveValues(
    U1 = runif(2500),
    U2 = runif(2500),
    U3 = runif(2500),
    U4 = runif(2500))
  # resample button
  observeEvent(input$resample, { rv$U1 <- runif(2500) })
  observeEvent(input$resample2, { rv$U2 <- runif(2500) })
  observeEvent(input$resample3, { rv$U3 <- runif(2500) })
  observeEvent(input$resample4, { rv$U4 <- runif(2500) })
  
  vis_unif <- reactive({
    dat <- data.frame(u = rv$U1)
    dat %>% ggvis(~u) %>%
      layer_histograms(fill := "grey", fillOpacity := 0.6, fillOpacity.hover := 0.8) %>%
      layer_freqpolys(stroke := "red", strokeWidth := 2) %>%
      add_axis("x", title = "Histogram of uniform samples") %>%
      set_options(width = 700, height = 300)
  })
  vis_unif %>% bind_shiny("unif")
  
  vis_unif <- reactive({
    dat <- data.frame(u = rv$U2)
    dat %>% ggvis(~u) %>%
      layer_histograms(fill := "grey", fillOpacity := 0.6, fillOpacity.hover := 0.8) %>%
      layer_freqpolys(stroke := "red", strokeWidth := 2) %>%
      add_axis("x", title = "Histogram of uniform samples") %>%
      set_options(width = 700, height = 300)
  })
  vis_unif %>% bind_shiny("unif2")
  
  vis_unif <- reactive({
    dat <- data.frame(u = rv$U3)
    dat %>% ggvis(~u) %>%
      layer_histograms(fill := "grey", fillOpacity := 0.6, fillOpacity.hover := 0.8) %>%
      layer_freqpolys(stroke := "red", strokeWidth := 2) %>%
      add_axis("x", title = "Histogram of uniform samples") %>%
      set_options(width = 700, height = 300)
  })
  vis_unif %>% bind_shiny("unif3")
  
  vis_unif <- reactive({
    dat <- data.frame(u = rv$U4)
    dat %>% ggvis(~u) %>%
      layer_histograms(fill := "grey", fillOpacity := 0.6, fillOpacity.hover := 0.8) %>%
      layer_freqpolys(stroke := "red", strokeWidth := 2) %>%
      add_axis("x", title = "Histogram of uniform samples") %>%
      set_options(width = 700, height = 300)
  })
  vis_unif %>% bind_shiny("unif4")
  
  # exponential cdf
  output$expdens <- renderPlot({
    ggplot(data = data.frame(x = c(0, 10)), aes(x = x)) +
      stat_function(fun = function(x) 1 - exp(-3 * x), color = "blue") +
      ggtitle("CDF of Exponential Distribution")
  })
  
  # normal cdf
  output$nordens <- renderPlot({
    ggplot(data = data.frame(x = c(-5, 5)), aes(x = x)) +
      stat_function(fun = pnorm, args = list(mean = 0, sd = 1), color = "blue") +
      ggtitle("CDF of Normal Distribution")
    
  })
  
  # beta cdf
  output$betdens <- renderPlot({
    ggplot(data = data.frame(x = c(0, 1)), aes(x = x)) +
      stat_function(fun = pbeta, args = list(shape1 = 2, shape2 = 3), color = "blue") +
      ggtitle("CDF of Beta Distribution")
  })
  
  # gamma cdf
  output$gamdens <- renderPlot({
    ggplot(data = data.frame(x = c(0, 0.6)), aes(x = x)) +
      stat_function(fun = pgamma, args = list(shape = 3, scale = 0.05), color = "blue") +
      ggtitle("CDF of Gamma Distribution")
  })
  
  
  # exponential
  vis_exp <- reactive({
    dat <- data.frame(u = rv$U1)
    X1 <- c()
    for (i in 1:length(rv$U1)) {
      X1[i] <- invexpon(rv$U1[i])
    }
    dat <- mutate(dat, X1 = X1)
    dat %>% ggvis(~X1) %>%
      layer_histograms(fill := "grey", fillOpacity := 0.6, fillOpacity.hover := 0.8) %>%
      layer_freqpolys(stroke := "red", strokeWidth := 2) %>%
      add_axis("x", title = "Density Curve of Exponential Distribution") %>%
      set_options(width = 700, height = 300)
  })
  vis_exp %>% bind_shiny("exp")
  
  # normal
  vis_nor <- reactive({
    dat2 <- data.frame(u = rv$U2)
    X2 <- c()
    for (i in 1:length(rv$U2)) {
      X2[i] <- invnorm(rv$U2[i])
    }
    dat2 <- mutate(dat2, X2 = X2)
    dat2 %>% ggvis(~X2) %>%
      layer_histograms(fill := "grey", fillOpacity := 0.6, fillOpacity.hover := 0.8) %>%
      layer_freqpolys(stroke := "red", strokeWidth := 2) %>%
      add_axis("x", title = "Density Curve of Normal Distribution") %>%
      set_options(width = 700, height = 300)
  })
  vis_nor %>% bind_shiny("nor")
  
  # beta
  vis_bet <- reactive({
    dat3 <- data.frame(u = rv$U3)
    X3 <- c()
    for (i in 1:length(rv$U3)) {
      X3[i] <- invbeta23(rv$U3[i])
    }
    dat3 <- mutate(dat3, X3 = X3)
    dat3 %>% ggvis(~X3) %>%
      layer_histograms(fill := "grey", fillOpacity := 0.6, fillOpacity.hover := 0.8) %>%
      layer_freqpolys(stroke := "red", strokeWidth := 2) %>%
      add_axis("x", title = "Density Curve of Beta Distribution") %>%
      set_options(width = 700, height = 300)
  })
  vis_bet %>% bind_shiny("bet")
  
  # Gamma
  vis_gam <- reactive({
    dat4 <- data.frame(u = rv$U4)
    X4 <- c()
    for (i in 1:length(rv$U4)) {
      X4[i] <- invgamma6(rv$U4[i])
    }
    dat3 <- mutate(dat4, X4 = X4)
    dat3 %>% ggvis(~X4) %>%
      layer_histograms(fill := "grey", fillOpacity := 0.6, fillOpacity.hover := 0.8) %>%
      layer_freqpolys(stroke := "red", strokeWidth := 2) %>%
      add_axis("x", title = "Density Curve of Gamma Distribution") %>%
      set_options(width = 700, height = 300)
  })
  vis_gam %>% bind_shiny("gam")
  
  
})
