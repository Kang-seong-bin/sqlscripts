-- SELECT 기본형식
-- SELECT 컬럼1, 컬럼2,.... from 테이블명 WHERE 검색조건식 
--						order by 기준컬럼 (기본은 오름 : asc, 내림 : desc)

SELECT * FROM tbl_buy tb;	--INSERT 순서로 결과 출력
SELECT * FROM TBL_CUSTOM;
SELECT * FROM TBL_CUSTOM order BY CUSTOM_ID ;
SELECT * FROM TBL_BUY WHERE CUSTOM_ID ='mina012';
SELECT * FROM TBL_BUY WHERE CUSTOM_ID ='mina012'--WHERE 와 ORDER BY 를 같이 쓸 떄는 where(조건식)이 먼저 나와야한다.
						ORDER BY BUY_DATE DESC;





-- 조회할 컬럼 지정할 떄 DISTINCT 키워드 : 중복 값은 1번만 결과 출력.
SELECT custom_id from TBL_BUY tb ;	--구매고객 ID 조회
SELECT DISTINCT custom_id from TBL_BUY  ; --중복 값은 1번만


