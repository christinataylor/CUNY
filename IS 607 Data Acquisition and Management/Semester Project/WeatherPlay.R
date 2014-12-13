
dfoctober <- df %>%
  filter(month == 10) %>%
  group_by(day) %>%
  summarise(Count <- n())

dfoctober1 <- df %>%
  filter(day == 1, month == 10)

monthindex <- 10
date <- 1

for(date in problemdays){
  dftest <- df %>%
    filter(day == date)
  
  d <- 0:23
  missinghours <- d[!(d %in% dfoctober1$hour)]
  naaddition <- rep(NA, each=length(missinghours))
  dfadd <- data.frame(
    year = rep(2014, each=length(missinghours)),
    month = rep(monthindex, each=length(missinghours)),
    day = rep(date, each=length(missinghours)),
    hour = missinghours,
    minute = naaddition,
    temp = naaddition,
    windchill = naaddition,
    heatindex = naaddition,
    dewpoint = naaddition,
    humidity = naaddition,
    pressure = naaddition,
    visibility = naaddition,
    winddir = naaddition,
    windspeed = naaddition,
    gustspeed = naaddition,
    precip = naaddition,
    events = naaddition,
    conditions = naaddition,
    stringsAsFactors = FALSE)
  
  dfoctober1<- rbind(dfoctober1, dfadd)
  rm(dfadd, dftest)
}


dftest <- df %>% 
  group_by(year,month,day,hour) %>%
  summarise(count = n()) %>%
  filter(count != 1)

dftest1 <- df %>%
  filter(month==3, day==9, hour==0)

dfagg <- df %>%
  filter(month == 3) %>%
  group_by (day) %>%
  summarise(count = n())

dftest2 <- df %>%
  filter(month==3, day==9)

dftest3 <- df %>%
  filter(month==3, day==9, hour==0, temp==39.0)

df[df$month==3 & df$day==9 & df$hour==0 & df$temp==39.0,]$hour <- 2
