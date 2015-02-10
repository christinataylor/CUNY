

# matrixFactor returns the matrix result of the Gaussian elimination using recursion

matrixFactor <- function(M){
  E <- matrix()
  if(dim(M)[1] > 1){
    EVec <- -M[2:dim(M)[1],1]/M[1,1]
    E <- matrix(0,nrow=dim(M)[1],ncol=dim(M)[1])
    diag(E) <- 1
    E[2:dim(E)[1],1] <- EVec
    MRec <- matrix((E %*% M)[2:dim(E %*% M)[1],2:dim(E %*% M)[1]],nrow=dim(E %*% M)[1]-1)
    
    EMini <- matrixFactor(MRec)
    
    EFull <- matrix(0,nrow=dim(M)[1],ncol=dim(M)[1])
    diag(EFull) <- 1
    EFull[2:dim(EFull)[1],2:dim(EFull)[1]] <- EMini
    
    E <- EFull %*% E
    
    return(E)
  }else{
    return(matrix(1))
  }
  
}

# factorize uses matrixFactor to return a list of the L and U matrices that 
# square matrix M factorizes to.

factorize <- function(M){
  return(list(solve(matrixFactor(M)), matrixFactor(M) %*% M))
}


