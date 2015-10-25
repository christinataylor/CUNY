library(TTR)
library(forecast)
library(babynames)

head(babynames)
ggplot(babytest, aes(x=year, y=n))  + geom_line()
babytest$n


namefilter <- "Keith"

babytest <- babynames %>% filter(name==namefilter, sex=="M")

nameseries <- ts(babytest$n, frequency = 1, start=1880)

plot.ts(nameseries)

ggplot(babytest, aes(x=year, y=n))  + geom_line()

install.packages("zoo")
library(zoo)
vignette("zoo")

install.packages(c('openintro','OIdata','devtools','ggplot2','psych','reshape2',
                   'knitr','markdown'))
devtools::install_github("jbryer/IS606")
library(RTools)
library(IS606)
