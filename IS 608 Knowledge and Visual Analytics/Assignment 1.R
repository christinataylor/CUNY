library(plyr)
library(dplyr)
library(ggplot2)
library(ggthemes)

path <- "https://raw.githubusercontent.com/jlaurito/CUNY_IS608/master/lecture1/data/inc5000_data.csv"

df <- read.csv(path)

##### Question 1 #####


countstates <- function(data){
  c(Count = dim(data)[1])
}

dfbystate <- ddply(df, .variables="State", .fun=countstates)


ggplot(dfbystate, aes(y=reorder(State, Count), x=Count)) +
  geom_point(size=3) + 
  theme_bw() + 
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(linetype = c(0,1,0,0)),
        panel.border = element_blank()) +
  xlab("Number of Companies") +
  ylab("State")


##### Question 2 #####

# The state with the third most companies in it is NY

dfny <- df %>%
  filter(State == "NY")

avgindustries <- function(data){
  data <- data %>%
    filter(complete.cases(Employees))
  c(avgEmp = mean(data$Employees))
  
}

dfnybyindustry <- ddply(dfny, .variables="Industry", .fun=avgindustries)

# Now to do a quick view of the data

ggplot(dfnybyindustry, aes(x=reorder(Industry, avgEmp), avgEmp)) +
  geom_bar(stat="Identity") +
  theme(axis.text.x = element_text(angle=90))


# Looks like Business, Products, and Services is an outlier.
# I'll set this as 800, then annotate the actual value on the graph.

dfnybyindustryoutlier <- dfnybyindustry
dfnybyindustryoutlier[dfnybyindustryoutlier$Industry == "Business Products & Services","avgEmp"] <- 800

ggplot(dfnybyindustryoutlier, aes(x=reorder(Industry, avgEmp), avgEmp)) +
  theme_bw() +
  geom_bar(stat="Identity") +
  xlab("Industry") + ylab("Average Employment") +
  theme(axis.text.x = element_text(angle=90),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.border = element_blank()) + 
  annotate("text", x=17, y=750,
           label=paste("Business Products & Services Employment: ",
                       round(dfnybyindustry[dfnybyindustry$Industry =="Business Products & Services","avgEmp"],
                             digits=2),sep=""))

##### Question 3 #####

# I'm assuming we're looking at the full dataset, and not just New York

revbyemp <- function(data){
  data <- data %>%
    filter(complete.cases(Employees))
  c(revByEmp = sum(data$Revenue)/sum(data$Employees))
}

dfrevbyindustry <- ddply(df, .variables="Industry", .fun=revbyemp)

ggplot(dfrevbyindustry, aes(x=reorder(Industry, revByEmp), revByEmp)) +
  geom_bar(stat="Identity") +
  theme(axis.text.x = element_text(angle=90))

# This time it looks Computer Hardware is the outlier. Lets give it the same treatment

dfrevbyindustryoutlier <- dfrevbyindustry
dfrevbyindustryoutlier[dfrevbyindustryoutlier$Industry == "Computer Hardware","revByEmp"] <- 700000
dfrevbyindustryoutlier$revByEmp <- dfrevbyindustryoutlier$revByEmp/1000


ggplot(dfrevbyindustryoutlier, aes(x=reorder(Industry, revByEmp), revByEmp)) +
  theme_bw() +
  geom_bar(stat="Identity") + 
  xlab("Industry") + ylab("Revenue per Employee ($Thousands)") +
  theme(axis.text.x = element_text(angle=90),
        panel.grid.major.x = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.border = element_blank()) +
  annotate("text", x=20, y=650,
           label=paste("Computer Hardware: $",
                       round(dfrevbyindustry[dfrevbyindustry$Industry == "Computer Hardware","revByEmp"]/1000,
                             digits=2),sep=""))

