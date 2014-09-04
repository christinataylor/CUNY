#Week 2 Quiz

#The answers to the following [21] questions should be placed in a single R script. 
#Place your R script in a public repository on github and submitting a link to the script here. 
#Label your answers using comments so that they can be clearly and quickly found within the script.
#Week 2 quiz is due end of day on Friday September 5th. Solutions to all quiz exercises will 
#be posted on Saturday September 6th. Your grade will be based on two randomly selected exercises.


#1. Create a vector that contains 20 numbers. (You may choose whatever numbers you 
#like, but make sure there are some duplicates.)

vec <- c(2, 4, 6, 8, 4, 6, 8, 3, 5, 8, 3, 6, 7, 3, 6, 8, 3, 5, 6, 8)

#2. Use R to convert the vector from question 1 into a character vector.

vec <- as.character(vec)

#3. Use R to convert the vector from question 1 into a vector of factors.

vec <- c(2, 4, 6, 8, 4, 6, 8, 3, 5, 8, 3, 6, 7, 3, 6, 8, 3, 5, 6, 8)
vec <- as.factor(vec)

#4. Use R to show how many levels the vector in the previous question has.

levels(vec)

#[1] "2" "3" "4" "5" "6" "7" "8"

length(levels(vec))

#[1] 7
#This displays the number of levels in this vector

#5. Use R to create a vector that takes the vector from question 1 and performs on it the 
#formula 3x^2 - 4x + 1

vec <- c(2, 4, 6, 8, 4, 6, 8, 3, 5, 8, 3, 6, 7, 3, 6, 8, 3, 5, 6, 8)
question5.vec <- vec^2 - 4*vec + 1

#6. Implement ordinary least-squares regression in matrix form:
#B = (X^T X)X^T y

X <- matrix(c(1,1,1,1,1,1,1,1,
              5,4,6,2,3,2,7,8,
              8,9,4,7,4,9,6,4), nrow=8, ncol=3)
Y <- matrix(c(45.2, 46.9, 31, 35.3, 25, 43.1, 41, 35.1), nrow=8, ncol=1)

b <- solve(t(X)%*%X) %*% t(X) %*% Y


#7. Create a named list. That is, create a list with several elements that are 
#each able to be referenced by name.

question7.list <- list(arthur=c(1, 2, 3), barry=c(4, 5, 6), carmine=c(7, 8, 9))

#8. Create a data frame with four columns - one each character, factor (with three levels), 
#numeric, and date.  Your data frame should have at least 10 observations (rows).

options(stringsAsFactors=FALSE)

Name <- c("Gwen Stefani", "Simon Cowell", "Tony Shalhoub", "Matt Bomer",
                    "Margaret Thatcher", "Snoop Dogg", "Christopher Lloyd", "Drake",
                    "Hilary Clinton", "John Cleese")
Fame.Claim <- as.factor(c("Singer", "Actor", "Actor", "Actor", "Politician", 
                                    "Singer", "Actor", "Singer", "Politician", "Actor"))
Age <- c(44, 54, 60, 36, 87, 42, 75, 27, 66, 74)
Birthday <- c("10-3-1969", "10-7-1959", "10-9-1953", "10-11-1977", "10-13-1925", 
                        "10-20-1971", "10-22-1938", "10-24-1986", "10-26-1947", "10-27-1939")
Birthday <- strptime(Birthday, format = "%m-%d-%Y", tz="")

df <- data.frame(Name, Fame.Claim, Age, Birthday)

#9. Illustrate how to add a row with a value for the factor column 
#that isn't already in the list of levels. (Note:You do not need to accomplish 
#this with a single line of code.)

levels(df$Fame.Claim) <- c(levels(df$Fame.Claim), "The Doctor")

df$Birthday <- as.character(df$Birthday)

df <- rbind(df, c("Matt Smith", "The Doctor", 31, "10/28/1982"))

df$Birthday <- strptime(df$Birthday, format = "%m-%d-%Y", tz="")

#10. Show the code that would read in a CSV file called temperatures.csv from the current working
#directory

workingDirectory <- "C:/Users/Charley/Downloads/Courses/CUNY/SPS/IS 607 Data Acquisition and Management/Week 2"
setwd(workingDirectory)

temperatures <- read.csv("temperatures.csv", header=TRUE)

#11. Show the code that would read in a TSV file called measurements.txt from a directory 
#other than the working directory on your local machine.

measurements <- read.table(file = "C:/Users/Charley/Desktop/measurements.txt", 
                     sep = "\t", header=TRUE)

#12. Show the code that will read in a delimited file with a pipe separator (the "|" symbol) 
#from a website location. (You may make up an appropriate URL.)

webfile <- read.table("http://fakewebsite.com/webfile.dat", sep = "|", header=TRUE)

#13. Write a loop that calculates 12-factorial

count <- 1
for(n in 1:12){
  count <- count*n
}

#14. Use a loop to calculate the final balance, rounded to the nearest cent, in 
#an account that earns 3.24% interest compounded monthly after six years if the 
#original balance is $1,500.

#Assuming the inerest rate is monthly
count <- 1500
for(n in 1:72){
  count <- count*(1.0324)
}

count <- round(count, 2)

#Assuming the interest rate is annual, but compounding is monthly 
count <- 1500
r <- 1 + (0.0324/12)
for(n in 1:72){
  count <- count*r
}

count <- round(count, 2)

#15. Create a numeric vector of length 20 and then write code to calculate the 
#sum of every third element of the vector you have created.

vec <- c(2, 4, 6, 8, 4, 6, 8, 3, 5, 8, 3, 6, 7, 3, 6, 8, 3, 5, 6, 8)

sumtest <- 6 + 6 + 5 + 6 + 6 + 5

sum <- 0
for(n in 1:(length(vec)%/%3)){
  sum <- sum + as.numeric(vec[n*3])
}

#16. Use a for loop to calculate sum from i= 1 to 10 of x^i for x = 2

sum <- 0
x <- 2
for(i in 1:10){
  sum <- sum + x^i
}

#17. Use a while loop to accomplish the same task as in the previous exercise.

sum <- 0
x <- 2
i <- 1
while(i <= 10){
  sum <- sum + x^i
  i <- i + 1
}

#18. Solve the problem from the previous two exercises without using a loop.

x <- 2
i <- 10

sum <- 2*(2^i-1)

#19. Show how to create a numeric vector that contains the sequence from 
#20 to 50 by 5.

vec <- seq(from=20, to=50, by=5)

#20. Show how to create a character vector of length 10 with the same word, 
#"example", ten times.

vec <- rep("example", each=10)

#normally I would add a column to an existing dataframe, for example:

df <- data.frame(c(1,2,3), c(4,5,6))
colnames(df) <- c("x", "y")
df$z <- "example"

#21. Show how to take a trio of input numbers a, b, and c and implement the quadratic equation.

a <- 1
b <- 8
c <- 12

x1 <- (-b + sqrt(b^2 - 4*a*c))/(2*a)
x2 <- (-b - sqrt(b^2 - 4*a*c))/(2*a)

