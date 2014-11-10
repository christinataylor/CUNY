library(dplyr)
library(RPostgreSQL)


#########################################################
#
# Part 1: Uploading the data to R
# 
#########################################################

workingDirectory <- paste("C:/Users/Charley/Downloads/Courses/CUNY/SPS",
"/Git/IS 607 Data Acquisition and Management/Project 4", sep="")
setwd(workingDirectory)

grad.students <- read.csv(paste("https://raw.githubusercontent.com/",
"fivethirtyeight/data/master/college-majors/grad-students.csv", sep=""), 
stringsAsFactors=FALSE)
recent.grads <- read.csv(paste("https://raw.githubusercontent.com/",
"fivethirtyeight/data/master/college-majors/recent-grads.csv", sep=""),
stringsAsFactors=FALSE)
all.ages <- read.csv(paste("https://raw.githubusercontent.com/",
"fivethirtyeight/data/master/college-majors/all-ages.csv", sep=""),
stringsAsFactors=FALSE)
majors.list <- read.csv(paste("https://raw.githubusercontent.com/",
"fivethirtyeight/data/master/college-majors/majors-list.csv", sep=""),
stringsAsFactors=FALSE)


# Make sure the major codes are unique
length(unique(grad.students$Major_code))
length(unique(all.ages$Major_code))
length(unique(recent.grads$Major_code))
length(unique(majors.list$FOD1P))

# Checking why the lengh of majors.list is one item longer.
filter(majors.list, !FOD1P %in% recent.grads$Major_code)
filter(majors.list, !FOD1P %in% all.ages$Major_code)
filter(majors.list, !FOD1P %in% grad.students$Major_code)

# It should be safe to remove NA majors
majors.list <- filter(majors.list, Major != "N/A (less than bachelor\'s degree)")

# Now to make FOD1P an int, instead of CHR
majors.list$FOD1P <- as.integer(majors.list$FOD1P)

# Fixing column titles. 
# majors.list$FOD1P will be changed to $Major_code
# recent.grads$Full_time_year_round will be changed to
# $Employed_full_time_year_round

colnames(majors.list) <- c("Major_code", "Major", "Major_Category")
colnames(recent.grads)[colnames(recent.grads) == "Full_time_year_round"] <- 
  "Employed_full_time_year_round"

#########################################################
#
# Part 2: Preparing data for PostgreSQL Upload
# See Appendix B for data source schema and PSQL Schema
# 
#########################################################

# Remove Major and Major cateogry from all.ages, grad.students, 
# and recent.grads


all.ages <- select(all.ages, -(c(Major, Major_category)))
grad.students <- select(grad.students, -(c(Major, Major_category)))
recent.grads <- select(recent.grads, -(c(Major, Major_category)))


con <- dbConnect(RPostgreSQL::PostgreSQL(), user="postgres", 
                 password="sinaiA9xpsql", dbname="MajorIncome")
con

#dbConnect(RPostgreSQL::PostgreSQL(), "postgres", "sinaiA9xpsql")
#dbDisconnect(con)

dbWriteTable(con, "majorlist", majors.list, row.names=FALSE)
dbWriteTable(con, "allages", all.ages, row.names=FALSE)
dbWriteTable(con, "recentgrads", recent.grads, row.names=FALSE)
dbWriteTable(con, "gradstudents", grad.students, row.names=FALSE)


#########################################################
#
# Part 3: Preparing data for MongoDB Upload
# See Appendix B for data source schema and Mongo Schema
# All data will be added in one collection
# Data will be written to CSV and then imported into 
# 
#########################################################

rm(majors.list)
all.ages$Student_type <- "All ages"
grad.students$Student_type <- "Grad students"
recent.grads$Student_type <- "Recent grads"

write.csv(all.ages, "allages.csv", row.names=FALSE)
write.csv(grad.students, "gradstudents.csv", row.names=FALSE)
write.csv(recent.grads, "recentgrads.csv", row.names=FALSE)

