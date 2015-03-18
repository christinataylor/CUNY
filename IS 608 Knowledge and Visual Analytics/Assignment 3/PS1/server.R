# This script determines what the server does.
# 

library('shiny')
library('plyr')
library('ggplot2')
library(googleVis)
library(dplyr)
setwd('E:/Downloads/Courses/CUNY/SPS/Large Data Space Semester 2/607 Assignment 3/PS1/gVis')

# load data
mort <- read.csv('cleaned-cdc-mortality-1999-2010.csv')

# let's just get the 'crude rate' of deaths for one state
# in one year
shinyServer(function(input, output){
  
  outputPlot <- function(){
    # subset

    in_cause <- input$cause
    #in_cause <- as.character(unique(mort$ICD.Chapter)[1])
    
    slcted <- mort %>%
      filter(ICD.Chapter==in_cause, mort$Year==2010) %>%
      select(State, Crude.Rate) %>%
      arrange(desc(Crude.Rate))
    
    #p <- ggplot(slcted, aes(x=reorder(State, Crude.Rate), y=Crude.Rate)) +
    #  geom_bar(stat="identity") + xlab(paste(in_cause, "ranked by state", sep=" ")) +
    #  theme(axis.text.x = element_text(angle=90))
    
    gvisBarChart(slcted, xvar="State", y="Crude.Rate",
                    options=list(height=1200, width=800))
    
    #plot(p)
  }
  
  # push to output for display
  output$view <- renderGvis(outputPlot())
})


#ggplot(slcted, aes(x=State, y=Crude.Rate)) +
#geom_bar(stat="identity") + xlab(paste(in_cause, "ranked by state", sep=" ")) +
#  theme(axis.text.x = element_text(angle=90))