db.towns.insert({
	name: "New York",
	population: 22200000,
	last_census: ISODate("2009-07-31"),
	famous_for: [ "statue of libery", "food" ],
	mayor: {
		name: "Michael Bloomberg",
		party: "I"
	}
})


function insertCity(
	name, population, last_census, 
	famous_for, mayor_info
) {
	db.towns.insert({
		name: name,
		popuation: population,
		last_census: ISODate(last_census),
		famous_for: famous_for,
		mayor: mayor_info
	})
}

insertCity("Punxsutawney", 6200, "2008-01-31", 
	["phil the groundhog"], {name: "Jim Wehrle" }
)

insertCity("Portland", 582000, "2007-09-20",
	["beer", "food"]. { name: "Sam Adams", party: "D"}
)

db.towns.find(
	{ name: /^P/, population : { $lt : 10000 } },
	{ name: 1, population : 1 }
)