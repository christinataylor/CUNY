library(rmongodb)
library(jsonlite)


mongo <- mongo.create(db = "unitedstates")

coll <- "unitedstates.geos"

statequery <- "{ \"state\" : {\"$exists\" : \"true\"}}"

districtquery <- "{ \"federal_district\" : {\"$exists\" : \"true\"}}"

terrquery <- "{ \"territory\" : {\"$exists\" : \"true\"}}"

###########################################################

# Get the first value to initialize the data frame

curs <- mongo.find(mongo, coll, statequery)
mongo.cursor.next(curs)

statedata <- data.frame(matrix(NA, nrow=0, 
                               ncol=length(names(mongo.bson.to.list(mongo.cursor.value(curs))))), 
                        stringsAsFactors = FALSE)

colnames(statedata) <- names(mongo.bson.to.list(mongo.cursor.value(curs)))
colnames(statedata) <- c("id", colnames(statedata)[2:length(colnames(statedata))])



mongolist <- mongo.bson.to.list(mongo.cursor.value(curs))

statedata <- rbind(statedata, mongolist)

###########################################################

# Then loop through the rest

for(i in 1:(mongo.count(mongo, coll, statequery)-1)){
  

mongo.cursor.next(curs)

statedataadd <- data.frame(matrix(NA, nrow=0, 
                                  ncol=length(names(mongo.bson.to.list(mongo.cursor.value(curs))))), 
                           stringsAsFactors = FALSE)

colnames(statedataadd) <- names(mongo.bson.to.list(mongo.cursor.value(curs)))
colnames(statedataadd) <- c("id", colnames(statedata)[2:length(colnames(statedata))])

mongolist <- mongo.bson.to.list(mongo.cursor.value(curs))

statedataadd <- rbind(statedataadd, mongolist)
statedata <- rbind(statedata, statedataadd)

i <- i + 1

}

rm(statedataadd)

###########################################################

# For district there's only one record

curs <- mongo.find(mongo, coll, districtquery)
mongo.cursor.next(curs)

districtdata <- data.frame(matrix(NA, nrow=0, 
                               ncol=length(names(mongo.bson.to.list(mongo.cursor.value(curs))))), 
                        stringsAsFactors = FALSE)

colnames(districtdata) <- names(mongo.bson.to.list(mongo.cursor.value(curs)))
colnames(districtdata) <- c("id", colnames(districtdata)[2:length(colnames(districtdata))])

mongolist <- mongo.bson.to.list(mongo.cursor.value(curs))

districtdata <- rbind(districtdata, mongolist)

###########################################################

# Initialize the territory query

curs <- mongo.find(mongo, coll, terrquery)
mongo.cursor.next(curs)

territorydata <- data.frame(matrix(NA, nrow=0, 
                                  ncol=length(names(mongo.bson.to.list(mongo.cursor.value(curs))))), 
                           stringsAsFactors = FALSE)

colnames(territorydata) <- names(mongo.bson.to.list(mongo.cursor.value(curs)))
colnames(territorydata) <- c("id", colnames(territorydata)[2:length(colnames(territorydata))])

mongolist <- mongo.bson.to.list(mongo.cursor.value(curs))

territorydata <- rbind(territorydata, mongolist)

###########################################################

# And then loop through it

for(i in 1:(mongo.count(mongo, coll, terrquery)-1)){
  
  
  mongo.cursor.next(curs)
  
  territorydataadd <- data.frame(matrix(NA, nrow=0, 
                                    ncol=length(names(mongo.bson.to.list(mongo.cursor.value(curs))))), 
                             stringsAsFactors = FALSE)
  
  colnames(territorydataadd) <- names(mongo.bson.to.list(mongo.cursor.value(curs)))
  colnames(territorydataadd) <- c("id", colnames(territorydata)[2:length(colnames(territorydata))])
  
  mongolist <- mongo.bson.to.list(mongo.cursor.value(curs))
  
  territorydataadd <- rbind(territorydataadd, mongolist)
  territorydata <- rbind(territorydata, territorydataadd)
  
  i <- i + 1
  
}

rm(territorydataadd)
