select * from member;

select sysdate from member; 
select mdate from member;
select sysdate - mdate from member; 
select mdate,add_months(mdate,3) from member;
select mdate,add_months(mdate,10) from member;
select mdate,add_months(mdate,10),add_months(mdate,-10) from member;
select mdate, add_months(sysdate,-10) from member;
-- 현재 가입날짜가 10개월 이상된 회원들 출력하시오
select mdate, add_months(sysdate,-10) from member
where mdate <= add_months(sysdate, -10); 
-- 현재 가입날짜가 10개원 미만인 회원들 출력하시오
select mdate, add_months(sysdate,-10) from member
where mdate >= add_months(sysdate, -10); 

-- mdate 확인
select mdate from member;

-- mdate 그 달의 첫째일과 마지막일을 출력하시오
-- 2026/01/01, 2026/12/31 이런 식으로 출력하시오
select mdate, trunc(mdate,'mm') from member;
select mdate, add_months(mdate,1),trunc(add_months(mdate,1),'mm'), 
last_day(mdate) from member;

select round(months_between(sysdate, mdate),2) from member;
select trunc(months_between(sysdate, mdate),2) from member;

select mdate from member;
select name, mdate, sysdate, round(months_between(sysdate,mdate)) from member
where months_between(sysdate,mdate)=8;
select mdate, add_months(sysdate,-8) from member;
select mdate, months_between(sysdate,mdate) from member;
-- 가입한지 8개월째 되는 회원들 출력하시오
select mdate, trunc(months_between(sysdate,mdate)) from member;
select name, mdate, trunc(months_between(sysdate,mdate)) from member
where trunc(months_between(sysdate,mdate))=8; 
select name, mdate, round(months_between(sysdate,mdate),1) from member
where round(months_between(sysdate,mdate))=8; 
-- 9개월 이상된 회원들 출력하시오
select name, mdate, round(months_between(sysdate,mdate)) from member
where round(months_between(sysdate,mdate))=9;
select name, mdate, round(months_between(sysdate,mdate),1) from member
where round(months_between(sysdate,mdate))=9; 

-- 다음주 월요일 출력
select next_day(sysdate, '월요일') from dual;
-- 다다음주 월요일 출력
select next_day(next_day(sysdate, '월요일'),'월요일') from dual;_

select sysdate from dual;
-- 년도-월-일-시-분-초 출력하시오
select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') from dual;
select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss day') from dual;
select to_char(sysdate, 'yyyy"년"-mm"월"-dd"일" hh24"시":mi"분":ss"초"') from dual;
select to_char(mdate, 'yyyy-mm-dd hh24:mi:ss') from member;
select to_char(mdate, 'yyyy-mm-dd hh24:mi:ss day') from member;
select to_char(mdate, 'yyyy"년"-mm"월"-dd"일" hh24"시":mi"분":ss"초"') from member;

select * from employees;
-- 190번대 (190~199) 까지 salary (월급, 연봉, 원화연봉) 을 출력하는데
-- 천단위 표시, 원화연봉은 원화 표시를 출력하시오
select emp_name, employee_id, salary from employees;
select trunc(employee_id,-1) from employees;
select trunc(employee_id,-1) from employees
where trunc(employee_id,-1)=190;
select employee_id from employees
where employee_id>=190 and employee_id<=199;
select employee_id from employees
where employee_id between 190 and 199;

select emp_name, employee_id, to_char(salary,'999,999,999') as msalary, 
to_char(salary*12,'$999,999,999') as ysalary, 
to_char(salary*12*1420,'L999,999,999') from employees
where employee_id between 190 and 199;

select * from gallerylist;
-- galmodifiedtime 타입을 날짜 포맷으로 변경하시오
desc gallerylist;

-- 컬럼 추가를 먼저했으면 복사할 때 타입을 먼저 변경한 다음 복사 진행해야함.
alter table gallerylist
add (GALMODIFIEDTIME2 date);

