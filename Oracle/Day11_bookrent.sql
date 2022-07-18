-- ȸ���� ������ '�뿩'�ϴ� ����ó���� ���õ� ���̺�.
create table book_member(
mem_idx number(5) primary key, --ȸ����ȣ 
name varchar2(20) not null,
email varchar2(20) not null,
tel varchar2(20) unique,
password varchar2(10)
);

create table tbl_book (
bcode char(5) primary key,
title varchar2(30) not null,
writer varchar2(20),
publisher varchar2(20),
pdate date
);

create table tbl_bookrent(
rent_no number(5) primary key,
mem_idx number(5) NOT null,
bcode char(5) NOT null,
rent_date date not null,
exp_date date not null,
return_date date,
delay_days number(3),
CONSTRAINT fk1 foreign KEY (mem_idx) --CONSTRAINT fk1�� ��������
	REFERENCES book_member(mem_idx),
	CONSTRAINT fk2 FOREIGN KEY(bcode)
	references tbl_book(bcode)
);

--ȸ�� ��ȣ ������
CREATE SEQUENCE memidx_seq START WITH 10001;

-- �뿩 �Ϸù�ȣ�� ���� ������
CREATE SEQUENCE bookrent_seq START WITH 1;
--ȸ�������� �߰�
INSERT INTO book_member (mem_idx,name,email,tel,password)
VALUES (memidx_seq.nextval,'���ϴ�','honey@naver.com','010-9889-0567','1122');
INSERT INTO book_member (mem_idx,name,email,tel,password)
VALUES (memidx_seq.nextval,'�̼���','jong@daum.net','010-2354-6773','2345');
INSERT INTO book_member (mem_idx,name,email,tel,password)
VALUES (memidx_seq.nextval,'�����','lucky@korea.com','010-5467-8792','9876');
INSERT INTO book_member (mem_idx,name,email,tel,password)
VALUES (memidx_seq.nextval,'���浿','nadong@kkk.net','010-3456-8765','3456');
INSERT INTO book_member (mem_idx,name,email,tel,password)
VALUES (memidx_seq.nextval,'������','haha@korea.net','010-3987-9087','1234');

SELECT * FROM book_member ;

INSERT INTO tbl_book (bcode,title,writer,publisher,pdate)
VALUES ('A1101','�ڽ���','Į���̰�','���̾𽺺Ͻ�','2006-12-01');
--���ڿ����� ��¥Ÿ�����δ� �ڵ�ĳ���õ˴ϴ�. �Լ��� ����� ������ to_date() �Լ��� ����մϴ�.
-- ���� : ��¥������ ���ڿ��� ��ȯ��Ű�� ����? to  char() �Լ�
INSERT INTO tbl_book (bcode,title,writer,publisher,pdate)
VALUES ('B1101','��Ŀ������','����Ŀ','��Ŀ����','2018-07-10');
INSERT INTO tbl_book (bcode,title,writer,publisher,pdate)
VALUES ('C1101','Ǫ������ �ʹϴ�','����','â��','2015-06-20');
INSERT INTO tbl_book (bcode,title,writer,publisher,pdate)
VALUES ('A1102','�佺Ʈ','�˺���Ʈ �','������','2011-03-01');

SELECT * FROM tbl_book ;

insert into tbl_bookrent (rent_no,mem_idx,bcode,rent_date,exp_date,return_date) 
values(bookrent_seq.nextval,10001,'B1101','2021-09-01 ','2021-09-15 ','2021-09-14');
insert into tbl_bookrent (rent_no,mem_idx,bcode,rent_date,exp_date,return_date) 
values(bookrent_seq.nextval,10002,'C1101','2021-09-12 ','2021-09-26','2021-09-29');
insert into tbl_bookrent (rent_no,mem_idx,bcode,rent_date,exp_date,return_date) 
values(bookrent_seq.nextval,10003,'B1101','2021-09-03 ','2021-09-17 ','2021-09-17');
insert into tbl_bookrent (rent_no,mem_idx,bcode,rent_date,exp_date) 
values(bookrent_seq.nextval,10004,'C1101','2022-06-30','2022-07-14');
insert into tbl_bookrent (rent_no,mem_idx,bcode,rent_date,exp_date) 
values(bookrent_seq.nextval,10001,'A1101','2022-07-04 ','2022-07-18 ');
insert into tbl_bookrent (rent_no,mem_idx,bcode,rent_date,exp_date,return_date) 
values(bookrent_seq.nextval,10003,'A1102','2022-07-06 ','2022-07-20 ','2022-07-13');

SELECT * FROM tbl_bookrent ;

--�߰��ϱ� : �⺻���� ������ �뿩��¥�� ����, �ݳ������� ����+14
--alter table "C##idev".tbl_bookrent modify rent_date date default sysdate;
--alter table "C##idev".tbl_bookrent modify exp_date date default sysdate+14;
-- INSERT into TBL_BOOKRENT (rent_no,mem_dex,bcode)
--values(bookrent_seq.nextval,10002,'A1102');


--�÷� ����Ʈ �� ���ְ� ���� ��
--alter table "C##idev".tbl_bookrent modify rent_date date default null;