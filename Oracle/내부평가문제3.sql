--�ۼ��� ������


-----����3 
--����3 1)
INSERT INTO tbl_postcode values(137964,'����Ư���� ���ʱ� ����2��');
INSERT INTO tbl_postcode values(138761,'����Ư���� ���ı� ������ 409880');
INSERT INTO tbl_postcode values(412510,'��⵵ ���� ���籸 ������');
INSERT INTO tbl_postcode values(409880,'��õ������ ������ �ڿ���');
SELECT *FROM  tbl_postcode;

--����3 2)
UPDATE TBL_CUSTOM# SET postcode  = 137964
WHERE CUSTOM_ID = 'mina012';
UPDATE TBL_CUSTOM# SET postcode  = 412510
WHERE CUSTOM_ID = 'hongGD';
UPDATE TBL_CUSTOM# SET postcode  = 409880
WHERE CUSTOM_ID = 'wonder';
UPDATE TBL_CUSTOM# SET postcode  = 138761
WHERE CUSTOM_ID = 'sana';
SELECT * FROM TBL_CUSTOM#;




--����3 3)
CREATE VIEW v_custom_info 
AS
select 
tc.custom_id,tp.postcode ,tp.area1 
from TBL_CUSTOM# tc,TBL_POSTCODE tp  
WHERE tc.POSTCODE = tp.POSTCODE ;
select 


SELECT *FROM v_custom_info;