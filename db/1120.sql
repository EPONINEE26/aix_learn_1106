--drop table board;
--drop table board2;
--drop table stuscore;

create table board(
bno number(4) primary key,  -- 기본이 24자리
id varchar2(50) not null,
btitle varchar2(1000),
bcontent clob,
bgroup number(4) default 0,
bstep number(4) default 0,
bindent number(4) default 0,
bhit number(4) default 0,
bdate date,
bfile varchar2(100)
);

select * from employees;
-- nextval : 1씩 증가 
-- currval : 현재 시퀀스 번호가 몇 번인지 알려줌. 현제 번호 확인
select board_seq.nextval from dual;
select board_seq.currval from dual;
select * from board;
insert into board values(
board_seq.nextval, 'aaa',' 게시글제목','게시글내용',
board_seq.currval,0,0,0,sysdate,'1.jpg'
);

insert into board (bno,id,btitle,bcontent,bgroup,bfile) values(
board_seq.nextval, 'aaa',' 게시글제목','게시글내용',
board_seq.currval,'2.jpg'
);

select * from board;
-- drop table board;

create table board(
bno number(4) primary key,
id varchar2(50) not null,
btitle varchar2(1000),
bcontent clob,
bgroup number(4),
bstep number(4) default 0,
bindent number(4) default 0,
bhit number(4) default 0,
bdate date default sysdate,
bfile varchar2(100)
);
-- 정보를 입력한 다음에는 파일 업로드가 안 되니, 무조건 안에 있는 정보가 아무 것도 없는지 먼저 확인 후 파일을 업로드 해야함.
rollback; 
select * from board;

create table board2 as select * from board;
create table board3 as select * from board where 1=2;

create table stuscore (
no	number(4) primary key, 
name varchar2(100),
school	varchar2(50),
rank number(4),
height number(5,1),  -- 키에 소수점이 생길 수 있기에 5,1 로 지정하는편이 좋음
kor	number(5),
eng	number(5),
math number(5),
specialty varchar2(20),
total number(5),
avg number(5,2)
); 
--  아래와 같이 쓰면 합계와 평균 값이 없어도 NULL로는 출력이 안됨. 
--  NVL(TO_CHAR(total), ' ') AS total, NVL(TO_CHAR(avg), ' ') AS avg
-- 테이블을 만들때 미리 계산식을 포함하면 계산된 숫자가 합계, 평균자리에 들어감 GENERATED ALWAYS AS " 항상 이 계산식대로 자동 생성된다 라는 의미
--  total number(5) GENERATED ALWAYS AS (kor + eng + math) VIRTUAL,
-- avg number(5,2) GENERATED ALWAYS AS (ROUND((kor + eng + math) / 3, 2)) VIRTUAL
-- 처음 테이블을 생성할 떼  total number(5), avg number(5,2)지정을 한 다음 파일 임포트 후에 update로 수정하면 계산이 되어 숫자가 입력됨
-- UPDATE stuscore 
-- SET total = kor + eng + math, avg = ROUND((kor + eng + math) / 3, 2);
-- 계산이 완료되면 commit;을 꼭 한다.


-- 테이블 생성 때 컬럼은 영어로 지정하는 것이 좋음. 추후에 에러가 발생할 가능성이 있기에. 
create table students (
번호	number(4) primary key, 
이름 varchar2(100),
학교	varchar2(50),
학년 number(4),
키 number(5,1), 
국어	number(5),
영어	number(5),
수학 number(5),	
SW특기 varchar2(20),
합계 number(5),
평균 number(5,2)
);

create table gallary (
no number(4) primary key,
galContentId number(20),	
galContentTypeId number(4), 	
galTitle varchar2(50),	
galWebImageUrl varchar2(100),
galCreatedtime	number(30),
galModifiedtime	number(30),
galPhotographyMonth	 number(10),
galPhotographyLocation	varchar2(50),
galPhotographer	varchar2(10),
galSearchKeyword varchar2(1000)
);

alter table gallary add primary key (no);
-- drop table gallary; 



-- gallerylist 로 샤로 생성 
create table gallerylist (
    gno number(12) primary key,
    galContentId varchar2(8) not null,
    galContentTypeId varchar2(10),
    galTitle varchar2(100),
    galWebImageUrl varchar2(100),
    galCreatedtime varchar2(100),
    galModifiedtime varchar2(100),
    galPhotographyMonth varchar2(30),
    galPhotographyLocation varchar2(100),
    galPhotographer varchar2(100),
    galSearchKeyword varchar2(1000)
);

