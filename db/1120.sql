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
