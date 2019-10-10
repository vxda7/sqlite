-- DDL(데이터 정의 언어 Data Define Language)
-- 구조를 정의
CREATE TABLE classmates (
    id INTEGER PRIMARY KEY,
    name TEXT
);

-- 테이블 목록 조회
.tables

-- 스키마 조회
.schema classmates

-- 테이블 삭제
DROP TABLE classmates;
.tables

-- 예제
CREATE TABLE classmates (
    id INTEGER PRIMARY KEY,
    name TEXT,
    age INT,
    address TEXT
);

.tables
.schema classmates