library(rvest)

lego_movie <- html("http://www.imdb.com/title/tt1490017/")

rating <- lego_movie %>% 
  html_nodes("strong span") %>%
  html_text() %>%
  as.numeric()
rating

theURL <-"http://en.wikipedia.org/wiki/List_of_paradoxes"

theSource <- html(theURL)

#theURL <- "http://en.wikipedia.org/wiki/List_of_cocktails"
#theSource <- html(theURL)
# Originally I was pulling from this list but decided to use the list of paradoxes instead
# This was the code I tried to use before using selector gadget.

#cocktailList <- theSource %>%
#  html_nodes(".column-count-2 ul li a") %>%
#  html_text()
#cocktailList <- cocktailList[cocktailList != "IBA"]

#cocktailList

paradoxList <- theSource %>%
  html_nodes("p+ ul b , dd b , .thumb+ ul b , h3+ ul b , .seealso+ ul a b , h2+ ul a:nth-child(1) b") %>%
  html_text()

paradoxList


