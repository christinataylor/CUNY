
n <- 20
alpha <- 0.05
mu0 <- 500
sigma <- 100

m <- 10000
p <- numeric(m)
for(j in 1:m){
  x <- rnorm(n, mu0, sigma)
  ttest <- t.test(x, alternative = "greater", mu=mu0)
  p[j] <- ttest$p.value
}

p.hat <- mean(p < alpha)
se.hat <- sqrt(p.hat*(1-p.hat)/m)


t.test(x, alternative = "greater", mu=mu0)
t.test(x, alternative = "greater", mu=mu0)$p.value

#######################

n <- c(10,20,30,40,50)
m <- 1000
mu0 <- 500
sigma <- 100
mu <- c(seq(450,650,10))
M <- length(mu)
power <- c()
for(j in n){  

  for(i in 1:M){
    mu1 <- mu[i]
    pvalues <- replicate(m,expr={
      x <- rnorm(j, mean=mu1, sd=sigma)
      ttest <- t.test(x,
                      alternative="greater", mu=mu0)
      ttest$p.value
    })
    power <- c(power,mean(pvalues<=0.05))
  }
}

table <- expand.grid(mu,n)
colnames(table) <- c("mu","n")
table$power <- power

power <- data.frame(power)

ggplot(table,aes(x=mu,y=power,color=as.factor(n))) + geom_line()
