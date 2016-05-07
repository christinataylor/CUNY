# This script determines what the server does.
# 

library('shiny')
library('plyr')
library('ggplot2')
setwd('/Users/Charley/Downloads/cuny/IS 608 Knowledge and Visual Analytics/Assignment 3/PS1/ggplot')

# load data
mort <- read.csv('cleaned-cdc-mortality-1999-2010.csv')

# let's just get the 'crude rate' of deaths for one state
# in one year
shinyServer(function(input, output){
  
  outputPlot <- function(){
    # subset

    in_cause <- input$cause
    #in_cause <- unique(mort$ICD.Chapter)[1]
    slcted <- mort[mort$ICD.Chapter==in_cause & mort$Year==2010, 
                   c('ICD.Chapter','State','Year','Crude.Rate')
                  ]

    p <- ggplot(slcted, aes(x=reorder(State, Crude.Rate), y=Crude.Rate)) +
      geom_bar(stat="identity") + xlab(paste(in_cause, "ranked by state", sep=" ")) +
      theme(axis.text.x = element_text(angle=90))
    
    print(p)
  }

  
  # push to output for display
  output$values <- renderPlot(outputPlot())
})


#ggplot(slcted, aes(x=State, y=Crude.Rate)) +
#geom_bar(stat="identity") + xlab(paste(in_cause, "ranked by state", sep=" ")) +
#  theme(axis.text.x = element_text(angle=90))