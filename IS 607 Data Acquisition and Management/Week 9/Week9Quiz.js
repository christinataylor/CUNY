// Question 1

use employment


// Question 2

db.employees.insert({
	name: "Wendy Yasquez",
	title: "Assistant Professor",
	salary: 86000,
	department: ["Computer Science"],
	hire_year: 1998
})

// Question 3

function insertProf(
	name, title, salary, department, hire_year
) {
	db.employees.insert({
		name: name,
		title: title,
		salary: salary,
		department: department,
		hire_year: hire_year
	});
}

// Question 4

insertProf(
	"Raoul Dewan", "Assistant Professor", 78000, ["Physics", "Biology"], 2009)

insertProf(
	"Isabelle Winters", "Associate Professor", 92000, ["Physics"], 1995)

insertProf(
	"Jack McDunn", "Associate Professor", 101000, ["Physics"], 1993)

// Question 5

function insertAdmin(
	locationbool, name, title, salary, division, location, hire_year, location
) {
	if(locationbool){
		db.employees.insert({
			name: name,
			title: title,
			salary: salary,
			division: division,
			location: location,
			hire_year: hire_year
		});
	} else {
		db.employees.insert({
			name: name,
			title: title,
			salary: salary,
			division: division,
			hire_year: hire_year
		});
	};
}

// I tried playing around with the length of arguments, but the only way I could
// see to do this was to include a bool argument to determine how to insert

// Question 6

insertAdmin(
	false, "Tonja Baldner", "Assistant to the Deal", 42000, "Arts and Sciences", 2001)

insertAdmin(
	true, "Dennis Bohnet", "Vice President", 106500, "Academic Affairs", "Main Campus", 1997)

// Question 7

db.employees.find({ salary : { $lt: 90000 }})

// Question 8

db.employees.find({ salary: {$lt: 90000}, title: {$regex: ".Professor"}})

// Question 9

db.employees.find({ department: "Physics", hire_year: { $lt: 2001}})

// Question 10 

db.employees.find({ $or : [ { department : { $ne: "Physics"} }, { department : { $size: {$gt: 1} } } ], title : {$regex: ".Professor"} })

// Question 11

db.employees.find({ $or : [ { hire_year: {$lt: 1997}}, { salary: {$gt: 100000} } ] })

// Question 12

db.employees.update({ name: "Tonja Baldner" }, { $set : { "salary" : 46200 }})

// Question 13

db.employees.remove({ name: "Raoul Dewan" })

// Question 14

db.pastemployees.save( db.employees.find({ name: "Raoul Dewan" }).toArray() )
db.pastemployees.update( { name: "Raoul Dewan" }, { $set : { "depart_year" : 2014 } } )
db.employees.remove({ name: "Raoul Dewan" })