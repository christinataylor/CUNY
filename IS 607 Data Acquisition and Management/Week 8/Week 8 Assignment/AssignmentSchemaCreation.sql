CREATE TABLE posttable
(
	post_id integer,
	post_title varchar,
	CONSTRAINT post_pkey PRIMARY KEY (post_id)
);

CREATE TABLE commenttable
(
	comment_id integer,
	comment_comment varchar,
	CONSTRAINT comment_pkey PRIMARY KEY (comment_id)
);

CREATE TABLE tagtable
(
	tag_id integer,
	tag varchar,
	CONSTRAINT tag_pkey PRIMARY KEY (tag_id)
);

CREATE TABLE commentsonposts
(
	comment_id integer,
	post_id integer,
	CONSTRAINT cp_pkey PRIMARY KEY (comment_id),
	CONSTRAINT com_fkey FOREIGN KEY (comment_id)
		REFERENCES commenttable (comment_id) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT postc_fkey FOREIGN KEY (post_id)
		REFERENCES posttable (post_id) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE tagsofposts
(
	post_id integer,
	tag_id integer,
	item_id serial,
	CONSTRAINT tp_pkey PRIMARY KEY (item_id),
	CONSTRAINT tag_fkey FOREIGN KEY (tag_id)
		REFERENCES tagtable (tag_id) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT postt_fkey FOREIGN KEY (post_id)
		REFERENCES posttable (post_id) MATCH SIMPLE
		ON UPDATE CASCADE ON DELETE RESTRICT
);