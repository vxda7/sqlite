.mode csv
.import users.csv users
.headers on


.tables
-- SELECT * FROM users;
-- 나이가 30 이상인 사람
SELECT * FROM users WHERE age>=30;

-- 나이가 30 이상인 사람의 이름
SELECT first_name FROM users WHERE age >= 30;

-- 나이 30 이상이고 성이 김씨인 사람들의 성과 나이 출력
SELECT last_name, age FROM users WHERE age>=30 AND last_name="김";

-- 레코드의 갯수 반환
SELECT COUNT(*) FROM users;

-- 나이 30 이상의 성이 김씨인 사람들 수
SELECT COUNT(*) FROM users WHERE age>=30 AND last_name="김";

-- 나이가 30 이상인 사람의 평균
SELECT AVG(age) FROM users WHERE age>=30;

-- 계좌 잔액이 가장 높은 사람과 액수는?
SELECT first_name, MAX(balance) FROM users;

-- 나이가 30 이상인 사람들의 평균 계좌 잔액은?
SELECT AVG(balance) FROM users WHERE age >= 30;

-- 스키마로 표현하면 가져온 데이터는 전부 TEXT타입이 된다.
.schema users

-- users 에서 20대인 사람의 테이블은?
SELECT * FROM users WHERE age LIKE '2_';

-- users 에서 지역번호가 02인 사람?
SELECT * FROM users WHERE phone LIKE '02-%';
SELECT COUNT(*) FROM users WHERE phone LIKE '02-%';

--users 에서 준으로 이름이 끝나는 사람?
SELECT * FROM users WHERE first_name LIKE '%준';
SELECT COUNT(*) FROM users WHERE first_name LIKE '%준';

--중간번호가 5114 인 사람 
SELECT * FROM users WHERE phone LIKE '%-5114-%';
SELECT COUNT(*) FROM users WHERE phone LIKE '%-5114-%';

-- users에서 나이순으로 오름차순 정렬하여 상위 10개만 뽑아보면?
SELECT * FROM users ORDER BY age LIMIT 10;

-- users에서 나이순, 성 순으로 오름차순 정렬하여 상위 10개만 뽑아보면?
SELECT * FROM users ORDER BY age, last_name LIMIT 10;

-- users에서 계좌잔액순으로 내림차순 정렬하여 해당하는 사람이름 10개만 뽑아보면?
SELECT last_name, first_name, balance FROM users ORDER BY balance DESC LIMIT 10;

DROP TABLE users;