select * from stuscore;

-- 오라클 if 절 조건에 따라 실행할 수 있는 형태
-- decode : 정확히 일치할 때 실행 
-- case : 크거나 작거나 또는 정확히 일치할 때 실행 (범위가 확장됨)

select emp_name, department_id, 
decode (department_id,10,'10번입니다.',
20,'20번입니다.',
30,'30번입니다.') as did from employees;

select * from stuscore;

-- 10번대 월급을 1,2% 인상
-- 20번대 월급을 1.0% 유지
-- 30번대 월급을 2% 인상
-- 40번대 월급을 2.5% 인상
-- 50번대 월급을 1.8% 인상 을 출력하시오
select department_id from employees
where department_id<=50;

select department_id, salary,
decode(department_id,10,salary*1.2,
20,salary*1.0,
30,salary*2.0,
40,salary*2.5,
50,salary*1.8) as new_salary 
from employees;

-- case : 10번, 20번...이런 식으로 입력해야하는 것이 줄여주는 기능이 있음
select department_id, salary,
case 
when department_id<=50 then '근무장소이동:A동'
when department_id>=50 then '근무장소이동:B동'
end as move_department
from employees;

select department_id, salary,
case 
when department_id<=50 then salary*1.5
when department_id>=50 then salary*2.5
end as salary_department
from employees;

select * from stuscore;
-- (kor+eng+math)/3 이 90점 이상이면 A
-- (kor+eng+math)/3 이 80점 이상이면 B
-- (kor+eng+math)/3 이 70점 이상이면 C
-- (kor+eng+math)/3 이 60점 이상이면 D
-- (kor+eng+math)/3 이 60점 이하이면 F
select (kor+eng+math)/3, avg,
case 
when (kor+eng+math)/3 >=90 then 'A학점'
when (kor+eng+math)/3 >=80 then 'B학점'
when (kor+eng+math)/3 >=70 then 'C학점'
when (kor+eng+math)/3 >=60 then 'D학점'
when (kor+eng+math)/3 <=60 then 'F학점'
end as stuscore_rank
from stuscore;

select round((kor+eng+math)/3,2), avg,
case 
when (kor+eng+math)/3 >=90 then 'A학점'
when (kor+eng+math)/3 >=80 then 'B학점'
when (kor+eng+math)/3 >=70 then 'C학점'
when (kor+eng+math)/3 >=60 then 'D학점'
when (kor+eng+math)/3 < 60 then 'F학점'
end as stuscore_rank
from stuscore;

select * from stuscore;
-- 타입이 number이기에 글자 입력이 안됨 
update stusocre set rank = (
case
when (kor+eng+math)/3 >=90 then 'A'
when (kor+eng+math)/3 >=80 then 'B'
when (kor+eng+math)/3 >=70 then 'C'
when (kor+eng+math)/3 >=60 then 'D'
else 'F'
);

desc stuscore;

select rank from stuscore;
-- rank에 값이 들어가 있으면 그 값을 null 값으로 변경한 다음 실행하면 실행 가능
update stuscore set rank = null;
alter table stuscore modify rank varchar2(2);

update stuscore set rank = (
case
when (kor+eng+math)/3>=90 then 'A'
when (kor+eng+math)/3>=80 then 'B'
when (kor+eng+math)/3>=70 then 'C'
when (kor+eng+math)/3>=60 then 'D'
else 'F'
end 
);

create table stuscore2 as select * from stuscore;
delete stuscore2;
commit;

insert into stuscore select * from stuscore2;
select * from stuscore;

desc stuscore2;
select * from stuscore2;
insert into stuscore2 values(
1,'홍길동','신림고','',178,100,100,99,'C',100+100+99,(100+100+99)/3
);

-- employees 5000이하는 20% 증가, 8000이하는 10%증가, 8000초과는 5% 증가 출력하시오
select salary from employees;
select salary, 
case
when salary <=50000 then salary*20
when salary <=80000 then salary*10
when salary > 80000 then salary*5
end salary from employees;

select * from stuscore;
-- 1~17번 : 1반
-- 18~50번 : 2반 
-- 51~77번 : 3반
-- 그외 4반 
-- grade

desc stuscore;
select no,
case 
when no>=1 and no<=17 then '1반'
when no>=18 and no<=50 then '2반'
when no>=51 and no<=77 then '3반'
else '4반'
end grade from stuscore;


select no,
case 
when no between 1 and 17 then '1반'
when no between 18 and 50 then '2반'
when no between 51 and 77 then '3반'
else '4반'
end grade from stuscore;

-- count, sum, max, min, avg, studev(표준편차), variance(분산)
select count(*) from stuscore;