select * from stuscore;
-- order by asc, desc
select * from stuscore order by rank;
select * from stuscore order by rank, height asc;
select * from stuscore order by rank, height asc, kor desc;

-- 숫자함수
-- abs (): 절대값 
-- round (): 반올림 
-- floor (): 버림
-- ceil (): 올림
-- trunc (): 자르기 
select abs(-10) from dual;
select 100/3 from dual;
select 100/6 from dual;
-- round : 소수점 몇 개까지 출력할지 지정 가능 
select round(100/6,2) from dual;
-- round (1978,-1) : 몇 뒤 첫째자리에서 반올림
select round(1978,-1) from dual;

-- floor, ceil : 소수점 첫째자리에서 계산. 정수로 출력
select floor(100/6) from dual;
select ceil(100/3) from dual;
select * from stuscore;
select round(kor,-1) from stuscore;
-- trunc : 뒤 자리를 자름. 
select kor, round(kor,-1),trunc(kor,-1) from stuscore;

select bdate from board;
-- select trunc(bdate,1)from board; -- 타입 에러, 타입을 변경해서 출력해야함.

select mod(23,2)from dual;
-- stuscore 홀수 학생만 출력하시오
select * from stuscore where no >=10;
select * from stuscore where mod(no,2)=1;
select * from stuscore where rank=1 or rank=3;
select * from stuscore where rank in(1,3);

-- 타입형 변환
-- 타입 : number, varchar, char, clob, date
-- date : +-*/ 가능 
select sysdate from dual;
select sysdate-1,sysdate, sysdate+1 from dual;
-- 시스템 상 1년 후의 메일 발송이 가능
select sysdate-365,sysdate, sysdate+365 from dual;
select sysdate-365,sysdate,last_day(sysdate+365) from dual;

select * from member;
select mdate as 가입일 from member;
select mdate as 가입일, sysdate-mdate as 현재까지기간 from member;
-- 명령어는 조합해서 사용 가능
select mdate as 가입일, round(sysdate-mdate, 2) from member;
select mdate as 가입일, round(sysdate-mdate, 2) as 현재까지기간 from member;
-- mdate를 문자열로 변환하라는 의미
-- 형태는 마음대로 변경 가능
-- 작은 따옴표로 사용해야함 
select mdate, to_char from member;
select mdate, to_char(mdate, 'yyyy/mm/dd') from member;
select mdate, to_char(mdate, 'yyyy:mm:dd') from member;
-- 월에 대한 반올림 
select round(mdate,'month') from member;
--select round(mdate,'month','day') from member;
select round(mdate,'year') from member;
-- 날짜 형태
select mdate, to_char(mdate, 'yyyy-mm-dd hh:mi:ss') from member;
select * from board3;

select bdate, to_char(bdate, 'yyyy-mm-dd hh:mi:ss') from board3;
insert into board3 values (
1, 'aaa','게시글제목','게시글내용',1,0,0,0,sysdate,'1.jpg'
);
select * from board3;

-- 날짜 : 숫자함수 - round, trunc
select mdate from member;
select mdate, trunc (mdate,'dd'), round(mdate,'mm') from member;
-- 마지막 날짜, 첫번째 날짜, 반올림 날짜
-- 월기준 : month, mon, mm (trunc mm, year 가 기준)
-- 년기준 : year, yyyy 
select mdate, last_day(mdate), trunc (mdate,'mm'), round(mdate,'mm') from member;
select mdate, last_day(mdate), trunc (mdate,'month'), round(mdate,'month') from member;
select mdate, last_day(mdate), trunc (mdate,'year'), round(mdate,'mm') from member;
select mdate, last_day(mdate), trunc (mdate,'year'), round(mdate,'year') from member;

