# SQL과 django ORM

## 기본 준비 사항

* https://bit.do/djangoorm에서 csv 파일 다운로드

* django app

  * `django_extensions` 설치

  * `users` app 생성

  * csv 파일에 맞춰 `models.py` 작성 및 migrate

    아래의 명령어를 통해서 실제 쿼리문 확인

    ```bash
    $ python manage.py sqlmigrate users 0001
    ```

* `db.sqlite3` 활용

  * `sqlite3`  실행

    ```bash
    $ ls
    db.sqlite3 manage.py ...
    $ sqlite3 db.sqlite3
    ```

  * csv 파일 data 로드

    ```sqlite
    sqlite > .tables
    auth_group                  django_admin_log
    auth_group_permissions      django_content_type
    auth_permission             django_migrations
    auth_user                   django_session
    auth_user_groups            auth_user_user_permissions  
    users_user
    sqlite > .mode csv
    sqlite > .import users.csv users_user
    sqlite > SELECT COUNT(*) FROM user_users;
    100
    ```

* 확인

  * sqlite3에서 스키마 확인

    ```sqlite
    sqlite > .schema users_user
    CREATE TABLE IF NOT EXISTS "users_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "first_name" varchar(10) NOT NULL, "last_name" varchar(10) NOT NULL, "age" integer NOT NULL, "country" varchar(10) NOT NULL, "phone" varchar(15) NOT NULL, "balance" integer NOT NULL);
    ```

    

## 문제

> 아래의 문제들을 sql문과 대응되는 orm을 작성 하세요.

### 기본 CRUD 로직

1. 모든 user 레코드 조회

   ```python
   # orm
   User.objects.all()
   ```

      ```sql
   -- sql
   SELECT * FROM users_user
      ```

2. user 레코드 생성

   ```python
   # orm
   User.objects.create(last_name="홍", first_name="길동", age=100, country="제주", phone="123-1234-1234",balance=123123)
   ```

   ```sql
   -- sql
   INSERT INTO users_user
   VALUES(101, '길동', '홍',30,'제주도','010-1234-1234',10000);
   ```

   * 하나의 레코드를 빼고 작성 후 `NOT NULL` constraint 오류를 orm과 sql에서 모두 확인 해보세요.

3. 해당 user 레코드 조회

   ```python
   # orm
   User.objects.get(id=102)
   ```

      ```sql
   -- sql
   SELECT * FROM users_user WHERE id=102;
      ```

4. 해당 user 레코드 수정

   ```python
   # orm
   user = User.objects.get(id=102)
   user.age = 10
   user.save()
   ```

      ```sql
   -- sql
   UPDATE users_user SET last_name="김" WHERE id=102;
      ```

5. 해당 user 레코드 삭제

   ```python
   # orm
   User.objects.get(id=102).delete()
```
   
      ```sql
   -- sql
   DELETE FROM users_user WHERE id=102;
      ```

### 조건에 따른 쿼리문

1. 전체 인원 수 

   ```python
   # orm
   len(User.objects.all())
   User.objects.all().count()
   ```

      ```sql
   -- sql
   SELECT COUNT(*) FROM users_user;
      ```

2. 나이가 30인 사람의 이름

   ```python
   # orm
   User.objects.filter(age=30).values('first_name')
   ```

   ```
   <QuerySet [{'first_name': '영환'}, {'first_name': '보람'}, {'first_name': '은영'}, {'first_name': '길동'}]>
   ```

      ```sql
   -- sql
   SELECT first_name FROM users_user 
   WHERE age=30;
      ```

3. 나이가 30살 이상인 사람의 인원 수

   ```python
   # orm
   User.objects.filter(age__gte=30).count()
   ```

      ```sql
   -- sql
   SELECT COUNT(*) FROM users_user 
   WHERE age>=30;
      ```

4. 나이가 30이면서 성이 김씨인 사람의 인원 수

   ```python
   # orm
   User.objects.filter(age__gte=30, last_name='김').count()
   ```

      ```sql
   -- sql
   SELECT COUNT(*) FROM users_user 
   WHERE age>=30 and last_name='김';
      ```

5. 지역번호가 02인 사람의 인원 수

   ```python
   # orm
   User.objects.filter(phone__startswith='02').count()
   ```

      ```sql
   -- sql
   SELECT COUNT(*) FROM users_user 
   WHERE phone LIKE '02-%';
      ```

6. 거주 지역이 강원도이면서 성이 황씨인 사람의 이름

   ```python
   # orm
   User.objects.filter(last_name='황', country="강원도").values("first_name")[0].get('first_name')
```
   
      ```sql
   -- sql
   SELECT first_name FROM users_user 
   WHERE last_name='황' and country="강원도";
      ```



### 정렬 및 LIMIT, OFFSET

1. 나이가 많은 사람 10명

   ```python
   # orm
   User.objects.order_by('-age')[:10].values()
   ```

      ```sql
   -- sql
   SELECT * FROM users_user 
   ORDER BY age DESC LIMIT 10;
      ```

2. 잔액이 적은 사람 10명

   ```python
   # orm
   User.objects.order_by('balance')[:10].values()
   ```

      ```sql
   -- sql
   SELECT * FROM users_user 
   ORDER BY balance LIMIT 10;
      ```

3. 성, 이름 내림차순 순으로 5번째 있는 사람

      ```python
   # orm
   User.objects.order_by('-last_name', '-first_name').values()[4]
```
   
      ```sql
   -- sql
   SELECT * FROM users_user 
   ORDER BY last_name DESC, first_name DESC 
   LIMIT 1 OFFSET 4;
      ```



### 표현식

1. 전체 평균 나이

   ```python
   # orm
   from django.db.models import Avg, Min, Max, Sum
   User.objects.all().aggregate(Avg('age'))
   ```

      ```sql
   -- sql
   SELECT AVG(age) FROM users_user;
      ```

2. 김씨의 평균 나이

   ```python
   # orm
   User.objects.filter(last_name='김').aggregate(Avg('age'))
   ```

      ```sql
   -- sql
   SELECT AVG(age) FROM users_user WHERE last_name="김";
      ```

3. 계좌 잔액 중 가장 높은 값

   ```python
   # orm
   User.objects.all().aggregate(Max('balance'))
   ```

      ```sql
   -- sql
   SELECT MAX(balance) FROM users_user;
      ```

4. 계좌 잔액 총액

      ```python
   # orm
   User.objects.all().aggregate(Sum('balance'))
```
   
      ```sql
   -- sql
   SELECT SUM(balance) FROM users_user;
      ```