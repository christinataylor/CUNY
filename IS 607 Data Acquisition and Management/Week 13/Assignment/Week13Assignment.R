library(nycflights13)
library(dplyr)
library(RPostgreSQL)
library(plyr)

##### Question 1 Prep #####

airportsdf <- data.frame(airports, stringsAsFactors = FALSE)
flightsdf <- data.frame(flights, stringsAsFactors = FALSE)



workingdirectory <- "C:/Users/Charley/Downloads/Courses/CUNY/SPS/Git/IS 607 Data Acquisition and Management/Week 13/Assignment"
setwd(workingdirectory)

con <- dbConnect(RPostgreSQL::PostgreSQL(), user="postgres", password="sinaiA9xpsql",
                 dbname="flights")
con

length(unique(flightsdf$dest))

length(flightsdf$flight)

# I found a double here, I'll remove it for the purposes of this assignment.
# Lets keep Beaufort


airportsdf <- airportsdf %>%
  filter(name != "BFT County Airport")

# I also found a fewairports, BQN, in flights that's not in 
# airports. I'll remove this as well for the assignment


removelist <- unique(flightsdf$dest)[!(unique(flightsdf$dest) %in% unique(airportsdf$faa))]

flightsdf <- flightsdf %>%
  filter(!(dest %in% removelist))

dbWriteTable(con, "airports", airportsdf, row.names=FALSE)
dbWriteTable(con, "flights", flightsdf, row.names=TRUE)

##### Question 2 Prep #####

# First remove all tables from the database to recreate the sourcetables

airlinesdf <- data.frame(carrier = as.character(airlines$carrier),
                         name = as.character(airlines$name),
                         stringsAsFactors = FALSE)



dbWriteTable(con, "airlines", airlinesdf, row.names=FALSE)
dbWriteTable(con, "flights", flightsdf, row.names=TRUE)

##### Question 3 Comparison #####

planes <- group_by(flights, tailnum)
delay <- summarise(planes,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE))
delay <- filter(delay, count > 20, dist < 2000)


airport.delays <- flights %>%
  filter(!(is.na(flights$dep_delay) | is.na(flights$arr_delay))) %>%
  group_by(origin)

airport.delay.sum <- summarise(airport.delays,
                               count = n(),
                               sumdelay = sum(arr_delay))



airport.delays <- flights[!(is.na(flights$dep_delay) | is.na(flights$arr_delay)),]

dim(flights[flights$dep_delay>0 | flights$arr_delay>0,])

sumcount <- function(data){
  c(count = with(data, count = dim(data[data$dep_delay>0 | data$arr_delay>0,])[1]),
    sum = with(data, sum = sum(data$dep_delay) + sum(data$arr_delay)))
}

sum(flights$dep_delay[!(is.na(flights$dep_delay))])

airport.delay.sum <- ddply(airport.delays, .variables = "origin", .fun = sumcount)
