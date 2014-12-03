library(nycflights13)
library(dplyr)
library(RPostgreSQL)


##### Question 1 Prep #####

airportsdf <- data.frame(airports, stringsAsFactors = FALSE)
flightsdf <- data.frame(flights, stringsAsFactors = FALSE)



workingdirectory <- "C:/Users/Charley/Downloads/Courses/CUNY/SPS/Git/IS 607 Data Acquisition and Management/Week 13/Assignment"
setwd(workingdirectory)

con <- dbConnect(RPostgreSQL::PostgreSQL(), user="postgres", password="sinaiA9xpsql",
                 dbname="flights")
con

# I found a double here, I'll remove it for the purposes of this assignment.
# Lets keep Beaufort


airportsdf <- airportsdf %>%
  filter(name != "BFT County Airport")

# I also found a few airports, BQN, in flights that's not in 
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

system.time(airport.delays <- flights %>%
  filter(!(is.na(dep_delay) | is.na(arr_delay))) %>%
  mutate(sumdelay = arr_delay + dep_delay) %>%
  group_by(carrier,origin) %>%
  summarise(total.delay = sum(sumdelay)))

# user  system elapsed 
# 0.10    0.02    0.11 

aggregatetest <- function(){

airport.delays <- flights[!(is.na(flights$dep_delay) | is.na(flights$arr_delay)),]

airport.delays$sumdelay <- with(airport.delays, dep_delay + arr_delay)


airport.delay.sum <- aggregate(sumdelay ~ carrier + origin, airport.delays,
                               FUN = function(x) c(num.delays = length(x), total.delay = sum(x)))
}

system.time(aggregatetest())

# user  system elapsed 
# 5.06    0.11    5.29

# Looks like dplyr is faster than the stock aggregation in R