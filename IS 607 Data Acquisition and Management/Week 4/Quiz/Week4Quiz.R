# Week 4 Quiz
# Charley Ferrari

library(ggplot2)
library(ggthemes)

workingDirectory <- "C:/Users/Charley/Downloads/Courses/CUNY/SPS/git/IS 607 Data Acquisition and Management/Week 4/quiz"
setwd(workingDirectory)

m <- read.table("movies.tab", sep="\t", header=TRUE, quote="", comment="")

##### Question 1 #####


# Trying to ween myself off of for loops!
# 
#####################
#decade <- numeric()
#for(year in m$year){
#  year <- year - as.numeric(substr(as.character(year),4,4))
#  decade <- c(decade, year)
#}
#
#m$decade <- decade
####################

decadeMaker <- function(year){
  return(year - as.numeric(substr(as.character(year),4,4)))
}

m$decade <- sapply(m$year, decadeMaker)

ggplot(m, aes(x=decade)) + 
  geom_bar(stat="bin") + 
  scale_x_continuous(breaks=seq(from=1890, to=2000, by=10)) + 
  theme_economist()


# stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
# Warning message:
# position_stack requires constant width: output may be incorrect 

### for some reason I got this error only after I started using the bins below...

### Hmm, looks like if you run stat_bin2d() it changes the stat argument in 
### your geom into "bin." You have to set that back to Identity.

##### Question 2 #####

# Averages per genre over time (for all movies):

options(stringsAsFactors=FALSE)
genreAverages <- data.frame(genre = character(), average.rating = numeric())

for(genre in c("Action", "Animation", "Comedy", "Drama", "Documentary", 
               "Romance", "Short")){
  genreAverages[nrow(genreAverages)+1,] <- c(genre, mean(m[m[,genre] == 1,"rating"]))
  
}

#genreVec <- c("Action", "Animation", "Comedy", "Drama", "Documentary", 
#              "Romance", "Short")

#genreAverager <- function(genre){
#  return(c(genre, mean(m[m[,genre] == 1,"rating"])))
#}

#genreAverages <- tapply(genreVec, genreAverager)

ggplot(genreAverages, aes(x=genre, y=average.rating)) + 
  geom_bar(stat="identity") + 
  theme_economist()


# Second part of thee question: How has this changed over time?

# The structure of this data makes it difficult to work with.
# I can't just add genre as a variable, since some movies belong to
# Multiple genres. I can't color by or facet by this quality simply.
# So, I'll create a few different graphs as output using a loop

# First a scatter plot containing all movies of year vs rating:

ggplot(m, aes(x=year, y=rating)) + 
  geom_point() + 
  stat_smooth(method=lm)

# Too many datapoints... Lets try binning the data into rectangles.

ggplot(m, aes(x=year, y=rating)) + 
  #geom_point() + 
  stat_bin2d() + 
  scale_fill_gradient(low="orange", high="yellow") + 
  stat_smooth(method=lm) + 
  theme_tufte()

# Looks like a weak negative correlation

summary(lm(year ~ rating, data=m))

# Call:
#   lm(formula = year ~ rating, data = m)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -84.226 -18.421   6.152  20.899  33.103 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 1982.46882    0.38563 5140.90   <2e-16 ***
#   rating        -1.06782    0.06288  -16.98   <2e-16 ***
#   ---
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
# 
# Residual standard error: 23.68 on 58786 degrees of freedom
# Multiple R-squared:  0.004882,  Adjusted R-squared:  0.004865 
# F-statistic: 288.4 on 1 and 58786 DF,  p-value: < 2.2e-16

##################################################

# Now to look at each genre individually
# Because I have multipe graphs, I'll output to PDF

lmlist <- list()

#PDFPath <- "genre graphs.pdf"
#pdf(file=PDFPath)