desc gallerylist;
-- 1. 기존컬럼의문자타입을 날짜타입으로 변경한 후에 복사 진행 
-- 타입 변경이 안된 상태에서 date 타입의 GALMODIFIEDTIME2 로 복사가 안됨 
update gallerylist
set GALMODIFIEDTIME = to_date(GALMODIFIEDTIME, 'yyyymmddhh24miss');
set GALMODIFIEDTIME = to_date(GALMODIFIEDTIME, 'yyyy-mm-dd hh24:mi:ss');

select substr(galmodifiedtime,0,8) from gallerylist; 
select to_date(substr(galmodifiedtime,0,8),'yyyy-mm-dd') from gallerylist; 

select GALMODIFIEDTIME2 from gallerylist;

-- 2. 컬럼 추가 
alter table gallerylist
add (GALMODIFIEDTIME2 date);

-- 3. 날자 타입에 날짜데이터 추가
update gallerylist
set GALMODIFIEDTIME2 = to_date(GALMODIFIEDTIME, 'yyyy-mm-dd hh24:mi:ss');

-- 4. 기존컬럼삭제 
alter table gallerylist
drop column GALMODIFIEDTIME; 

-- 5. 컬럼이름변경
alter table gallerylist
rename column GALMODIFIEDTIME2 to GALMODIFIEDTIME;

-- 6. 순서변경
alter table gallerylist modify GALPHOTOGRAPHER invisible;
alter table gallerylist modify GALSEARCHKEYWORD invisible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION invisible;

alter table gallerylist modify GALPHOTOGRAPHER visible;
alter table gallerylist modify GALSEARCHKEYWORD visible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION visible;

select * from gallerylist;
desc gallerylist;

select * from gallerylist;

-- galmodifiedtime
-- 날짜포맷으로 변경하시오.

-- 문자타입을 날짜타입으로 변경
select
galmodifiedtime,
to_date(galmodifiedtime,‘yyyy-mm-dd hh24:mi:ss’) from gallerylist;

-- 컬럼추가
alter table gallerylist add (galmodifiedtime2 date);

-- 날짜타입에 날짜데이터추가
update gallerylist
set galmodifiedtime2 = to_date(galmodifiedtime,‘yyyy-mm-dd hh24:mi:ss’);
commit;

-- 기존컬럼삭제
alter table gallerylist drop column galmodifiedtime;

-- 컬럼이름변경
alter table gallerylist rename column galmodifiedtime2 to galmodifiedtime;

desc gallerylist;
-- 컬럼순서변경
-- 컬럼임시숨김
alter table gallerylist modify GALPHOTOGRAPHYLOCATION invisible;
alter table gallerylist modify GALPHOTOGRAPHER invisible;
alter table gallerylist modify GALSEARCHKEYWORD invisible;
-- 컬럼보이기
alter table gallerylist modify GALPHOTOGRAPHYLOCATION visible;
alter table gallerylist modify GALPHOTOGRAPHER visible;
alter table gallerylist modify GALSEARCHKEYWORD visible;

desc gallerylist;

select
substr(galmodifiedtime,0,8) from gallerylist;
select to_date(substr(galmodifiedtime,0,8),‘yyyy-mm-dd’) from gallerylist;

-- 문자열 20,000 / 문자열 11,900 = 8100 으로 출력하시오 
-- 숫자로 변경 후 빼기를 한후 결과값을 출력하시오 '
select to_number('20,000', '999,999') from dual; 
select to_number('11,900', '999,999') from dual; 
select to_number('20,000', '999,999'), to_number('11,900', '999,999') from dual; 
select to_number(20000)-to_number(11900) from dual;
select to_number(20000-11900) from dual;

select to_number('20,000', '99,999'),to_number('11,900', '99,999'), 
to_number('20,000', '99,999')-to_number('11,900', '99,999'),
to_char(to_number('20,000', '99,999')-to_number('11,900', '99,999'),'99,999')
from dual;

select to_char(to_number('20,000', '99,999'), 'L99,999'),
       to_char(to_number('11,900', '99,999'), 'L99,999'),
       -- 아래의 부분에는 원화 표시 불가능. 이유 : ₩, $, ,, 한글, 영어 등 모든 기호와 글자이기에 숫자 타입에는 표시 불가능
       to_number('20,000', '99,999')-to_number('11,900', '99,999'),
       to_char(to_number('20,000', '99,999')-to_number('11,900', '99,999'),'L99,999')
