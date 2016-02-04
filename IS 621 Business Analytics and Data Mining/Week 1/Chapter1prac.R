#install.packages("faraway")

library(faraway)

pima

summary(pima)

sort(pima$diastolic)

pima$diastolic[pima$diastolic == 0] <- NA
pima$test <- factor(pima$test)
levels(pima$test) <- c('negative', 'positive')

hist(pima$diastolic)

plot(density(pima$diastolic, na.rm = TRUE))
