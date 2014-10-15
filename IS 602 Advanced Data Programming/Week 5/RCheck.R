library(ggplot2)

setwd("C:/Users/Charley/Downloads/Courses/CUNY/SPS/IS 602 Advanced Data Programming/Week 5")
df <- read.csv("brainandbody.csv")

?lm

summary(lm(brain ~ body, data=df))

ggplot(df, aes(x=body, y=brain)) + 
  geom_point() + 
  stat_smooth(method=lm)

