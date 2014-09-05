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