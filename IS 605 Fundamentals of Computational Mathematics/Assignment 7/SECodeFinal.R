calcVar_CharleyFerrari <- function(filepath){
  
  #Count the number of "portions" within the CSV
  #We have a limit of 100,000 entries in memory. Because we're calculating covariances,
  #we're going to need to divide up the table into 50,000 entry portions
  #For testing purposes I set a variable "limit" to 21. This can easily be changed to 50,000
  
  
  #Since the problem gives 1,000,451 rows, instead of doing a general solutin as I initially 
  #set out to do, I'm going to divide this into 563 jobs of 1777 entries.
 
  #rm(table, i, limit, portionCount, skipRows, table1, table2, M, j)
  
  
 
  #portionCount <- 0
  
  skipRows <- 1
  i <- 0
  limit <- 1777
  
  #while(i == 0){
  #  table <- read.table(filepath, header = FALSE, sep = "|", nrows = limit, skip = skipRows)
  #  colnames(table) <- c("ID", "Region", "Amount")
  #  if(length(table$ID) != limit){
  #    i <- 1
  #  } else {
  #    skipRows = skipRows + limit
  #  }
  #  portionCount = portionCount + 1
  #}
  

  M <- matrix(numeric(0), 563,563)
  
  for(i in 1:563){
    for(j in 1:563){
      table1 <- read.table(filepath, header = FALSE, sep = "|", nrows = limit, skip = limit*(i-1)+1)
      colnames(table1) <- c("ID", "Region", "Amount")
      table2 <- read.table(filepath, header = FALSE, sep = "|", nrows = limit, skip = limit*(j-1)+1)
      colnames(table2) <- c("ID", "Region", "Amount")
      M[i,j] = cov(table1$Amount, table2$Amount)
    }
  }

 return(sum(M))
}
  
