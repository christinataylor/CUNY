#Charley Ferrari

##### Question 1 #####

##### Part a #####

queue <- c("James", "Mary", "Steve", "Alex", "Patricia")

##### Part b #####

queue <- c(queue, "Harold")

##### Part c #####

queue <- queue[queue != "James"]

##### Part d #####

queue <- append(queue, "Pam", after = 1)

##### Part e #####

queue <- queue[queue != "Harold"]

##### Part f #####

queue <- queue[queue != "Alex"]

##### Part g #####

Patricia.Position <- match("Patricia", queue)

##### Part h #####

Queue.Length <- length(queue)

##### Question 2 #####

quadraticSolve <- function(a, b, c){
  
  #This function takes 3 arguments: a, b, and c. It returns a string
  #explaining the nature of the solution. Either no solutions, one solution, or 
  #two solutions, naming the solutions if they exist.
  
  if(b^2 - 4*a*c < 0){
    return("This quadratic equation has no real solutions.")
  } else {
    
    x1 <- (-b + sqrt(b^2 - 4*a*c))/(2*a)
    x2 <- (-b - sqrt(b^2 - 4*a*c))/(2*a)
    
    if(x1 == x2){
      return(paste("This quadratic equation has one solution:", x1, sep=" "))
    } else {
      return(paste("This quadratic equation has two solutions:", x1, "and", x2, sep=" "))
    }
  }
  
  
}

##### Question 3 #####

count <- 0
vec <- c()

for(n in 1:1000){
  if(n%%7 != 0 & n%%3 != 0 & n%%11 != 0){
    count <- count + 1
    vec <- c(vec, n)
  }
}

##### Question 4 #####

pythag <- function(f,g,h){
  
  #This function takes in three numbers: f, g, and h.
  #It returns TRUE if the numbers form a pythagorean triple, and FALSE if they don't.
  
  if(f^2+g^2==h^2 | f^2+h^2==g^2 | g^2+h^2==f^2){
    return(TRUE)
  } else {
    return(FALSE)
  }
  
}
