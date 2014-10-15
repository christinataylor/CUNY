INSERT INTO charactertable (character_id, character_name, house, kingdom)
VALUES
(1, 'Jon Snow', 'Stark', 'The North'),
(2, 'Robb Stark', 'Stark', 'The North'),
(3, 'Ned Stark', 'Stark', 'The North'),
(4, 'Tywin Lannister', 'Lannister', 'The Westerlands'),
(5, 'Tyrion Lannister', 'Lannister', 'The Westerlands'),
(6, 'Cersei Lannister', 'Lannister', 'The Westerlands'),
(7, 'Jaime Lannister', 'Lannister', 'The Westerlands'),
(8, 'Oberyn Martell', 'Martell', 'Dorne'),
(9, 'Daenerys Targaryen', 'Targaryen', 'Dragonstone'),
(10, 'Walder Frey', 'Frey', 'The Riverlands'),
(11, 'Robert Baratheon', 'Baratheon', 'The Stormlands'),
(12, 'Renly Baratheon', 'Baratheon', 'The Stormlands');

INSERT INTO campaigntable (campaign_desc, character_id)
VALUES
('Jon Snow arrives at the wall', 1),
('Tywin Lannister takes Harrenhal', 4),
('Tywin Lannister becomes hand of the king', 4),
('Renly Baratheon allies with the Reach', 12),
('Robert Baratheon hunts a pig', 11),
('Walder Frey hosts a wedding', 10),
('Tywin Lannister allies with the Reach', 4),
('Cersei Lannister drinks wine', 6),
('Daenerys Targaryen becomes the mother of dragons', 9),
('Robb Stark gets married', 2),
('Tyrion Lannister drinks wine', 5),
('Tyrion Lannister insults Cersei', 5),
('Oberyn Martell arrives at Kings Landing', 8),
('George RR Martin finishes Book 6', NULL);