# week6quiz.R
# [For your convenience], here is the provided code from Jared Lander's R for Everyone, 
# 6.7 Extract Data from Web Sites

require(XML)

theURL <- "http://www.jaredlander.com/2012/02/another-kind-of-super-bowl-pool/"
bowlPool <- readHTMLTable(theURL, which = 1, header = FALSE, stringsAsFactors = FALSE)
bowlPool

bowlpool <- readHTMLTable(theURL)

##### Question 1 #####
# What type of data structure is bowlpool?

# Bowlpool is a dataframe.

# 2. Suppose instead you call readHTMLTable() with just the URL argument,
# against the provided URL, as shown below
theURL <- "http://www.w3schools.com/html/html_tables.asp"
hvalues <- readHTMLTable(theURL)
# What is the type of variable returned in hvalues?

# hvalues returns a list of datatables, and some null objects. 

# Doing a quick view source on the webpage, it seems it picks up whenever 
# the <table> html tag is used. If there isn't a relevant data table (and instead
# is just some sort of formatting) it will return a null object

# 3. Write R code that shows how many HTML tables are represented in hvalues

count <- 0
for(tabl in hvalues){
  if(!is.null(tabl)){
    count <- count + 1
  }
}

# 4. Modify the readHTMLTable code so that just the table with Number, 
# FirstName, LastName, # and Points is returned into a dataframe

dataframe.4 <- readHTMLTable(theURL, which = 1)

# 5. Modify the returned data frame so only the Last Name and Points columns are shown.

colnames(dataframe.4) <- c("Number", "First.Name", "Last.Name", "Points")
# hmmm... I couldn't find a way for select to work when colnames had spaces

dataframe.5 <- dataframe.4 %>% select(Last.Name, Points)

# 6 Identify another interesting page on the web with HTML table values. 
# This may be somewhat tricky, because while
# HTML tables are great for web-page scrapers, many HTML designers now prefer 
# creating tables using other methods (such as <div> tags or .png files). 
# 7 How many HTML tables does that page contain?

theURL <- "http://en.wikipedia.org/wiki/List_of_freshwater_islands_in_Scotland"
wvalues.6 <- readHTMLTable(theURL)

wvaluetable <- wvalues.6[[1]]

#Now to format the tables:

minus1 <- function(str){
  return(substr(str, nchar(str), nchar(str)))
}

minus3 <- function(str){
  return(substr(str, 1, nchar(str)-4))
}

colnames(wvaluetable) <- c("Island", "Location", "Area", "Population")

wvaluetable$Area <- as.character(wvaluetable$Area)

wvaluetable$Area[minus1(wvaluetable$Area) == "]"] <- 
  minus3(wvaluetable$Area[minus1(wvaluetable$Area) == "]"])

wvaluetable$Area <- as.numeric(wvaluetable$Area)

wvaluetable$Population <- as.numeric(as.character(wvaluetable$Population))

# 8 Identify your web browser, and describe (in one or two sentences) 
# how you view HTML page source in your web browser.

# I use Google Chrome. In order to view page source, I just right click
# and select "view page source"