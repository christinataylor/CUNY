# This is the user interface part of the script
#

library('shiny')
library('ggplot2')
setwd('/Users/Charley/Downloads/cuny/IS 608 Knowledge and Visual Analytics/Assignment 3/PS1/ggplot')

# let's create a list of potential states and years
mort_ui <- read.csv('cleaned-cdc-mortality-1999-2010.csv')

cause  <- lapply(unique(mort_ui$ICD.Chapter), as.character)

# shiny UI
shinyUI(pageWithSidebar(
  headerPanel('Cause of Death by Year, by Type'),
  sidebarPanel(selectInput("cause", "Cause: ", 
                           choices=cause, selected='Certain infectious and parasitic diseases')),
  mainPanel(plotOutput('values')))
)

