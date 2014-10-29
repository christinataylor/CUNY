// In command line

mongoimport --db unitedstates --type csv --headerline --file "C:\Users\Charley\Downloads\Courses\CUNY\SPS\Git\IS 607 Data Acquisition and Management\Week 9\Assignment\statedata.csv" --collection "geos"
mongoimport --db unitedstates --type tsv --headerline --file "C:\Users\Charley\Downloads\Courses\CUNY\SPS\Git\IS 607 Data Acquisition and Management\Week 9\Assignment\districtdata.txt" --collection "geos"
mongoimport --db unitedstates --type tsv --headerline --file "C:\Users\Charley\Downloads\Courses\CUNY\SPS\Git\IS 607 Data Acquisition and Management\Week 9\Assignment\inhabitedterritorydata.txt" --collection "geos"

