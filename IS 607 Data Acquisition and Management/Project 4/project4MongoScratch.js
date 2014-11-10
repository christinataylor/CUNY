
/*
db.majorsorganized.update(
		{
			Major_code : value
		},
		{
			$set : {
				"All ages" : {
					"Total" : allageslist[0].Total,
					"Employed" : allageslist[0].Employed,
					"Employed_full_time_year_round" : allageslist[0].Employed_full_time_year_round,
					"Unemployed" : allageslist[0].Unemployed,
					"Unemployment_rate" : allageslist[0].Unemployment_rate,
					"Median" : allageslist[0].Median,
					"P25th" : allageslist[0].P25th,
					"P75th" : allageslist[0].P75th
				}
			}
		});

		db.majorsorganized.update(
		{
			Major_code : value
		},
		{
			$set : {
				"Grad students" : {
					"Grad_total" : gradstudentslist[0].Grad_total,
					"Grad_sample_size" : gradstudentslist[0].Grad_sample_size,
					"Grad_employed" : gradstudentslist[0].Grad_employed,
					"Grad_full_time_year_round" : gradstudentslist[0].Grad_full_time_year_round,
					"Grad_unemployed" : gradstudentslist[0].Grad_unemployed,
					"Grad_unemployment_rate" : gradstudentslist[0].Grad_unemployment_rate,
					"Grad_median" : gradstudentslist[0].Grad_median,
					"Grad_P25" : gradstudentslist[0].Grad_P25,
					"Grad_P75" : gradstudentslist[0].Grad_P75,
					"Nongrad"





					"Total" : gradstudentslist[0].Total,
					"Employed" : gradstudentslist[0].Employed,
					"Employed_full_time_year_round" : gradstudentslist[0].Employed_full_time_year_round,
					"Unemployed" : gradstudentslist[0].Unemployed,
					"Unemployment_rate" : gradstudentslist[0].Unemployment_rate,
					"Median" : gradstudentslist[0].Median,
					"P25th" : gradstudentslist[0].P25th,
					"P75th" : gradstudentslist[0].P75th
				}
			}
		});

		db.majorsorganized.update(
		{
			Major_code : value
		},
		{
			$set : {
				"Recent grads" : {
					"Total" : recentgradslist[0].Total,
					"Sample_size" : recentgradslist[0].Sample_size,
					"Men" : recentgradslist[0].Men,
					"Women" : recentgradslist[0].Women,
					"ShareWomen" : recentgradslist[0].ShareWomen,
					"Employed" : recentgradslist[0].Employed,
					"Full_time" : recentgradslist[0].Full_time,
					"Part_time" : recentgradslist[0].Part_time,
					"Employed_full_time_year_round" : recentgradslist[0].Employed_full_time_year_round,
					"Unemployed" : recentgradslist[0].Unemployed,
					"Unemployment_rate" : recentgradslist[0].Unemployment_rate,
					"Median" : recentgradslist[0].Median,
					"P25th" : recentgradslist[0].P25th,
					"P75th" : recentgradslist[0].P75th,
					"College_jobs" : recentgradslist[0].College_jobs,
					"Non_college_jobs" : recentgradslist[0].Non_college_jobs,
					"Low_wage_jobs" : recentgradslist[0].Low_wage_jobs
				}
			}
		});

*/


/////////////////////////////////////////////////////////////////////////////


/*
db.majorsorganized.save(
	db.majors.find(
	{
		Major_code : majorslist[0],
		Student_type : "Recent grads"
	},
	{
		Major_code : 1,
		Major : 1,
		Major_category : 1
	}).toArray()
)

allageslist = db.majors.find(
{
	Major_code : majorslist[0],
	Student_type : "All ages"
},
{
	Major_code : 0,
	Major : 0,
	Major_category : 0,
	Student_type : 0
}).toArray()

recentgradslist = db.majors.find(
{
	Major_code : majorslist[0],
	Student_type : "Recent grads"
},
{
	Major_code : 0,
	Major : 0,
	Major_category : 0,
	Student_type : 0
}).toArray()

gradstudentslist = db.majors.find(
{
	Major_code : majorslist[0],
	Student_type : "Grad students"
},
{
	Major_code : 0,
	Major : 0,
	Major_category : 0,
	Student_type : 0
}).toArray()


db.majorsorganized.update(
{
	Major_code : majorslist[0]
},
{
	$set : {
		"All ages" : {
			"Total" : allageslist["Total"],
			"Employed" : allageslist["Employed"],
			"Employed_full_time_year_round" : allageslist["Employed_full_time_year_round"],
			"Unemployed" : allageslist["Unemployed"],
			"Unemployment_rate" : allageslist["Unemployment_rate"],
			"Median" : allageslist["Median"],
			"P25th" : allageslist["P25th"],
			"P75th" : allageslist["P75th"]
		}
	}
})

db.majorsorganized.update(
{
	Major_code : majorslist[0]
},
{
	$set : {
		"Grad students" : {
			"Total" : gradstudentslist["Total"],
			"Employed" : gradstudentslist["Employed"],
			"Employed_full_time_year_round" : gradstudentslist["Employed_full_time_year_round"],
			"Unemployed" : gradstudentslist["Unemployed"],
			"Unemployment_rate" : gradstudentslist["Unemployment_rate"],
			"Median" : gradstudentslist["Median"],
			"P25th" : gradstudentslist["P25th"],
			"P75th" : gradstudentslist["P75th"]
		}
	}
})

db.majorsorganized.update(
{
	Major_code : majorslist[0]
},
{
	$set : {
		"Recent grads" : {
			"Total" : recentgradslist["Total"],
			"Sample_size" : recentgradslist["Sample_size"],
			"Men" : recentgradslist["Men"],
			"Women" : recentgradslist["Women"],
			"ShareWomen" : recentgradslist["ShareWomen"],
			"Employed" : recentgradslist["Employed"],
			"Full_time" : recentgradslist["Full_time"],
			"Part_time" : recentgradslist["Part_time"],
			"Employed_full_time_year_round" : recentgradslist["Employed_full_time_year_round"],
			"Unemployed" : recentgradslist["Unemployed"],
			"Unemployment_rate" : recentgradslist["Unemployment_rate"],
			"Median" : recentgradslist["Median"],
			"P25th" : recentgradslist["P25th"],
			"P75th" : recentgradslist["P75th"],
			"College_jobs" : recentgradslist["College_jobs"],
			"Non_college_jobs" : recentgradslist["Non_college_jobs"],
			"Low_wage_jobs" : recentgradslist["Low_wage_jobs"]
		}
	}
})
*/