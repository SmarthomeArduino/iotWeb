
// DB ���� ���� �� ���� �ο�
IDENTIFIED BY 1234
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE temp;

GRANT CONNECT TO momento_test;
GRANT RESOURCE TO momento_test;
GRANT DBA TO momento_test;
commit;

// ���̺� ���� * ��� ���̺� ���� �� ���� ���̺� ���� �ؾ���. *
// ��� ���̺�
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

// ���� ���̺�
create table member_tbl_auth (
user_id varchar2(30) not null primary key,
auth varchar2(50) not null default 'ROLE_USER',
  CONSTRAINT fk_member_tbl_auth_user_id
    FOREIGN KEY (user_id)
    REFERENCES member_tbl (user_id)
);

// �ڵ� �α��� ���̺�
create table persistent_logins (
user_id varchar2(30) not null,
series varchar2(64)primary key,
token varchar2(64) not null,
last_used timestamp not null
);

// ���̺� ��Ģ Ȯ��
desc '���̺� ��';

// ���̺� �÷� ����
delete from '���̺� ��' where '����' = '����';

// ���̺� ����
drop table '���̺� ��';