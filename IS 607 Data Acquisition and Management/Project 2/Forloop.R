#m<- 8
#y <- 2011
#columntitle <- "count"

variables <- variablesWithDates

Months <- c("January", "February", "March", "April", "May", "June",  "July", "August", "September", "October", "November", "December")

#slice <- newvariables %>% filter(Year == y, Month == m)
# Not working because of datetime again.


for(columntitle in c("count", "registered", "casual")){
  
  newvariables <- variables[,(!(colnames(variables) == "count") & !(colnames(variables) == "registered") & !(colnames(variables) == "casual"))]
  
  newvariables[,"usedcount"] <- variables[,columntitle]
  
  for(y in 2011:2012){
    for(m in 1:12){
      
      slice <- newvariables[newvariables$Year == y & newvariables$Month == m,]
      
      ################
      # Weekends & Holidays
      ################
      
      if(NROW(slice[slice$holiday == 1,]) == 0){
        print(ggplot(slice,aes(x=datetime, y=usedcount)) + 
                geom_rect(data = slice[slice$workingday == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "gray") + 
                #geom_rect(data = slice[slice$holiday == 1,], aes(ymin = -Inf, ymax = Inf, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "yellow") +
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_line() + 
                ggtitle(paste("Weekends and Holidays", columntitle, Months[m], y, sep=" ")) + 
                coord_fixed(ratio=452000/max(slice[,"usedcount"])) + 
                theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank()))
      }else{
        print(ggplot(slice,aes(x=datetime, y=usedcount)) +
                geom_rect(data = slice[slice$workingday == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "gray") + 
                geom_rect(data = slice[slice$holiday == 1,], aes(ymin = -Inf, ymax = Inf, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "yellow") +
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_line() + 
                ggtitle(paste("Weekends and Holidays", columntitle, Months[m], y, sep=" ")) + 
                coord_fixed(ratio=452000/max(slice[,"usedcount"])) + 
                theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank()))
      }
      
      
      ################
      # Weather
      # My original plan with weather was to
      # draw rectangles for the weather. This
      # ended up looking too busy. 
      ################
      
      if(NROW(slice[slice$holiday == 1,]) == 0){
        print(ggplot(slice,aes(x=datetime, y=usedcount, colour=weather)) + 
                #geom_rect(data = slice[slice$weather == 1,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "gray") + 
                #geom_rect(data = slice[slice$weather == 2,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "green") + 
                #geom_rect(data = slice[slice$weather == 3,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "yellow") + 
                #geom_rect(data = slice[slice$weather == 4,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "red") + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_rect(data = slice[slice$workingday == 0,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "gray") +
                #geom_rect(data = slice[slice$holiday == 1,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "yellow") +
                geom_line() + 
                ggtitle(paste("Weather", columntitle, Months[m], y, sep=" ")) + 
                scale_colour_gradient(limits=c(1, 4)) + 
                #scale_colour_manual(values = cols) + 
                coord_fixed(ratio=452000/max(slice[,"usedcount"])) + 
                theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank()))
      }else{
        print(ggplot(slice,aes(x=datetime, y=usedcount, colour=weather)) + 
                #geom_rect(data = slice[slice$weather == 1,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "gray") + 
                #geom_rect(data = slice[slice$weather == 2,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "green") + 
                #geom_rect(data = slice[slice$weather == 3,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "yellow") + 
                #geom_rect(data = slice[slice$weather == 4,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "red") + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_rect(data = slice[slice$workingday == 0,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "gray") +
                geom_rect(data = slice[slice$holiday == 1,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "yellow") +
                geom_line() + 
                ggtitle(paste("Weather", columntitle, Months[m], y, sep=" ")) + 
                scale_colour_gradient(limits=c(1, 4)) + 
                #scale_colour_manual(values = cols) + 
                coord_fixed(ratio=452000/max(slice[,"usedcount"])) + 
                theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank()))
      }
      
      
      
      ################
      # Temp
      ################
      
      if(NROW(slice[slice$holiday == 1,]) == 0){
        print(ggplot(slice,aes(x=datetime, y=usedcount, colour=temp)) + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_rect(data = slice[slice$workingday == 0,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "gray") +
                #geom_rect(data = slice[slice$holiday == 1,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "yellow") +
                geom_line() + 
                ggtitle(paste("Temp", columntitle, Months[m], y, sep=" ")) + 
                scale_colour_gradient(limits=c(min(newvariables$temp), max(newvariables$temp)), low="blue", high="red") + 
                coord_fixed(ratio=452000/max(slice[,"usedcount"])) + 
                theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank()))
      }else{
        print(ggplot(slice,aes(x=datetime, y=usedcount, colour=temp)) + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_rect(data = slice[slice$workingday == 0,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "gray") + 
                geom_rect(data = slice[slice$holiday == 1,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "yellow") + 
                geom_line() + 
                ggtitle(paste("Temp", columntitle, Months[m], y, sep=" ")) + 
                scale_colour_gradient(limits=c(min(newvariables$temp), max(newvariables$temp)), low="blue", high="red") + 
                coord_fixed(ratio=452000/max(slice[,"usedcount"])) + 
                theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank()))
      }
      
      ################
      # ATemp
      ################
      
      if(NROW(slice[slice$holiday == 1,]) == 0){
        print(ggplot(slice,aes(x=datetime, y=usedcount, colour=atemp)) + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") +  
                geom_rect(data = slice[slice$workingday == 0,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "gray") + 
                #geom_rect(data = slice[slice$holiday == 1,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "yellow") + 
                geom_line() + 
                ggtitle(paste("ATemp", columntitle, Months[m], y, sep=" ")) + 
                scale_colour_gradient(limits=c(min(newvariables$atemp), max(newvariables$atemp)), low="blue", high="red") + 
                coord_fixed(ratio=452000/max(slice[,"usedcount"])) + 
                theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank()))
      }else{
        print(ggplot(slice,aes(x=datetime, y=usedcount, colour=atemp)) + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_rect(data = slice[slice$Hour == 0,], aes(ymin = -Inf, ymax = Inf, xmin = datetime, xmax = datetime), alpha = 1, colour = "white") + 
                geom_rect(data = slice[slice$workingday == 0,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "gray") + 
                geom_rect(data = slice[slice$holiday == 1,], aes(ymin = -Inf, ymax = 25, xmin = datetime - 1000, xmax = datetime + 1000), alpha = 1, colour = "yellow") + 
                geom_line() + 
                ggtitle(paste("ATemp", columntitle, Months[m], y, sep=" ")) + 
                scale_colour_gradient(limits=c(min(newvariables$atemp), max(newvariables$atemp)), low="blue", high="red") + 
                coord_fixed(ratio=452000/max(slice[,"usedcount"])) + 
                theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank()))
      }
    }
  }  
}