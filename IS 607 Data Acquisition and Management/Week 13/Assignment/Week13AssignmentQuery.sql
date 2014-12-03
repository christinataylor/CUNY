--Question 1--------------------

SELECT
	year,
	month,
	day,
	dep_time,
	dep_delay,
	arr_time,
	arr_delay,
	carrier,
	tailnum,
	flight,
	origin,
	dest,
	air_time,
	distance,
	hour,
	minute,
	airports.faa,
	airports.name,
	airports.lat,
	airports.alt,
	airports.tz,
	airports.dst
FROM	
	flights
INNER JOIN airports on flights.origin = airports.faa;

--329174 rows
--54772 MS

ALTER TABLE airports
  ADD CONSTRAINT airports_pkey PRIMARY KEY(faa);

ALTER TABLE flights
  ADD CONSTRAINT flights_pkey PRIMARY KEY("row.names");

ALTER TABLE flights
  ADD CONSTRAINT origin_faa_fkey FOREIGN KEY (origin)
      REFERENCES airports (faa) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE flights
  ADD CONSTRAINT dest_faa_fkey FOREIGN KEY (dest)
      REFERENCES airports (faa) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

--55226 MS
--329174 rows

CREATE INDEX airports_faa_idx
  ON airports
  USING btree
  (faa COLLATE pg_catalog."default");

CREATE INDEX fki_dest_faa_fkey
  ON flights
  USING btree
  (dest COLLATE pg_catalog."default");

--47137 MS
--329174

--It does look like some time was saved by indexing. Indexing would seem to work best
--in a situation like this, where there are a small number of unique values. A column with
--all unique values, like a key, wouldn't really make sense to index.

--Question 2--------------------

CREATE TABLE question2table AS

SELECT 
	year,
	month,
	day,
	SUM (arr_delay) + SUM (dep_delay) as total_delay,
	flights.carrier,
	airlines.name
FROM
	flights
INNER JOIN
	airlines on flights.carrier = airlines.carrier
GROUP BY 
	year, month, day, flights.carrier, airlines.name;

--Query returned successfully: 5432 rows affected, 2834 ms execution time.


CREATE VIEW question2view AS

SELECT 
	year,
	month,
	day,
	SUM (arr_delay) + SUM (dep_delay) as total_delay,
	flights.carrier,
	airlines.name
FROM
	flights
INNER JOIN
	airlines on flights.carrier = airlines.carrier
GROUP BY 
	year, month, day, flights.carrier, airlines.name;

--Query returned successfully with no result in 31 ms.
--!!!

--Testing some use cases. Selecting in the TABLE
--versus pulling up the VIEW

SELECT * FROM question2table;

--5432 rows
---333 MS

--Pulling up the view in pgadmin doesn't give a time
--But pulling the full view appeared to take longer than the SELECT statment did.
--This suggests the differing benefits of these two approaches. The newly created table
--makes future queries easier, but the table itself takes more time to create. Views can be
--created in very short periods of time, but require processing time to actually view.
--Depending on your need, you can choose to either front load your processing time and 
--create a table, or create a view for an ad hoc quick creation.


