/*
 * [[[[ ' �����뿩
 * 
 * -�뿩�Ѵ�. : rent_date �� �뿩����, ��xp_date�� �ݳ����������̸� rent_date + 14
 * -�ݳ��Ѵ�. : return date �� �ݳ�����, delay_days�� ��ü�ϼ� return date - exp_date
 * - ���� ���� ���� Ȯ���ϴ� ó������ : return_date �� null�̸� �뿩��, null�� �ƴϸ� �ݳ��� ����.
 */


--1)������ �߰��մϴ�. ��B1102�� , ����Ʈ����ũ �����⡯, ����ö���� ,��KBO�� , ��2020-11-10����
INSERT INTO tbl_book (bcode,title,writer,publisher,pdate)
values('B1102', '��Ʈ����ũ ������', '��ö��', 'KBO', '2020-11-10');
--2)�ݳ��� ������ ��ü�ϼ��� ����Ͽ� delay_days �÷����� update �մϴ�.
UPDATE TBL_BOOKRENT SET delay_days = RETURN_date - exp_date
WHERE RETURN_date IS NOT NULL;
SELECT * FROM tbl_book ;
SELECT * FROM tbl_bookrent;
--3)���� �������� ������ ��ü�ϼ�����ؼ� ȸ��IDX, �����ڵ�, ��ü �ϼ� ��ȸ�մϴ�.
-- ���� ��¥ sysdate �� ����� ������ �������� �ʾ� �׳��ϸ� long ������ ���˴ϴ�.
SELECT mem_idx, bcode, to_date(to_char(sysdate,'yyyy-MM-dd')) - exp_date 
FROM tbl_bookrent WHERE RETURN_date IS NULL;

--4) ���� ���� ���� ���� �� ��ü�� ȸ���� �̸�,��ȭ��ȣ�� �˻��մϴ�. ���� ��¥ sysdate �������� Ȯ���ϱ�.!
SELECT name,tel FROM BOOK_MEMBER bm JOIN tbl_bookrent tb
ON bm.mem_idx = tb.mem_idx AND SYSDATE > exp_date AND RETURN_date IS NULL;

--5) ���� �������� ������ ������ �ڵ�� ������ �˻��մϴ�.
SELECT tb.bcode ,title  FROM tbl_book tb JOIN tbl_bookrent tb2
ON tb.bcode = tb2.bcode AND return_date IS NULL;


--6) ���� ������ �뿩�� ȸ���� IDX�� ȸ���̸��� �˻��մϴ�.
SELECT bm.mem_idx , name  FROM BOOK_MEMBER bm JOIN tbl_bookrent tb
ON bm.mem_idx = tb.mem_idx AND RETURN_date IS NULL;

-- 7) ���� ���� ������ ȸ���̸�, ������, �ݳ����� �˻��մϴ�.
--join
SELECT name, title  ,exp_date FROM tbl_book tb 
JOIN tbl_bookrent tb2 ON tb.bcode = tb2.bcode 
JOIN BOOK_MEMBER  bm ON bm.mem_idx =tb2.mem_idx 
WHERE  return_date IS NULL; 

-- �Ǵ� join x
SELECT bm.name , tb.title ,tb2.exp_date 
FROM book_member bm, tbl_book tb, tbl_bookrent tb2
WHERE bm.mem_idx = tb2.mem_idx AND tb.bcode = tb2.bcode 
AND tb2.return_date IS NULL;



--8)���� ��ü ���� ������ ȸ��IDX, �����ڵ�, �ݳ������� �˻��մϴ�.
SELECT mem_idx ,bcode ,exp_date FROM tbl_bookrent tb
WHERE sysdate > exp_date;
--9)ȸ��  IDX ��10002���� ���� ������ �������� ���ν����� �ۼ��մϴ�.
--CREATE OR REPLACE PROCEDURE 'WTRT' (param_index NUMBER(5))

-- ��ȸ������ �����ϴ� ���ν���
DECLARE
	vcnt NUMBER;
BEGIN 
	SELECT count(*) 
	INTO vcnt -- SELECT ��ȸ ��� ������ ����. ������ , �� ������ �� ����.
	FROM tbl_bookrent tb
	WHERE mem_idx =10001 AND RETURN_date IS NULL;		--rcnt�� 0�϶��� �뿩����
	IF (vcnt = 0) THEN
	DBMS_OUTPUT.put_line('å �뿩 �����մϴ�.');
	ELSE
	DBMS_OUTPUT.put_line('�뿩 ���� å�� �ݳ��ؾ� �����մϴ�.');
	END IF;
END;

