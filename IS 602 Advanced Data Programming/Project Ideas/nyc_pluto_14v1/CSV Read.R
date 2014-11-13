library(dplyr)

setwd("C:/Users/Charley/Downloads/Courses/CUNY/SPS/Git/IS 602 Advanced Data Programming/Project Ideas/nyc_pluto_14v1")

databx <- read.csv("bx.csv", header=TRUE)

databk <- read.csv("bk.csv", header=TRUE)

dataqn <- read.csv("qn.csv", header=TRUE)

datasi <- read.csv("si.csv", header=TRUE)

datamn <- read.csv("mn.csv", header=TRUE)

data <- rbind(databx, databk, dataqn, datasi, datamn)

rm(databx, databk, dataqn, datasi, datamn)

head(data$Address)

filter(data, OwnerName == "WASSFAM,LLC")

data2 <- data %>%
  select(Block, Lot)

?unique

?read.csv

colnames(data)

write.csv(colnames(data), "datacolnames.csv")

length(unique(data$Block)) # 3032
length(unique(data$Lot)) # 1964
length(unique(data$CD)) # 17
length(unique(data$CT2010)) # 339
length(unique(data$ZoneDist1))
unique(data$ZoneDist1)

length(unique(data$Block))*length(unique(data$Lot))

data %>%
  filter(data$Lot == "")
unique(data$Lot)
?unique
duplicated(data)
datasub <- data %>%
  select(Block, Lot)
length(duplicated(datasub))
length(datasub$Block)
