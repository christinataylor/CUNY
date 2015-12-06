
# Start out at equilibrium

totalPop <- 10000

capacity <- c(5000,5000)

slack <- c(4000,4000)

capjobs <- 0.98*capacity

UE <- 1-(capjobs/capacity)

avgUE <- sum((capacity/totalPop)*UE)

# Lets test out what happens when 10 people moves from location A to location B
# First, lets define the number of jobs lost or gained with an inflow or outflow 
# of population. 

marginaljobs <- function(p, capacity, slack){
  return((capacity - p)/(capacity - slack))
}

intmarginaljobs <- function(p, capacity, slack){
  imj <- (2*capacity*p - p^2)/(2*capacity - 2*slack)
  return(imj)
}

numjobsraw <- function(p1,p2,capacity,slack){
  nj <- intmarginaljobs(p2,capacity,slack) - 
    intmarginaljobs(p1,capacity,slack)
  return(nj)
}

numjobs <- function(p1,p2,capacity,slack){
  if(p1 < slack){
    if(p2 < slack){
      #print(1)
      return((p2-p1))
    }else if(p2 >= slack && p2 < capacity){
      nj <- (slack-p1) + numjobsraw(slack,p2,capacity,slack)
      #print(2)
      return(nj)
    }else{
      nj <- (slack-p1) + numjobsraw(slack,capacity,capacity,slack)
      #print(3)
      return(nj)
    }
    
  }else if(p1 >= slack && p1 < capacity){
    if(p2 < slack){
      nj <- (p2-slack) + numjobsraw(p1,slack,capacity,slack)
      #print(4)
      return(nj)
    }else if(p2 >= slack && p2 < capacity){
      nj <- numjobsraw(p1,p2,capacity,slack)
      #print(5)
      return(nj)
    }else{
      nj <- numjobsraw(p1,capacity,capacity,slack)
      #print(6)
      return(nj)
    }
    
  }else{
    if(p2 < slack){
      nj <- numjobsraw(capacity,slack,capacity,slack) + (p2 - slack)
      #print(7)
      return(nj)
    }else if(p2 >= slack && p2 < capacity){
      nj <- numjobsraw(capacity,p2,capacity,slack)
      #print(8)
      return(nj)
    }else{
      #print(9)
      return(0)
    }
  }
}

## Now lets move 500 people from location A to location B

deltaPop <- c(-500,500)
deltaJobs <- c(numjobs(5000,4500,5000,4000),numjobs(5000,5500,5000,4000))

population <- capacity + deltaPop
jobs <- capjobs + deltaJobs
UE <- 1-(jobs/population)
avgUE <- sum((capacity/totalPop)*UE)
