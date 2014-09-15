#Charley Ferrari
#Week 3 Assignment

##### Question 1 #####

vecnatest <- function(vec){
  count <- 0
  for(v in vec){
    if(is.na(v)){
      count <- count + 1
    }
  }
  return(count)
}

##### Question 2 #####

dfnatest <- function(df){
  dfcount <- numeric()
  for(colnum in 1:ncol(df)){
    dfcount <- c(dfcount,vecnatest(df[,colnum]))
    names(dfcount)[length(dfcount)] <- colnames(df)[colnum]
  }
  return(dfcount)
}

##### Question 3 #####

vecstats <- function(vec){
  
  if(length(vec) > 0){
    nacount <- vecnatest(vec)
    vec <- vec[!is.na(vec)]
    sortedvec <- vec
    count <- 0
  
    #Sort vector
    while(TRUE){
      count <- 0
      for(n in 1:(length(sortedvec)-1)){
        if(sortedvec[n] > sortedvec[n+1]){
          x <- sortedvec[n]
          sortedvec[n] <- sortedvec[n+1]
          sortedvec[n+1] <- x
        }else{
          count <- count + 1
        }
      }
      if(count == length(sortedvec)-1){
        break
      }
    }
    
    min <- sortedvec[1]
    max <- sortedvec[length(sortedvec)]
    
    vecsum <- 0
    for(n in vec){
      vecsum <- vecsum+n
    }
    mean <- vecsum/length(vec)
    
    sdvec <- (vec-mean)^2
    sdvecsum <- 0
    for(n in sdvec){
      sdvecsum <- sdvecsum+n
    }
    #For sd we nuse the denominator n-1
    sd <- sqrt(sdvecsum/(length(vec)-1))
    
    #For the median, if the length is odd, I used the vector[(Lenth+1)/2]. If the length
    #is even, I took the average of the two middle numbers. I used a similar method for
    #the quartiles. This does not match the default quantile() function.
    #(It does however match the type 2 method in quantile())
    
    if(length(sortedvec)%%2 == 0){
      if(length(sortedvec)%%4 == 0){
        med <- (sortedvec[length(sortedvec)/2] + sortedvec[(length(sortedvec)/2)+1])/2
        q1 <- (sortedvec[length(sortedvec)/4] + sortedvec[(length(sortedvec)/4)+1])/2
        q3 <- (sortedvec[(3*length(sortedvec))/4] + sortedvec[((3*length(sortedvec))/4)+1])/2
      }else{
        med <- (sortedvec[length(sortedvec)/2] + sortedvec[(length(sortedvec)/2)+1])/2
        q1 <- sortedvec[(length(sortedvec)%/%4)+1]
        q3 <- sortedvec[((3*length(sortedvec))%/%4)+1]
      }
    }else{
      if((length(sortedvec)-1)%%4 == 0){
        med <- sortedvec[(length(sortedvec)+1)/2]
        #Why is med coming up as 101L?
        q1 <- (sortedvec[(length(sortedvec)-1)/4] + sortedvec[((length(sortedvec)-1)/4)+1])/2
        q3 <- (sortedvec[(3*(length(sortedvec)-1))/4] + sortedvec[((3*(length(sortedvec)-1))/4)+1])/2
      }else{
        med <- sortedvec[(length(sortedvec)+1)/2]
        q1 <- sortedvec[(length(sortedvec)+1)/4]
        q3 <- sortedvec[(3*(length(sortedvec)+1))/4]
      }
    }
    
    return(list("Number of NAs"=nacount, Minimum=min, "1st Quartile"=q1, Median=med,
                "3rd Quartile"=q3, Maximum=max, Mean=mean,
                "Standard Deviation"=sd))
    
  }else{
    return(list())
  }
}

##### Question 4 #####

veclevelinfo <- function(vec){
  nacount <- vecnatest(vec)
  vec <- vec[!is.na(vec)]
  vec <- as.factor(vec)
  distinct <- length(levels(vec))
  maxoccur <- 0
  for(lev in levels(vec)){
    if(length(vec[vec==lev]) > maxoccur){
      mostCommonElement <- lev
      maxoccur <- length(vec[vec==lev])
    }
  }
  return(list("Number of Distinct Elements"=distinct,
              "Most Commonly Occurring Element"=mostCommonElement,
              "Number of Times MCOE Occurs"=maxoccur,
              "Number of Missing Values"=nacount))
}

##### Question 5 #####

veclogicinfo <- function(vec){
  nacount <- vecnatest(vec)
  vec <- vec[!is.na(vec)]
  truecount <- 0
  falsecount <- 0
  for(val in vec){
    if(val){
      truecount <- truecount + 1
    }else{
      falsecount <- falsecount + 1
    }
  }
  return(list("Number of True Values"=truecount,
              "Number of False Values"=falsecount,
              "Proportion of True Values"=truecount/length(vec),
              "Number of Missing Values"=nacount))
}

##### Question 6 #####

rm(Age, Birthday, Fame.Claim, Name)
df$True <- c(TRUE, TRUE, FALSE, TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, FALSE)

typeof(df$True)

ncol(df)

dfsummary <- function(df){
  naSummary <- numeric()
  statsList <- list()
  for(colnum in 1:ncol(df)){
    naSummary <- c(naSummary, vecnatest(df[,colnum]))
    names(naSummary)[length(naSummary)] <- paste("Number of NAs",colnames(df)[colnum],
                                                 sep=": ")
    if(is.numeric(df[,colnum]) & is.null(levels(df[,colnum]))){
      statsList <- c(statsList, "Numeric Stats Summary"=vecstats(df[,colnum]))
    }else if(typeof(df[,colnum]) == "character" | !is.null(levels(df[,colnum]))){
      statsList <- c(statsList, "Factor Stats Summary"=veclevelinfo(df[,colnum]))
    }else if(typeof(df[,colnum]) == "logical"){
      statsList <- c(statsList, "Logical Stats Summary"=veclogicinfo(df[,colnum]))
    }else{
      statsList <- c(statsList, "No Summary Available"="There are no relevant statistics
                     available for this column")
    }
  }
  return(list("Summary of Missing Values"=naSummary,
              "Summary of Columns"=statsList))
}

rm(dfdf)
