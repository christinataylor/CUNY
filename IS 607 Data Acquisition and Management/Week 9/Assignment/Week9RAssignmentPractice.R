library(rmongodb)
library(jsonlite)

mongo <- mongo.create(db = "unitedstates")

mongo.get.databases(mongo)

mongo.get.database.collections(mongo, "unitedstates")

coll <- "unitedstates.geos"

mongo.count(mongo, coll)

colorado <- mongo.find.one(mongo, coll)

coloradolist <- mongo.bson.to.list(colorado)

coloradolist

?mongo.find

coloradofind <- mongo.find.one(mongo, coll, "{\"state\":\"Colorado\"}")

coloradofind <- mongo.find.all(mongo, coll, "{\"state\":\"Colorado\"}")

mongo.bson.to.list(coloradofind)

?mongo.bson.buffer

buf <- mongo.bson.buffer.create()
mongo.bson.buffer.append(buf, "state", "Colorado")

query <- mongo.bson.from.buffer(buf)

query

mongo.bson.from.JSON("{\"state\":\"Colorado\"}")

pops <- mongo.find.all(mongo, coll, "{\"population\":{\"$gte\":10000000}}")

popstest <- mongo.bson.to.list(pops)

length(pops)

popslist <- list()

for(item in 1:length(pops)){
  popslist <- c(popslist, item)
}

popone <- mongo.find.one(mongo, coll, "{\"population\":{\"$gte\":1000000}}")

head(pops)

listtest <- list(state=c(1,2,3), terr=c(4,5,6))

dim(pops)[1]

pops[[1, 2]]

length(pops)

pops[[1, "state"]]

pops[[1,"state"]] # THIS ONE IS GOING TO BE KEY

typeof(pops[1])


length(pops)

# Attach library(jsonlite)

json <- "{\"population\":{\"$gte\":1000000}}"

cat(prettify(json))

validate(json)

head(pops)