for(genre in c("Action", "Animation", "Comedy", "Drama", "Documentary", 
               "Romance", "Short")){
  genreDF <- m[m[,genre] == 1,]
  
  print(ggplot(genreDF, aes(x=year, y=rating)) + 
    #geom_point() + 
    stat_bin2d() + 
    scale_fill_gradient(low="orange", high="yellow") + 
    stat_smooth(method=lm) + 
    ggtitle(genre) +
    theme_tufte())
  
  lmlist[[length(lmlist)+1]] <- summary(lm(year ~ rating, data=genreDF))
  names(lmlist)[length(lmlist)] <- genre
}  

#dev.off()

lmlist

# From the graphs, it looks like documentaries and shorts are getting better
# over time, but everything else is getting worse.

# $Action
# 
# Pearson's product-moment correlation
# 
# data:  genreDF$year and genreDF$rating
# t = -11.627, df = 4686, p-value < 2.2e-16
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
# -0.1951435 -0.1394938
# sample estimates:
# cor 
# -0.1674521 
# 
# 
# $Animation
# 
# Pearson's product-moment correlation
# 
# data:  genreDF$year and genreDF$rating
# t = -1.3851, df = 3688, p-value = 0.1661
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#   -0.055029023  0.009471776
# sample estimates:
#   cor 
# -0.02280235 
# 
# 
# $Comedy
# 
# Pearson's product-moment correlation
# 
# data:  genreDF$year and genreDF$rating
# t = -21.036, df = 17269, p-value < 2.2e-16
# alternative hypothesis: true correlation is not equal to 0
# # 95 percent confidence interval:
# -0.1725722 -0.1434892
# sample estimates:
# cor 
# -0.1580649 
# 
# 
# $Drama
# 
# Pearson's product-moment correlation
# 
# data:  genreDF$year and genreDF$rating
# t = -6.8286, df = 21809, p-value = 8.798e-12
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#   -0.05942535 -0.03293929
# sample estimates:
#   cor 
# -0.04619044 
# 
# 
# $Documentary
# 
# Pearson's product-moment correlation
# 
# data:  genreDF$year and genreDF$rating
# t = 12.781, df = 3470, p-value < 2.2e-16
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
# 0.1800423 0.2435840
# sample estimates:
# cor 
# 0.2120372 
# 
# 
# $Romance
# 
# Pearson's product-moment correlation
# 
# data:  genreDF$year and genreDF$rating
# t = -8.9935, df = 4742, p-value < 2.2e-16
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
#   -0.1573788 -0.1014176
# sample estimates:
#   cor 
# -0.1295013 
# 
# 
# $Short
# 
# Pearson's product-moment correlation
# 
# data:  genreDF$year and genreDF$rating
# t = 12.9668, df = 9456, p-value < 2.2e-16
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
# 0.1123215 0.1519253
# sample estimates:
# cor 
# 0.1321761 


##### Question 3 #####

ggplot(m, aes(x=length, y=rating)) +
  geom_point()

# outliers...

ggplot(m, aes(x=length, y=rating)) +
  geom_point() +
  xlim(0,mean(m$length) + 2*sd(m$length))

# I checked and I got roughly 98.6% of the ratings with this, but would this work with a
# lower bound like this?

ggplot(m, aes(x=length, y=rating)) + 
  #geom_point() + 
  stat_bin2d() + 
  scale_fill_gradient(low="orange", high="yellow") + 
  stat_smooth(method=lm) + 
  xlim(0,mean(m$length) + 2*sd(m$length)) +
  theme_tufte()

# Once again looks like a weak negative correlation

cor.test(m$length, m$rating)

# Pearson's product-moment correlation

# data:  m$length and m$rating
# t = -7.4553, df = 58786, p-value = 9.087e-14
# alternative hypothesis: true correlation is not equal to 0
# 95 percent confidence interval:
# -0.03880838 -0.02265643
# sample estimates:
# cor 
# -0.03073441 

##### Question 4 #####

#ggplot(m, aes(x=genre, y=length))

#summary(lm(length ~ Action + Comedy + Drama + Documentary + Romance + 
#             Short, data=m))

# pairs(m)
# Use pairs once you get the genres sorted out.
