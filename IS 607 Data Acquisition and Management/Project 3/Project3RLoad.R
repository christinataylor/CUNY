library(RPostgreSQL)

################################
#
# Project 3 Base Loading Script
# 
################################

workingdirectory <- "C:/Users/Charley/Downloads/Courses/CUNY/SPS/Git/IS 607 Data Acquisition and Management/Project 3"
setwd(workingdirectory)

wikidata <- read.table("20141001140000.txt", header=FALSE, sep=" ", stringsAsFactors=FALSE)
colnames(wikidata) <- c("projectcode", "pagename", "pageviews", "bytes")

write.csv(wikidata, "wikidata.csv")

con <- dbConnect(RPostgreSQL::PostgreSQL(), user="postgres", password="insertpasswordhere",
                 dbname="WikiData")
con

dbConnect(RPostgreSQL::PostgreSQL(), "postgres", "insertpasswordhere")
dbDisconnect(con)

################################
#
# Project 3 Challenge Loading Script
# 
################################

dbWriteTable(con, "wikitable", wikidata, row.names=FALSE)

workingdirectory <- "C:/Users/Charley/Downloads/Courses/CUNY/SPS/Git/IS 607 Data Acquisition and Management/Project 3/Project Challenge"
setwd(workingdirectory)

wikidata <- read.table("pagecounts-20130802-210000.txt", header=FALSE, sep=" ", stringsAsFactors=FALSE)

con <- dbConnect(RPostgreSQL::PostgreSQL(), user="postgres", password="sinaiA9xpsql",
                 dbname="wikidatachallenge")
con

colnames(wikidata) <- c("projectcode", "pagename", "pageviews", "bytes")
dbWriteTable(con, "wikitable", wikidata, row.names=FALSE)

wikidata2 <- read.table("projectcounts-20130802-220001.txt", header=FALSE, sep=" ", stringsAsFactors=FALSE)
colnames(wikidata2) <- c("projectcode", "pagename", "pageviews", "bytes")

dbWriteTable(con, "wikitable2", wikidata2, row.names=FALSE)
