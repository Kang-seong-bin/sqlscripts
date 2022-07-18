--DDL : create, alter, drop, TRUNCATE
-- (����� user,table,sequence, view, .. �� truncate �� ���̺� ��� )
--DML : insert, update,  delete 


DROP TABLE students0;	--���� : students ���̺� ���� �����ϸ�
			-- ���� : �ܷ� Ű�� ���� �����Ǵ� ����/�⺻ Ű�� ���̺� �ֽ��ϴ�
DROP TABLE scores0;
			-- update ���̺�� set �÷��� - ��, �÷��� = ��, �÷��� = ��,....
			-- WHERE ���� �÷� �����
			-- DELETE FROM ���̺�� WHERE �����÷������
			-- �������� : update�� delete�� where ���� ����ϴ� ���� ������ ����
			-- 			��� �����͸� ������ ���� delete ��ſ� TRUNCATE�� ����մϴ�
			--			truncate�� ������ ���(rollback)�� �� ���� ������ DDL�� ���մϴ�.

SELECT * FROM students0;
-- update, delete, select ���� where�� �÷��� �⺻Ű �÷��̸�
--	����Ǵ� ����� �ݿ��Ǵ� ���� �ִ� 1���̴�
--	�⺻Ű�� ������ ���̺��� ��������� ����(�ĺ�)�ϴ� ���� ���� �̹Ƿ�!
UPDATE students0 SET age = 16 WHERE STUNO = 2021001;	-- num�÷� ���� 2021001�� ����� age ���� 17�� 

-- rollback , commit �׽�Ʈ (�����ͺ��̽� �޴����� Ʈ����� ��带 manual�� �����մϴ�.)
UPDATE students0 SET NAME = '����', ADDRESS = '���ʱ�', age = 17 WHERE STUNO = 2021001; 
ROLLBACK;	--���� UPDATE ������ ���
SELECT * FROM STUDENTS0;	-- �ٽ� '���ʱ�', 17���� ����
UPDATE students0 SET ADDRESS  = '���ϱ�', age = 16 WHERE STUNO = 2021001;
COMMIT;
SELECT * FROM students0;		--'���ϱ�' , 16���� �ݿ���.
ROLLBACK;			
SELECT * FROM students0;		--�̹� COMMIT�� �� ��ɾ�� ROLLBACK ����.
------------------------------------------�������
-- Ʈ����� ������� : ROLLBACK, COMMIT


DELETE FROM scores0;
DELETE FROM scores0;
SELECT * FROM scores0;
DELETE form score WHERE STUNO = 2019019;
SELECT * FROM scores0;
--39���� ����������
--�� ������� Ʈ����� ���� ����̰� ���� â������ select ��� 2019019�� �����ϴ�.
-- �ٸ� ������� �ٸ� Ŭ���̾�Ʈ �̹Ƿ� ���� ����(���� Ŀ���� ����)�� �������ϴ�.
ROLLBACK;
SELECT * FROM scores0;

--------------------------------------------������� �ι�° ����
TRUNCATE TABLE scores0;		--��� �����͸� ����ϴ�. ROLLBACK ���� Ȯ��?
							--�� : rollback �Ұ�.
--��絥���͸� ���� ���� Ȯ���ϸ� �ٸ� �͵�� ������ �ѹ���� �ʰ� Ȯ���ϰ� TRUNCATE �ض�.
--------------------------------------------

/*
 *  INSERT
 * DELETE
 * COMMIT;		(1) ���� 43, 44
 * UPDATE
 * DELETE;
 * ROLLBACK;	(2) ���� 46, 47
 * INSERT;
 * INSERT;
 * ROLLBACK;	(3) ���� 49, 50
 * INSERT
 * UPDATE;
 * COMMIT;		(4) ���� 52, 53
 * 
 */




--1������ ������ ��� 10�� ���� �������� ����  �� ��ȭ��, port,���ּ�( ip), �����, NIC, ����ġ, �����ּ�(MAC), ���, �̺�

--2 ������E_R���̾�׷� �׸���
--ǥ��� chen ,** ��������ǥ���** �׸����� �׷��� ���� ���̺� 3���� ������ �����ϵ� ���� ǥ��� -> ���� ���� -> ��͹� ǥ�� ������ 3���� ���� �� �ϳ��� ���蹮�� Ǯ��
--����Ŭ�� ������ - �ڵ� �������


