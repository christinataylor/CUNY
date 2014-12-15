-- Table: hourlyweather

-- DROP TABLE hourlyweather;

CREATE TABLE hourlyweather
(
  year double precision NOT NULL,
  month double precision NOT NULL,
  day double precision NOT NULL,
  hour double precision NOT NULL,
  minute double precision,
  temp double precision,
  windchill double precision,
  heatindex double precision,
  dewpoint double precision,
  humidity double precision,
  pressure double precision,
  visibility double precision,
  winddir text,
  windspeed double precision,
  gustspeed double precision,
  precip double precision,
  events text,
  conditions text,
  CONSTRAINT hourlyweather_pkey PRIMARY KEY (year, month, day, hour)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE hourlyweather
  OWNER TO postgres;

-- Table: stations

-- DROP TABLE stations;

CREATE TABLE stations
(
  "station.id" integer NOT NULL,
  "station.name" text,
  "station.latitude" double precision,
  "station.longitude" double precision,
  CONSTRAINT stations_pkey PRIMARY KEY ("station.id")
)
WITH (
  OIDS=FALSE
);
ALTER TABLE stations
  OWNER TO postgres;

-- Table: trips

-- DROP TABLE trips;

CREATE TABLE trips
(
  "row.names" text NOT NULL,
  tripduration integer,
  starttime text,
  stoptime text,
  "start.station.id" integer,
  "end.station.id" integer,
  bikeid integer,
  usertype text,
  "birth.year" double precision,
  gender integer,
  starthour integer,
  startday integer,
  startmonth double precision,
  startyear double precision,
  startminute integer,
  startsecond double precision,
  CONSTRAINT trips_pkey PRIMARY KEY ("row.names"),
  CONSTRAINT "end.station_fkey" FOREIGN KEY ("end.station.id")
      REFERENCES stations ("station.id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "start.station_fkey" FOREIGN KEY ("start.station.id")
      REFERENCES stations ("station.id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT weather_fkey FOREIGN KEY (starthour, startday, startmonth, startyear)
      REFERENCES hourlyweather (hour, day, month, year) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE trips
  OWNER TO postgres;

-- Index: "fki_end.station_fkey"

-- DROP INDEX "fki_end.station_fkey";

CREATE INDEX "fki_end.station_fkey"
  ON trips
  USING btree
  ("end.station.id");

-- Index: "fki_start.station.pkey"

-- DROP INDEX "fki_start.station.pkey";

CREATE INDEX "fki_start.station.pkey"
  ON trips
  USING btree
  ("start.station.id");

-- Index: fki_weather_fkey

-- DROP INDEX fki_weather_fkey;

------------------------------------------------------------------------------

DELETE FROM trips WHERE endmonth = 9 AND endyear = 2014;

-- I added the end month after I found some interesting analysis to perform with ggmap.
-- I ran into trouble because some users borrowed a bike late August 31 and returned it
-- early on September 1, messing up my indices. 

ALTER TABLE weekends ALTER COLUMN year SET DATA TYPE double precision;
ALTER TABLE weekends ALTER COLUMN month SET DATA TYPE double precision;
ALTER TABLE weekends ALTER COLUMN day SET DATA TYPE double precision;
ALTER TABLE weekends ALTER COLUMN hour SET DATA TYPE double precision;

------------------------------------------------------------------------------

CREATE INDEX fki_weather_fkey
  ON trips
  USING btree
  (starthour, startday, startmonth, startyear);

------------------------------------------------------------------------------

CREATE TABLE cyclists AS

SELECT DISTINCT
  bikeid,
  usertype,
  "birth.year",
  gender
FROM
  trips;

ALTER TABLE 
  trips 
DROP COLUMN usertype, 
DROP COLUMN "birth.year", 
DROP COLUMN gender;


CREATE TABLE hourlyrides AS

SELECT
  startyear AS year,
  startmonth AS month,
  startday AS day,
  starthour AS hour,
  count(*)
FROM
  trips
GROUP BY
  startyear,
  startmonth,
  startday,
  starthour;


CREATE TABLE firststartstationhourly AS

SELECT
  starthour AS hour,
  "start.station.id",
  count(*)
FROM
  trips
GROUP BY
  starthour,
  "start.station.id";

CREATE TABLE startstationhourly AS

SELECT
  hour,
  "start.station.id",
  stations."station.name",
  stations."station.latitude",
  stations."station.longitude",
  count
FROM
  firststartstationhourly
INNER JOIN
  stations ON firststartstationhourly."start.station.id" = stations."station.id";


CREATE TABLE firstendstationhourly AS

SELECT
  endhour AS hour,
  "end.station.id",
  count(*)
FROM
  trips
GROUP BY
  endhour,
  "end.station.id";

CREATE TABLE endstationhourly AS

SELECT
  hour,
  "end.station.id",
  stations."station.name",
  stations."station.latitude",
  stations."station.longitude",
  count
FROM
  firstendstationhourly
INNER JOIN
  stations ON firstendstationhourly."end.station.id" = stations."station.id";


CREATE TABLE endstationhourly AS

SELECT
  starthour AS hour,
  "end.station.id",
  count(*)
FROM
  trips
GROUP BY
  starthour,
  "end.station.id";


CREATE TABLE hourlyrideswithweather AS

SELECT
  hourlyrides.year,
  hourlyrides.month,
  hourlyrides.day,
  hourlyrides.hour,
  count AS ridescount
  hourlyweather.temp,
  hourlyweather.dewpoint,
  hourlyweather.humidity,
  hourlyweather.pressure,
  hourlyweather.visibility,
  hourlyweather.windspeed,
  hourlyweather.conditions,
  weekends.weekend
  
FROM
  hourlyrides
INNER JOIN
  hourlyweather on hourlyweather.year = hourlyrides.year
  AND hourlyweather.month = hourlyrides.month
  AND hourlyweather.day = hourlyrides.day
  AND hourlyweather.hour = hourlyrides.hour
INNER JOIN
  weekends ON weekends.year = hourlyrides.year
  AND weekends.month = hourlyrides.month
  AND weekends.day = hourlyrides.day
  AND weekends.hour = hourlyrides.hour;



---------------------------------------------------------------

--Create weekend trips

CREATE TABLE weekendstarttrips AS

SELECT
  "row.names", tripduration, starttime,
  stoptime, "start.station.id", "end.station.id",
  bikeid, usertype, "birth.year", gender, starthour,
  startday, startmonth, startyear, startminute, 
  startsecond,

  weekends.weekend
FROM
  trips
INNER JOIN
  weekends ON 
  trips.startyear = weekends.year
  AND trips.startmonth = weekends.month
  AND trips.startday = weekends.day
  AND trips.starthour = weekends.hour;

CREATE TABLE firststartstationweekenddailyhourly AS

SELECT 
  starthour AS hour,
  startday AS day,
  startmonth AS month,
  startyear AS year,
  "start.station.id",
  weekend,
  count(*)
FROM
  weekendstarttrips
GROUP BY
  starthour,
  startday,
  startmonth,
  startyear,
  "start.station.id",
  weekend;

CREATE TABLE firststartstationweekendhourly AS

SELECT
  hour,
  "start.station.id",
  weekend,
  avg(count) AS count
FROM
  firststartstationweekenddailyhourly
GROUP BY
  hour, 
  "start.station.id",
  weekend;


CREATE TABLE startstationweekendhourly AS

SELECT
  hour,
  "start.station.id",
  stations."station.name",
  stations."station.latitude",
  stations."station.longitude",
  weekend,
  count
FROM
  firststartstationweekendhourly
INNER JOIN
  stations ON firststartstationweekendhourly."start.station.id" = stations."station.id";


---------------------------

CREATE TABLE weekendendtrips AS

SELECT
  "row.names", tripduration, starttime,
  stoptime, "start.station.id", "end.station.id",
  bikeid, usertype, "birth.year", gender, endhour,
  endday, endmonth, endyear, endminute, 
  endsecond,

  weekends.weekend
FROM
  trips
INNER JOIN
  weekends ON 
  trips.endyear = weekends.year
  AND trips.endmonth = weekends.month
  AND trips.endday = weekends.day
  AND trips.endhour = weekends.hour;

CREATE TABLE firstendstationweekenddailyhourly AS

SELECT
  endhour AS hour,
  endday AS day,
  endmonth AS month,
  endyear AS year,
  "end.station.id",
  weekend,
  count(*)
FROM
  weekendendtrips
GROUP BY 
  endhour,
  endday,
  endmonth,
  endyear,
  "end.station.id",
  weekend

CREATE TABLE firstendstationweekendhourly AS

SELECT
  hour,
  "end.station.id",
  weekend,
  avg(count) as count
FROM
  firstendstationweekenddailyhourly
GROUP BY
  hour,
  "end.station.id",
  weekend



CREATE TABLE endstationweekendhourly AS

SELECT
  hour,
  "end.station.id",
  stations."station.name",
  stations."station.latitude",
  stations."station.longitude",
  weekend,
  count
FROM
  firstendstationweekendhourly
INNER JOIN
  stations ON firstendstationweekendhourly."end.station.id" = stations."station.id";





--CREATE TABLE firstendstationweekendhourly AS

--SELECT
--  endhour AS hour,
--  "end.station.id",
--  weekend,
--  count(*)
--FROM
--  weekendendtrips
--GROUP BY
--  endhour,
--  "end.station.id",
--  weekend;




--CREATE TABLE firststartstationweekendhourly AS

--SELECT
--  starthour AS hour,
--  "start.station.id",
--  weekend,
--  count(*)
--FROM
--  weekendstarttrips
--GROUP BY
--  starthour,
--  "start.station.id",
--  weekend;