--���ν��� ����Ŭ ��ü
CREATE OR REPLACE PROCEDURE CHECK_member(
	arg_mem IN book_member.MEM_IDX%TYPE,	-- ���ν��� �����Ҷ� ���� ���� �Ű����� 
	isOK OUT varchar2		--�ڹ��� ���ϰ��� �ش��ϴ� �κ�
	)
IS 
vcnt NUMBER;
vname varchar2(100);
	BEGIN 	--�Է¸Ű������� ���� ȸ���ΰ��� Ȯ���ϴ� sql�� EXCEPTION ó�� . arg_mem���� ȸ�����̺����� name��ȸ
		-- ������ exception ó��
		SELECT name
		INTO vname		--������ ����.
		FROM BOOK_MEMBER bm WHERE mem_idx = arg_mem ;
		
	SELECT count(*) 
	INTO vcnt 
	FROM tbl_bookrent tb
	WHERE mem_idx =arg_mem AND RETURN_date IS NULL;		--rcnt�� 0�϶��� �뿩����
	IF (vcnt = 0) THEN
	DBMS_OUTPUT.put_line('å �뿩 �����մϴ�.');
	isOK := '����';
	ELSE
	DBMS_OUTPUT.put_line('�뿩 ���� å�� �ݳ��ؾ� �����մϴ�.');
	isOK := '�Ұ���';
	END IF;
EXCEPTION		-- ����(����)ó��
	WHEN no_data_found THEN  
		DBMS_OUTPUT.PUT_LINE('ȸ���� �ƴմϴ�.');	
	isOK := 'no match'; 
END;
	--���ν��� �����ϱ�
	DECLARE
		vresult varchar2(20);
	BEGIN


		CHECK_member(10003,vresult);
		DBMS_OUTPUT.put_line('��� : ' || vresult);
	END;
	



--10)�������� ����Ʈ�� ��� ���ڰ� ���� ������ �˻��Ͽ� ���� ������ �������� ���ν����� �ۼ��մϴ�. ���ν����̸��� check_book ���� �ϼ���.
DECLARE
	v_bcode varchar2(20);
	v_cnt NUMBER;
	BEGIN 
	SELECT bcode  INTO v_bcode		--v_bcode�� 'A1102'
	FROM tbl_book tb WHERE title LIKE '�佺Ʈ'; 		
	SELECT count(*) INTO v_cnt		--v_cnt���� 1�̸� v_bcode å�� ������
			FROM tbl_bookrent tb2 WHERE bcode = v_bcode AND return_date IS NULL;
	IF (v_cnt = 0) THEN
	dbms_output.put_line('�� å�� �뿩 �����մϴ�.');
	ELSE
	dbms_output.put_line('�� å�� �뿩 ���Դϴ�.');
	END IF;
END; 

--

--���ν��� ����Ŭ ��ü
CREATE OR REPLACE PROCEDURE CHECK_BOOK(
			arg_book IN tbl_book.TITLE%TYPE,	-- ���ν��� �����Ҷ� ���� ���� �Ű����� 
			isOK OUT varchar2		--�ڹ��� ���ϰ��� �ش��ϴ� �κ�
	)
		IS 	
		v_bcode varchar2(100);
		v_cnt NUMBER;
	BEGIN 
	SELECT BCODE INTO v_bcode 		---v_bcode�� 'A1102'
		FROM tbl_book tb WHERE title = arg_book;
	SELECT count(*) INTO v_cnt		-- v_cnt ���� 1�̸� v_bcode å�� ������
	FROM tbl_bookrent tb2 WHERE bcode = v_bcode AND return_date IS NULL; 
	IF (v_cnt = 1) THEN
	DBMS_OUTPUT.put_line('�뿩 ���� å �Դϴ�.');
	isOK := 'FALSE';
	ELSE
	DBMS_OUTPUT.put_line('å �뿩 �����մϴ�.');
	isOK := 'TRUE';
	END IF;
EXCEPTION		-- ����(����)ó��
	WHEN no_data_found THEN  
		DBMS_OUTPUT.PUT_LINE('ã�� �����Ͱ� �����ϴ�.');	
	isOK := 'no match'; 
END;
	--���ν��� �����ϱ�
	DECLARE
		vresult varchar2(100);
	BEGIN
		CHECK_book('�佺Ʈ',vresult); 	--�ڽ���, Ǫ������ �ʹϴ� �� FALSE �������� TRUE
		DBMS_OUTPUT.put_line('��� : ' || vresult);
	END;
--

--11)9�� 10�� �̿��ؼ� insert �� �ϴ� ���ν����� �ۼ��մϴ�. 
