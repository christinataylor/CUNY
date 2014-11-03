// Charley Ferrari
// Week 10 : Assignment

// Using the map reduce pipeline, 
// determine total population by state

var amap = function(){
	emit(this.state, this.pop)
}

var areduce = function(keyState, valuesPop) {
	return Array.sum(valuesPop);
}

db.zips.mapReduce(amap, areduce, { out : "zipreduced" })

// and an aggregate to test it out

db.zips.aggregate( 
{
	$group : {
		_id : {
			state : "$state"
		},
		sum : {
			$sum : "$pop"
		}
	}
}
)

// It matches! MapReduce accomplished.