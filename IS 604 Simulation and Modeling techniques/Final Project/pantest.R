
u1 <- function(p){
  return(-p[1]+8)
}

u2 <- function(p){
  return(-p[2]+14)
}

u <- c(u1(p),u2(p))

p0 <- c(4,2)

# f is {f12, f21}

c12 <- function(f){
  return(2*f[1])
}

c21 <- function(f){
  return(2*f[2])
}

flowcalc <- function(p){
  if(u2(p) > u1(p)){
    f1 <- (p[1] - p[2] + 6)/4
    f <- c(f1,0)
  }else if(u1(p) > u2(p)){
    f2 <- (p[2] - p[1] - 6)/4
    f <- c(0,f2)
  }else{f <- c(0,0)}
  
  return(f)
}


p <- c(4,2)
pdata <- data.frame(p1 = 4, p2 = 2, totalu = u1(p) + u2(p))

p <- c(tail(pdata$p1,1),tail(pdata$p2,1))
f <- flowcalc(p)
u <- c(u1(p),u2(p))
totu <- sum(p*u)

pdata <- rbind(pdata, c(p[1]-f[1]+f[2], p[2]+f[1]-f[2], u))

A <- matrix(c(.5,0,.5,1),nrow=2)

t(matrix(as.numeric(pdata[1,]))) %*% A %*% A %*% A %*% A

matrix(c(4,2),nrow=1) %*% matrix(c(.5,0,.5,1),nrow=2) %*% matrix(c(.5,0,.5,1),nrow=2) %*% %*% matrix(c(.5,0,.5,1),nrow=2)
