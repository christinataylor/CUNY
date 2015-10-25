

library(bootstrap)

B <- 200
n <- nrow(law)
R <- numeric(B)

for(b in 1:B){
  i <- sample(1:n, size=n, replace=TRUE)
  LSAT <- law$LSAT[i]
  GPA <- law$GPA[i]
  R[b] <- cor(LSAT,GPA)
  
}

hist(R, prob=TRUE)
se.r <- sd(R)

law
sample(c("A","B","C"),size=5,replace=TRUE)


