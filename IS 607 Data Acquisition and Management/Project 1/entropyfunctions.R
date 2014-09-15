#Charley Ferrari
#Programming Entropy and Information Gain

workingDirectory <- "C:/Users/Charley/Downloads/Courses/CUNY/SPS/Git/IS 607 Data Acquisition and Management/Project 1"
setwd(workingDirectory)

data <- read.csv("entropy-test-file.csv", header=TRUE)

##### entropy function #####

entropy <- function(d){
  d <- as.factor(d)
  entropy <- 0
  for(level in levels(d)){
    p <- length(d[d==level])/length(d)
    entropy <- entropy + p*log2(p)
  }
  return(-entropy)
}

entropy(data$answer)

#> entropy(data$answer)
#[1] 0.9832692

##### infogain function #####

infogain <- function(d,a){
  combined <- data.frame(d,a)
  ed <- entropy(combined$d)
  ea <- 0
  combined$a <- as.factor(combined$a)
  for(level in levels(combined$a)){
    w <- length(combined[combined$a==level,"d"])/length(combined$d)
    ea <- ea + w*entropy(combined[combined$a==level,"d"])
  }
  return(ed-ea)
  
}

infogain(data$answer, data$attr1)

#> infogain(data$answer, data$attr1)
#[1] 2.411565e-05

infogain(data$answer, data$attr2)

#> infogain(data$answer, data$attr2)
#[1] 0.2599038

infogain(data$answer, data$attr3)

#> infogain(data$answer, data$attr3)
#[1] 0.002432707

#### decide function #####

decide <- function(df,colnum){
  maxrow <- 1
  max <- 0
  #gains <- list()
  gains <- numeric()  
  for(c in colnames(df)){
    if(c != colnames(df)[colnum]){
      #gains[[colnames(df)[grep(c,colnames(df))]]] <- infogain(df[,colnames(df)[colnum]],df[,c])
      gains <- c(gains, infogain(df[,colnames(df)[colnum]],df[,c]))
      names(gains)[length(gains)] <- colnames(df)[grep(c,colnames(df))]
      if(infogain(df[,colnames(df)[colnum]],df[,c]) > max){
        max <- infogain(df[,colnames(df)[colnum]],df[,c])
        maxrow <- grep(c,colnames(df))
      }
    }
  }
  return(list(max=maxrow,gains=gains))
}

#decide(data,4)

#> decide(data,4)
#$max
#[1] 2

#$gains
#attr1        attr2        attr3 
#2.411565e-05 2.599038e-01 2.432707e-03 