from dual;

-- is null, nvl(comission_pct, 0)
select emp_name, commission_pct from employees;
select emp_name, commission_pct from employees where commission_pct is null;
select nvl(salary*commission_pct,0), salary, nvl(commission_pct,0) from employees;
select salary+salary*nvl(commission_pct,0), salary, nvl(commission_pct,0) from employees;

select manager_id from employees;
select manager_id, nvl(manager_id,0) from employees;
-- CEO라는 문자 입력하고 싶을 때 
-- manager_id : number이기에 문자 타입으로 변경한 후에 ceo 글자 입력하면 됨
-- 이후에는 모든 manager_id는 문자타입으로 변경이 완료
select manager_id, nvl(to_char(manager_id),'ceo') from employees;

-- null
-- commission_pct null 사람이 몇명인지 출력하시오
select emp_name, commission_pct from employees
where commission_pct is null;
-- 그룹함수 : count, avg, max, min, sum, studev(표준편차)
select count(*) from employees
where commission_pct is null;

select * from stuscore;
select avg(kor) from stuscore;
select avg(eng) from stuscore;
select avg(math) from stuscore;

select sum(kor) from stuscore;
select sum(eng) from stuscore;
select sum(math) from stuscore;

select max(kor) from stuscore;
select max(eng) from stuscore;
select max(math) from stuscore;

-- 그룹함수는 일반함수와 같이 쓸수 없음.
-- 무조건 그룹함수와 같이 써야함.
select max(salary), min(salary) from employees;
-- select emp_name, max(salary), min(salary) from employees; 에러 

-- 연봉이 가장 높은 사람의 이름을 출력하시오
-- 이중 쿼리 (select가 2번 사용)
select * from employees 
where salary=(select max(salary) from employees);
select * from employees where salary=24000;

-- 평균월급보다 작게 받는 사원 및 사원수를 출력하시오
select avg(salary) from employees;
select * from employees
where salary < (select avg(salary) from employees);
select count(*) from employees
where salary < (select avg(salary) from employees);

select count(*) from employees;
select count(employee_id) from employees;
-- manager_id가 106인 이유는 null 값이 있기에
select count(employee_id), count(manager_id) from employees;

-- stuscore의 국어점수 최대값, 최소값, 평균, 합계를 구하시오
-- 국어점수 가장 적게 받은 학생을 출력하시오
select * from stuscore;
select max(kor), min(kor), avg(kor),sum(kor) from stuscore;
select min(kor) from stuscore;
select * from stuscore where kor = (select min(kor) from stuscore);

select name || school from stuscore;
select concat(name, school) from stuscore;

-- stuscore에서 m이 포함된 학생 모두 출력하시오
select * from stuscore
where name like '%M%' or name like '%m%';
select * from stuscore
where lower(name) like '%m%';
select count(*) from stuscore
where name like '%M%' or name like '%m%';
select count(*) from stuscore
where lower(name) like '%m%';

select name from stuscore;
-- 3번째에 m 글자가 포함된 학생 출력하시오
select * from stuscore
where name like '__m%';
select count(*) from stuscore
where name like '__m%';

-- lower():소문자, upper():대문자, initcap():첫글자대문자
select email, lower(email), initcap(email) from employees;

-- lpad, rpad
-- 공간을 만들수 있는 함수, 5자리로 만들고 나머지를 #, 0, 빈공백(스페이스바 1개 필요)으로 채워주라는 의미 
select kor, lpad(kor,5,'#')from stuscore;
select kor, lpad(kor,5,'0')from stuscore;
select kor, lpad(kor,5,' ')from stuscore;
select kor, rpad(kor,5,'*')from stuscore;

select * from gallerylist;
select galcontentid from gallerylist;

select galcontentid, length(galcontentid) from gallerylist;
select galcontentid, rpad(galcontentid,9,'*') from gallerylist;
select galcontentid, rpad(substr(galcontentid,0,5),7,'*') from gallerylist;

