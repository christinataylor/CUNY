library(bigvis)
library(ggplot2)
library(dplyr)
library(ggthemes)

# csvkit code to create nyc.csv:
# csvstack BX.csv BK.csv MN.csv QN.csv SI.csv > nyc.csv

setwd("E:/Downloads/Courses/CUNY/SPS/Large Data Space Semester 2")

pData <- read.csv("nyc.csv")

###########################################
### Question 1 ############################
###########################################

q1Data <- pData %>%
  filter(YearBuilt >= 1850 & YearBuilt <= 2015 & LotArea > 100 &
           AssessTot < 10000000 & NumFloors != 0)

q1DataC <- condense(bin(q1Data$YearBuilt, 5))

autoplot(q1DataC) + 
  ylab('Number of Buildings') + 
  xlab('Year Built') +
  theme_tufte()

# The condensed data seemed a bit spiky. There was probably a building boom between
# 1920 and 1935 (possibly due to the run up to the Great Depression), but the spikyness 
# between 5 year bins look suspicious. Lets check this out in a more granular plot:

ggplot(q1Data, aes(x=YearBuilt)) + 
  geom_histogram(binwidth = 1) + 
  ylab('Number of Buildings') + 
  xlab('Year Built') +
  theme_tufte()

q1DataSum <- q1Data %>%
  group_by(YearBuilt) %>%
  summarise(n())

# Looking at the summary of this data, it seems like the data is rounded into different years
# (mostly 5s and 10s) before 1983. There also seems to be an odd drop before 1899, suggesting
# it's a catch-all for buildings built before 1900 without known dates.

###########################################
### Question 2 ############################
###########################################

q2Data <- pData %>%
  filter(YearBuilt >= 1850 & YearBuilt <= 2015 & LotArea > 100 &
           AssessTot < 10000000 & NumFloors != 0)

q2DataC <- condense(bin(q2Data$YearBuilt, 1), bin(q2Data$NumFloors, 1))

autoplot(q2DataC) + 
  scale_fill_gradient(trans = "log") + 
  theme_tufte() + 
  ylab("Number of Floors") + 
  xlab("Year Built")

# It would appear taller buildings were built around 1899. This was also the time when I noticed
# an anomaly in Question 1, so lets zoom in and see more of what's happening here:

autoplot(q2DataC) + 
  scale_fill_gradient(trans = "log") + 
  theme_tufte() + 
  ylab("Number of Floors") + 
  xlab("Year Built") + 
  ylim(0, 25)

# 1899 isn't an anomaly. It does seem to be when taller buildings started to get constructed.
# The height limit prior to 1899, with a few exceptions, appears to be 8 stories. After that date,
# there appears to be a limit of around 14 stories (with a few exceptions), and after 1920 a limit
# of around 17 stories, with skyscraper construction stalling at the start of the great depression.

###########################################
### Question 3 ############################
###########################################

q3Data <- pData %>%
  filter(YearBuilt >= 1850 & YearBuilt <= 2015 & LotArea > 100 &
           AssessTot < 10000000 & NumFloors != 0) %>%
  mutate(AssessPerFloor = AssessTot/NumFloors)

q3DataC <- condense(bin(q3Data$YearBuilt, 5), bin(q3Data$AssessPerFloor, 1000))

# For this question I'm binning years by 5 because the "lumping" together of buildings 
# every 5 years was interfering with the general pattern of assessment during WWII

autoplot(q3DataC) +
  scale_fill_gradient(trans="log") + 
  ylab("Assessed Value Per Floor") +
  xlab("Year BUilt") +
  theme_tufte()

# Lets zoom in to a more relevant Assessed value and year range


autoplot(q3DataC) +
  scale_fill_gradient(trans="log") + 
  ylab("Assessed Value Per Floor") +
  xlab("Year Built") +
  theme_tufte() + 
  ylim(0,2e6) +
  xlim(1900, 2000)

# There does appear to be a decline in assessment per floor beginning around 1940, but the pattern
# lasts for about 15 years rather than 5. It looks like things don't recover until 1955. The 
# decline also doesn't look as bad as the decline after 1965, so Fort Apache was worse for 
# New York City real estate assesments than World War II.




