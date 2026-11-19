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






