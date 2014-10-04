#install.packages("Quandl")

library(Quandl)

Quandl.auth(auth_token='1Cx13bkj4vDb7E13GLD6')
Quandl.auth()

# The Quandl library lets you download data directly from the Quandl site

GDP = Quandl("FRED/GDP")

# It lets you do some manipulation of the time series data prior to getting it

fedFunds <- Quandl("FRED/DFF", collapse="monthly", start_date="2013-01-01")

# The API also works purely from the web. I could access this same information 
# Directly from CSV (I don't even need XML in order to parse it)


Claims <- read.csv("https://www.quandl.com/api/v1/datasets/FRED/ICSA.csv?exclude_headers=false&trim_start=2013-01-01&collapse=monthly", header=T)
