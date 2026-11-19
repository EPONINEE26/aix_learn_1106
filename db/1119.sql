create table stuscore (
    no number(4),
    name varchar2(50),
    school varchar2(100),
    rank number(1),
    height number(4,1),
    kor number(4,1),
    eng number(4,1),
    math number(4,1),
    total number(4,1),
    avg number(5,2),
    specialty varchar2(50)
);

select * from stuscore;

select * from stuscore order by height; -- asc 가 빠져있는 것임. 순차정렬
select * from stuscore order by height desc;
-- 1차 키, 키가 같을 경우 2차 국어점수, 3차 영어점수로 정렬
select * from stuscore order by height desc, kor desc, eng asc; 
-- 1차 키, 키가 같을 경우 2차 영어점수, 3차 국어점수로 정렬
select * from stuscore order by height desc, eng asc, kor desc; 

select * from stuscore;
-- 이름 순으로 역순정렬
select name from stuscore order by name desc;
-- 학교 순으로 순차정렬, 같을 경우 학년으로 역순정렬
select school from stuscore order by school, rank desc;

-- employees 테이블에서 입사일 기준으로 순처정렬하고, 
-- 출력은 사원번호, 사원명, 직급, 입사일 컬럼으로 출력
select * from employees;
desc employees;
select employee_id, emp_name, job_id, hire_date from employees 
order by hire_date asc; 

-- 사원번호,부서, 입사일을 출력하되 
-- 정렬은 부서 순차정렬, 입사일 역순정렬하시오
select * from employees;
select employee_id, department_id, hire_date from employees
order by department_id asc, hire_date desc;

-- dual : 임시 테이블, 가상 테이블 
select -1 from dual;
select 'aaa' from dual; -- 뒤에 테이블이 없을 경우 에러가 나기에 가상테이블 생성하는 것임
select (-1*3) from dual;
select (-1*3+100-100) from dual;

select -123 from dual;
-- abs : 절대값
select abs(-123) from dual;
-- round : 반올림
-- round (값, 자리수) 12.34567,3 : 3째 자리에서 반올림 하라는 의미
select round(12.34567,3) from dual;
-- 
select kor,eng,math from stuscore;
select kor,eng,math,(kor+eng+math)/3 from stuscore;
-- 별칭을 지정해야 그 이름으로 출력되고 그렇지 않을 경우 모든 글자가 다 출력
select kor,eng,math,kor+eng+math as total,(kor+eng+math)/3 as avg from stuscore;
select kor,eng,math,kor+eng+math total,(kor+eng+math)/3 avg from stuscore;
-- 평균을 소수점 2자리에서 반올림해서 출력하시오
select kor,eng,math,kor+eng+math total,round((kor+eng+math)/3,2) avg from stuscore;
-- round (값, 자리수) 
select round((kor+eng+math)/3,2)from stuscore;
-- floor : 소수점 버림 
select floor((kor+eng+math)/3)from stuscore;
-- ceil : 소수점 올림 
select ceil((kor+eng+math)/3)from stuscore;
-- trunc : 버림(특정자리수 버림)
select (kor+eng+math)/3, trunc((kor+eng+math)/3,3) from stuscore;
-- 나머지
select mod(3,2) from dual;

select kor from stuscore;
-- 반올림이 있을 경우의 점수 
select kor, round(kor,-1)from stuscore;
-- 버림이 있을 경우의 점수
select kor, round(kor,-1),trunc (kor,-1) from stuscore;

-- 1915, 1819,1719 .... 몇 년 태생인지 알고 싶음
-- 1900 년대, 1800년대, 1700년대 로 출력하시오
select 1915,1819,1719 from dual;
select 
    1915, 1819, 1719,
    round(1915, -1), round(1819, -1), round(1719, -1),
    trunc(1915, -1), trunc(1819, -1), trunc(1719, -1)
from dual;
select trunc (1915,-2),trunc (1819,-2),trunc (1719,-2) from dual; 

-- 사원번호 홀수인 사원을 출력하시오
-- 역순정렬 출력하시오 
select * from employees;
select mod(3,2) from dual;
select employee_id from employees where mod(employee_id,2)=1 
order by employee_id desc;

-- stuscore 평균값이 80점 이상인 학생을 출력하시오
select * from stuscore;
select kor+eng+math)/3 avg from stuscore;
select kor,eng,math,kor+eng+math total,(kor+eng+math)/3 avg from stuscore;
select (kor+eng+math)/3 from stuscore where (kor+eng+math)/3 >=80;
select kor,eng,math,(kor+eng+math) total,(kor+eng+math)/3 avg  from stuscore 
where (kor+eng+math)/3>=80 order by (kor+eng+math)/3 desc;

-- stuscore no 가 짝수인 학생을 출력하시오
select * from stuscore;
select * from stuscore where mod(no,2)=0;
select * from stuscore where mod(no,1)=0;

