library(rvest)
library(dplyr)

weatherpage <- html("http://www.wunderground.com/history/airport/KNYC/2014/12/3/DailyHistory.html")

time <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(1)") %>%
  html_text()

temp <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(2) > span > span.wx-value") %>%
  html_text() %>%
  as.numeric()

Windchill <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(3) > span > span.wx-value") %>%
  html_text() %>%
  as.numeric()

dewpoint <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(4) > span > span.wx-value") %>%
  html_text() %>%
  as.numeric()

humidity <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(5)") %>%
  html_text()
humidity <- as.numeric(substr(humidity, 1, 2))

pressure <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(6) > span > span.wx-value") %>%
  html_text() %>%
  as.numeric()

visibility <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(7) > span > span.wx-value") %>%
  html_text() %>%
  as.numeric()

winddir <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(8)") %>%
  html_text()

windspeed <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(9) > span > span.wx-value") %>%
  html_text()

gustspeed <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(10)") %>%
  html_text()
gustspeed[gustspeed == "\n  -\n"] <- NA
gustspeed[!is.na(gustspeed)] <- as.numeric(substr(gustspeed[!is.na(gustspeed)],4,7))

precip <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(11)") %>%
  html_text()
precip[precip == "N/A"] <- NA
precip[!is.na(precip)] <- as.numeric(substr(precip[!is.na(precip)],4,7))

events <- weatherpage %>%
  html_nodes("#obsTable > tbody > tr > td:nth-child(12)") %>%
  html_text()
events[events == "\n\t \n"] <- NA
events[!is.na(events)] <- stri_sub(events[!is.na(events)],2)

stri_sub("abcde", 2)

nchar("abcde")

events[!is.na(events)]

events[1] == "\n\t \n"
events[1] == events[1]
events[1]
events[4] == "\n\t \n"
