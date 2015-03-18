# This script determines what the server does.
# 

library('shiny')
library('plyr')
library('ggplot2')
library(googleVis)
library(plyr)
library(dplyr)
setwd('E:/Downloads/Courses/CUNY/SPS/Large Data Space Semester 2/607 Assignment 3/PS2')

# load data
mort <- read.csv('cleaned-cdc-mortality-1999-2010.csv')





# let's just get the 'crude rate' of deaths for one state
# in one year
shinyServer(function(input, output){
  
  ddplyfun <- function(data){
    c(SumOfStates = with(data, weighted.mean(Crude.Rate, Population)))
  }
  
  outputPlot <- function(){
    # subset

    in_cause <- input$cause
    
    in_state <- input$state
    #in_state <- "Alabama"
    #in_cause <- as.character(unique(mort$ICD.Chapter)[1])
    
    statesums <- ddply(mort, .variables = c("ICD.Chapter", "Year"), .fun = ddplyfun)
    
    mort <- merge(mort, statesums, by=c("ICD.Chapter", "Year"))
    
    slcted <- mort %>%
      filter(ICD.Chapter == in_cause, State == in_state) %>%
      select(Year, Crude.Rate, SumOfStates)
    
    colnames(slcted) <- c("Year", in_state, "National")
    
    #plot(gvisLineChart(slcted, options=list(
    #  hAxis="{title:'Year'}")))
    
    
    
    #p <- ggplot(slcted, aes(x=reorder(State, Crude.Rate), y=Crude.Rate)) +
    #  geom_bar(stat="identity") + xlab(paste(in_cause, "ranked by state", sep=" ")) +
    #  theme(axis.text.x = element_text(angle=90))
    
    #gvisBarChart(slcted, xvar="State", y="Crude.Rate",
    #                options=list(height=1200, width=800))
    
    gvisLineChart(slcted, options=list(
      hAxis="{title:'Year'}",
      vAxis="{title:'Crude Rate'}",
      height=600, width=900))
    
    #plot(p)
  }
  
  # push to output for display
  output$view <- renderGvis(outputPlot())
})


#ggplot(slcted, aes(x=State, y=Crude.Rate)) +
#geom_bar(stat="identity") + xlab(paste(in_cause, "ranked by state", sep=" ")) +
#  theme(axis.text.x = element_text(angle=90))