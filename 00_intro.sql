-- 데이터베이스 생성
.database


-- csv파일을 긁어오기

.mode csv
.import hellodb.csv examples

-- 예쁘게 보기
.headers ON
.mode column

-- 테이블 조회

SELECT * FROM examples;

