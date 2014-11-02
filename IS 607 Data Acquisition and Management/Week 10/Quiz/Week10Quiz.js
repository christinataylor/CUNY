//mongoimport --db zips --type json --file "C:\Users\Charley\Downloads\Courses\CUNY\SPS\Git\IS 607 Data Acquisition and Management\Week 10\Quiz\zips.json"



// Question 1 : Which states have populations less than 8 million.

db.zips.aggregate( [ 

{
	$match : {
		pop : {
			$lte : 8000000
		}
	}
},

{
	$group : {
		_id : "$state",
		total : {
			$sum : "$pop"
		}
	}
}

])

// Question 2 : What is the fifth largest city in New York 

db.zips.aggregate( [ 

{
	$match : {
		state : "NY"
	}
},

{
	$group : {
		_id : {
			city : "$city"
		}, 
		pop : {
			$sum : "$pop"
		}
	}
}, 

{
	$sort : {
		pop : -1
	}
}

]).toArray()[4]

// The .toArray makes the aggregate an array, and [4] returns the 5th value.
// Staten Island is the fifth largest city in New York
// To be technical... New York City is politically a city, the post office has a weird way of defining cities 
// (Queens neighborhoods are considered cities for example, so are the other four boroughs.)
// So the fifth biggest city is Yonkers. The more you know (my father worked for the post office.)

// Question 3 : What is the total number of cities in each state according to this dataset?

db.zips.aggregate( [

{
	$group : {
		_id : {
			city : "$city",
			state : "$state"
		},  
		count : {
			$sum : 1
		}
	}
},

{
	$group : {
		_id : {
			state : "$_id.state"
		},
		ncities : {
			$sum : "$count"
		}
	}
}

])


// Challenge Questions
// Region set


db.zips.update( 
{
	$or : [
		{ state : "CT" },
		{ state : "ME" },
		{ state : "MA" },
		{ state : "NH" },
		{ state : "RI" },
		{ state : "VT" }
		]
}, 

{
	$set : {
		region : "Northeast",
		division : 1
	}
},

{
	multi : true
}

)

db.zips.update( 
{
	$or : [
		{ state : "NY" },
		{ state : "NJ" },
		{ state : "PA" }
		]
}, 

{
	$set : {
		region : "Northeast",
		division : 2
	}
},

{
	multi : true
}

)

db.zips.update( 
{
	$or : [
		{ state : "IL" },
		{ state : "IN" },
		{ state : "MI" },
		{ state : "OH" },
		{ state : "WI" }
		]
}, 

{
	$set : {
		region : "Midwest",
		division : 3
	}
},

{
	multi : true
}

)

db.zips.update( 
{
	$or : [
		{ state : "IA" },
		{ state : "KS" },
		{ state : "MN" },
		{ state : "MO" },
		{ state : "NE" },
		{ state : "ND" },
		{ state : "SD" }
		]
}, 

{
	$set : {
		region : "Midwest",
		division : 4
	}
},

{
	multi : true
}

)

db.zips.update( 
{
	$or : [
		{ state : "DE" },
		{ state : "FL" },
		{ state : "GA" },
		{ state : "MD" },
		{ state : "NC" },
		{ state : "SC" },
		{ state : "VA" },
		{ state : "DC" }, 
		{ state : "WV" }
		]
}, 

{
	$set : {
		region : "South",
		division : 5
	}
},

{
	multi : true
}

)

db.zips.update( 
{
	$or : [
		{ state : "AL" },
		{ state : "KY" },
		{ state : "MS" },
		{ state : "TN" }
		]
}, 

{
	$set : {
		region : "South",
		division : 6
	}
},

{
	multi : true
}

)

db.zips.update( 
{
	$or : [
		{ state : "AK" },
		{ state : "LA" },
		{ state : "OK" },
		{ state : "TX" }
		]
}, 

{
	$set : {
		region : "South",
		division : 7
	}
},

{
	multi : true
}

)

db.zips.update( 
{
	$or : [
		{ state : "AZ" },
		{ state : "CO" },
		{ state : "ID" },
		{ state : "MT" },
		{ state : "NV" }, 
		{ state : "NM" },
		{ state : "UT" },
		{ state : "WY" }
		]
}, 

{
	$set : {
		region : "West",
		division : 8
	}
},

{
	multi : true
}

)

db.zips.update( 
{
	$or : [
		{ state : "AR" },
		{ state : "LA" },
		{ state : "OK" },
		{ state : "TX" }
		]
}, 

{
	$set : {
		region : "South",
		division : 7
	}
},

{
	multi : true
}

)

db.zips.update( 
{
	$or : [
		{ state : "AZ" },
		{ state : "CO" },
		{ state : "ID" },
		{ state : "MT" },
		{ state : "NV" },
		{ state : "NM" },
		{ state : "UT" },
		{ state : "WY" }
		]
}, 

{
	$set : {
		region : "West",
		division : 8
	}
},

{
	multi : true
}

)

db.zips.update( 
{
	$or : [
		{ state : "AK" },
		{ state : "CA" },
		{ state : "HI" },
		{ state : "OR" },
		{ state : "WA" }
		]
}, 

{
	$set : {
		region : "West",
		division : 9
	}
},

{
	multi : true
}

)

// Check that everything has updated:

db.zips.count( {
	region : {
		$exists : false
	}
})

// Question 1 : What's the average city population by region

db.zips.aggregate( [ 

{
	$group : {
		_id : {
			region : "$region"
		}, 
		avgpop : {
			$avg : "$pop"
		}
	}
}
]
)

// Question 2 : Which region has the most people? The fewest?

l = db.zips.aggregate( [

{
	$group : {
		_id : {
			region : "$region"
		},
		sumpop : {
			$sum : "$pop"
		}
	}
},

{
	$sort : {
		sumpop : -1
	}
}

]).toArray().length

// Region with the most people

db.zips.aggregate( [

{
	$group : {
		_id : {
			region : "$region"
		},
		sumpop : {
			$sum : "$pop"
		}
	}
},

{
	$sort : {
		sumpop : -1
	}
}

]).toArray()[0]

// Region with the fewest people

db.zips.aggregate( [

{
	$group : {
		_id : {
			region : "$region"
		},
		sumpop : {
			$sum : "$pop"
		}
	}
},

{
	$sort : {
		sumpop : -1
	}
}

]).toArray()[l-1]

// Question 3 : What is the total population of each district
// Assuming District = division

db.zips.aggregate( [
{
	$group : {
		_id : {
			division : "$division"
		},
		sumdpopiv : {
			$sum : "$pop"
		}
	}
}

]

)