select * from employees;
-- 이메일 뒤에 2자리를 별표 표시하시오
select email from employees;
select email, length(email)-2 from employees;
select email, 
rpad(substr(email,0,length(email)-2), length(email),'*')  
from employees;

select email from employees;
-- substr 은 1부터 시작. 1번째부터 2개만 잘라와라의 의미 (0,1은 동일하기에 1로 작성)
select email, substr(email,1,2) from employees;

select * from member;
-- 중앙 숫자를 별표로 출력하시오 
select tel from member;
select substr(tel,1,4)||'****'|| substr(tel,8,length(tel)) as marktel
from member; 

-- ltrim, rtrim : 공백 제거, 특정 문자 제거, 앞쪽부터 처리
select '    aaa111' from dual;
select '    aaa111', ltrim('    aaa111') from dual;
select '20261101', ltrim('20261101','2026') from dual;
-- 밖에 있는 0(000)은 제거하나 안에 있는 0(1101)은 제거 하지 않음
-- 0001101	1101 로 출력
select '0001101', ltrim('0001101','0') from dual;
-- 0001101	110100	0001101 로 출력
select '0001101', ltrim('000110100','0'), rtrim ('000110100','0') from dual;

-- 000110100 를 111로 출력 0을 빈 공백으로 출력
select replace('000110100','0','') from dual;

-- length(): 문자열의 길이 출력. 빈 공백 포함해서 출력
select emp_name,length(emp_name) from employees;

-- 데이터 형 : char,varchar2,nvarchar2, blob, clob, Nlong, Bfile
-- varchar2 : 영문은 2바이트, 국문은 3바이트 사용
-- nvarchar2 : 영문이든 국문이든 2바이트 사용. 
-- nvarchar2(4) : 국문이든 영문이든 4글자까지는 사용 가능
-- BFILE : 파일 업로드인 경우 드라이브에 저장한 다음 varchar2로 지정해서 테이블 생성하면 좋음

-- member 
-- 테이블 구조 및 데이터 복사
create table member2 as select * from member;
select * from member2;

-- 테이블 구조만 복사 
create table member3 as select * from member where 1=2;
select * from member3;

-- 구조가 member테이블과 같을 때에는 아래와 같은 명령어로 입력 가능 
insert into member3 select * from member; 
select * from member3;
commit;

desc member;
create table member4 (
mid varchar2(50) not null,
mname varchar2(30) not null,
mgender char(6) 
);

-- 구조가 다르면 하기 코드로 입력 가능
-- 특정 값에 대한 입력이 불가능하나 두 개의 테이블을 join으로 처리 가능
-- 100개 모두 입력
insert into member4 (mid,mname,mgender) select id,name,gender from member;

-- 테이블구조복사, 데이터내용복사
-- 테이블구조복사
-- 테이블 생성 후 데이터복사
-- 컬럼이 다르지만 타입이 같은 테이블의 일부 컬럼을 복사
-- 테이블 일부구조복사, 데이터복사

-- 테이블 일부구조복사, 데이터복사
-- 전체 데이트를 다 보여주지 않고 일부 컬럼만 보여줄 수 있을 때 일부구조복사에 데이터만 복사하게 함
create table member5 as select id,pw,name from member;
select * from member5;
select * from employees;

--drop table member2;
--drop table member3;
--drop table member4;
--drop table member5;
 

CREATE TABLE bookproduct (
    product_id         NUMBER(13,0) PRIMARY KEY, -- 기본키 (9791199244375)
    cover_image_url    VARCHAR2(1000 CHAR),      -- 맨 위 표지 이미지 URL
    title              VARCHAR2(200 CHAR) NOT NULL, -- 책 제목
    subtitle           VARCHAR2(300 CHAR),       -- 책 부제목
    publisher          VARCHAR2(100 CHAR),       -- 출판사
    published_date     DATE,                     --  발행일
    sale_price         NUMBER(9,0),              --판매가
    bookinfo           CLOB,                     -- 책소개
    book_index         CLOB,                     -- 목차
    detail_image_url   VARCHAR2(1000 CHAR),      -- 상세이미지
    writerinfo         CLOB,                     -- 저자 1 소개
    writerinfo2        CLOB,                     -- 저자 2 소개
    creator_comment    CLOB,                     -- 만든 이 코멘트
    into_book          CLOB,                     -- 책 속으로
    publisher_review   CLOB,                     -- 출판사 리뷰
    recommendation     CLOB,                     -- 추천평
    member_reviews     CLOB,                     -- 회원리뷰 6건
    one_line_review    VARCHAR2(2000)            -- 한줄평 4건
);

