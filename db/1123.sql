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

select emp_name,length(emp_name) from employees;

select email, substr(email,1,2) from employees;
