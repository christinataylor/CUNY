populatePhones = function(area, start, stop) {
	for(var i=start; i < stop; i++){
		var country = 1 + ((Math.random() * 8) << 0);
		var num = (country * 1e10) + (area * 1e7) + i;
		db.phones.insert({
			_id : num,
			components : {
				country : country,
				area : area,
				prefix : (i * 1e-4) << 0,
				number : i
			},
			display : "+" + country + " " + area + "-" + i
		});
	}
}

db.phones.find( { display : "+1 800-5650001" } ).explain()


db.phones.ensureIndex(
	{ display : 1 },
	{ unique : true, dropDups : true }
)

db.phones.ensureIndex(
	{ "components.area" : 1 },
	{ background : 1 }
)

populatePhones(855, 5550000, 5650000)

// Map Reduce?
// to replicate the count function?

db.phones.group(
{
	initial : { count : 0 },
	reduce : function(phone, output) { output.count++; },
	cond : { 'components.number' : { $gt : 5599999 } }
} )