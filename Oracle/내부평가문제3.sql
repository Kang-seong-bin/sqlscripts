--작성자 강성빈


-----문제3 
--문제3 1)
INSERT INTO tbl_postcode values(137964,'서울특별시 서초구 서초2동');
INSERT INTO tbl_postcode values(138761,'서울특별시 송파구 장지동 409880');
INSERT INTO tbl_postcode values(412510,'경기도 고양시 덕양구 벽제동');
INSERT INTO tbl_postcode values(409880,'인천광역시 옹진군 자월면');
SELECT *FROM  tbl_postcode;

--문제3 2)
UPDATE TBL_CUSTOM# SET postcode  = 137964
WHERE CUSTOM_ID = 'mina012';
UPDATE TBL_CUSTOM# SET postcode  = 412510
WHERE CUSTOM_ID = 'hongGD';
UPDATE TBL_CUSTOM# SET postcode  = 409880
WHERE CUSTOM_ID = 'wonder';
UPDATE TBL_CUSTOM# SET postcode  = 138761
WHERE CUSTOM_ID = 'sana';
SELECT * FROM TBL_CUSTOM#;




--문제3 3)
CREATE VIEW v_custom_info 
AS
select 
tc.custom_id,tp.postcode ,tp.area1 
from TBL_CUSTOM# tc,TBL_POSTCODE tp  
WHERE tc.POSTCODE = tp.POSTCODE ;
select 


SELECT *FROM v_custom_info;