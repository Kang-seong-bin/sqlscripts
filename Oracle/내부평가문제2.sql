--�ۼ��� ������

--���� 2
INSERT into tbl_custom#  VALUES ('mina012', '��̳�', 'kimm@gmail.com', 20,to_timestamp('2022-02-07 15:03:06.000'),null);
INSERT into tbl_custom#  VALUES ('hongGD', 'ȫ�浿', 'gil@korea.com', 32,to_timestamp ('2022-02-07 15:03:06.000'),null);
INSERT into tbl_custom#  VALUES ('twice', '�ڸ��', 'momo@daum.net', 39, to_timestamp('2022-02-05'),null);
INSERT into tbl_custom#  VALUES ('wonder', '�̳���', 'nana@korea.kr', 23,to_timestamp('2022-02-05'),null);
INSERT into tbl_custom#  VALUES ('sana', '�ֻ糪', 'unknown', 22,to_timestamp('2022-02-09 15:19:24.000'),null);
SELECT * FROM tbl_custom# ;

INSERT INTO TBL_PRODUCT# values('CJ-BABQ1','B1','CJ�޹�����SET',26000);
INSERT INTO tbl_product# VALUES ('DOWON123a', 'B1', '������ġ������Ʈ',54000);
INSERT INTO tbl_product# VALUES ('dk_143', 'A2', '��ǵ���ũ',234500);
INSERT INTO tbl_product# VALUES ('IPAD011', 'A1', '�����е�10',880000);
INSERT INTO tbl_product# VALUES ('GAL0112', 'A1', '������20',912300);
INSERT INTO tbl_product# VALUES ('CHR-J59', 'A2', 'Sü��',98700);
SELECT * FROM tbl_product#;

INSERT INTO tbl_buy# VALUES (29, 'mina012','IPAD011', 1,to_timestamp('2022-02-06'));
INSERT INTO tbl_buy# VALUES (30,'hongGD', 'IPAD011', 2,to_timestamp('2022-02-08 15:55:08'));
INSERT INTO tbl_buy# VALUES (31,'wonder', 'DOWON123a', 3,to_timestamp('2022-02-06'));
INSERT INTO tbl_buy# VALUES (32,'mina012', 'dk_143', 1,to_timestamp('2022-02-08 15:55:08'));
INSERT INTO tbl_buy# VALUES (33,'twice', 'DOWON123a', 2,to_timestamp('2022-02-07'));
INSERT INTO tbl_buy# VALUES (63,'hongGD', 'dk_143', 1,to_timestamp('2022-02-11'));
INSERT INTO tbl_buy# VALUES (61,'twice', 'CHR-J59', 2,to_timestamp('2022-02-12'));
INSERT INTO tbl_buy# VALUES (62,'hongGD', 'CJ-BABQ1', 4,to_timestamp('2022-02-11'));
SELECT  * FROM  tbl_buy# ;

--���� 2 1)
SELECT buy_seq,custom_id ,pcode ,quantity,buy_date FROM TBL_BUY# tb 
WHERE BUY_DATE >= '2022-02-11';
--���� 2 2)
SELECT pcode ,pname ,price FROM TBL_PRODUCT# tp where price >= 900000  ;

--���� 2 3)
SELECT max(price) FROM TBL_PRODUCT# tp 
WHERE CATEGORY  =
(SELECT CATEGORY from TBL_PRODUCT# tp2 WHERE  PRICE IS MAXVALUE  ;
--���� 2 4)
SELECT custom_id ,name ,quantity from tbl_custom# WHERE pcode ='IPAD011';
--���� 2 5)
SELECT custom_id ,name , age FROM TBL_CUSTOM# tc2 LEFT OUTER join TBL_BUY# tb2 on tc2.CUSTOM_ID = tb2.CUSTOM_ID ;

--���� 2 6)
SELECT buy_date2 ,sum(money)
from TBL_BUY# tb
GROUP BY buy_date 
ORDER BY buy_date2 ;

