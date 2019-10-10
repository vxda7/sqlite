CREATE TABLE friends (
	id INTEGER,
    name TEXT,
    location TEXT
);

INSERT INTO friends 
VALUES (1, "Justin", "Seoul"), (2, "Simon", "New York"), 
(3, "Chang", "Las Vegas"), (4, "John", "Sydney");

SELECT * FROM friends;

ALTER TABLE friends ADD COLUMN married INTEGER;

UPDATE friends SET married=1 WHERE id=1 or id=4;
UPDATE friends SET married=0 WHERE id=2 or id=3;
UPDATE friends SET location="LA" WHERE id=1;

SELECT * FROM friends;

DROP TABLE friends;