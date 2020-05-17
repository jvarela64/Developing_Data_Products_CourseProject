#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

data("mtcars")

shinyUI(pageWithSidebar(  
    headerPanel("MTCars Dataset Linear predicting"),
    sidebarPanel(  
        radioButtons('outcome', 'Select your Outcome Variable', names(mtcars)),
        checkboxGroupInput('predictors', 'Select your Predictor Variables', 
                           names(mtcars), selected ="cyl")),
    mainPanel(
        h2("Result of Calculations"),
        plotOutput("ModelPlot"),
        verbatimTextOutput("printedOutput")
        
    )
))