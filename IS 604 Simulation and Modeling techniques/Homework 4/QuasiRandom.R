library(abind)

binvec <- function(n){
  return(rev(as.numeric(intToBits(n))[1:(floor(log(n)/log(2))+1)]))
}

vdc <- function(d,n){
  
  b <- 2
  r <- floor(log(n)/log(b))+1
  
  bitcreate <- function(N,r){
    return(as.numeric(intToBits(N))[1:r])
  }
  
  a <- apply(as.matrix(N,ncol=1),1,bitcreate, r=r)
  bb <- 1/b^(1:r)
  
  return(t(bb) %*% a)
  
}

mcalc <- function(k,r){
  
  polys <- c(1,3,7,11,13,19,25,37,59,47,61,55,41,67,97,91,109,103,
             115,131,193,137,145,143,241,157,185,167,229,171,213,191,
             253,203,211,239,247,285,369,299,425,301,361,333,357,351,
             501,355,397,391,451,463,487)
  
  ivals <- t(matrix(c(1,1,1,1,1,1,1,1,
                      1,3,5,15,17,51,85,255,
                      1,1,7,11,13,61,67,79,
                      1,3,7,5,7,43,49,147,
                      1,1,5,3,15,51,125,141,
                      1,3,1,1,9,59,25,89,
                      1,1,3,7,31,47,109,173,
                      1,3,3,9,9,57,43,43,
                      1,3,7,13,3,35,89,9,
                      1,1,5,11,27,53,69,25,
                      1,3,5,1,15,19,113,115,
                      1,1,7,3,29,51,47,97,
                      1,3,7,7,21,61,55,19,
                      1,1,1,9,23,39,97,97,
                      1,3,3,5,19,33,3,197,
                      1,1,3,13,11,7,37,101,
                      1,1,7,13,25,5,83,255,
                      1,3,5,11,7,11,103,29,
                      1,1,1,3,13,39,27,203,
                      1,3,1,15,17,63,13,65),nrow=8))
  
  m <- ivals[k,]
  ppn <- polys[k]
  c <- tail(binvec(ppn),-1)
  deg <- length(c)
  for(i in 8:r){
    s <- 0
    for(j in 1:deg){
      s <- bitwXor(s,(2^j)*c[j]*m[i-j])
    }
    m <- c(m,bitwXor(s,m[i-deg]))
  }
  
  return(m[1:r])
  
}

vcalc <- function(k,r){
  V <- diag(r)
  if(k>=2){
    for(i in 2:k){
      m <- mcalc(i,r)
      vk <- c()
      for(j in 1:r){
        h <- binvec(m[j])
        h <- c(rep(0,j-length(h)), h, rep(0,r-j))
        vk <- cbind(vk,as.matrix(h,nrow=r))
      }
      V <- abind(V,vk,along=3)
    }
  }
  return(array(V,dim=c(r,r,k)))
}

scramblevcalc <- function(r){
  
  scrambleapply <- function(rownum,r){
    samp <- sample(c(1,0),rownum-1,replace=TRUE)
    return(c(samp,1,rep(0,r-rownum)))
  }
  
  t(sapply(1:r,scrambleapply, r=r))
  
}

# sobol as defined in the Handbook
sobol <- function(d,n,scramble=FALSE){
  
  b <- 2
  N <- 0:n
  r <- floor(log(n)/log(b))+1
  bb <- 1/b^(1:r)
  
  bitcreate <- function(N,r){
    return(as.numeric(intToBits(N))[1:r])
  }
  
  a <- t(apply(as.matrix(N,ncol=1),1,bitcreate, r=r))
  
  p <- matrix(nrow=n+1,ncol=d)
  
  V <- vcalc(d, r)

  for(i in 1:d){
    Vtemp <- V[,,i]
    atv <- (a%*%t(Vtemp))%%b
    if(scramble){
      scramblevec <- scramblevcalc(r)
      atv <- (atv%*%t(scramblevec))%%b
    }
    
    p[,i] <- bb %*% t(atv)
  }
  
  return(p)
  
}

# Sobol actually returning length n, 0 to n-1

sobol <- function(d,n,scramble=FALSE){
  
  b <- 2
  N <- 0:(n-1)
  r <- floor(log(n-1)/log(b))+1
  bb <- 1/b^(1:r)
  
  bitcreate <- function(N,r){
    return(as.numeric(intToBits(N))[1:r])
  }
  
  a <- t(apply(as.matrix(N,ncol=1),1,bitcreate, r=r))
  
  p <- matrix(nrow=n,ncol=d)
  
  V <- vcalc(d, r)
  
  for(i in 1:d){
    Vtemp <- V[,,i]
    atv <- (a%*%t(Vtemp))%%b
    if(scramble){
      scramblevec <- scramblevcalc(r)
      atv <- (atv%*%t(scramblevec))%%b
    }
    
    p[,i] <- bb %*% t(atv)
  }
  
  return(p)
  
}