--작성자 강성빈

--문제 1

CREATE TABLE  TBL_PRODUCT#(
	PCODE varchar2(20) NOT NULL PRIMARY KEY ,
	category char(2),
	pname nvarchar2(20) not null,
	price number(9,0) not null
);

CREATE TABLE  TBL_CUSTOM#(
	CUSTOM_ID varchar2(20) not null primary key ,
	name nvarchar2(20) not null,
	email varchar2(30),
	age number(3,0),
	reg_date timestamp
);

CREATE TABLE  TBL_BUY#(
	BUY_SEQ number(8,0) NOT null PRIMARY key,
CUSTOM_ID varchar2(20),
PCODE varchar2(20),
QUANTITY number(5,0) not null,
BUY_DATE timestamp,
FOREIGN KEY (PCODE) REFERENCES TBL_PRODUCT#(pcode),
FOREIGN KEY (custom_id) REFERENCES tbl_custom#(custom_id)
);-- 2개의 외래키 설정해야함 pcode, custom_id

CREATE SEQUENCE tbl_buy_seq START WITH 2001;

create table tbl_postcode(
postcode char(6) not null primary key,
area1 varchar2(200) not null); 

alter TABLE  tbl_custom# add postcode char (6);

ALTER table tbl_custom#  ADD CONSTRAINT fk_postcode FOREIGN KEY (postcode) REFERENCES tbl_postcode (postcode);