select bdate, to_char(bdate, 'yyyy-mm-dd hh:mi:ss') from board3;
-- 24시간 기준으로 출력. 13시, 20시... 이렇게 출력
select bdate, to_char(bdate, 'yyyy-mm-dd hh24:mi:ss') from board3;
select mdate, trunc(mdate, 'year') from member;
-- 요일 기준 
select mdate,trunc(mdate,'day') from member;
-- 20일 기준으로 맨 앞쪽 날짜로 출력, 그래서 15일로 출력 
-- trunc : 해당기간 일요일 날짜로 변경
-- round : 수용일 기준으로 반올림
-- hh,mi,ss 기준으로 trunc,round 사용 
select sysdate, trunc(sysdate,'day') from dual;
select sysdate, trunc(sysdate,'day'), round(sysdate,'day') from dual;
-- 간격 (months_between)
select months_between(sysdate, mdate) from member;
select mdate, sysdate,months_between(sysdate, mdate) from member;
select mdate, sysdate from member where months_between(sysdate,mdate)>=12;
select mdate, sysdate, round(months_between(sysdate,mdate)) from member 
where months_between(sysdate,mdate)>=12;
select mdate, sysdate, round(months_between(sysdate,mdate)) from member 
where months_between(sysdate,mdate)<=6;

-- add months : 개월 추가 
select mdate, add_months(mdate,3) from member;
select mdate, add_months(mdate,12) from member;
-- 1년 후 첫째일 출력하고 마지막 일을 출력하시오 
select mdate, add_months(mdate,12), trunc(add_months(mdate,12),'mm'), last_day(add_months(mdate,12))
from member; 
-- 금요일이면 이전 일요일날짜로 이동하라는 의미
select trunc(sysdate,'day') from dual;
-- 금요일이면 수요일 기준으로 다음 일요일로 이동하라는 의미
select round(sysdate,'day') from dual;

select trunc(sysdate,'day'), sysdate, round(sysdate,'day') from dual;
select next_day(sysdate, '금요일') from dual;
-- 다가오는 요일의 날자를 리턴 
select next_day(sysdate, '토요일') from dual;
-- 일요일마다 행사가 있어요. 다음번 일요일은 언제일까요? 
select next_day(sysdate, '금요일') from dual;
-- 다다음주 일요일은 언제일까요? 
select next_day(next_day(sysdate, '일요일'),'일요일')from dual;
-- 날짜와 날짜의 사이 계산
-- 날짜 계산에는 +, - 가 가능
select (sysdate-(sysdate-1)) from dual;
select sysdate-mdate from member;

--trunc(): 1일자를 알려줌
-- round(): 15일 기준으로 이전이면 1일 이후이면 다음달 1일을 출력함
-- last_day(): 마지막 날짜를 알려줌 
-- 형 변환
-- to_number, to_char, to_date 
-- 문자열끼리는 더하기 가능 
select '2026-11-20' from dual;
select to_date('2026-11-20') from dual; -- 날짜 타입으로 변환
select to_date('2026-11-20')+1 from dual; -- 날짜 타입으로 변환되었기에 더하기 빼기 기능 가능 
select to_date('20261120')from dual;
select to_date('20261120')+1 from dual;
select * from GALLARY;
select to_date(galcreatedtime) from gallary;
select to_date(galcreatedtime, 'yyyymmddhh24miss') 
from gallary 
where galcreatedtime > 0;
select galcreatedtime from gallary;

-- sub함수
-- 'abcdef'[0:2]
select substr(galcreatedtime,0,3) from gallary;
-- 3번째에서 2개만 출력하라는 의미
select substr('abcdefg',3,2) from dual;

select galcreatedtime from gallary;
select substr (galcreatedtime,1,8) from gallary;
select to_date(substr(galcreatedtime, 1,8)) from gallary;

-- substr함수를 사용해서 날짜부분만 추출후 날짜타입으로 변경
-- 그달의 1일을 출력하시오
select * from gallary;
select trunc (to_date(substr(galcreatedtime, 1,8)), 'month') from gallary;
select last_day (to_date(substr(galcreatedtime, 1,8)), 'month') from gallary;

select bdate from board3;
-- 2026년 11월 20일 12시 34분 12초로 출력하시오
select bdate, to_char(bdate, 'yyyy"년"-mm"월"-dd"일" hh24"시":mi"분":ss"초"') from board3;

select * from board3;
insert into board3 values(
2, '0aaa','222게시글','222내용',2,0,0,0,sysdate,'2.jpg'
);
commit;
--- yyyy/mm/dd hh24:mi:ss day 출력하시오
select * from board3;
select bdate from board3;
select to_char(bdate,'yyyy/mm/dd hh24:mi:ss day') from board3;

