library(dplyr)

setwd("C:/Users/Charley/Downloads/Courses/CUNY/SPS/Git/IS 607 Data Acquisition and Management/Week 12/Week12Quiz")

dataCourses <- read.csv("week-12-quiz-data-courses.csv", stringsAsFactors=FALSE)
studentHousing <- read.csv("week-12-quiz-data-students-and-housing.csv", stringsAsFactors=FALSE)

studentTable <- select(studentHousing, GivenName, Surname, ID, Gender, StreetAddress, City, State, 
                       ZipCode, TelephoneNumber)

courseTable <- dataCourses %>%
  group_by(CourseDept, CourseNumber, CourseName) %>%
  summarise()

housingList <- unique(select(studentHousing, Dormitory))

enrolledCourses <- dataCourses %>%
  filter(Grade == "IP")

completedCourses <- dataCourses %>%
  filter(Grade != "IP")

write.csv(courseTable, "courseTable.csv", row.names=FALSE)
write.csv(housingList, "housingList.csv", row.names=FALSE)
write.csv(studentTable, "studentTable.csv", row.names=FALSE)
write.csv(enrolledCourses, "enrolledCourses.csv", row.names=FALSE)
write.csv(completedCourses, "completedCourses.csv", row.names=FALSE)
