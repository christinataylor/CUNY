library(plyr)
library(tidyr)


  
messy <- data.frame(
  c("Edinburgh", "16-24", 80100, 35900),
  c("Edinburgh", "25+", 143000, 214800),
  c("Glasgow", "16-24", 99400, 43000),
  c("Glasgow", "25+", 150400, 207000)
)

##### Question 1 #####

# Looking at the data, the three questions that come to mind are:

# 1) Do people in Edinburgh prefer Cullen Skink over Parten Bree? What about in Glasgow?
# 2) Do 16-24 year olds prefer Cullen Skink? What about 25+?
# 3) Overall do more people prefer Cullen Skink or Parten Bree?

##### Question 2 #####

messy <- data.frame(
  city = c("Edinburgh", "Edinburgh", "Glasgow", "Glasgow"),
  age = c("16-24", "25+"), 
  yes = c(80100, 143000, 99400, 150400),
  no = c(35900, 214800, 43000, 207000)
)

##### Question 3 #####

# I think it makes more sense to have a stated preference rather than a 
# yes/no on whether they prefer Cullen Skink.

colnames(messy) <- c("city", "age", "cullen.skink", "parten.bree")

tidydf <- messy %>% gather(preference, number.people, cullen.skink:parten.bree)

##### Question 4 #####

# 1) Do people in Edinburgh prefer Cullen Skink over Parten Bree? What about in Glasgow?

question.fun <- function(data){
  c(number.people = with(data, sum(number.people)))
}

sum(c(1,2,3))

question.1 <- ddply(tidydf, .variables=c("city", "preference"), .fun=question.fun)

# More people in both Edinburgh and Glasgow prefer Parten Bree to Cullen Skink (but it's close)

# 2) Do 16-24 year olds prefer Cullen Skink? What about 25+?

question.2 <- ddply(tidydf, .variables=c("age", "preference"), .fun=question.fun)

# Younger people prefer Cullen Skink While older people prefer Parten Bree.

# 3) Overall do more people prefer Cullen Skink or Parten Bree?

question.3 <- ddply(tidydf, .variables="preference", .fun=question.fun)

# Overall, people in Scotland prefer Parten Bree.

##### Question 5 #####

# I already made the change to answer these questions. Instead of showing the data in terms of
# a yes or no question to whether or not the person prefers Cullen Skink, I would have a 
# "preference" variable, which is defined as Cullen Skink or Parten Bree.
