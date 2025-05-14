
## 기본 질의문 연습

-- 1) orders 테이블에서 결제수단이 카카오페이인 데이터만 가져와주세요.
select * from orders where payment_method like 'kakaopay';
-- 2) point_users 테이블에서 포인트가 5000점 이상인 데이터만 가져와주세요.
select * from point_users where point >= 5000;
-- 3) orders 테이블에서 주문한 강의가 앱개발 종합반이면서, 결제수단이 카드인 데이터만 가져와줘.
select * from orders where course_title like '앱개발 종합반' and payment_method like 'CARD';
-- 4) 포인트가 20000 점보다 많은 유저만 뽑아보기!
select * from point_users where point > 20000;
-- 5) 성이 황씨인 유저만 뽑아보기 (users테이블)
select * from users where name like '황%';
-- 6) 웹개발 종합반' 을 제외하고 주문데이터를 보고 싶어졌어요 어떻게 하면좋을까요?
select * from orders where course_title not like "웹개발 종합반";
-- 7) 7 월 13 일, 7 월 14 일의 주문데이터만 보고 싶어졌어요. 어떻게 해야 할까요? (timestamp --> 날짜까지만구하기)
select * from orders where DATE(created_at) between "2020-07-13" and "2020-07-14";
-- 8) 1, 3 주차 사람들의 ' 오늘의 다짐' 데이터만 보고 싶어졌어요.
select * from checkins where week = 1 or week = 3;
select * from checkins where week in(1,3);
-- 9) 다음 (daum) 이메일을 사용하는 유저만 보고 싶어졌어요. 어떻게 하죠?
select * from users where substring_index(email , '.' , 1) like '%daum';
select * from users where email like '%daum%';
-- 10) a로 시작하고 t로 끝나는 이메일을 가지는 유저들을 보고 싶어요.
select * from users where email like "a%" and email like "%t";
-- 11) 성이 남씨인 유저의 이메일 계정의 아이디만 추출하기
SELECT substring_index(email, '@', 1), name FROM users WHERE name LIKE '남%'; 
-- 12) 결제수단이 CARD 가 아닌 주문데이터만 추출해보기
SELECT * FROM orders WHERE payment_method NOT LIKE 'CARD';
-- 13) 20000~30000 포인트 보유하고 있는 유저만 추출해보기
SELECT * FROM point_users WHERE point BETWEEN 20000 AND 30000;
-- 14) 이메일이 a 로 시작하고 com 로 끝나는 유저만 추출해보기
SELECT * FROM users WHERE email LIKE 'a%com';
-- 15) 이메일이 s 로 시작하고 com 로 끝나면서 성이 이씨인 유저만 추출해보기
SELECT * FROM users WHERE email LIKE 's%com' AND name LIKE '이%';
-- 16) 주문시 몇개의 결제 수단이 있는지 알아보세요~
SELECT COUNT(distinct payment_method) FROM orders;
-- 17) 회원 분들의 성(family name) 씨가 몇개인지 궁금하다면?
SELECT COUNT(DISTINCT name) FROM users;
-- 18) daum, naver등 메일 계정들 중 가장 많은 유저를 가지는 메일 계정을 알고 싶어요.
SELECT SUBSTRING_INDEX(email,'@', -1) AS email_users, count(*) AS cnt FROM users GROUP BY email_users;

WITH temp AS(
SELECT SUBSTRING_INDEX(email, '@', -1) as email_user,
COUNT(*) as cnt, rank() over(order by count(*) desc) as rank_ from users group by email_user
)SELECT email_user from temp where rank_ = 1;


-- 19) Gmail 을 사용하는 2020-07-12~13 에 가입한 유저를 추출하기
SELECT * FROM users WHERE email LIKE '%Gmail%'
and DATE(created_at) between '2020-07-12' AND '2020-07-13';

-- 20) naver 을 사용하는 2020-07-12~13 에 가입한 유저의 수를 세기


-- 21) naver 이메일을 사용하면서, 웹개발 종합반을 신청했고 결제는 kakaopay 이뤄진 주문데이터 추출하기
SELECT * FROM orders WHERE email like '%naver%' and course_title LIKE '웹개발 종합반' AND payment_method LIKE 'kakaopay'; 


