--SELECT 
--	commentsonposts.post_id,
--	commentsonposts.comment_id,
--	tagsofposts.tag_id
--FROM
--	commentsonposts
--INNER JOIN tagsofposts ON commentsonposts.post_id = tagsofposts.post_id;
------------------------------------------------------------------------------
SELECT
	posttable.post_title,
	commenttable.comment_comment,
	tagtable.tag
FROM
	commentsonposts
INNER JOIN tagsofposts ON commentsonposts.post_id = tagsofposts.post_id
INNER JOIN commenttable ON commentsonposts.comment_id = commenttable.comment_id
INNER JOIN posttable ON commentsonposts.post_id = posttable.post_id
INNER JOIN tagtable ON tagsofposts.tag_id = tagtable.tag_id;
------------------------------------------------------------------------------
--You could also display this data in two tables
------------------------------------------------------------------------------

SELECT
	posttable.post_title,
	commenttable.comment_comment
FROM
	commentsonposts
INNER JOIN commenttable ON commentsonposts.comment_id = commenttable.comment_id
INNER JOIN posttable ON commentsonposts.post_id = posttable.post_id;

------------------------------------------------------------------------------

SELECT
	posttable.post_title,
	tagtable.tag
FROM
	tagsofposts
INNER JOIN tagtable ON tagsofposts.tag_id = tagtable.tag_id
INNER JOIN posttable ON tagsofposts.post_id = posttable.post_id;