-- drop table bookproduct;

CREATE TABLE bookproduct (
    product_id         VARCHAR2(13 CHAR) PRIMARY KEY, --  ISBN13이므로 이름을 맞춤: 9791199244375 
    cover_image_url    VARCHAR2(1000 CHAR),           -- 맨 위 표지 이미지 URL
    title              VARCHAR2(200 CHAR) NOT NULL,   -- 책 제목
    subtitle           VARCHAR2(300 CHAR),            -- 책 부제목
    authors            VARCHAR2(200 CHAR),            -- 저자 이름 (신숙옥, 이일하)
    publisher          VARCHAR2(100 CHAR),            -- 출판사
    published_date     DATE,                          -- 발행일
    list_price         NUMBER(9,0),                   -- 정가 (21800)
    sale_price         NUMBER(9,0),                   -- 판매가 (19620)
    stock_qty          NUMBER(6,0),                   -- 재고 수량 (값은 확인 필요)
    item_info          VARCHAR2(200 CHAR),            -- 품목정보 (쪽수, 무게, 크기)
    related_category   VARCHAR2(1000 CHAR),           -- 관련 분류
    bookinfo           CLOB,                          -- 책소개
    book_index         CLOB,                          -- 목차
    detail_image_url   VARCHAR2(1000 CHAR),           -- 상세 이미지 URL
    writerinfo         CLOB,                          -- 저자 1 소개
    writerinfo2        CLOB,                          -- 저자 2 소개
    creator_comment    CLOB,                          -- 만든 이 코멘트
    into_book          CLOB,                          -- 책 속으로
    publisher_review   CLOB,                          -- 출판사 리뷰
    recommendation     CLOB,                          -- 추천평
    member_reviews     CLOB,                          -- 회원리뷰 6건
    one_line_review    VARCHAR2(500 CHAR)             -- 한줄평 4건
);

select * from bookproduct;
SELECT COUNT(*) FROM BOOKPRODUCT;
SELECT MIN(PRODUCT_ID), MAX(PRODUCT_ID)
FROM BOOKPRODUCT;
-- commit;
-- DELETE FROM BOOKPRODUCT WHERE PRODUCT_ID BETWEEN 1 AND 1000;
-- commit;

SELECT COLUMN_NAME, DATA_TYPE, DATA_LENGTH
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'BOOKPRODUCT'
ORDER BY COLUMN_ID;

