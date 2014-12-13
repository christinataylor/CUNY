library(RPostgreSQL)
library(ggmap)
library(ggplot2)
library(dplyr)
library(plyr)
library(scales)
library(animation)

con <- dbConnect(RPostgreSQL::PostgreSQL(), user="postgres", password="sinaiA9xpsql",
                 dbname="bikeshare")

con

start.station.pop <- dbReadTable(con, "startstationweekendhourly")

end.station.pop <- dbReadTable(con, "endstationweekendhourly")

colnames(start.station.pop)[2] <- "station.id"
colnames(end.station.pop)[2] <- "station.id"


# There are a few hours when no one borrowed from a station,
# lets find those and add 0's




addzerosweekend <- function(data)
{
  comboaz <- filter(combo, weekend == 1)
  vec <- unique(comboaz$station.id[!(comboaz$station.id %in% data$station.id)])
  return(vec)
}

addzerosweekday <- function(data)
{
  comboaz <- filter(combo, weekend == 0)
  vec <- unique(comboaz$station.id[!(comboaz$station.id %in% data$station.id)])
  return(vec)
}


makedf <- function(ec)
{
  df <- data.frame(station.id = ec)
}

combo <- expand.grid(unique(start.station.pop$station.id),0:23,0:1)
colnames(combo) <- c("station.id", "hour", "weekend")

stationagg <- start.station.pop %>%
  select(-count, -hour, -weekend)

stationagg <- unique(stationagg)

start.station.weekend <- filter(start.station.pop, weekend==1)
start.station.weekend <- select(start.station.weekend, -weekend)
emptycheckss <- dlply(start.station.weekend, .variables="hour", .fun=addzerosweekend)
missingss <- ldply(emptycheckss, .fun = makedf)
missingss <- merge(missingss, stationagg, by="station.id")
missingss$count <- 0
start.station.weekend <- rbind(start.station.weekend, missingss)

start.station.weekday <- filter(start.station.pop, weekend==0)
start.station.weekday <- select(start.station.weekday, -weekend)
emptycheckss <- dlply(start.station.weekday, .variables="hour", .fun=addzerosweekday)
missingss <- ldply(emptycheckss, .fun = makedf)
missingss <- merge(missingss, stationagg, by="station.id")
missingss$count <- 0
start.station.weekday <- rbind(start.station.weekday, missingss)
  
end.station.weekend <- filter(end.station.pop, weekend==1)
end.station.weekend <- select(end.station.weekend, -weekend)
emptycheckes <- dlply(end.station.weekend, .variables="hour", .fun=addzerosweekend)
missinges <- ldply(emptycheckes, .fun=makedf)
missinges <- merge(missinges, stationagg, by="station.id")
missinges$count <- 0
end.station.weekend <- rbind(end.station.weekend, missinges)

end.station.weekday <- filter(end.station.pop, weekend==0)
end.station.weekday <- select(end.station.weekday, -weekend)
emptycheckes <- dlply(end.station.weekday, .variables="hour", .fun=addzerosweekday)
missinges <- ldply(emptycheckes, .fun=makedf)
missinges <- merge(missinges, stationagg, by="station.id")
missinges$count <- 0
end.station.weekday <- rbind(end.station.weekday, missinges)


colnames(start.station.weekend)[6] <- "startcount"
colnames(end.station.weekend)[6] <- "endcount"
colnames(start.station.weekday)[6] <- "startcount"
colnames(end.station.weekday)[6] <- "endcount"


mergedweekend <- merge(start.station.weekend, end.station.weekend, 
                       by=c("hour", "station.id", "station.name", 
                            "station.latitude", "station.longitude"))
mergedweekend <- mergedweekend %>%
  mutate(flow = endcount - startcount)

mergedweekday <- merge(start.station.weekday, end.station.weekday, 
                       by=c("hour", "station.id", "station.name", 
                            "station.latitude", "station.longitude"))
mergedweekday <- mergedweekday %>%
  mutate(flow = endcount - startcount)

rm(combo, end.station.pop, missinges, missingss, start.station.pop, stationagg,
   emptycheckes, emptycheckss, addzerosweekday, addzerosweekend, makedf,
   end.station.weekday, end.station.weekend, start.station.weekday, start.station.weekend)

ggplot(filter(mergedweekday, startcount < 10), aes(x=startcount)) + geom_histogram()

###################################################


nyc <- get_map(location = c(lon=-73.968410, lat=40.725496), zoom = 12)

upperweekendlimit <- max(mergedweekend$flow)
lowerweekendlimit <- min(mergedweekend$flow)
upperweekdaylimit <- max(mergedweekday$flow)
lowerweekdaylimit <- min(mergedweekday$flow)



nyc2 <- ggmap(nyc)
i = 0

for(i in 0:23){
  mergedstationsfilter <- mergedweekend %>%
    filter(hour == i)
  
  png(filename=paste("weekendhour",i,".png",sep=""), width = 600)
  
  nyc <- nyc2
  
  nyc <- nyc +
    geom_point(data = mergedstationsfilter, 
               aes(x = station.longitude, y = station.latitude, colour=flow), size = 4) + 
    scale_colour_gradientn(colours=c("blue","cyan","white", "yellow","red"),
                           values=rescale(c(lowerweekendlimit,-1,0,1,upperweekendlimit)),
                           limits=c(lowerweekendlimit,upperweekendlimit)) + 
    theme(legend.position = c(1,0.2)) + 
    annotate("text", x=-73.92, y=40.72, label=paste(i,":00",sep=""), size=9)
  
  print(nyc)
  
  dev.off()
  
}

for(i in 0:23){
  mergedstationsfilter <- mergedweekday %>%
    filter(hour == i)
  
  png(filename=paste("weekdayhour",i,".png",sep=""), width = 600)
  
  nyc <- nyc2
  
  nyc <- nyc +
    geom_point(data = mergedstationsfilter, 
               aes(x = station.longitude, y = station.latitude, colour=flow), size = 4) + 
    scale_colour_gradientn(colours=c("blue","cyan","white", "yellow","red"),
                           values=rescale(c(lowerweekdaylimit,-1,0,1,upperweekdaylimit)),
                           limits=c(lowerweekdaylimit,upperweekdaylimit)) + 
    theme(legend.position = c(1,0.2)) + 
    annotate("text", x=-73.92, y=40.72, label=paste(i,":00",sep=""), size=9)
  
  print(nyc)
  
  dev.off()
  
}

?scale_colour_gradientn

nyc <- nyc2
  
nyc <- nyc +
  geom_point(data = mergedstationsfilter, 
             aes(x = station.longitude, y = station.latitude, colour=flow), size = 5) + 
  scale_colour_gradientn(colours=c("blue","cyan","white", "yellow","red"),
                       values=rescale(c(lowerlimit,-1,0,1,upperlimit)))


makeplot <- function(){
  
  for(i in 0:23){
    
    mergedstationsfilter <- mergedstations %>%
      filter(hour == i)
    
    nyc <- nyc2
    
    nyc <- nyc +
      geom_point(data = mergedstationsfilter, 
                 aes(x = station.longitude, y = station.latitude, colour=flow), size = 5) + 
      scale_colour_gradientn(colours=c("blue","cyan","white", "yellow","red"),
                             values=rescale(c(lowerlimit,-1,0,1,upperlimit)))
    
  }
}

