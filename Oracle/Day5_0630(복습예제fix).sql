CREATE TABLE tbl_custom (	--�ۼ��� : ������
	custom_id varchar2(20) PRIMARY key,		--�⺻Ű�� ����
	name nvarchar2(20) NOT NULL,
	email varchar2(20),
	age number(3),
	reg_date DATE DEFAULT sysdate	--default(�⺻��) �����Դϴ�.
);

-- ��ǰ ���̺� : ī�װ� ���� A1: ������ǰ, B1:��ǰ
CREATE TABLE tbl_product(
	pcode varchar2(20)PRIMARY key, 	--�⺻Ű�� �����ϼ���.
	category char(2) NOT NULL,
	pname nvarchar2(20) NOT NULL,
	price NUMBER (9) NOT null
);

-- ���� ���̺� : ��� ���� ���� ��ǰ�� �����ϴ°�?
CREATE TABLE tbl_buy(
	custom_id varchar2 (20) NOT NULL,
	pcode varchar2 (20) NOT NULL,
	quantity number (5) NOT NULL, --����
	buy_date DATE default sysdate 
);
-- Date ���Ŀ� �����Ǵ� ���� �����ϱ� -> insert �� �� to_date �Լ� ��������
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

SELECT * FROM tbl_custom ;
INSERT into tbl_custom  VALUES ('mina012', '��̳�', 'kimm@gmail.com', 20,
to_date('2022-03-10 14:23:25','YYYY-MM-DD HH24:MI:SS'));
INSERT into tbl_custom  VALUES ('hongGD', 'ȫ�浿', 'gil@korea.com', 32,
to_date('2021-10-21','YYYY-MM-DD'));
INSERT into tbl_custom  VALUES ('twice', '�ڸ��', 'momo@daum.net', 29,
to_date('2021-12-25','YYYY-MM-DD'));
INSERT into tbl_custom(custom_id, name,EMAIL,AGE)  --���� �޸� ��ü �÷��� ���� �־��ִ� ������ �ƴϰ� 4���� �־��ִ� ���Ŀ��� default ������ �̿��� ���
VALUES ('wonder', '�̳���', 'lee@naver.com', 40); --reg_date �÷��� default sysdate ���� �־��ش�.
SELECT * FROM tbl_custom ;


INSERT INTO tbl_product VALUES ('IPAD011', 'A1', '�����е�10',880000);
INSERT INTO tbl_product VALUES ('DOWON123a', 'B1', '������ġ������Ʈ',54000);
INSERT INTO tbl_product VALUES ('dk_143', 'A2', '��ǵ���ũ',234500);
SELECT * FROM tbl_product;

INSERT INTO tbl_buy VALUES ('mina012', 'IPAD011', 1,to_date('2022-02-06','YYYY-MM-DD HH:MI:SS'));
INSERT INTO tbl_buy VALUES ('hongGD', 'IPAD011', 2,to_date('2022-02-06 20:37:47','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_buy VALUES ('wonder', 'DOWON123a', 2,to_date('2022-02-06','YYYY-MM-DD HH24:MI:SS'));
INSERT INTO tbl_buy (custom_id,PCODE,QUANTITY)
VALUES ('mina012', 'dk_143', 2);-- default �� �̿��� �⺻ ���� �־��� ����
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



