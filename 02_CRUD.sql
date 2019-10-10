CREATE TABLE classmates (
    name TEXT,
    age INT,
    address TEXT
);

-- CREATE
INSERT INTO classmates (name, age, address) 
VALUES ('김승연', 26, '전대');

-- 확인
SELECT * FROM classmates;

-- CREATE
INSERT INTO classmates (name, address) 
VALUES ('김승연', '전대');

-- 확인
SELECT * FROM classmates;
-- 모든열에 데이터를 넣을 때는 데이터를 명시할 필요가 없당
INSERT INTO classmates
VALUES ('홍길동', 30, '서울');


SELECT rowid, * FROM classmates;

DROP TABLE classmates;

CREATE TABLE classmates(
    id INT PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INT NOT NULL,
    address TEXT NOT NULL
);

.schema classmates

INSERT INTO classmates (name, age, address)
VALUES (1, '하이', 600,'광주');

SELECT * FROM classmates;
DROP TABLE classmates;

CREATE TABLE classmates(
    name TEXT NOT NULL,
    age INT NOT NULL,
    address TEXT NOT NULL
);

INSERT INTO classmates (name, age, address)
VALUES ('홍길동', 30,'서울'), ('김철수', 23, '대전'), ('박나래', 23, '광주'), ('이요셉', 33, '구미');
SELECT rowid,* FROM classmates;
SELECT rowid, name FROM classmates;
SELECT rowid, name FROM classmates LIMIT 1;
SELECT rowid, * FROM classmates LIMIT 1 OFFSET 2;
SELECT rowid, * FROM classmates WHERE address="서울";
SELECT DISTINCT age FROM classmates;
DELETE FROM classmates WHERE rowid=4;
INSERT INTO classmates VALUES ('아무나', 40, '광주');
SELECT rowid, * FROM classmates;
UPDATE classmates SET name="홍길동",age="10000",address="여수" where name="아무나";
SELECT rowid, * FROM classmates;
DROP TABLE classmates;
