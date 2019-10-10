CREATE TABLE articles (
    title TEXT NOT NULL,
    content TEXT NOT NULL
);

.tables
.headers ON
.mode column


INSERT INTO articles Values ("1번글", "1번내용");
SELECT * FROM articles;

ALTER TABLE articles RENAME TO news;
.tables

-- Error: near line 17: Cannot add a NOT NULL column with default value NULL
-- DEFAULT 로 이미 있는 값에 필수 값들을 채워넣어 줄 수 있음.
ALTER TABLE news ADD COLUMN created_at DATETIME NOT NULL DEFAULT 1;
SELECT * FROM news;


DROP TABLE news;