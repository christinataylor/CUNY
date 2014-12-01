
SELECT 
	campaign_desc,
	campaigntable.character_id,
	charactertable.character_name,
	charactertable.house,
	charactertable.kingdom
FROM
	campaigntable
INNER JOIN charactertable ON campaigntable.character_id = charactertable.character_id;

--The NULL values don't show up in this query. In order for George RR Martin to show up,
--I'd have to use the LEFT JOIN

SELECT 
	campaign_desc,
	campaigntable.character_id,
	charactertable.character_name,
	charactertable.house,
	charactertable.kingdom
FROM
	campaigntable
LEFT JOIN charactertable ON campaigntable.character_id = charactertable.character_id;


--And to add a WHERE clause:

SELECT 
	campaign_desc,
	campaigntable.character_id,
	charactertable.character_name,
	charactertable.house,
	charactertable.kingdom
FROM
	campaigntable
LEFT JOIN charactertable ON campaigntable.character_id = charactertable.character_id

WHERE
	charactertable.character_name = 'Tywin Lannister';