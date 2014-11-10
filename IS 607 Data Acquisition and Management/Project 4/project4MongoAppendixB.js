mongoimport --db majors --type csv --headerline --file "C:\Users\Charley\Downloads\Courses\CUNY\SPS\Git\IS 607 Data Acquisition and Management\Project 4\allages.csv" --collection "majors"
mongoimport --db majors --type csv --headerline --file "C:\Users\Charley\Downloads\Courses\CUNY\SPS\Git\IS 607 Data Acquisition and Management\Project 4\gradstudents.csv" --collection "majors"
mongoimport --db majors --type csv --headerline --file "C:\Users\Charley\Downloads\Courses\CUNY\SPS\Git\IS 607 Data Acquisition and Management\Project 4\recentgrads.csv" --collection "majors"

majorsrawlist = db.majors.find(
{
	Student_type : "All ages"
},
{
	Major_code : 1,
	"_id" : 0
}).toArray()

majorslist = []
for(var i=0; i<majorsrawlist.length; i++){
	majorslist.push(majorsrawlist[i]["Major_code"])
}


majorslist.forEach(
	function(value)
	{
		db.majorsorganized.save(
			db.majors.find(
			{
				Major_code : value,
				Student_type : "Recent grads"
			},
			{
				Major_code : 1,
				Major : 1,
				Major_category : 1
			}).toArray()
		);

		allageslist = db.majors.find(
		{
			Major_code : value,
			Student_type : "All ages"
		},
		{
			Major_code : 0,
			Major : 0,
			Major_category : 0,
			Student_type : 0
		}).toArray();

		recentgradslist = db.majors.find(
		{
			Major_code : value,
			Student_type : "Recent grads"
		},
		{
			Major_code : 0,
			Major : 0,
			Major_category : 0,
			Student_type : 0
		}).toArray();

		gradstudentslist = db.majors.find(
		{
			Major_code : value,
			Student_type : "Grad students"
		},
		{
			Major_code : 0,
			Major : 0,
			Major_category : 0,
			Student_type : 0
		}).toArray();

		db.majorsorganized.update(
		{
			Major_code : value
		},
		{
			$set : {
				"All ages" : allageslist[0]
			}
		});

		db.majorsorganized.update(
		{
			Major_code : value
		},
		{
			$set : {
				"Grad students" : gradstudentslist[0]
			}
		});

		db.majorsorganized.update(
		{
			Major_code : value
		},
		{
			$set : {
				"Recent grads" : recentgradslist[0]
			}
		});

	}
)
