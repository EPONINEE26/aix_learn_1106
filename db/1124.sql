drop table board2;
drop table board3;

create table board2 as select * from board;
select * from board2;

-- fk키를 삭헤 후 pk를 삭제할 수 있음 
alter table board drop constraint board_fk_id;
alter table mem drop constraint mem_pk_id;

select * from mem;
-- fk, pk 삭제 후 id='bbb' 삭제 가능
delete mem where id='bbb';
delete mem where id='aabbcc';
insert into mem values(
'aabbcc','1111','홍홍홍','여자',sysdate,null,20
);
select id from board;

-- fk가 삭제가 되면 아이디를 삭제해도 board bbb 라는 아이디가 존재
-- 아이디 bbb의 모든 자료를 삭제해야함

-- on delete cascade : 부모데이터 삭제 시 자식데이터 모두 삭제
-- mem aaa 아이디를 삭제하면 보드에 있는 aaa 아이디로 작성한 모든 컬럼이 삭제됨
alter table mem add constraint mem_pk_id primary key (id);
alter table board add foreign key(id) 
references mem (id) on delete cascade;

-- on delete cascade 설정
alter table board add constraint boardmem_fk_id  
foreign key (id)
references mem (id) on delete cascade;
 
-- on delete set null : 부모 데이터 삭제 시 자식데이터는 null 값

select id from mem;
delete board where id='bbb';
select * from board;

-- 삭제
alter table board drop constraint boardmem_fk_id;
-- on delete set null 설정
alter table board add foreign key(id) 
references mem (id) on delete set null;

-- 속성변경
-- board null 허용설정
alter table board modify id VARCHAR2(50) null;
delete board where id='ccc';
alter table board add foreign key(id) 
references mem (id) on delete set null;

drop table board2;
drop table board3;

-- fk키 삭제후 pk를 삭제할수 있음
alter table board drop constraint board_fk_id;
alter table mem drop constraint mem_pk_id;

-- pk,fk 설정,해제
-- fk : on delete set null, on delete cascade

-- fk가 삭제가 되면, 아이디를 삭제해도, board bbb라는 아이디가 존재.
-- on delete cascade : 부모데이터 삭제시, 자식데이터 모두 삭제
-- on delete set null : 부모데이터 삭제시, 자식데이터는 null
-- mem aaa아이디를 삭제하면, board에 있는 aaa 컬럼을 모두 삭제됨.
alter table mem add constraint mem_pk_id primary key (id);
-- on delete cascade 설정됨.
alter table board add foreign key (id)
references mem (id) on delete cascade;
-- 삭제
alter table board drop constraint SYS_C008405;
-- on delete set null
alter table board add foreign key (id)
references mem (id) on delete set null;

-- board null허용설정
alter table board modify id VARCHAR2(50) null;

delete mem where id='ccc';
select * from mem;
select * from board;
insert into mem values(
'aabbcc','1111','홍홍홍','여자',sysdate,null,20
);
commit;

board
--primary key : bno
foreign key : id
-- on delete cascade
-- on delete set null

-- mem
--primary key : id

drop table board;
create table board as select * from board2;
desc board;

alter table board2 modify id varchar2(50) null;

drop table mem;

create table mem as select * from member;

alter table mem modify pw null;
alter table mem modify name null;

select * from mem;
select * from board;

update mem set id='aaa' where id='Channa';
update mem set id='bbb' where id='Tremain';
update mem set id='ccc' where id='Lulu';
update mem set id='ddd' where id='Sawyer';
update mem set id='eee' where id='Dasya';
commit;

-- 제약조건 (pk, fk, not null, check, unique)
-- mem pk -- 추가 : add 
alter table mem add constraint mem_pf_id primary key(id);
desc mem;

select * from mem;

-- check 제약조건을 변경 수정 : modify
alter table mem modify gender check (gender in('남자','여자'));

select * from mem;

-- check 제약조건은 해당 체크내용으로만 입력이 가능
insert into mem values(
'fff','1111','홍길순','길순스','010-111-1111','여자','게임',sysdate
);
commit;

-- fk 등록 -- add 
-- 부모의 키를 삭제하려면 자식의 모든 아이디를 삭제해야 부모 키를 삭제할 수 있음
-- on delete restricted : 기본값
alter table board add constraint boardmem_fk_id foreign key(id)
references mem (id) ;

-- 부모 aaa를 삭제하려면 자식 aaa와 연관된 모든 것을 삭제해야만 부모 aaa 삭제 가능
delete mem where id='aaa'; -- 자식 aaa 무결성 제약조건에 위배됨
delete board where id='aaa'; -- 부모 aaa 삭제 하였기에 자식 aaa도 다시 삭제 가능 
commit;
-- on delete cascade : 부모 삭제 시 자식 모두 삭제 
alter table board drop constraint boardmem_fk_id;
alter table board add constraint boardmem_fk_id foreign key(id)
references mem(id) on delete cascade ; 

select * from mem;
delete mem where id='bbb';
select * from board;

-- on delete set null : 부모 삭제 시 자식 모드 null값으로 변경
alter table board drop constraint boardmem_fk_id;
alter table board add constraint boardmem_fk_id foreign key(id)
references mem(id) on delete set null ;
commit;

select * from mem;
delete mem where id='ccc';
select * from board;

--drop table board;
--drop table mem;

-- board, mem 테이블 생성
-- mem - id:pk, gender:check 
-- board : id:fk
-- on delete restricted : 기본값
-- on delete cascade : 부모 삭제시, 자식 모두 삭제
-- on delete set null : 부모 삭제시, 자식 모두 null로 대체

create table board as select * from board2;
select * from board;

create table mem as select * from member;
select * from mem;

alter table mem add constraint men_pk_id primary key(id);
alter table mem modify gender check(gender in('남자','여자'));

select * from mem;
insert into mem values (
'fff', '1111','홍길순','길순스','010-111-1111','여자','게임',sysdate 
);   

select id from mem;
select id from board;

-- 6개의 정보를 다 입력한 다음 foreign key 추가 가능
insert into mem values ('aaa', '1111', '홍길동', '길동스', '010-111-1111', '남자', '게임', sysdate);
insert into mem values ('bbb', '1111', '유관순', '관순스', '010-222-2222', '여자', '독서', sysdate);
insert into mem values ('ccc', '1111', '이순신', '순신스', '010-333-3333', '남자', '운동', sysdate);
insert into mem values ('ddd', '1111', '강감찬', '감찬스', '010-444-4444', '남자', '등산', sysdate);
insert into mem values ('eee', '1111', '신사임당', '사임당스', '010-555-5555', '여자', '그림', sysdate);

alter table board add constraint boardmen_fk_id foreign key(id)
references mem(id);  

-- on delete restricted : 기본값
-- on delete cascade : 부모 삭제시, 자식 모두 삭제
-- on delete set null : 부모 삭제시, 자식 모두 null로 대체

-- on delete cascade : 부모삭제시 자식도 모두삭제
-- 1번째 실행: (기존 제약조건 삭제)
alter table board drop constraint boardmem_fk_id;
alter table board add constraint boardmem_fk_id foreign key (id) references mem (id);

-- 2번째 실행: (on delete cascade 생성
alter table board add constraint boardmem_fk_id foreign key (id)
references mem (id) on delete cascade;

-- on delete set null : 부모삭제시 자식값 null
alter table board drop constraint boardmem_fk_id;
alter table board add constraint boardmem_fk_id foreign key (id)
references mem (id) on delete set null;


