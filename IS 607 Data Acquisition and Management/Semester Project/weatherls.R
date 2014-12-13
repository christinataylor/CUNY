library(RPostgreSQL)
library(ggplot2)
library(dplyr)
library(GGally)
library(ggthemes)
library(coefplot)

con <- dbConnect(RPostgreSQL::PostgreSQL(), user="postgres", password="sinaiA9xpsql",
                 dbname="bikeshare")

con

fulldata <- dbReadTable(con, "hourlyrideswithweather")

goodweather <- c("Clear", "Fog", "Haze", "Mostly Cloudy", "Overcase", "Partly Cloudy", "Scattered Clouds")
badweather <- c("Heavy Rain", "Heavy Snow", "Light Freezing Rain", "Light Rain", "Light Snow",
                "Rain", "Snow", "Unknown")

fulldata$simplifiedconditions <- ifelse(fulldata$conditions %in% goodweather, "Good Weather", "Bad Weather")


fulldata$year <- as.factor(fulldata$year)
fulldata$month <- as.factor(fulldata$month)
fulldata$day <- as.factor(fulldata$day)
fulldata$hour <- as.factor(fulldata$hour)
fulldata$weekend <- as.factor(fulldata$weekend)


ggplot(fulldata, aes(x=ridescount, fill=conditions)) + 
  geom_histogram()

ggplot(fulldata, aes(x=ridescount, y=temp, colour = conditions)) +
  geom_point() + 
  geom_smooth(method="lm", color="red")

ggplot(fulldata, aes(x=ridescount, y=temp, colour = simplifiedconditions)) +
  geom_point() + 
  geom_smooth(method="lm", color="red") + 
  facet_wrap( ~ hour, nrow=6, ncol=4) + 
  theme_tufte()

ggplot(fulldata, aes(x=ridescount, y=humidity, colour = simplifiedconditions)) +
  geom_point() + 
  geom_smooth(method="lm", color="red") + 
  facet_wrap( ~ hour, nrow=6, ncol=4) + 
  theme_tufte()

?facet_wrap



ggplot(fulldata, aes(x=ridescount, y=temp)) +
  geom_point() + 
  geom_smooth(method="lm", color="red")

ggplot(fulldata, aes(x=ridescount, y=temp)) +
  geom_point() + 
  geom_smooth(method="lm", color="red")

# Remove some outliers 
var = "temp"

  
for(var in c("temp", "humidity", "pressure", "visibility", "windspeed")){
  
  png(filename=paste("analysis",var,".png",sep=""), width=600)
  
  print(ggplot(fulldata, aes(x=ridescount, y=get(var), colour = simplifiedconditions)) +
    geom_point() + 
    geom_smooth(method="lm", color="red") + 
    facet_wrap( ~ hour, nrow=6, ncol=4) + 
    theme_tufte() + 
    ggtitle(paste(toupper(substr(var,1,1)),substr(var,2,nchar(var)),
                  " Colored by Weather Condition, Facet by Hour", sep="")))
  
  dev.off()
  
}


fulldataraw <- fulldata

fulldata <- fulldata %>%
  filter(ridescount < mean(ridescount)+2*sd(ridescount))

ggplot(fulldata, aes(x=ridescount, fill=conditions)) + 
  geom_histogram()

length(fulldata$ridescount[fulldata$ridescount > 3000])/length(fulldata$ridescount)

mean(fulldata$ridescount) + 2*sd(fulldata$ridescount)

model <- lm(ridescount ~ temp+month+hour+humidity+conditions+weekend, data=fulldata)
coefplot(model) + 
  theme_tufte()

modellog <- lm(log(ridescount) ~ temp+month+hour+humidity+conditions+weekend, data=fulldataraw)

ggplot(fulldata, aes(x=ridescount, y=temp)) +
  geom_point() + 

ggplot(fulldata, aes(x=log(ridescount), y=temp)) +
  geom_point()


conditionsagg <- fulldata %>%
  group_by(conditions) %>%
  summarise(ridescount = mean(ridescount)) %>%
  filter(!is.na(conditions), conditions != "Clear")

fulldata$date <- ISOdatetime(fulldata$year, fulldata$month, fulldata$day, fulldata$hour, 0, 0)

fulldata$conditions <- as.factor(fulldata$conditions)

ggplot(fulldata, aes(x=date, y=ridescount)) + geom_line()

fulldata$year <- as.numeric(fulldata$year)
fulldata$month <- as.numeric(fulldata$month)
fulldata$day <- as.numeric(fulldata$day)
fulldata$hour <- as.numeric(fulldata$hour)
fulldata$conditions <- as.numeric(fulldata$conditions)
fulldata$weekend <- as.numeric(fulldata$weekend)


dailyagg <- fulldata %>%
  group_by(year, month, day) %>%
  summarise(ridescount = sum(ridescount))

dailyagg$date <- ISOdatetime(dailyagg$year, dailyagg$month, dailyagg$day, 0, 0, 0)

ggplot(dailyagg, aes(x=date, y=ridescount)) + geom_line()

monthlyagg <- fulldata %>%
  group_by(year, month) %>%
  summarise(ridescount = sum(ridescount))

monthlyagg$date <- ISOdatetime(monthlyagg$year, monthlyagg$month, 1, 0, 0, 0)

ggplot(monthlyagg, aes(x=date, y=ridescount)) + geom_line()

ggpairs(fulldata, columns=c())

