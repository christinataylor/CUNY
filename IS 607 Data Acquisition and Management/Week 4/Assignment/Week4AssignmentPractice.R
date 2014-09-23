##### ddply #####

require(plyr)
head(baseball)

# OBP = (H + BB + HBP)/(AB + BB + HBP + SF)

# 

baseb <- baseball

baseb$sf[baseball$year < 1954] <- 0

any(is.na(baseb$sf))

baseb$hbp[is.na(baseb$hbp)] <- 0

any(is.na(baseb$hbp))

baseb <- baseb[baseb$ab >= 50,]

baseb$OBP <- with(baseb, (h + bb + hbp)/(ab + bb + hbp + sf))

tail(baseb)

obp <- function(data){
  c(OBP = with(data, sum(h + bb + hbp)/sum(ab + bb + hbp + sf)))
}

obp2 <- function(data){
  OBP = with(data, sum(h + bb + hbp)/sum(ab + bb + hbp + sf))
  return(OBP)
}

obp2(baseb2)


baseb2 <- baseb

baseb2 <- baseb[order(baseb$id),]

baseb2 <- baseb[baseb$id == "aaronha01",]

careerOBP <- ddply(baseb, .variables = "id", .fun = obp)

careerOBP2 <- ddply(baseb, .variables = "id", .fun = obp2)

identical(careerOBP, careerOBP2)

#by ID, apply the function obp

obp(baseb2)

careerOBP <- careerOBP[order(careerOBP$OBP, decreasing = T),]

head(baseb[baseb$id=="ansonca01",])
# ID has stats for each year.

head(careerOBP[careerOBP == "ansonca01",])

head(careerOBP)

##### llply #####

theList <- list(A = matrix(1:9,3), B = 1:5, C = matrix(1:4,2), D = 2)

lapply(theList, sum)

llply(theList, sum)

laply(theList)