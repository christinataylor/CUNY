INSERT INTO posttable (post_id, post_title)
VALUES
(1, 'New Jersey’s Response to Suicide Attempts: Close Bridge to Pedestrians'),
(2, 'Trottenberg: Federal Cuts Could Make MTA Funding Gap Even Bigger'),
(3, 'Will Roosevelt Island Reach Its Potential as a Bikeable Neighborhood?'),
(4, 'Peter Norton: We Can Learn From the Movement to Enshrine Car Dependence'),
(5, 'Will Miami Take the First Step Toward Parking Reform?'),
(6, 'NYPD Recommended a Mandatory Helmet Law in 2011'),
(7, 'Q&A With Peter Norton: History Is on the Side of Vision Zero');

INSERT INTO commenttable (comment_id, comment_comment)
VALUES
(1, 'Good story, more coverage of NJ is needed here. The pre-war municipalities 
of NJ are where the TOD is really happening, with intact street grids, good bones 
for mass transit, walkable downtowns and schools, ect.'),
(2, 'Wonder what the Perth Amboy mayor would close off to the public if he found 
out how many people attempt suicide using their cars?'),
(3, 'I don''t think the Perth Amboy Mayor asked to ban pedestrians. That was most 
likely thought up by someone at NJDOT in Trenton.'),
(4, 'Maybe it is time for Polly Trottenberg, DOT and the local livable streets 
movement to rediscover the community organizing potential of Safe Streets to School 
--- which NYC pioneered in the US.'),
(5, 'Am I missing something? Roosevelt Island is way too small to be really interesting 
for bicyclists.'),
(6, 'I don''t live on Roosevelt Island but I was about to say the same thing. At ~4 
miles to loop around the island any serious cyclist will need 5 loops or more to get 
a good ride in.'),
(7, 'Where is the Equity in Vision Zero. Its great to think about the good old days but 
the reality demographics are changing in the US and Latinos have some of the highest 
bike and pedestrian rates.'),
(8, 'If you look closely at this photo you will see a smooth concrete street. Its all 
nice and clean. So clean that little girls could play in their party dresses.'),
(9, 'What does it matter? Miami is doomed within the next few decades with rising sea levels.'),
(10, 'Once again, the NYPD is essentially throwing up its hands and saying it can’t (or won’t) 
do anything to make the streets safer, so cyclists better protect themselves. It’s as if the 
CDC’s sole response to Ebola were to require every American to wear a face mask.'),
(11, 'Like the double parking law? Or the driving on the right law? Or the not tailgating 
law? And the red light law, the not blocking intersections law, the no turns on red law? 
Such success.'),
(12, 'With bike share, the helmet debate is really over. John Liu and many others predicted 
massive of casualties upon the launch of no-helmet-required Citibike. They made their predictions 
with total confidence - they told everyone exactly what was going to happen. And then the 
opposite happened.'),
(13, 'Thanks for this interview. I loaned my copy of Fighting Traffic to someone, and it is gone. 
Just ordered a new copy. :-)'),
(14, 'I have read this book when it first came out. Use parts of it in developing our RTP. ');

INSERT INTO tagtable (tag_id, tag)
VALUES
(1, 'Network Roundup'),
(2, 'Carl Weisbrod'),
(3, 'MTA'),
(4, 'Polly Trottenberg'),
(5, 'Transit Funding'),
(6, 'Bicycling'),
(7, 'Roosevelt Island'),
(8, 'Cars'),
(9, 'Bicycle Safety'),
(10, 'NYPD');


INSERT INTO commentsonposts(comment_id, post_id)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 3),
(6, 3),
(7, 4),
(8, 4),
(9, 5),
(10, 6),
(11, 6),
(12, 6),
(13, 7),
(14, 7);

INSERT INTO tagsofposts(post_id, tag_id)
VALUES
(1, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 6),
(3, 7),
(4, 8),
(5, 1),
(6, 9),
(6, 6),
(6, 10),
(7, 8);