select * from member;
select to_char(mdate, 'yyyy-mm-dd')from member;
select to_char(mdate, 'mm')from member;
-- 가입일이 7월일 사람만 출력하시오
select mdate from member where to_char(mdate, 'mm') = '07';

-- 1900년대 입사한 사람을 출력하시오.
-- 2000년대 입사한 사람을 출력하시오.
select hire_date from employees;
select emp_name,hire_date,to_char(hire_date,'yyyy') from employees
where substr(to_char(hire_date,'yyyy'),0,2)='20';
select emp_name,hire_date,to_char(hire_date,'yyyy') from employees
where substr(to_char(hire_date,'yyyy'),0,2)='19';

select trunc(sysdate,'year') from dual;

-- kor 점수가 40점대(40~49점), 60점대(60~69점), 80점대(80~89점)인 사람 출력하시오
select * from stuscore;
select kor from stuscore;
select name, kor from stuscore 
where (kor between 40 and 49) 
or (kor between 60 and 69) 
or (kor between 80 and 89);
select name, kor from stuscore where trunc(kor, -1) in (40, 60, 80);
select name, kor from stuscore 
where trunc(kor, -1)=40 or trunc(kor, -1)= 60 or trunc(kor, -1)=80; 
select name, kor from stuscore 
where (kor>=40 and kor<=49) or (kor>=60 and kor<=69) or (kor>=80 and kor<=89);

-- 시간
select bdate, to_char(bdate,'yyyy-mm-dd hh:mi:ss day') from board3;
-- 오전, 오후 
select bdate, to_char(bdate,'yyyy-mm-dd am hh') from board3;
select bdate, to_char(bdate,'yyyy-mm-dd pm hh') from board3;

-- 날짜 타입 -> 문자 타입 / 날짜 형태를 변경해서 출력
-- 숫자 타입 -> 문자 타입 
-- 자릿수 '999,999,999,999' : 자리가 있으면 자리에 있는 숫자 출력, 없으면 빈 공백으로 출력
-- 자리수 '000,000,000,000' : 자리가 있으면 자리에 있는 숫자 출력, 없으면 0으로 채워줌 
-- 자리수 L : 원화표시, $ : 달러표시, 일본어버젼은 엔화표시

select * from kor_loan_status;
select salary*1425 from employees;
select salary*1425*12 as ysalary from employees;
select to_char(salary*1425*12) as ysalary from employees;
select to_char(salary*1425*12*10, '999,999,999,999') as ysalary from employees;
-- 빈자리는 0으로 채워져서 출력
select to_char(salary*1425*12*10, '009,999,999,999') as ysalary from employees;
select to_char(salary*1425*12*10, '$009,999,999,999') as ysalary from employees;
select to_char(salary*1425*12*10, 'L009,999,999,999') as ysalary from employees;

-- loan_jan_amt * 10000000 천만단위임 
-- 천만원을 곱해서 자리수를 표시하시오
select * from kor_loan_status;
select to_char(salary*1425*12*10, '999,999,999,999') as ysalary from employees;
select loan_jan_amt*10000000 from kor_loan_status;
select to_char(loan_jan_amt*10000000,'L999,999,999,999,999') from kor_loan_status;

-- number -> to_char() : 숫자형태를 문자형태로 변환, 천단위 및 원화표시 가능
-- date -> to_char() : 날짜형태를 문자형태로 변환
-- number -> to_date : 숫자형태를 날짜형태로 변환
select 20261120 from dual;
select to_date(20261120,'yyyy-mm-dd') from dual;
select to_date(20261120,'yyyymmdd') from dual;
select * from gallary;
-- galphotographmonth 를 날짜타입으로 변경하시오
select galPhotographyMonth from gallary;
select to_date(galPhotographyMonth,'yyyymm') from gallary;
select to_date(galPhotographyMonth,'yyyy-mm') from gallary

desc gallary;
select * from gallary;

-- 컬럼삭제 : 컬럼삭제는 복사를 완료 한 다음 처리해야함. 안 그러면 모든 정보가 다 사라지기에 무조건 복사 후에 처리해아힘.
-- 컬럼이 이미 존재하기에 변경이 불가하여 먼저 타입 변경할 컬럼을 삭제한 다음 컬럼을 생성하여 변경해야함
alter table gallary
drop column galphotographymonth;

-- 컬럼추가
alter table gallary
add (galphotographymonth2 date);

