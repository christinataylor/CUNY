#Week 2 Quiz
#Charley Ferrari

##### Question 1 #####

vec <- c(2, 4, 6, 8, 4, 6, 8, 3, 5, 8, 3, 6, 7, 3, 6, 8, 3, 5, 6, 8)

##### Question 2 #####

vec <- as.character(vec)

##### Question 3 #####

vec <- c(2, 4, 6, 8, 4, 6, 8, 3, 5, 8, 3, 6, 7, 3, 6, 8, 3, 5, 6, 8)
vec <- as.factor(vec)

##### Question 4 #####

levels(vec)

#[1] "2" "3" "4" "5" "6" "7" "8"

length(levels(vec))

#[1] 7
#This displays the number of levels in this vector

##### Question 5 #####

vec <- c(2, 4, 6, 8, 4, 6, 8, 3, 5, 8, 3, 6, 7, 3, 6, 8, 3, 5, 6, 8)
question5.vec <- vec^2 - 4*vec + 1

##### Question 6 #####

X <- matrix(c(1,1,1,1,1,1,1,1,
              5,4,6,2,3,2,7,8,
              8,9,4,7,4,9,6,4), nrow=8, ncol=3)
Y <- matrix(c(45.2, 46.9, 31, 35.3, 25, 43.1, 41, 35.1), nrow=8, ncol=1)

b <- solve(t(X)%*%X) %*% t(X) %*% Y


##### Question 7 #####

question7.list <- list(arthur=c(1, 2, 3), barry=c(4, 5, 6), carmine=c(7, 8, 9))

##### Question 8 #####

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

##### Question 9 #####

levels(df$Fame.Claim) <- c(levels(df$Fame.Claim), "The Doctor")

df$Birthday <- as.character(df$Birthday)

df <- rbind(df, c("Matt Smith", "The Doctor", 31, "10/28/1982"))

df$Birthday <- strptime(df$Birthday, format = "%m-%d-%Y", tz="")

##### Question 10 #####

workingDirectory <- "C:/Users/Charley/Downloads/Courses/CUNY/SPS/IS 607 Data Acquisition and Management/Week 2"
setwd(workingDirectory)

temperatures <- read.csv("temperatures.csv", header=TRUE)

##### Question 11 #####

measurements <- read.table(file = "C:/Users/Charley/Desktop/measurements.txt", 
                     sep = "\t", header=TRUE)

##### Question 12 #####

webfile <- read.table("http://fakewebsite.com/webfile.dat", sep = "|", header=TRUE)

##### Question 13 #####

count <- 1
for(n in 1:12){
  count <- count*n
}

##### Question 14 #####

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

##### Question 15 #####

vec <- c(2, 4, 6, 8, 4, 6, 8, 3, 5, 8, 3, 6, 7, 3, 6, 8, 3, 5, 6, 8)

sumtest <- 6 + 6 + 5 + 6 + 6 + 5

sum <- 0
for(n in 1:(length(vec)%/%3)){
  sum <- sum + as.numeric(vec[n*3])
}

##### Question 16 #####

sum <- 0
x <- 2
for(i in 1:10){
  sum <- sum + x^i
}

##### Question 17 #####

sum <- 0
x <- 2
i <- 1
while(i <= 10){
  sum <- sum + x^i
  i <- i + 1
}

##### Question 18 #####

x <- 2
i <- 10

sum <- 2*(2^i-1)

##### Question 19 #####

vec <- seq(from=20, to=50, by=5)

##### Question 20 #####

vec <- rep("example", each=10)

#normally I would add a column to an existing dataframe, for example:

df <- data.frame(c(1,2,3), c(4,5,6))
colnames(df) <- c("x", "y")
df$z <- "example"

##### Question 21 #####

a <- 1
b <- 8
c <- 12

x1 <- (-b + sqrt(b^2 - 4*a*c))/(2*a)
x2 <- (-b - sqrt(b^2 - 4*a*c))/(2*a)

