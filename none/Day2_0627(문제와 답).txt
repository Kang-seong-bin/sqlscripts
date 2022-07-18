/* 	
 * 직원 테이블 : 직원_ID , 이름, 성, 이메일, 폰번호, 고용일자, 업무_ID, 급여, 매니저_ID, 부서_ID)
1. hire_date가 2006년 1월 1일 이전인 직원의 이름,성,이메일 (<연산)

2. lastname이 'Jones' 인 직원의 모든 컬럼 동등한 값 조회 (=연산)

3. salary 가 5000 이상인 직원의 이름,성,JOB_ID 조회 (이상이하 =포함)

4. JOB_ID 에 ACCOUNT 가 들어가는 직원의 이름,성,salary 조회 (like 연산)

5. 부서_ID 가 50 ,60, 80,90 인 직원의 직원_ID, 이름,성 조회  (in연산)

*/	--작성자 : 강성빈
--1
SELECT first_name, last_name, email  FROM  EMPLOYEES  WHERE hire_DATE < '2006-01-01';
--2
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Jones';
--대소문자 검사는 조건식에서 주의해야할 요인 대소문자 검사로 한다!
--컬럼 값을 대소문자 변환 후 조건 값 비교	-> 대소문자와 무관하게 비교 가능
SELECT * FROM EMPLOYEES WHERE UPPER(LAST_NAME)  = 'JONES';
SELECT * FROM EMPLOYEES WHERE LOWER(LAST_NAME)  = 'jones';


--3
SELECT first_name, last_name, JOB_ID FROM EMPLOYEES WHERE SALARY >= 5000;
--4
SELECT first_name, last_name, SALARY  FROM EMPLOYEES WHERE JOB_ID LIKE '%ACCOUNT%'; 
--5 : 데이터 타입 변환
--5 or로 작성
SELECT first_name, last_name, EMPLOYEE_ID FROM EMPLOYEES 
WHERE DEPARTMENT_ID = 50 OR DEPARTMENT_ID = 60 OR DEPARTMENT_ID = 80 OR DEPARTMENT_ID = 90;
--5 in으로 작성
SELECT first_name, last_name, EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID IN (50,60,80,90);
--SELECT first_name, last_name, EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID IN ('50','60','80','90');--문자로 작성되었지만 오라클이 자동으로 형변환해주었기에 오류가 발생하지 않는다. -> 컬럼형식에 따라 number로 변환

--통계 함수 : count, avg, max, min . 통계 함수는 그룹 함수라고도 합니다.
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


-- 오늘의 요약 : create table, insert into, select ~ where ~ 기본 형식 작성

-- 참고 : 별칭(alias). 컬럼 또는 테이블 이름이 길 때 짧게 줄여서 쓰는 이름.
SELECT * FROM EMPLOYEES e;	--	EMPLOYEES 테이블의 별칭 e
SELECT * FROM DEPARTMENTS d; -- DEPARTMENTS 테이블의 별칭 d
-- 위에서는 굳이 별칭이 필요없지만 언젠간 유용하게 쓰는 날이 온다. 알아두도록