1. 전체 설정표 (모카루)
번호	Field Name	Type 선택	Options / 설정	blank (%)
1	PRODUCT_ID	Row Number	순번 사용. 1,000행이면 1부터 1000까지	0
2	COVER_IMAGE_URL	Dummy Image URL	가로 최소·최대 240, 세로 최소·최대 360, 이미지 형식 png	0
3	TITLE	Formula	['도시의 책방','초록의 계절','기록하는 하루'].sample	0
4	SUBTITLE	Formula	['삶과 사회를 바라보는 이야기','일상 속에서 찾는 의미','사람과 기억을 기록한 책'].sample	0
5	AUTHORS	Formula	['김서윤','이하준','박서연','정민우','최지안'].sample	0
6	PUBLISHER	Formula	['새봄출판','푸른문장','다온북스','생각의숲'].sample	0
7	PUBLISHED_DATE	Datetime	범위 2020-01-01 ~ 2026-11-23, 날짜 형식 yyyy-mm-dd	0
8	LIST_PRICE	Number	min 20000 / max 30000 / decimals 0	0
9	SALE_PRICE	Number	min 12000 / max 19000 / decimals 0	0
10	STOCK_QTY	Number	min 0 / max 100 / decimals 0	0
11	ITEM_INFO	Formula	['국내도서 / 250쪽 / 무선제본','국내도서 / 320쪽 / 양장본'].sample	0
12	RELATED_CATEGORY	Formula	['소설','에세이','사회','정치'].sample	0
13	BOOKINFO	Formula	['삶과 사회의 관계를 살펴보는 책','사람과 기억을 소재로 한 책'].sample	0
14	BOOK_INDEX	Formula	['프롤로그 / 1장 시작 / 2장 변화 / 에필로그','머리말 / 1부 사람 / 2부 사회 / 맺음말'].sample	0
15	DETAIL_IMAGE_URL	Dummy Image URL	가로 최소·최대 600, 세로 최소·최대 900, 이미지 형식 png	0
16	WRITERINFO	Formula	['사회와 문화를 주제로 글을 쓰는 저자','역사와 인권에 관한 글을 집필하는 작가'].sample	0
17	WRITERINFO2	Formula	['강연과 집필 활동을 이어가고 있음','다양한 분야의 작품을 발표하고 있음'].sample	0
18	CREATOR_COMMENT	Formula	['독자와 함께 생각할 질문을 담았습니다.','일상의 이야기를 나누고자 이 책을 썼습니다.'].sample	0
19	INTO_BOOK	Formula	['삶과 사회의 관계를 살펴보는 도서입니다.','사람과 기억을 소재로 한 도서입니다.'].sample	0
20	PUBLISHER_REVIEW	Formula	['사회와 인간에 관한 내용을 담았습니다.','독자에게 새로운 질문과 생각을 전하는 작품입니다.'].sample	0
21	RECOMMENDATION	Formula	['사회 문제에 관심 있는 독자에게 추천합니다.','삶과 사람의 이야기를 좋아하는 독자에게 추천합니다.'].sample	0
22	MEMBER_REVIEWS	Formula	['내용이 흥미롭고 생각할 부분이 많았습니다.','다양한 관점을 접할 수 있었습니다.'].sample	0
23	ONE_LINE_REVIEW	Formula	['인상적인 책입니다.','추천하고 싶습니다.','다시 읽고 싶습니다.'].sample


CREATE TABLE bookproduct (
    product_id         VARCHAR2(13 CHAR) PRIMARY KEY, -- [수정] isbn13 -> product_id (값은 ISBN13 13자리)
    cover_image_url    VARCHAR2(1000 CHAR),           -- 맨 위 표지 이미지 URL
    title              VARCHAR2(200 CHAR) NOT NULL,   -- 책 제목
    subtitle           VARCHAR2(300 CHAR),            -- 책 부제목
    authors            VARCHAR2(200 CHAR),            -- 저자 이름
    publisher          VARCHAR2(100 CHAR),            -- 출판사
    published_date     DATE,                          -- 발행일
    list_price         NUMBER(9,0),                   -- 정가
    sale_price         NUMBER(9,0),                   -- 판매가
    stock_qty          NUMBER(6,0),                   -- 재고 수량
    item_info          VARCHAR2(200 CHAR),            -- 품목정보 (쪽수, 무게, 크기)
    related_category   VARCHAR2(1000 CHAR),           -- 관련 분류
    bookinfo           CLOB,                          -- 책소개
    book_index         CLOB,                          -- 목차
    detail_image_url   VARCHAR2(1000 CHAR),           -- 상세 이미지 URL
    writerinfo         CLOB,                          -- 저자 1 소개
    writerinfo2        CLOB,                          -- 저자 2 소개
    creator_comment    CLOB,                          -- 만든 이 코멘트
    into_book          CLOB,                          -- 책 속으로
    publisher_review   CLOB,                          -- 출판사 리뷰
    recommendation     CLOB,                          -- 추천평
    member_reviews     CLOB,                          -- 회원리뷰 6건
    one_line_review    VARCHAR2(500 CHAR)             -- 한줄평 4건
);


   



select * from member;
-- 현재 월과 같은 월에 등록된 회원을 출력하시오
select name, mdate from member;
select trunc(sysdate,'mm') from dual;
select to_char(sysdate,'mm') from dual;
select mdate from member 
where to_char(sysdate, 'mm') = to_char(mdate,'mm');

