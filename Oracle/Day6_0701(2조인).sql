--����, custom_id 'mina012' �� ������ ���� ��ȸ : pcode ��ȸ�ϰ� pname �� �� �� ����
SELECT pcode FROM TBL_BUY WHERE CUSTOM_ID = 'mina012';

-- 1. ��������(select �ȿ� select �� �����.)
select pname FROM TBL_PRODUCT --�ܺ� ����
WHERE PCODE =			--���ǽ���  = �����̹Ƿ� ���������� 1�� �� ����̾�� ��.
(SELECT PCODE FROM TBL_BUY WHERE custom_id = 'mina012' --���� ����
 					AND buy_date = '2022-2-6');
 SELECT pname FROM TBL_PRODUCT  
 WHERE PCODE IN 					--���ǽ��� IN �����̹Ƿ� ���������� ���� �� �� ��� ������.
 	(SELECT PCODE FROM TBL_BUY WHERE custom_id = 'mina012');
 	
 -- ���� ���� �׽�Ʈ
 SELECT pcode FROM TBL_BUY WHERE CUSTOM_ID = 'mina012'
 	AND BUY_DATE = '2022-2-6';
 	SELECT pcode FROM TBL_BUY WHERE CUSTOM_ID = 'mina012';
 	 SELECT * FROM TBL_PRODUCT ;
 -- �������� ������ : �ܺ������� ���ǽ��� ��� �࿡ ���� �˻��� ������ ���������� ����ǹǷ� 
 --	ó�� �ӵ��� ������ ����ϴ�. --> ���̺��� ���� ���� ������� �����մϴ�.
 

-- 2. SELECT �� ���̺� JOIN : �� �̻��� ���̺�(�ַ� ���������� ���̺�)�� �����Ͽ� �����͸� ��ȸ�ϴ� ���
-- ���� ���� : �� �̻��� ���̺��� ����� �÷��� ���� �� �÷����� '����(=)'�� �̿��Ͽ� join �մϴ�.
-- ����1 : select ~~~ from ���̺�1 a,���̺�2 b 
--					where a.�����÷�1=b.�����÷�1;
 	
-- ������ ���� ��ǰ �߰�
 	INSERT INTO TBL_PRODUCT VALUES ('GALAXYS22','A1','������s22',555600);
 --join Ű���� ���� ���� 1
SELECT * FROM TBL_PRODUCT tp , TBL_BUY 	tb	-- ������ ���̺� 2��
			WHERE tp.pcode = tb.pcode ;		--���� ����.���� �÷����� = �����.
		
-- JOIN Ű���带 ���� ��ɹ� ����2(ANSI ǥ��)
		select * FROM TBL_PRODUCT tp 
			join TBL_BUY tb 
			ON tp.PCODE =tb.PCODE ;

-- ���� �׽�Ʈ : tbl_custom �� tbl_buy �� �����غ�����.
--1
SELECT * FROM TBL_CUSTOM tc ,TBL_BUY tb 
		WHERE TC.custom_id = tb.CUSTOM_ID ;
--2		
SELECT * FROM TBL_CUSTOM tc join TBL_BUY tb ON tc.CUSTOM_ID =tb.CUSTOM_ID ;
		
-- ������ ������� Ư�� �÷��� ��ȸ
SELECT tc.CUSTOM_ID ,name,REG_DATE ,pcode ,quantity FROM TBL_CUSTOM tc ,TBL_BUY tb 
		WHERE TC.custom_id = tb.CUSTOM_ID ;
		
-- �������� �ܿ� �ٸ� ������ �߰�
SELECT tc.custom_id ,name reg_date, pcode , quantity 
		from TBL_CUSTOM tc ,TBL_BUY tb 
		WHERE tc.CUSTOM_ID = tb.CUSTOM_ID AND tc.CUSTOM_ID  = 'mina012';
	
-- mina012 �� ������ ��ǰ���� �����ΰ� ��ȸ�ϱ�
		SELECT tp.pname FROM TBL_PRODUCT tp , TBL_BUY tb 
			WHERE tp.PCODE = tb.PCODE AND custom_id = 'mina012';
		
		
		SELECT tp.pname from TBL_PRODUCT tp join TBL_BUY tb 
		ON tp.PCODE =tb.PCODE AND custom_id ='mina012';
		SELECT tp.pname from TBL_PRODUCT tp join TBL_BUY tb 	
		ON tp.PCODE =tb.PCODE AND custom_id ='mina012' AND buy_date = '2022-2-6';
		
-- mina012 �� ������ ��ǰ��� ���� ��ȸ�ϱ�
		SELECT tp.pname,tp.price FROM TBL_PRODUCT tp , TBL_BUY tb 
			WHERE tp.PCODE = tb.PCODE AND custom_id = 'mina012';		
--������ ��, �̸��� ���� �÷��� ���̺���� �� �����ؾ��մϴ�.
		
		
		
--3���� ���̺��� ������ �� �������?		
	SELECT *FROM TBL_PRODUCT tp ,
		(SELECT tc.custom_id cusid, name,email,age,REG_DATE, pcode, quantity, buy_date, buyno
	FROM TBL_CUSTOM tc,TBL_BUY tb
	WHERE tc.CUSTOM_ID= tb.CUSTOM_ID) temp	--ù��° ����
	WHERE tp.PCODE =temp.pcode 	; 	--�ι�° ����
	
	--Ư�� �÷��� ��ȸ�ϱ�
SELECT tb,CUSTOM_ID ,tb.PCODE ,name, age,pname ,QUANTITY ,BUY_DATE 
	FROM TBL_BUY tb , TBL_CUSTOM tc , TBL_PRODUCT tp 
	WHERE tc.CUSTOM_ID =tb.CUSTOM_ID AND tp.PCODE = tb.PCODE ;

--3. �ܺ� ���� (outer join) : = ������ ����ϴ� �����̳� ������ ����(null)���� ���ΰ���� ����.
--join Ű���� ���� ���� 1
SELECT * FROM TBL_PRODUCT tp , TBL_BUY 	tb	
			WHERE tp.pcode = tb.pcode(+) ;		--�ܺ� ���� tbl_buy ���̺� ��ġ�ϴ� pcode ���� ��� ����.
		
-- JOIN Ű���带 ���� ��ɹ� ����2(ANSI ǥ��)
	select * FROM TBL_PRODUCT tp 
		LEFT outer join TBL_BUY tb 
		ON tp.PCODE =tb.PCODE ;		--tbl_product �� ���� ���̺��̸� �� ���� ��� �����Ͽ� ����.�������� �� NULL �� �Ǵ� ���̺��� �÷��� (+)��ȣ
		
	SELECT * FROM TBL_BUY tb 
		RIGHT OUTER JOIN TBL_PRODUCT tp 
		ON TB.pcode =tb.PCODE ;		--tbl_product �� ������ ���̺��̸� �� ���� ��� �����Ͽ� ����