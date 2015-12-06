setwd("E:/Downloads/Courses/CUNY/SPS/Git/IS 604 Simulation and Modeling techniques/Final Project/migration data")

library(plyr)
library(dplyr)
library(reshape)


data <- read.csv("cty_05_09.csv")

nylist <- c("Ulster County", "Dutchess County", "Putnam County",
            "Westchester County", "Rockland County", "Orange County", 
            "Bronx County", "New York County", "Queens County", "Kings County",
            "Richmond County", "Nassau County", "Suffolk County")

ctlist <- c("Litchfield County", "New Haven County", "Fairfield County")

njlist <- c("Bergen County", "Passaic County", "Morris County", "Essex County",
            "Hudson County", "Union County", "Somerset County",
            "Hunterdon County", "Mercer County", "Middlesex County",
            "Monmouth County", "Ocean County", "Warren County")

palist <- c("Pike County", "Monroe County", "Northampton County",
            "Carbon County", "Lehigh County")

statelist <- c(rep("New York",length(nylist)),rep("Connecticut",length(ctlist)),
               rep("New Jersey",length(njlist)),rep("Pennsylvania",length(palist)))

msalist <- data.frame(state=statelist,county=c(nylist,ctlist,njlist,palist))

nydata <- merge(data,msalist,by.x=c("dest.state","dest.county"),
                by.y=c("state","county"))

nydata <- merge(nydata,msalist,by.x=c("src.state","src.county"),
                by.y=c("state","county"))

fiveboros <- c("Bronx County","New York County", "Richmond County",
            "Queens County", "Kings County")

burblist <- filter(msalist,!(county %in% fiveboros))
citylist <- filter(msalist,county %in% fiveboros)

borodata <- merge(data,citylist,by.x=c("dest.state","dest.county"),
                  by.y=c("state","county"))

borodata <- merge(borodata,citylist,by.x=c("src.state","src.county"),
                  by.y=c("state","county"))

borodata <- select(borodata,-fips)



#destmetapply1 <- function(boro){
#  dest <- filter(nydata,dest.county==boro &
#                   !(src.county %in% fiveboros))
#  return(sum(dest$migration))
#}

#srcmetapply1 <- function(boro){
#  src <- filter(nydata,src.county==boro & 
#                  !(dest.county %in% fiveboros))
#  
#  return(sum(src$migration))
#}

destmetapply <- function(boro){
  newcitylist <- filter(citylist,county==boro)
  dest <- merge(data,newcitylist,by.x=c("dest.state","dest.county"),
                by.y=c("state","county"))
  dest <- merge(dest,burblist,by.x=c("src.state","src.county"),
                by.y=c("state","county"))
  return(sum(dest$migration))
}

srcmetapply <- function(boro){
  newcitylist <- filter(citylist,county==boro)
  src <- merge(data,newcitylist,by.x=c("src.state","src.county"),
               by.y=c("state","county"))
  src <- merge(src,burblist,by.x=c("dest.state","dest.county"),
               by.y=c("state","county"))
  return(sum(src$migration))
}

desttotapply <- function(boro){
  newcitylist <- filter(citylist,county==boro)
  dest <- merge(data,newcitylist,by.x=c("dest.state","dest.county"),
                by.y=c("state","county"))
  dest <- anti_join(dest,msalist,by=c("src.state"="state","src.county"="county"))
  return(sum(dest$migration))
}

srctotapply <- function(boro){
  newcitylist <- filter(citylist,county==boro)
  src <- merge(data,newcitylist,by.x=c("src.state","src.county"),
               by.y=c("state","county"))
  src <- anti_join(src,msalist,by=c("dest.state"="state","dest.county"="county"))
  return(sum(src$migration))
}

msaoutside <- merge(data,burblist,by.x=c("src.state","src.county"),
                    by.y=c("state","county"))
msaoutside <- anti_join(msaoutside,msalist,by=c("dest.state"="state",
                                                "dest.county"="county"))
msaoutside <- sum(msaoutside$migration)

outsidemsa <- merge(data,burblist,by.x=c("dest.state","dest.county"),
                    by.y=c("state","county"))
outsidemsa <- anti_join(outsidemsa,msalist,by=c("src.state"="state",
                                                "src.county"="county"))
outsidemsa <- sum(outsidemsa$migration)



destmettot <- apply(matrix(fiveboros),MARGIN=1,FUN=destmetapply)

srcmettot <- apply(matrix(fiveboros),MARGIN=1,FUN=srcmetapply)

desttottot <- apply(matrix(fiveboros),MARGIN=1,FUN=desttotapply)