-- employees 월급의 총합, 평균
select salary from employees;
select sum(salary), avg(salary) from employees; 
-- 평균보다 낮은 사원을 출력하시오
select salary emp_name,salary from employees
where salary<=(select avg(salary) from employees);
-- commission_pct 를 커미션을 받는 사원수를 출력하시오
select commission_pct from employees;
select count(*),count(commission_pct) from employees;
select count(*),count(commission_pct) from employees
where commission_pct is not null;
-- commission_pct 를 안 받는 사람명 수 출력하시오 
select count(*),count(commission_pct) from employees
where commission_pct is null;
select count(*), count(*) - count(commission_pct) from employees;
select count(commission_pct) from employees
where department_id is null;

-- 그룹함수
-- group by 
-- 부서별 월급합계를 출력하시오  
select salary from employees; 
select sum(salary) from employees;
select sum(salary) from employees
group by department_id;
-- group by 로 묶인 정보를 출력되고 부서별로 출력
select department_id, sum(salary) from employees
group by department_id
order by department_id;

-- 그룹함수컬럼과 일반컬럼은 동시에 사용이 안됨
-- group by에 일반컬럼을 넣으면 일반컬럼도 출력이 가능함
-- 한명의 정보 출력일 땐 가능 
select emp_name, job_id, count(commission_pct) from employees
where department_id is null
group by emp_name, job_id;

select * from kor_loan_status;
-- 지역별 region 금액 합계를 출력하시오
select region, sum(loan_jan_amt) from kor_loan_status
group by region
order by region;
-- 연도별 금액합계를 출력하시오
select period from kor_loan_status;
select period, substr(period,1,4),substr(period,5,2) from kor_loan_status;
select substr(period,1,4), sum(loan_jan_amt) from kor_loan_status
group by substr(period,1,4);
select substr(period,1,4) year,sum(loan_jan_amt) from kor_loan_status
group by substr(period,1,4);
-- 월별 금액합계를 출력하시오
select substr(period,5,2) month,sum(loan_jan_amt) from kor_loan_status
group by substr(period,5,2);

select sum(salary) from employees
group by department_id;
-- 일반컬럼의 제약조건은 where 절에 넣으면 됨 (일반컬럼은 where)
-- 그룹함수는 where 절에 넣을 수 없음
-- 그룹함수컬럼의 제약조건은 having 절에 넣으면 됨 (그룹함수는 having)
select department_id, sum(salary) from employees
where department_id>=50 
group by department_id
having sum(salary)<50000;

-- 부서별 평균 급여를 출력하시오
select department_id,round(avg(salary),2) from employees
group by department_id;
-- 부서별 평균 급여가 5000이하인 부서를 출력하시오
select department_id, round(avg(salary),2) from employees
group by department_id
having avg(salary)<=5000;

-- kor_loan_status 테이블에서 2012년 이상의 년도별 총합 금액을 출력하시오
-- 총합의 현재단위가 십만원 원단위로 출력하고, 천단위 표시를 출력하시오 
select * from kor_loan_status;
select period, sum(loan_jan_amt*100000) from kor_loan_status
group by period;
select period, substr(period,1,4), sum(loan_jan_amt*100000) from kor_loan_status
group by period
having substr(period,1,4)>=2012;
select period, substr(period,1,4), sum(loan_jan_amt*100000) from kor_loan_status
where substr(period,1,4)>=2012
group by (period,1,4);
select period, substr(period,1,4) year, to_char(sum(loan_jan_amt*100000),'L999,999,999,999,999') from kor_loan_status
where substr(period,1,4)>=2012
group by period;

select * from kor_loan_status;
-- 지역별 그룹으로 한 후 주택담보대출이 최대한 지역을 출력하시오
select region,sum(loan_jan_amt) from kor_loan_status
group by region
order by max(loan_jan_amt) desc ;

select region,sum(loan_jan_amt) from kor_loan_status
group by region
having max(loan_jan_amt) >= 100000
order by region;

select region,sum(loan_jan_amt) from kor_loan_status
where gubun ='주택담보대출'
group by region
having max(loan_jan_amt) >= 100000
order by sum(loan_jan_amt) desc;


select region, sum(loan_jan_amt) as amt from kor_loan_status
where gubun = '주택담보대출'
group by region
having sum(loan_jan_amt) = (
    select max(sum(loan_jan_amt)) from kor_loan_status
    where gubun = '주택담보대출'
    group by region
);

select region,sum(loan_jan_amt) as amt from kor_loan_status
where gubun='주택담보대출'
group by region
order by sum(loan_jan_amt) desc
FETCH FIRST 1 ROW ONLY
;




