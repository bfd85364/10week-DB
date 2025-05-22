# ---------------------------------- 부속 질의문 ----------------------------------------------
-- 문제1.  가장 비싼 도서의 이름을 조회하시오.
SELECT bookname FROM book 
WHERE price = (select max(price) FROM book);

-- 문제2.　
-- (1) 주문테이블로부터　주문이력존재하는　고객아이디들을　조회하시오．　
SELECT DISTINCT custid FROM orders;

-- (2) 조회　결과를　활용하여　도서를 구매한 적이 있는 고객의 이름을 검색하는 부속질의어를　작성하시오．

-- > 부속 질의를 활용하면 ==
SELECT name FROM customer WHERE custid 
IN (SELECT custid FROM orders);
-- IN 연산자 내부에는 DISTINCT를 넣을 필요가 없다. 
  
-- (3) 도서를 구매한　적이　있는　고객의　이름을　검색하는　부속질의어를　exists 를　사용하여　작성하시오．(위에서 exists를 사용하였다면, IN을 사용하시오)

-- exists를 사용하는 경우 
SELECT name FROM customer A WHERE exists(SELECT 1 FROM orders B where A.custid = B.custid); 
 -- SELECT를 1로 하던 custid로 하던 상관 없다 -> 뭐가 있어야 결과를 TRUE를 반환함 

-- (4) 위의 부속질의어를 조인문으로 재구현하시오. 
SELECT DISTINCT(A.name) FROM customer A JOIN orders B  
 ON A.custid = B.custid;
 
 -- 문제 3. 대한미디어에서 출판한 도서를 구매한 고객의 이름을 조회하시오. 
SELECT name FROM customer WHERE custid in (SELECT custid FROM orders WHERE bookid
IN(SELECT bookid FROM book WHERE publisher  LIKE "대한미디어"));

-- 문제 4. 대한미디어에서 출판한 도서를 구매한 고객의 이름과 도서명을 조회하시오
-- 얘의 경우에는 결국 orders 테이블과 customer 테이블 book 테이블을 각각 참조해야함 -> 그냥  join 사용 

-- 문제 5. 도서의 이름의 두번째 글자가 '구' 인 도서를 구매한 고객의 이름을 조회하시오. 
SELECT name from customer where custid in 
(SELECT custid from orders where bookid in
(select bookid from book  where bookname like '_구%'));

select name from customer a where exists (
select 1 from orders b where exists (
select 1 from book c where b.bookid  = c.bookid  and a.custid = b.custid and c.bookname like '_구%'));
 
-- 문제 6. 도서의 이름의 두번째 글자가 '구' 인 도서를 구매한 고객의 이름과 출판사를 조회하시오. 
 -- join 없이는 name과 출판사 조회 불과 
 SELECT A.name, C.bookname FROM customer A JOIN orders B ON A.custid = B.custid JOIN 
 book C ON B.bookid = C.bookid WHERE C.bookname like '_구%';
 
 -- WITH랑 쓰면 
 WITH temp AS(
 SELECT a.name, b.saleprice, c.bookname, c.publisher from customer a join
 orders b on a.custid = b.custid join 
 book c on b.bookid = c.bookid 
 ) SELECT name, publisher from temp where  bookname like '_구%';

-- 문제 7. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.

SELECT * FROM book WHERE price > (SELECT avg(BK.price) FROM book BK WHERE publisher = BK.publisher);

-- 문제 8. 대한민국에 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 나타내시오.

-- 국적 확인 
SELECT * FROM customer WHERE address like '%대한민국%';

-- 주문 이력 있는 고객의 이름을 나타내려면 
select name from customer where custid in (select custid  from orders);

-- 따라서,  대한민국에 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 알고 싶다면 (전체 부속 쿼리로 확인) 

SELECT name FROM customer WHERE address like '%대한민국%'
UNION
select name from customer where custid in (select custid  from orders);

-- 문제 9. 주문이 있는 고객의 이름과 주소를 나타내시오

SELECT name, address FROM customer Where custid in (select custid from orders);

SELECT DISTINCT a.name, a.address FROM customer a join orders b on a.custid = b.custid;
