CREATE FUNCTION maxid() RETURNS integer
AS $$
SELECT character_id FROM charactertable WHERE character_id = (SELECT MAX(character_id) FROM charactertable);
$$
LANGUAGE SQL 
RETURNS NULL ON NULL INPUT;

CREATE FUNCTION upsert(varchar, varchar, varchar) RETURNS VOID AS
$$
BEGIN
	UPDATE charactertable SET house = $2, kingdom = $3 WHERE character_name = $1;
	IF found THEN
		RETURN;
	ELSE
		INSERT INTO charactertable(character_id, character_name, house, kingdom)
		VALUES
		(maxid()+1, $1, $2, $3);
		RETURN;
	END IF;
END;
$$
LANGUAGE plpgsql

--CREATE FUNCTION upsert(varchar, varchar, varchar) RETURNS VOID AS
--$$
--BEGIN
--	UPDATE charactertable SET house = $2, kingdom = $3 WHERE character_name = $1;
--	IF found THEN
--		RETURN;
--	END IF;
--
--	BEGIN
--		INSERT INTO charactertable(chracter_id, character_name, house, kingdom)
--		VALUES
--		(maxid()+1, $1, $2, $3);
--		RETURN;
--	END;
--END;
--$$
--LANGUAGE plpgsql;

--CREATE FUNCTION upsert(varchar, varchar, varchar) RETURNS VOID AS 
--$$
--BEGIN
--	LOOP
--		UPDATE charactertable
--		SET character_name = $1, house = $2, kingdom = $3;
--		IF found THEN
--			RETURN;
--		END IF;
--		BEGIN
--			INSERT INTO charactertable(character_id, character_name, house, kingdom)
--			VALUES
--			(maxid()+1, $1, $2, $3);
--			RETURN;
--
--		END;
--	END LOOP;
--END;
--$$
--LANGUAGE plpgsql;

--SELECT IF SELECT EXISTS (SELECT * FROM charactertable WHERE character_name = 'Balon Greyjoy')
--UPDATE charactertable SET house = 'Stark' WHERE character_name = 'Balon Greyjoy'
--ELSE
--INSERT INTO charactertable (character_id, character_name, house, kingdom)
--VALUES (15, 'Asha Greyjoy', 'Greyjoy', 'Iron Islands');
--END IF;

--CREATE FUNCTION addchar(varchar, varchar, varchar) RETURNS void
--AS $$
--INSERT INTO charactertable (character_id, character_name, house, kingdom) VALUES (maxid()+1, $1, $2, $3);
--$$
--LANGUAGE SQL
--RETURNS NULL ON NULL INPUT;