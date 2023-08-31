
// DB 계정 생성 및 권한 부여
IDENTIFIED BY 1234
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE temp;

GRANT CONNECT TO momento_test;
GRANT RESOURCE TO momento_test;
GRANT DBA TO momento_test;
commit;

// 테이블 생성 * 멤버 테이블 생성 후 권한 테이블 생성 해야함. *
// 멤버 테이블
create table member_tbl(
user_id varchar2(30) not null primary key,
user_name varchar2(30) not null,
password varchar2(100) not null,
addr varchar2(300) not null,
question_code number(10) not null,
question_answer varchar2(20) not null,
regdate date default sysdate,
updatedate date default sysdate,
phone varchar2(20) not null
);

// 권한 테이블
create table member_tbl_auth (
user_id varchar2(30) not null primary key,
auth varchar2(50) not null default 'ROLE_USER',
  CONSTRAINT fk_member_tbl_auth_user_id
    FOREIGN KEY (user_id)
    REFERENCES member_tbl (user_id)
);

// 자동 로그인 테이블
create table persistent_logins (
user_id varchar2(30) not null,
series varchar2(64)primary key,
token varchar2(64) not null,
last_used timestamp not null
);

// 테이블 규칙 확인
desc '테이블 명';

// 테이블 컬럼 삭제
delete from '테이블 명' where '조건' = '조건';

// 테이블 삭제
drop table '테이블 명';