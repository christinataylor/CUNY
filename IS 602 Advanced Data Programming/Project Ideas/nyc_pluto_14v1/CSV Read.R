library(dplyr)

setwd("C:/Users/Charley/Downloads/Courses/CUNY/SPS/Git/IS 602 Advanced Data Programming/Project Ideas/nyc_pluto_14v1")

data <- read.csv("bx.csv", header=TRUE)

data2 <- data %>%
  select(Block, Lot)

?unique

?read.csv
