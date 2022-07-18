CREATE TABLE student# (
	col_st_no char(7) primary key,
	col_name varchar2(10)  NOT NULL,
	co1_age number(3),
	col_add	varchar2(10) 
);
INSERT INTO student# values(2021001,'����',16,'���ʱ�');
INSERT INTO student# values(2019019,'������',18,'������');
SELECT *FROM student# ;


CREATE TABLE grade# (
	col_st_no char(7) NOT null,
	col_sub varchar2(10) NOT null, 
	col_grade number (3) NOT null,	--����
	col_teacher varchar2 (10) NOT null,
	col_class_term varchar2 (10) NOT NULL, --�б�
	PRIMARY KEY (col_st_no,col_sub),	--�⺻Ű ���� (not null �׸��� unique)
	FOREIGN KEY (col_st_no) REFERENCES student#(col_st_no)
	--�ܷ�Ű ���� REFERENCES (����) Ű���� �ڿ� �������̺�(�����÷�)
		--	�ܷ�Ű �÷��� �����÷� ��� col_st_no �� ������ (���� �÷�) ��������
	--�ܷ�Ű �÷��� FOREIGN KEY Ű���� �ڿ� (���ھ����̺� col_st_no) �ȿ� �ۼ�.
	--�˻��غ�����. ���� �÷��� ������? �⺻Ű �Ǵ� unique ���� ���� �÷��� �˴ϴ�.
	);--�⺻Ű �ܷ�Ű �߿�
INSERT INTO grade# values (2021001,'����',89,'�̳���','2022_1');
INSERT INTO grade# values (2021001,'����',78,'��浿','2022_1');
INSERT INTO grade# values (2021001,'����',67,'�ڼ���','2021_2');
INSERT INTO grade# values (2019019,'����',92,'�̳���','2019_2');
INSERT INTO grade# values (2019019,'����',85,'������','2019_2');
INSERT INTO grade# values (2019019,'����',88,'�ڼ���','2020_1');
SELECT *FROM grade# ;