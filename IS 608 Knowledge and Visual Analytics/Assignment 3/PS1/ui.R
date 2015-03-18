# This is the user interface part of the script
#

library('shiny')
library('ggplot2')
library(googleVis)
setwd('E:/Downloads/Courses/CUNY/SPS/Large Data Space Semester 2/607 Assignment 3/PS1/gVis')

# let's create a list of potential states and years
mort_ui <- read.csv('cleaned-cdc-mortality-1999-2010.csv')

cause  <- lapply(unique(mort_ui$ICD.Chapter), as.character)

# shiny UI
shinyUI(pageWithSidebar(
  headerPanel('Cause of Death by Year, by Type'),
  headerPanel(selectInput("cause", "Cause: ", 
                           choices=cause, selected='Certain infectious and parasitic diseases')),
  mainPanel(htmlOutput('view')))
)