-- 컬럼이름 변경
alter table gallary
rename column galphotographymonth2 to galphotographymonth;

-- 컬럼순서 변경
alter table gallary modify GALPHOTOGRAPHER invisible;
alter table gallary modify GALSEARCHKEYWORD invisible;
alter table gallary modify GALPHOTOGRAPHER visible;
alter table gallary modify GALSEARCHKEYWORD visible;

desc gallary;

-- galphtographymonth : varchar 타입이었음
-- 날짜타입으로 변경하려니 데이터가 변경하려는 타입과 형태가 다름으로 나옴 

-- gallerylist 로  새롭게 생성
create table gallerylist (
    gno number(12) primary key,
    galContentId varchar2(8) not null,
    galContentTypeId varchar2(10),
    galTitle varchar2(100),
    galWebImageUrl varchar2(100),
    galCreatedtime varchar2(100),
    galModifiedtime varchar2(100),
    galPhotographyMonth varchar2(10),
    galPhotographyLocation varchar2(100),
    galPhotographer varchar2(100),
    galSearchKeyword varchar2(1000)
);
--drop table gallerylist;

select galPhotographyMonth from gallerylist;
select to_date(galPhotographyMonth, 'yyyy-mm') from gallerylist;
update gallerylist set
galPhotographyMonth=to_date(galPhotographyMonth, 'yyyy-mm');

commit;

-- 테이블 생성 할 때 타입을 잘 못 입력하여 변경해야하는 상황에 처리 방법
1. 새로운 컬럼 생성 
alter table gallerylist 
add (galPhotograpyMonth2, date);

2. 컬럼복사 
update gallerylist
set galPhotograpyMonth2=galPhotograpyMonth; 

3. 컬럼 삭제 
alter table gallerylist
drop coloumns galPhotograpyMonth; 

4. 이름 변경 
alter table gallerylist
rename columns galPhotograpyMonth2 to galPhotograpyMonth; 

5. 컬럼 확인 
desc gallerylist;

-- 아직 varchar2 타입
-- 새로운 컬럼 추가 
alter table gallerylist
add (GALPHOTOGRAPHYMONTH2 date);

-- 자료를 GALPHOTOGRAPHYMONTH2로 복사 
update gallerylist
set GALPHOTOGRAPHYMONTH2=GALPHOTOGRAPHYMONTH;

-- GALPHOTOGRAPHYMONTH 삭제 
alter table gallerylist
drop column galphotographymonth;

-- 이름 변경 
alter table gallerylist
rename column GALPHOTOGRAPHYMONTH2 to GALPHOTOGRAPHYMONTH;

-- 순서변경 
alter table gallerylist modify GALPHOTOGRAPHER invisible;
alter table gallerylist modify GALSEARCHKEYWORD invisible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION invisible;
alter table gallerylist modify GALPHOTOGRAPHYMONTH invisible;

alter table gallerylist modify GALPHOTOGRAPHER visible;
alter table gallerylist modify GALSEARCHKEYWORD visible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION invisible;
alter table gallerylist modify GALPHOTOGRAPHYMONTH invisible;

desc gallerylist;

select * from gallerylist;

-- 날짜 타입으로 변경하시오 
select to_date (galcreatedtime, 'yyyymmddhh24miss') from gallerylist;

alter table gallerylist
add (GALCREATEDTIME2 date);

update gallerylist
set GALCREATEDTIME2 = to_date(substr(GALCREATEDTIME, 1, 8), 'yyyymmdd');

select GALCREATEDTIME, GALCREATEDTIME2 from gallerylist;

alter table gallerylist
drop column GALCREATEDTIME;

alter table gallerylist
rename column GALCREATEDTIME2 to GALCREATEDTIME;
desc gallerylist;

alter table gallerylist modify GALPHOTOGRAPHER invisible;
alter table gallerylist modify GALSEARCHKEYWORD invisible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION invisible;
alter table gallerylist modify GALPHOTOGRAPHYMONTH invisible;

alter table gallerylist modify GALPHOTOGRAPHER visible;
alter table gallerylist modify GALSEARCHKEYWORD visible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION invisible;
alter table gallerylist modify GALPHOTOGRAPHYMONTH invisible;

desc gallerylist;

select * from gallerylist;

select '20261120' from dual;
select '20261120',sysdate-to_date('20251120') from dual;
select '20261120',sysdate-to_date('20260101') from dual;







