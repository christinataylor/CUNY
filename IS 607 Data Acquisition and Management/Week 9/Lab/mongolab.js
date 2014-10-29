// In Command Line

mongoimport --db mongolab --type csv --headerline --file 
"C:\Users\Charley\Downloads\Courses\CUNY\SPS\Git\IS 607 Data Acquisition and Management\Week 9\Lab\sampledata.csv"

db.sampledata.distinct("date")

db.sampledata.distinct("date").length

//Count distinct locations and shifts

db.sample.distinct("shift").length

// Do all locations have each shift

result = db.sample.aggregate( [ { "$group": { "_id": { shift: "$shift", location: "$location" } } } ] )


db.sampledata.aggregate([ { $group: { _id: "_id", total: { $sum: "$event" } } } ])

//8 what are the total number of events by shift

db.sampledata.aggregate([
	{ $match: {shift: "A"}},
	{ $group: {_id: "_id", total: { $sum: "$event"}}}
	])
//////////////////////////////


db.sampledata.aggregate([
	{ $match: {location: "Westnedge"}},
	{ $group: {_id: "_id", total: { $sum: "$event"}}}
	])

db.sampledata.aggregate([
	{ $match: {location: "Westnedge"}},
	{ $group: {_id: {shift: "$shift"}, total: { $sum: "$event"}}}
	])

// Question 10

db.sampledata.aggregate([
	{ $group: { _id: {shift: "$shift", location: "$location"}, average: {$avg: "$event"}}}])