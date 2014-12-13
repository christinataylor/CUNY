library(RPostgreSQL)
library(plyr)

#############################
# This assumes df from WeatherScrape.R
# Has already been created.
#############################

con <- dbConnect(RPostgreSQL::PostgreSQL(), user="postgres", password="insertpasswordhere",
                 dbname="bikeshare")

con

dbWriteTable(con, "hourlyweather", df, row.names=FALSE)


#############################
# Now to bring in the Bikeshare Data
#############################

workingdirectory <- "C:/Users/Charley/Downloads/CUNY/IS 607 Data Acquisition and Management/Semester Project"
setwd(workingdirectory)

years2013 <- c("08","09","10","11","12")
years2014 <- c("01","02","03","04","05","06","07","08")
csvs <- paste("2013-",years2013," - Citi Bike trip data.csv",sep="")
csvs <- c(csvs,paste("2014-",years2014," - Citi Bike trip data.csv",sep=""))

bikesharedf <- read.csv("2013-07 - Citi Bike trip data.csv", stringsAsFactors=FALSE)

for(filename in csvs){
  bikesharedf <- rbind(bikesharedf, read.csv(filename))
}

bikesharedf$birth.year[bikesharedf$birth.year == "\\N"] <- NA
bikesharedf$birth.year <- as.numeric(bikesharedf$birth.year)

  
#############################
# Separating the data into tables to be 
# uploaded to postgresql
#############################

stationlist <- unique(select(bikesharedf, start.station.id, start.station.name,
                             start.station.latitude, start.station.longitude))
row.names(stationlist) <- NULL
colnames(stationlist) <- c("station.id", "station.name", "station.latitude", 
                           "station.longitude")

## Checking the duplicates to make sure they're not too far apart

stationlist %>%
  filter(station.id %in% stationlist$station.id[duplicated(stationlist$station.id)]) %>%
  arrange(station.id)

## Close enough to remove the duplicates

stationlist <- stationlist[!duplicated(stationlist$station.id),]

bikesharedf <- bikesharedf %>%
  select(-(start.station.name:start.station.longitude),
         -(end.station.name:end.station.longitude))

bikesharedf$starttime <- strptime(bikesharedf$starttime,
                                  format = "%Y-%m-%d %H:%M:%S")

bikesharedf$stoptime <- strptime(bikesharedf$stoptime,
                                 format = "%Y-%m-%d %H:%M:%S")



bikesharedf$starthour <- bikesharedf$starttime$hour
bikesharedf$startday <- bikesharedf$starttime$mday
bikesharedf$startmonth <- bikesharedf$starttime$mon+1
bikesharedf$startyear <- bikesharedf$starttime$year+1900
bikesharedf$startminute <- bikesharedf$starttime$min
bikesharedf$startsecond <- bikesharedf$starttime$sec

bikesharedf$endhour <- bikesharedf$stoptime$hour
bikesharedf$endday <- bikesharedf$stoptime$mday
bikesharedf$endmonth <- bikesharedf$stoptime$mon+1
bikesharedf$endyear <- bikesharedf$stoptime$year+1900
bikesharedf$endminute <- bikesharedf$stoptime$min
bikesharedf$endsecond <- bikesharedf$stoptime$sec

dbWriteTable(con, "trips", bikesharedf, row.names=TRUE)

dbWriteTable(con, "stations", stationlist, row.names=FALSE)

weekends <- read.csv("weekends.csv")

hours <- 0:23

addhours <- function(vec)
{
  weekends$hours <- vec
  return(weekends)
}

weekends <- adply(hours, .margins = 1, .fun=addhours)

weekends <- weekends %>%
  select(-X1)

colnames(weekends) <- c("date", "day", "month", "year", "weekend", "hour")

dbWriteTable(con, "weekends", weekends, row.names=FALSE)
