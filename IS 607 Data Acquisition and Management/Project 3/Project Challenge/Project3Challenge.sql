--All columns had some duplicates, so we needed to add a serial column before we could create a primary key

ALTER TABLE wikitable
ADD COLUMN id SERIAL;

--In order to load two hours, I'm going to load the hours separately. 
--So first I'm going to add a column to wikitable with an hour column, default set at 1

ALTER TABLE wikitable
ADD COLUMN hourcol INT DEFAULT 1;

--Then after loading the second hour into wikitable2, I'm going to do the sam thing.

ALTER TABLE wikitable2
ADD COLUMN id SERIAL;

ALTER TABLE wikitable2
ADD COLUMN hourcol INT DEFAULT 2;

--And then once again make ID the primary key
--Then query based on the union of the two tables

SELECT * FROM wikitable

UNION

SELECT * FROM wikitable2

LIMIT 100;