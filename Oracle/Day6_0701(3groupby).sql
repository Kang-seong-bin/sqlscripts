--주제 : 행을 그룹화 합니다. 사용하는 순서는 아래 순서대로 지키기.
-- SELECT 문
-- [WHERE] 그룹화 하기 전에 사용할 조건식
-- group BY 그룹화에 사용할 컬럼명
-- [HAVING] 그룹화 결과에 대한 조건식
-- [ORDER BY] 그룹화 결과 정렬할 컬럼명가 방식

SELECT PCODE , COUNT(*)  FROM TBL_BUY tb group BY PCODE ;
SELECT PCODE , COUNT(*) , SUM(QUANTITY) 
FROM TBL_BUY tb 
group BY PCODE 
ORDER BY 2;			-- 조회된 컬럼의 위치 

SELECT PCODE , COUNT(*) cnt , SUM(QUANTITY) total 
FROM TBL_BUY tb 
group BY PCODE 
ORDER BY cnt;		--그룹함수 결과의 별칭

--그룹화 후에 수량합계가 3 이상만 조회

SELECT PCODE , COUNT(*) cnt , SUM(QUANTITY) total 
FROM TBL_BUY tb 
group BY PCODE 
-- HAVING total >= 3		--HAVING 에는 컬럼 별칭 사용 못함. 테이블컬럼명은 사용할 수 있음.
HAVING SUM(QUANTITY) >=3 
ORDER BY cnt;		-- 그룹함수 결과의 별칭

-- 구매날짜 2022-04-01 이후인 것만 그룹화하여 조회
SELECT PCODE , COUNT(*) cnt , SUM(QUANTITY) total 
FROM TBL_BUY tb 
WHERE BUY_DATE >= '2022=04-01'
GROUP BY PCODE 
ORDER BY cnt;
-- Day2 참고 
--통계 함수 : count, avg, max, min, sum . 통계 함수는 그룹 함수라고도 합니다.
--			해당 함수 결과 값을 구하기 위해 특정 컬럼 사용하여 여러 데이터를 그룹화한 후 실행.
SELECT count(*) FROM EMPLOYEES ; 	--테이블 전체 데이터 갯수 	: 107
SELECT max(salary) FROM EMPLOYEES ; --salary 컬럼의 최대 값 : 24000
SELECT min(salary) FROM EMPLOYEES ; --salary 컬럼의 최소 값 : 2100
SELECT avg(salary) FROM EMPLOYEES ;	--salary 컬럼의 평균 값 : 6461.831775700934579439252336448598130841
SELECT sum(salary) FROM EMPLOYEES ; --salary 컬럼의 합계 	: 691416

--위 5개 통계 함수를 JOB_ID = 'IT_PROG' 값을 조건식으로 똑같이 실행해보기
SELECT count(*) FROM EMPLOYEES WHERE job_ID ='IT_PROG'; 	--IT_PROG의 데이터 갯수 	: 5
SELECT max(salary) FROM EMPLOYEES WHERE job_ID ='IT_PROG'; --IT_PROG 컬럼의 최대 값 : 9000
SELECT min(salary) FROM EMPLOYEES WHERE job_ID ='IT_PROG'; --IT_PROG 컬럼의 최소 값 : 4200
SELECT avg(salary) FROM EMPLOYEES WHERE job_ID ='IT_PROG';	--IT_PROG 컬럼의 평균 값 : 5760
SELECT sum(salary) FROM EMPLOYEES WHERE job_ID ='IT_PROG'; --IT_PROG 컬럼의 합계 	: 28800

-- 통계 함수 결과는 다른 컬럼 값과 같이 조회할 수 없다. (그룹 함수이기 때문입니다.)
SELECT JOB_ID , count(*) FROM EMPLOYEES	--오류 : 단일 그룹의 그룹 함수가 아닙니다!
WHERE job_ID ='IT_PROG';