

p1 <- 4
p2 <- 2
f12 <- 0
f21 <- 0
f11 <- 4
f22 <- 2
A <- list()

f12 <- c(f12, (tail(p1,1)-tail(p2,1)+6)/4)
f21 <- c(f21, 0)
f11 <- c(f11,tail(p1,1)-tail(f12,1))
f22 <- c(f22, tail(p2,1))
A[[length(A)+1]] <- matrix(c(tail(f11,1)/tail(p1,1),tail(f21,1)/tail(p2,1),
                             tail(f12,1)/tail(p1,1),tail(f22,1)/tail(p2,1)),nrow=2)
p1 <- c(p1, tail(p1,1)-tail(f12,1))
p2 <- c(p2, tail(p2,1)+tail(f12,1))
#A[[length(A)+1]] <- 