select * from stuscore;
select * from board;
-- 시퀀스 : 번호가 자동으로 증가되는 프로그램 (자동번호발생기). 1씩 증가 
-- 뒤로 돌리는 기능은 없음
select board_seq.nextval from dual;
-- 현재 번호 출력
select board_seq.currval from dual; 
-- 시퀀스 생성
select board2_seq.nextval from dual;
select stuscore2_seq.currval from dual;

create sequence board2_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache;

-- 테이블 복사 : as select * from stuscore;
-- 테이블 복사와 함께 데이터 복사를 함께 실행
create table stuscore2 as select * from stuscore;
-- 테이블 구조만 복사 실행 (형태만 생성)
create table stuscore3 as select * from stuscore where 1=2;
select * from stuscore3;

insert into stuscore3 values (
board_seq.nextval,'홍길동','신림고',1,190,100,100,99,(100+100+99), (100+100+99)/3,
'python'
);
select * from stuscore3;
delete stuscore3;
commit;

-- stuscore2 시퀸스를 101부터 시작 (stuscore_seq를 만들어서 진행함. 다음번호로 101로 지정)
-- stuscore2 홍길동 학생성적을 입력하기
insert into stuscore2 values(
stuscore2_seq.nextval,'홍길동','신림고',1,190,100,100,99,(100+100+99),(100+100+99)/3,
'python'
);
commit;
insert into stuscore2 values(
stuscore2_seq.nextval,'홍길동','신림고',1,190,100,100,99,(229),(229)/3,
'python');
select * from stuscore2;
-- select * from stuscore2 where no = 13;
-- select * from stuscore2 where no = 13 and name = '홍길동';
-- delete from stuscore2 where no = 14 and name = '홍길동';
select * from stuscore2;
select board_seq.nextval from dual;

-- sql 기본 : select, insert, update, delete
-- 게시판리스트 : select
-- 게시글입력 : insert into
-- 게시글수정 : update
-- 게시글삭제 : delete 

-- select * from stuscore2;
-- select * from stuscore2 where no = 100 and name = '홍길동';
-- delete from stuscore2 where no = 100 and name = '홍길동';
-- commit;


-- sql기본 select,insert,update,delete
-- 게시판리스트 : select   select * from stuscore
-- 게시글입력 : insert     insert into stuscore values (    )
-- 게시글수정 : update     update stuscore set name = '홍길자' where no=1
-- 게시글삭제 : delete     delete stuscore where no=1

select * from stuscore2;
select board_seq.currval from dual;
-- 101
insert into stuscore2 values(
 stuscore_seq.nextval, '홍길동','신림고',1,190,100,100,90,290,290/3,'python'
);
insert into stuscore2 values(
 stuscore_seq.nextval, '유관순','신림고',1,170,90,90,91,271,271/3,'c'
);
commit;

-- select * from stuscore2;
-- delete stuscore2 where no=37;
-- update stuscore2 set name = '유관자' where no=102;

-- board 그대로 구조, 데이터 모두 복사해서 board2
-- 시퀸스 board2 생성해서 시작 101부터 
-- 1개의 게시글 입력해서 출력하시오

create table board2 as select * from board;

create sequence board2_seq
increment by 1
start with 101
minvalue 1
maxvalue 999999
nocycle
nocache;

select * from board2;
-- insert 입력컬럼을 선택을 안하려면, 모든 컬럼의 값을 입력해야 함.
insert into board2 (bno,id,btitle,bcontent,bgroup,bfile) values(
board2_seq.nextval,'aaa','게시글제목','게시글 내용입니다.',
board2_seq.currval,'1.jpg'
);
commit;


-- 속성 : default 0 
-- board2 를 클릭하여 왼쪽편 연필모양을 클릭하면 수정할수 있는 화면이 팝업이 됨.
-- 그 안에서 null 값인 bindent 와 bhit를 클릭하여 0으로 변경할 수있음 
desc board2;
alter table board2 modify(bstep default 0

insert into board2(bno,id,btitle,bcontent,bgroup,bfile) values(
board2_seq.nextval,'aaa','제목','내용',
board2_seq.currval,'1.jpg'
);

-- 속성 : default 0
desc board2;
alter table board2 modify(bstep default 0);

insert into board2(bno,id,btitle,bcontent,bgroup,bfile) values(
board2_seq.nextval,'aaa','제목','내용',
board2_seq.currval,'1.jpg'
);
select * from board2;

-- bno primary key 등록
alter table board2 add primary key (bno);

desc board2;

-- bno을 primary key로 등록하고 싶음
-- primary key 로 등록을 하면 다른 곳에서 foreign key로 등록 가능. 그렇지 않음 등록 불가
alter table board2 add primary key (bno);
desc board2;











