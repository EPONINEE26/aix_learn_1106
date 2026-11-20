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









