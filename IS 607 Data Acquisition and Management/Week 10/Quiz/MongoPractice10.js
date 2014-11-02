db.countries.insert({
	_id : "us",
	name : "United States",
	exports : {
		foods : [
		{ name : "bacon", tasty : true },
		{ name : "burgers" }
		]
	}
})

db.countries.insert({
	_id : "ca",
	name : "Canada",
	exports : {
		foods : [
		{ name : "bacon", tasty : false },
		{ name : "syrup", tasty : true }
		]
	}
})

db.countries.insert({
	_id : "mx",
	name : "Mexico",
	exports : {
		foods : [
		{ name : "salsa", tasty : false, condiment : true }
		]
	}
})

db.countries.find(
	{ 'exports.foods.name' : 'bacon', 'exports.foods.tasty' : true },
	{ name : 1 }
	)

db.countries.find(
{
	'exports.foods' : {
		$elemMatch : {
			name : 'bacon',
			tasty : true
		}
	}
},
{ _id : 0, name : 1 }
)

////////////////////////////////////////////////////////////////////////////////////////