-- 컬럼추가, 수정, 삭제, 타입변경
-- 컬럼추가 
select * from stuscore;
alter table stuscore add sturank number(3);

desc stuscore;

-- 컬럼수정 
-- 컬럼 안에 있는 데이터 확인 후 타입 변경 가능 
-- 컬럼안에 들어가 있는 테이터 타입이 변경이  가능한 형태여야만 타입 변경 가능
alter table stuscore modify(total varchar2(30));
alter table stuscore modify(total number(30));
alter table stuscore modify(total number(5,1));
desc board3;
select * from board3;
update board3 set bstep=null;
commit;
-- 컬럼안 데이터를 null 값으로 변경 후 타입 변경이 가능
alter table board3 modify(bstep varchar2(4));

-- 컬럼삭제
alter table stuscore drop column sturank;
desc stuscore;

-- 컬럼이름변경
alter table stuscore rename column rank to sturank;
alter table stuscore rename column sturank to rank;

desc stuscore;

-- 무결성 제약조건 
-- not null : null 을 허용하지 않음
-- unique : 중복된 값을 허용하지 않음 
-- primary key : null , 중복된 값 모두 허용하지 않음. NOT NULL 조건과 UNIQUE 조건을 합친 함수
-- foreign key : 참고로 
-- check 

create table mem(
id varchar2(50) primary key,
pw varchar2(100) not null, 
name varchar2(20) unique,
gender varchar2(6)check(gender in('남자','여자')), 
mdate date default sysdate,
mfile varchar2(10)
);

alter table mem add age number(5,2) check (age between 0 and 200);

desc mem;
insert into mem values(
'aaa','1111','홍길동','남자',sysdate,'',100 
);

select * from mem;

insert into mem values(
'bbb','2222','홍길자','여자',sysdate,'',100 
); 

insert into mem values(
'ccc','2222','홍길순','여자',sysdate,'',100 
); 
-- 이름이 null 값으로는 입력 가능
insert into mem values(
'ddd','1111','','여자',sysdate,'',100 
); 

select * from mem;
select * from member;

select * from screen;
alter table screen add primary key(sno);
-- sno 컬럼을 삭제하지 않고 primary key를 삭제하는 방법
alter table screen drop constraint SYS_C008393; 
-- screen_pk_sno로 primary key로 등록하겠다는 의미
alter table screen add constraint screen_pk_sno primary key(sno);

select * from mem;
alter table mem drop constraint SYS_C008390; 
alter table mem add constraint mem_pk_id primary key(id);

-- foreign key 등록하려면 우선 다른 테이블에서 primary key 등록이 되어있어야 가능

select * from mem;
select bno from board2 order by bno;
-- 1~20번까지 id 컬럼에 aaa 
-- 21~40번까지 id 컬럼에 bbb
-- 41~60번까지 id 컬럼에 ccc
-- 61~80번까지 id 컬럼에 ddd
-- 81~100번까지 id 컬럼에 eee 로 변경하시오

update board set id='aaa' 
where bno between 1 and 20;

select * from board;
update board set id='bbb' 
where bno between 21 and 40;

update board set id='ccc' 
where bno between 41 and 60;

update board set id='ddd' 
where bno between 61 and 80;

update board set id='eee' 
where bno between 81 and 100;
commit; 
select * from board order by bno;

-- foreign key 변경 설정 
-- mem 에 있는 primary key를 foreign key로 변경 설정할 때
-- 데이터 구조가 동일해야만 변경 설정이 가능함
alter table board
add constraint board_fk_id foreign key(id)
references mem(id) ; 

select * from mem;
insert into mem values(
'eee','1111','','여자',sysdate,'',100 
);

select * from board;
insert into board values(
101,'aaa','게시글 제목','게시글내용',101,0,0,0,sysdate,''
);
insert into board values(
101,'abc','게시글 제목','게시글내용',101,0,0,0,sysdate,''
);
select * from mem;
select * from board;
select * from board2;
create table member2 as select * from member;
drop table member2;
drop table mem;



