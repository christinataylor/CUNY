--Charley Ferrari
--Project 3

--Week 7 base deliverables

--Show the structure of the table(s) you've created
--Right now I have one table, with four columns: projectcode, pagename, pageviews, and bytes.
--The data was loaded in from R using the RPostgreSQL library. This R script is included in the project folder.
--I created one primary key off of pagename.
--I'll attempt to normalize the data further, and attempt the challenge portion of the project.



SELECT * FROM wikitable ORDER BY pageviews DESC LIMIT 5;
