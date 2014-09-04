#Week 1 Homework Assignment

#This week’s assignment questions are designed to ensure you have your environment properly running. The 
#answers to the following questions should be placed in a single R script. Label your answers using comments so 
#that they can be clearly and quickly found within the script.

####################################################################################

#1. What versions of R and RStudio do you have installed?

print(version)

#Version of R printout:

#platform       x86_64-w64-mingw32          
#arch           x86_64                      
#os             mingw32                     
#system         x86_64, mingw32             
#status                                     
#major          3                           
#minor          1.1                         
#year           2014                        
#3month          07                          
#day            10                          
#svn rev        66115                       
#language       R                           
#version.string R version 3.1.1 (2014-07-10)
#nickname       Sock it to Me 

#Version of R Studio:

#Version 0.98.1028

####################################################################################

#2. What version of PostgreSQL do you have installed?

#I just installed version 9.3.5

####################################################################################

#3. Install and load the R package DMwR. Load the data set sales and determine the number of observations 
#contained in the data set. (In RStudio, this is easy to determine.)

install.packages("DMwR")

library(DMwR)

d <- sales

#Once I load the library, and assign the sales dataset to the dataframe d, I can clearly see 
#in the environment on the upper right hand side that there are 401146 observations of 5 variables.
