CREATE TABLE tbl_custom (	--작성자 : 강성빈
	custom_id varchar2(20) PRIMARY key,		--기본키로 설정
	name nvarchar2(20) NOT NULL,
	email varchar2(20),
	age number(3),
	reg_date DATE DEFAULT sysdate	--default(기본값) 설정입니다.
);

-- 상품 테이블 : 카테고리 예시 A1: 전자제품, B1:식품
CREATE TABLE tbl_product(
	pcode varchar2(20)PRIMARY key, 	--기본키로 설정하세요.
	category char(2) NOT NULL,
	pname nvarchar2(20) NOT NULL,
	price NUMBER (9) NOT null
);

-- 구매 테이블 : 어느 고객이 무슨 상품을 구입하는가?
CREATE TABLE tbl_buy(
	custom_id varchar2 (20) NOT NULL,
	pcode varchar2 (20) NOT NULL,
	quantity number (5) NOT NULL, --수량
	buy_date DATE default sysdate 
);
-- Date 형식에 지정되는 패턴 설정하기 -> insert 할 때 to_date 함수 생략가능
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

SELECT * FROM tbl_custom ;
INSERT into tbl_custom  VALUES ('mina012', '김미나', 'kimm@gmail.com', 20,
to_date('2022-03-10 14:23:25','YYYY-MM-DD HH24:MI:SS'));
INSERT into tbl_custom  VALUES ('hongGD', '홍길동', 'gil@korea.com', 32,
to_date('2021-10-21','YYYY-MM-DD'));
INSERT into tbl_custom  VALUES ('twice', '박모모', 'momo@daum.net', 29,
to_date('2021-12-25','YYYY-MM-DD'));
INSERT into tbl_custom(custom_id, name,EMAIL,AGE)  --위와 달리 전체 컬럼에 값을 넣어주는 형식이 아니고 4개만 넣어주는 형식에서 default 형식을 이용한 방법
VALUES ('wonder', '이나나', 'lee@naver.com', 40); --reg_date 컬럼은 default sysdate 값을 넣어준다.
SELECT * FROM tbl_custom ;


INSERT INTO tbl_product VALUES ('IPAD011', 'A1', '아이패드10',880000);
INSERT INTO tbl_product VALUES ('DOWON123a', 'B1', '동원참치선물세트',54000);
INSERT INTO tbl_product VALUES ('dk_143', 'A2', '모션데스크',234500);
SELECT * FROM tbl_product;

INSERT INTO tbl_buy VALUES ('mina012', 'IPAD011', 1,to_date('2022-02-06','YYYY-MM-DD HH:MI:SS'));
INSERT INTO tbl_buy VALUES ('hongGD', 'IPAD011', 2,to_date('2022-02-06 20:37:47','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_buy VALUES ('wonder', 'DOWON123a', 2,to_date('2022-02-06','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_buy (custom_id,PCODE,QUANTITY)
VALUES ('mina012', 'dk_143', 2);-- default 를 이용해 기본 값을 넣어준 형식
INSERT INTO tbl_buy VALUES ('twice', 'DOWON123a', 2,to_date('2022-02-09 08:49:55','YYYY-MM-DD HH24:MI:SS'));
SELECT  * FROM  tbl_buy ;

ALTER TABLE tbl_buy add	buyno number (8);

SELECT * FROM tbl_buy ;


UPDATE tbl_buy set buyno = 1001  WHERE custom_id = 'mina012'AND PCODE = 'IPAD011';
UPDATE tbl_buy set buyno = 1002  WHERE custom_id = 'hongGD' AND PCODE = 'IPAD011';
UPDATE tbl_buy set buyno = 1003  WHERE custom_id = 'wonder' AND PCODE = 'DOWON123a' ;
UPDATE tbl_buy set buyno = 1004  WHERE custom_id = 'mina012' AND PCODE = 'dk_143'  ;
UPDATE tbl_buy set buyno = 1005  WHERE custom_id = 'twice' AND PCODE = 'DOWON123a' ;
SELECT * FROM tbl_buy ;
ALTER TABLE tbl_buy ADD PRIMARY KEY (buyno);


SELECT * FROM tbl_buy ;

ALTER table tbl_buy  ADD CONSTRAINT fk_custom_id 
FOREIGN KEY (custom_id) REFERENCES tbl_custom (custom_id); 

ALTER table tbl_buy  ADD CONSTRAINT fk_pcode 
FOREIGN KEY (pcode) REFERENCES tbl_product (pcode); 

CREATE SEQUENCE tblbuy_seq
START WITH 1006;

INSERT INTO tbl_buy(buyno,CUSTOM_ID,PCODE,QUANTITY,BUY_DATE)
VALUES (tblbuy_seq.nextval,'wonder','IPAD011',1,
to_date('2022-05-15','YYYY-MM-DD HH:MI:SS'));

SELECT  *   FROM tbl_custom WHERE age > 30;
SELECT  EMAIL   FROM tbl_custom WHERE CUSTOM_ID =  'twice';
SELECT   pname  FROM tbl_product  WHERE category  =  'A2';
SELECT   MAX(PRICE)  FROM tbl_product  ;

SELECT   *  FROM tbl_buy  WHERE CUSTOM_ID  = 'mina012';
SELECT   *  FROM tbl_buy  WHERE PCODE  LIKE '%0%';
SELECT   *  FROM tbl_buy  WHERE UPPER(PCODE)    LIKE   '%ON%';