srctottot <- apply(matrix(fiveboros),MARGIN=1,FUN=srctotapply)

destmettot <- data.frame(src.state="NYMSA",src.county="NYMSA",dest.state="New York",
                      dest.county=fiveboros,migration=destmettot)

srcmettot <- data.frame(src.state="New York",src.county=fiveboros,dest.state="NYMSA",
                     dest.county="NYMSA",migration=srcmettot)

desttottot <- data.frame(src.state="Rest",src.county="Rest",dest.state="New York",
                         dest.county=fiveboros,migration=desttottot)

srctottot <- data.frame(src.state="New York",src.county=fiveboros,dest.state="Rest",
                        dest.county="Rest",migration=srctottot)

msaoutside <- data.frame(src.state="NYMSA",src.county="NYMSA",dest.state="Rest",
                         dest.county="Rest",migration=msaoutside)

outsidemsa <- data.frame(src.state="Rest",src.county="Rest",dest.state="NYMSA",
                         dest.county="NYMSA",migration=outsidemsa)

finaldata <- rbind(borodata,destmettot,desttottot,srcmettot,srctottot,
                   msaoutside,outsidemsa)

############################

setwd("E:/Raw Data/Census PUMS/csv_pus_2014")

data1 <- read.csv("ss14pusa.csv")
data2 <- read.csv("ss14pusb.csv")

data <- readLines("ss14pusa.csv",n=50)

data$MIGPUMA[is.na(data$MIGPUMA)] <- data[is.na(data$MIGPUMA),"PUMA"]
data$MIGSP[is.na(data$MIGSP)] <- data[is.na(data$MIGSP),"ST"]



data 

length(data$)
data[2]

?read.csv

#######################
#
# States
# 
#######################

mig2014 <- read.csv("2014matrix.csv",header=TRUE,stringsAsFactors = FALSE)

migsame2014 <- read.csv("2014same.csv")

colnames(mig2014)[2:52] <- 
  as.character(migsame2014$State[1:(length(migsame2014$State)-1)])

colnames(mig2014)[54] <- "Puerto Rico"


for(state in as.character(migsame2014$State)){
  mig2014[mig2014$X == state,state] <- 
    as.numeric(migsame2014[migsame2014$State == state,"Migration"])
}

mig <- melt(mig2014,measure.vars=colnames(mig2014)[2:length(colnames(mig2014))])

mig$year <- 2014

colnames(mig) <- c("source","destination","migration","year")

migtotal <- mig

for(year in c(2013,2012,2011,2010)){

  mig <- read.csv(paste(year,"matrix.csv",sep=""),header=TRUE,
                  stringsAsFactors = FALSE)
  
  migsame <- read.csv(paste(year,"same.csv",sep=""))
  
  colnames(mig)[2:52] <- 
    as.character(migsame$State[1:(length(migsame$State)-1)])
  
  colnames(mig)[54] <- "Puerto Rico"
  
  
  for(state in as.character(migsame$State)){
    mig[mig$X == state,state] <-
      as.numeric(migsame[migsame$State == state,"Migration"])
  }
  
  mig <- melt(mig,measure.vars=colnames(mig)[2:length(colnames(mig))])
  
  mig$year <- year
  
  colnames(mig) <- c("source","destination","migration","year")
  
  migtotal <- rbind(migtotal,mig)
  
}

for(year in c(2009,2008,2007,2006,2005)){
  mig <- read.csv(paste(year,"matrix.csv",sep=""),header=TRUE,
                  stringsAsFactors = FALSE)
  
  colnames(mig)[2:40] <- 
    as.character(migsame$State[1:39])
  
  colnames(mig)[41] <- "Puerto Rico"
  
  colnames(mig)[42:length(colnames(mig))] <- 
    as.character(migsame$State[40:(length(migsame$State)-1)])
  
  mig <- melt(mig,measure.vars=colnames(mig)[2:length(colnames(mig))])
  
  mig$year <- year
  
  colnames(mig) <- c("source","destination","migration","year")
  
  migtotal <- rbind(migtotal,mig)
  
}

migtotal$migration <- as.numeric(migtotal$migration)

migtotal$source <- as.factor(migtotal$source)

#migsum <- migtotal %>% group_by(year) %>% summarize(sum = sum(migration))

migtest <- filter(migtotal, as.character(source) == as.character(destination))
migtest <- select(migtest,-source)
migtestsum <- migtest %>% group_by(year) %>% summarize(sum = sum(migration))

write.csv(migtotal,"migrationflat.csv",row.names=FALSE)

