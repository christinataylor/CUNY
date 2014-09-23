library(plyr)
library(dplyr)
library(hflights)

dim(hflights)

head(hflights) 

hflights_df <- tbl_df(hflights)
hflights_df

filter(hflights_df, Month == 1, DayofMonth == 1)

arrange(hflights_df, DayofMonth, Month, Year)

arrange(hflights_df, desc(ArrDelay))

select(hflights_df, Year, Month, DayOfWeek)

planes <- group_by(hflights_df, TailNum)
planes
