install.packages("devtools")
install.packages("Rtools")
devtools::install_github("bigvis")
library(Rtools)

install.packages("Rcpp", type="source")

install.packages("installr")
?devtools::install_github
library(bigvis)


setwd("E:/CUNY Semester 1/IS 607 Data Acquisition and Management/Semester Project")

weekends <- read.csv("weekends.csv")
