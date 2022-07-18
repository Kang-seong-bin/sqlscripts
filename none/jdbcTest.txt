INSERT INTO TBL_BUY(custom_id,PCODE,QUANTITY,BUYNO)
VALUES ('sana97', 'GALAXYS22',1,tblbuy_seq.nextval);

SELECT * FROM TBL_BUY tb ;

---------commit과 rollback 

DELETE FROM TBL_BUY tb   WHERE CUSTOM_ID = 'sana97';
DELETE FROM TBL_CUSTOM tc WHERE CUSTOM_ID = 'sana97';

SELECT * FROM TBL_CUSTOM tc ;
ROLLBACK;		--commit전 INSERT 취소



--

SELECT * FROM TBL_CUSTOM tc ;

SELECT name,email FROM TBL_CUSTOM tc WHERE CUSTOM_ID ='?';  --twice 가 ?일 때로

ALTER TRIGGER secure_custom disable;
UPDATE TBL_CUSTOM SET EMAIL = 'test@gmail.com'
WHERE CUSTOM_ID = 'twice';

SELECT * FROM TBL_CUSTOM tc ;

DELETE FROM TBL_CUSTOM tc WHERE CUSTOM_ID = '?';
