c <- 2
lambda <- 1/4
mu <- 1/3
rho <- lambda/(c*mu)


P0 <- (sum(((c*rho)^(0:(c-1)))/factorial(0:(c-1))) + 
         (((c*rho)^c)*(1/factorial(c))*(1/1-rho)))^-1


L <- c*rho + (((c*rho)^(c+1))*P0)/(c*factorial(c)*((1-rho)^2))

15*L + 20

########################################################################

setwd("E:/Downloads/Courses/CUNY/SPS/Git/IS 604 Simulation and Modeling techniques/Homework 6")

library(reshape2)
library(dplyr)

arrivals <- 0

repeat{
  iat <- rexp(1,rate=1/10)
  
  if(tail(arrivals,1)+iat > 10000){
    break
  }else{
    arrivals <- c(arrivals,tail(arrivals,1)+iat)
  }
  
}

arrivals <- tail(arrivals,-1)

servicetimes <- rexp(length(arrivals),rate=1/7)

departures <- head(arrivals,1)+head(servicetimes,1)


for(i in 2:length(arrivals)){
  departures <- c(departures,
                          ifelse(departures[i-1]<arrivals[i],
                                 arrivals[i]+servicetimes[i],
                                 departures[i-1]+servicetimes[i]))
}

entityID <- 1:length(arrivals)

entityTable <- data.frame(entityID=entityID, arrival=arrivals, 
                          servicetime = servicetimes, departure=departures)

eventTableA <- select(entityTable,-departure,-servicetime)
eventTableA$eventType <- "Arrival"

eventTableD <- select(entityTable,-arrival,-servicetime)
eventTableD$eventType <- "Departure"

colnames(eventTableA) <- c("entityID", "eventTime", "eventType")
colnames(eventTableD) <- c("entityID", "eventTime", "eventType")

eventTable <- rbind(eventTableA,eventTableD) %>% arrange(eventTime)

numberInSystem <- 1

for(i in 2:length(eventTable$eventType)){
  numberInSystem[i] <- ifelse(eventTable$eventType[i] == "Arrival",
                              numberInSystem[i-1]+1, numberInSystem[i-1]-1)
}

eventTable$numberInSystem <- numberInSystem

eventTable$interEventTime <- 
  c(eventTable$eventTime[1], 
    tail(eventTable$eventTime,-1)-head(eventTable$eventTime,-1))

eventTable$queueLength <- ifelse(eventTable$numberInSystem==0,0,
                                 eventTable$numberInSystem-1)

rho <- 1-(sum(filter(eventTable,numberInSystem==0)$interEventTime)/
  sum(eventTable$interEventTime))

Lq <- sum(eventTable$queueLength*eventTable$interEventTime)/
  sum(eventTable$interEventTime)

L <- sum(eventTable$numberInSystem*eventTable$interEventTime)/
  sum(eventTable$interEventTime)

Wq <- mean(entityTable$departure-entityTable$arrival)

rho
L
Lq
Wq
