A <- matrix(c(1,2,3,1,1,1,2,0,1),nrow=3)

A

E21 <- matrix(c(1,-2,0,0,1,0,0,0,1),nrow=3)

E21 %*% A

E31 <- matrix(c(1,0,-3,0,1,0,0,0,1),nrow=3)

E31 %*% E21 %*% A

E32 <- matrix(c(1,0,0,0,1,-2,0,0,1),nrow=3)

E32 %*% E31 %*% E21 %*% A


A <- matrix(c(1,3,7,2,4,2),nrow=3)
A

B <- matrix(c(4,2,7,9,3,3),nrow=2)

B
A %*% B
t(A) %*% t(B)


A <- matrix(c(1,2,3,1,1,1,2,0,1),nrow=3)
E21 <- matrix(c(1,-2,0,0,1,0,0,0,1),nrow=3)



A %*% E21

E31 <- matrix(c(1,0,-3,0,1,0,0,0,1),nrow=3)
A %*% E31
E31
A
E31 %*% E21 %*% A
E32 <- matrix(c(1,0,0,0,1,-2,0,0,1),nrow=3)
E32 %*% E31 %*% E21 %*% A


length(dim(A))

A[1,1]


E21 <- matrix(c(1,-A[2,1]/A[1,1],0,0,1,0,0,0,1),nrow=3)
E21

E31 <- matrix(c(1,0,-A[3,1]/A[1,1],0,1,0,0,0,1),nrow=3)

E31

(E31 %*% E21 %*% A)[1,1]

E32 <- matrix()

E <- c(E21,E31)
E <- list(E21,E31)
E


E <- list(E21)
E <- c(E, list(E31))


matrixFactor <- function(M){
  EList <- 
  }
}

dim(A)


matrixFactor <- function(M){
  if(dim(M)[1] > 1){
    EVec <- -M[2:dim(M)[1],1]/M[1,1]
    E <- matrix(0,nrow=dim(M)[1],ncol=dim(M)[1])
    diag(E) <- 1
    E[2:dim(E)[1],1] <- EVec
  }
  
}
