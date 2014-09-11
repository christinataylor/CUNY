#Week 3 Quiz
#Charley Ferrari

##### Question 1 #####

vecMean <- function(vec){
  
  #Takes in a vector and returns the mean.
  return(mean(vec))
  
}



##### Question 2 #####

vecMean <- function(vec){
  #Takes in a vector and returns the mean of the observations, while handling NAs.
  sum = 0
  for(n in vec){
    if(!is.na(n)){
      sum = sum + n
    }
  }
  return(sum/length(vec))
}

##### Question 3 #####

gcd <- function(x,y){
  gcdval <- 1
  if(x < y){
    for(n in y:1){
      if(y%%n == 0 & x%%n == 0){
        gcdval <- n
        break
      }
    }
  }else{
    for(n in x:1){
      if(y%%n == 0 & x%%n == 0){
        gcdval <- n
        break
      }
    }
  }
  return(gcdval)
}

##### Question 4 #####

gcd <- function(x,y){
  if(x == y){
    gcdval <- x
    return(gcdval)
  }else if(x > y){
    gcd(x-y, y)
  }else{
    gcd(y-x, x)
  }
}

#This is what I originally had (prints inclued to debug.)
#I ultimately tried putting the return in the if statement.
#Theoretically it should work this way... Not sure why it wasn't
#
#gcd <- function(x,y){
#  if(x == y){
#    print(c(x, y, "equal"))
#    gcdval <- x
#    print(gcdval)
#  }else if(x > y){
#    print(c(x, y))
#    gcd(x-y, y)
#    print("elseif ran")
#  }else{
#    print(c(x,y))
#    gcd(y-x, x)
#    print("else ran")
#  }
#  print("here?")
#  return(gcdval)
#}

##### Question 5 #####

formulacalc <- function(x,y){
  return(x^2*y + 2*x*y - x*y^2)
}

##### Question 6 #####

workingDirectory <- "C:/Users/Charley/Downloads/Courses/CUNY/SPS/Git/IS 607 Data Acquisition and Management/Week 3/quiz"
setwd(workingDirectory)

price <- read.csv("week-3-price-data.csv", header=TRUE)
makeModel <- read.csv("week-3-make-model-data.csv", header=TRUE)

mergedData <- merge(price, makeModel, by="ModelNumber")

#makeModel: 8 obs. of 4 variables
#price: 28 obs. of 5 variables
#mergedData: 27 obs. of 8 variables

#I didn't expect this... I expected the 28 obs. of price with the added information
#provided in makeModel...

##### Question 7 #####

mergedData <- merge(price, makeModel, by="ModelNumber", all=TRUE)

##### Question 8 #####

question8SubSet <- mergedData[mergedData$Year == 2010,]

#I wonder why this gives me a row of NA. Lets try the subset function

question8SubSet <- subset(mergedData, Year == 2010)

#That works.

##### Question 9 #####

question9SubSet <- mergedData[mergedData$Color == "Red" & 
                                mergedData$Price > 10000,]

#This time I didn't get the error. I'm guessing because there's not an NA in Color or price.
#For good measure lets use subset

question9SubSet <- subset(mergedData, Color == "Red" & Price > 10000)

##### Question 10 #####

question10SubSet <- question9SubSet[,colnames(question9SubSet)!="ModelNumber" &
                                      colnames(question9SubSet)!="Color"]

##### Question 11 #####

letterCount <- function(vec){
  nvec <- numeric(0)
  for(w in vec){
    nvec <- c(nvec, nchar(w))
  }
  return(nvec)
}

##### Question 12 #####

#I'm assuming you wanted the function to die gracefully if the vectors were
#not of the same length?

concat <- function(vec1, vec2){
  if(length(vec1) != length(vec2)){
    return(NA) #Hope that's graceful enough!
  }else{
    if(typeof(vec1)!="character" | typeof(vec2)!="character"){
      return(NA)
    }else{
      rvec <- character(0)
      for(n in 1:length(vec1)){
        rvec <- c(rvec, paste(vec1[n], vec2[n], sep=" "))
      }
      return(rvec)
    }
  }
}

##### Question 13 #####

substr3 <- function(vec){
  rvec <- character(0)
  for(w in vec){
    for(n in 1:nchar(w)){
      if(substr(w,n,n) %in% c("a","e","i","o","u")){
        if(n+2 <= nchar(w)){
          rvec <- c(rvec,substr(w,n,n+2))
        }else{
          rvec <- c(rvec,NA)
        }
        break
      }
      if(n == nchar(w)){
        rvec <- c(rvec,NA)
      }
    }
  }
  return(rvec)
}

##### Question 14 #####

months <- 1:12
days <- c(1,3,4,6,22,12,14,16,21,8,7,12)
years <- 2000:2011

df <- data.frame(months, days, years)

df$dates <- strptime(paste(months, days, years, sep="-"), format="%m-%d-%Y", tz="")

#Ideally I'd like to have something like "as.date(c(month, day, year))", where I just
#convert the three numbers directly into a date without using paste()
#I remember doing this in the past but for some reason cannot find the project I used it in!

##### Question 15 #####

datestr <- "12-31-2001"
date <- strptime(datestr, format="%m-%d-%Y")

##### Question 16 #####

#using "date" from question 15

month <- date$mon

##### Question 17 #####

begin <- strptime("1-5-2005", format="%m-%d-%Y")
end <- strptime("12-31-2014", format="%m-%d-%Y")

sequence <- seq(from=begin, to=end, by="days")

#for some reason this doesn't look like a vector in the environment. But, when I call 
#sequence[1], sequence[2], etc, it seems to be behaving as expected.