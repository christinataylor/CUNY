// Query : similar to the match stage
// Map : you "emit" key value pair
// 				key is the course number and the value is the enrollment
// reduce : perform the aggregation :  combine them back together
//                 emit a bunch of course enrollment pairs, then reduce combines them together
// finalize : average?


var map1 = function () { emit(this.Department, this.Enrollment); } /* emit key value pair for each document, 
for each class, which department, enrollment */

var reduce1 = function(keyDepartment, valuesEnrollment) { return Array.sum(valuesEnrollment); } // what is an Array.sum?

//average enrollment per course

var map2 = function(){
	var value = {
		count : 1,
		enrollment : this.Enrollment
	};
	emit(this.Department, value)
}

var reduce2 = function(keyDepartment, valuesCombo) { 
	reducedVal = { count : 0, enrollment : 0};
	for (var idx = 0; idx < valuesCombo.length; idx++) {
		reducedVal.count += valuesCombo[idx].count;
		reducedVal.enrollment += valuesCombo[idx].enrollment;
	}
	return reducedVal
}

// We need a third function, because we want the average. We have a course count and enrollment.

var finalize2 = function(key, reducedVal) {
	reducedVal.deptavg = reducedVal.enrollment/reducedVal.count;
	return reducedVal;
}

db.enrollment.mapReduce(map2, reduce2, { out : "mapreduced2", finalize : finalize2 })

///////////////////////////////////////////////////////////////////////////////////////

// What's the average by course

var map3 = function() {
	var value = {
		count : 1,
		enrollment : this.Enrollment
	};
	emit(this.Course, value)
}

var reduce3 = function(keyCourse, valuesCombo) {
	reducedVal = { count : 0, enrollment : 0 };
	for (var idx = 0; idx < valuesCombo.length; idx++) {
		reducedVal.count += valuesCombo[idx].count;
		reducedVal.enrollment += valuesCombo[idx].enrollment;
	}
	return reducedVal;
}

var finalize3 = function(key, reducedVal) {
	reducedVal.avg = reducedVal.enrollment/reducedVal.count;
	return reducedVal;
}

db.enrollment.mapReduce( map3, reduce3, {out : "mapreduced3", finalize : finalize3 } )