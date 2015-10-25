

theta.hat <- se <- numeric(5)


g <- function(x){
  exp(-x - log(1+x^2)) * (x>0) * (x<1)
}

g(0.5)

cofx <- function(x,D){
  theta.hat <- (1/((2*pi)^(D/2)))*exp((-1/2)*(t(x) %*% x))
  return(theta.hat)
}

x <- (runif(1000)-0.5)*10
x <- -(x+4)*(x-4)

fg <- apply(matrix(x,nrow=1),2,cofx,D=1) / -(x+4)*(x-4)
theta.hat <- mean(fg)
se <- sd(fg)

x <- runif(m)
fg <- g(x)
theta.hat[1] <- mean(fg)
se[1] <- sd(fg)

x <- rexp(m,1)
fg <- g(x) / exp(-x)
theta.hat[2] <- mean(fg)
se[2] <- sd(fg)

x <- rcauchy(m)
i <- c(which(x > 1), which(x < 0))
x[i] <- 22
fg <- g(x) / dcauchy(x)
theta.hat[3] <- mean(fg)
se[3] <- sd(fg)

u <- runif(m)
x <- -log(1 - u*(1 - exp(-1)))
fg <- g(x) / (exp(-1) / (1 - exp(-1)))
theta.hat[4] <- mean(fg)
se[4] <- sd(fg)

u <- runif(m)
x <- tan(pi*u / 4)
fg <- g(x) / (4 / ((1 + x^2)*pi))
theta.hat[5] <- mean(fg)
se[5] <- sd(fg)

x <- seq(0,1,by=0.1)

N <- 10000
results <- data.frame(list(Normal=rep(0,N), Cauchy=rep(0,N), t3=rep(0,N)))
for (i in 1:N) {
  x_norm <- rnorm(100)
  x_cauchy <- rt(100, df=1)
  results[i,1] <- mean(abs(x_norm)*dt(x_norm, df=3)/dnorm(x_norm))
  results[i,2] <- mean(abs(x_cauchy)*dt(x_cauchy, df=3)/dt(x_cauchy, df=1))
  results[i,3] <- mean(abs(rt(100, df=3)))
}
apply(results,2,var)
