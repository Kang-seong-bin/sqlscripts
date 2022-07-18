-- HR 스키마를 이용하여  조인과 group by 를 포함해서 select 로 검색하는 문제를 10개 만들기
-- group by 결과로도 조인을 할 수 있습니다.	예시: 부서인원이 가장 많은 부서는?
--작성자 강성빈
--1 각 월급별 월급 수령자 (명) 내역 조회 
SELECT salary , COUNT(*) FROM EMPLOYEES e group by SALARY ; 


--2 직종 별 직원 수와 평균 임금
SELECT JOB_ID  , COUNT(*) ,avg(SALARY)
FROM EMPLOYEES e 
group by JOB_ID  
ORDER BY 3 ;

--3 평균 임금이 10000이하인 직종, 직종 별 직원 수와 평균 임금 
SELECT JOB_ID  , COUNT(*) ,avg(SALARY)
FROM EMPLOYEES e 
WHERE SALARY <=10000
group by JOB_ID  
ORDER BY 3;
--4 2003년 이전부터 근무한 장기근속멤버 이름
SELECT FIRST_NAME   ,  count(JOB_ID) 
FROM EMPLOYEES e
WHERE HIRE_DATE <= '2003-01-01'
group by FIRST_NAME  
ORDER BY 2; 

--5 최고위직 이름 및 임금
SELECT FIRST_NAME  , sum(salary)
FROM EMPLOYEES e 
WHERE MANAGER_ID  IS null
GROUP BY FIRST_NAME  
ORDER BY 2;

--6 최고위직 직속 직원 이름 및 임금
SELECT FIRST_NAME  , sum(salary)
FROM EMPLOYEES e 
WHERE MANAGER_ID  NOT BETWEEN 101 AND 300
GROUP BY FIRST_NAME  
ORDER BY 2;

--7 장기유지부서 ID, 장기 근속직원 및 평균 임금
SELECT department_id , COUNT(*) num_peo , avg (SALARY) dp_avg
FROM EMPLOYEES e 
WHERE HIRE_DATE <= '2003-01-01'
GROUP BY DEPARTMENT_ID 
ORDER BY num_peo;

--8 인센티브 지급 대상자 ID
SELECT EMPLOYEE_ID  , count(*)num_peo , avg (SALARY) dp_avg
FROM EMPLOYEES e 
WHERE COMMISSION_PCT  > 0
GROUP BY EMPLOYEE_ID  
ORDER BY num_peo;

-- 9 성이 King인 직원들의 개 정보
SELECT * FROM EMPLOYEES e  WHERE LAST_NAME  = 'King';

-- 10 임금 10000이상인 인센티브 지급 대상자 풀네임/ 월급 및 지급 인센티브 비율
select FIRST_NAME,LAST_NAME,COMMISSION_PCT,SALARY  FROM EMPLOYEES e  
WHERE EMPLOYEE_ID  in			
(SELECT EMPLOYEE_ID  FROM EMPLOYEES e  WHERE SALARY  >= 10000
 					and COMMISSION_PCT  IS NOT  NULL);
 					
 				
 				
 				
 				
 				
 				---------------------------
 				
 				-- 부서별 평균급여를 조회합니다. 정렬은 평균급여 내림차순으로 부서-ID, 부서명, 평균급여(소수점 1자리로 반올림)
 				-- 오라클 소수점 관련 함수 : round(반올림), trunc(버림), ceil(내림)
 				
 				--그룹 함수 조회할 떄 group by를 써야 그룹바이에 쓴 컬럼을 SELECT 로 조회할 수 있습니다.
 				-- 그룹바이 컬럼외에는 다른 컬럼 select 할 수 없습니다. -> JOIN ,서브쿼리
 			-- 1단계 : 사용할 그룹함수 실행하기
			select DEPARTMENT_ID , AVG(salary) FROM EMPLOYEES e group BY DEPARTMENT_ID  ;
 			-- 2단계 :조인하기
 			SELECT * FROM DEPARTMENTS d JOIN
 			(SELECT DEPARTMENT_ID, AVG(salary) CAVG  FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
 			ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID ;
 		
 		-- 3단계 : 컬럼 지정하기
 			SELECT d.DEPARTMENT_ID ,d.DEPARTMENT_NAME ,round(tavg.cavg,1) FROM DEPARTMENTS d 
 			JOIN
 			(SELECT DEPARTMENT_ID, AVG(salary) CAVG  FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
 			ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID 
 			ORDER BY tavg.cavg DESC;
 		
 		-- 4단계 : 정렬한 결과로 특정 위치 지정 : first n은 상위 n개를 조회. 
 				
 			SELECT d.DEPARTMENT_ID ,d.DEPARTMENT_NAME ,round(tavg.cavg,1) FROM DEPARTMENTS d 
 			JOIN
 			(SELECT DEPARTMENT_ID, AVG(salary) CAVG  FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
 			ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID 
 			ORDER BY tavg.cavg DESC
 			FETCH FIRST 1 ROWS ONLY; --오라클12c 버전부터 사용합니다.
 			
 		-- 다른 예시
 		SELECT d.department_id did, d.department_name , e.cnt
 		FROM DEPARTMENTS d 
 		JOIN
 		(SELECT DEPARTMENT_ID, COUNT(*) cnt FROM EMPLOYEES e 
 		group BY DEPARTMENT_ID 	) e
 		ON d.DEPARTMENT_ID  = e.DEPARTMENT_ID 
 		ORDER BY cnt DESC 
 		FETCH FIRST 1 ROWS ONLY;
 		
 	-- 오라클의 rownum은 가상의 컬럼으로 조회된 결과에 순차적으로 오라클이 부여하는 값입니다. 
 	-- 가상 컬럼 사용을 위해 join이 한번 더 필요합니다.
 	
 	SELECT rownum,tcnt.*FROM
 	(SELECT department_id, COUNT(*) cnt FROM EMPLOYEES e
 		group BY  DEPARTMENT_ID ORDER BY cnt DESC ) tcnt 
 		WHERE rownum < 5;
 	
 	SELECT rownum,tcnt.*FROM
 	(SELECT department_id, COUNT(*) cnt FROM EMPLOYEES e
 		group BY  DEPARTMENT_ID ORDER BY cnt DESC ) tcnt 
 		WHERE rownum = 1;
 	
 	-- rownum 사용할 때 결과 확인이 안되는 예시 : rownum 1부터 시작해서 찾아갈 수 있는 조건식만 가능
 	-- where rownum =3; 
 	-- where rownum > 5;
--그래서 한번더 ROWNUM 을 포함한 조회 결과로 select 를 합니다. 이때 ROWNUM 은 별칭 부여.
 	SELECT * FROM 
	 	(SELECT rownum rn,tcnt.*FROM
		 	(SELECT department_id, COUNT(*) cnt FROM EMPLOYEES e
		 		group BY  DEPARTMENT_ID ORDER BY cnt DESC ) tcnt )
		 		WHERE rn BETWEEN 5 AND 9 ;
 	