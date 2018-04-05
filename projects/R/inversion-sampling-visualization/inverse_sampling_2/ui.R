#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# required packages
library(shiny)
library(ggplot2)
library(ggvis)
library(dplyr)
library(GoFKernel)
# import cdf
source("functions.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Inverse Sampling"),
  
  tabsetPanel(
    tabPanel(title = "Exponential",
             fluidRow(
               column(6, ggvisOutput("unif"),
                      actionButton("resample", "Resample")),
               column(6, plotOutput("expdens"))
             ),
             fluidRow(
               column(6),
               column(6, ggvisOutput("exp"))
             )
    ),
    tabPanel(title = "Normal",
             fluidRow(
               column(6, ggvisOutput("unif2"),
                      actionButton("resample2", "Resample")),
               column(6, plotOutput("nordens"))
             ),
             fluidRow(
               column(6),
               column(6, ggvisOutput("nor"))
             )
    ),
    tabPanel(title = "Beta",
             fluidRow(
               column(6, ggvisOutput("unif3"),
                      actionButton("resample3", "Resample")),
               column(6, plotOutput("betdens"))
             ),
             fluidRow(
               column(6),
               column(6, ggvisOutput("bet"))
             )
    ),
    tabPanel(title = "Gamma",
             fluidRow(
               column(6, ggvisOutput("unif4"),
                      actionButton("resample4", "Resample")),
               column(6, plotOutput("gamdens"))
             ),
             fluidRow(
               column(6),
               column(6, ggvisOutput("gam"))
             )
    )
  )
))
