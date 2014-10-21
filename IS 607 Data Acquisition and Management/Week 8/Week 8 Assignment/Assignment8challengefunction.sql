-------------------------------------------------------------------------------
-- This worked
--SELECT 
--	posttable.post_title,
--	commenttable.comment_comment,
--	tagtable.tag
--FROM
--	commentsonposts
--	INNER JOIN tagsofposts ON commentsonposts.post_id = tagsofposts.post_id
--	INNER JOIN commenttable ON commentsonposts.comment_id = commenttable.comment_id
--	INNER JOIN posttable ON commentsonposts.post_id = posttable.post_id
--	INNER JOIN tagtable ON tagsofposts.tag_id = tagtable.tag_id
--WHERE
--	posttable.post_title = 'New Jersey’s Response to Suicide Attempts: Close Bridge to Pedestrians';

-------------------------------------------------------------------------------

CREATE TYPE postqueryreturn AS
(
	title varchar,
	com varchar,
	tagtag varchar
);

--Function takes in a post title, and returns the tags and comments on that post.
CREATE FUNCTION postquery(postentry varchar)
RETURNS SETOF postqueryreturn AS $$
BEGIN 
RETURN QUERY
SELECT 
	posttable.post_title,
	commenttable.comment_comment,
	tagtable.tag
FROM
	commentsonposts
	INNER JOIN tagsofposts ON commentsonposts.post_id = tagsofposts.post_id
	INNER JOIN commenttable ON commentsonposts.comment_id = commenttable.comment_id
	INNER JOIN posttable ON commentsonposts.post_id = posttable.post_id
	INNER JOIN tagtable ON tagsofposts.tag_id = tagtable.tag_id
WHERE
	posttable.post_title = postentry;

END; $$
LANGUAGE PLPGSQL;


--------------------------------------------------------------------------------
-- To query this:


SELECT * FROM postquery('New Jersey’s Response to Suicide Attempts: Close Bridge to Pedestrians');