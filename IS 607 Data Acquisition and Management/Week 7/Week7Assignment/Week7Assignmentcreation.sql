
CREATE TABLE charactertable
(
	character_id integer,
	character_name varchar,
	house varchar,
	kingdom varchar,
	CONSTRAINT character_pkey PRIMARY KEY (character_id)
)

WITH (
	OIDS=FALSE
);

ALTER TABLE charactertable
	OWNER TO postgres;

CREATE TABLE campaigntable
(
	campaign_desc varchar,
	character_id integer,
	CONSTRAINT campaign_pkey PRIMARY KEY (campaign_desc),
	CONSTRAINT character_fkey FOREIGN KEY (character_id)
		REFERENCES charactertable (character_id) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE RESTRICT
)

WITH (
	OIDS=FALSE
);

ALTER TABLE campaigntable
	OWNER TO postgres;

