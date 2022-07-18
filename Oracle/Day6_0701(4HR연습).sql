-- HR ��Ű���� �̿��Ͽ�  ���ΰ� group by �� �����ؼ� select �� �˻��ϴ� ������ 10�� �����
-- group by ����ε� ������ �� �� �ֽ��ϴ�.	����: �μ��ο��� ���� ���� �μ���?
--�ۼ��� ������
--1 �� ���޺� ���� ������ (��) ���� ��ȸ 
SELECT salary , COUNT(*) FROM EMPLOYEES e group by SALARY ; 


--2 ���� �� ���� ���� ��� �ӱ�
SELECT JOB_ID  , COUNT(*) ,avg(SALARY)
FROM EMPLOYEES e 
group by JOB_ID  
ORDER BY 3 ;

--3 ��� �ӱ��� 10000������ ����, ���� �� ���� ���� ��� �ӱ� 
SELECT JOB_ID  , COUNT(*) ,avg(SALARY)
FROM EMPLOYEES e 
WHERE SALARY <=10000
group by JOB_ID  
ORDER BY 3;
--4 2003�� �������� �ٹ��� ���ټӸ�� �̸�
SELECT FIRST_NAME   ,  count(JOB_ID) 
FROM EMPLOYEES e
WHERE HIRE_DATE <= '2003-01-01'
group by FIRST_NAME  
ORDER BY 2; 

--5 �ְ����� �̸� �� �ӱ�
SELECT FIRST_NAME  , sum(salary)
FROM EMPLOYEES e 
WHERE MANAGER_ID  IS null
GROUP BY FIRST_NAME  
ORDER BY 2;

--6 �ְ����� ���� ���� �̸� �� �ӱ�
SELECT FIRST_NAME  , sum(salary)
FROM EMPLOYEES e 
WHERE MANAGER_ID  NOT BETWEEN 101 AND 300
GROUP BY FIRST_NAME  
ORDER BY 2;

--7 ��������μ� ID, ��� �ټ����� �� ��� �ӱ�
SELECT department_id , COUNT(*) num_peo , avg (SALARY) dp_avg
FROM EMPLOYEES e 
WHERE HIRE_DATE <= '2003-01-01'
GROUP BY DEPARTMENT_ID 
ORDER BY num_peo;

--8 �μ�Ƽ�� ���� ����� ID
SELECT EMPLOYEE_ID  , count(*)num_peo , avg (SALARY) dp_avg
FROM EMPLOYEES e 
WHERE COMMISSION_PCT  > 0
GROUP BY EMPLOYEE_ID  
ORDER BY num_peo;

-- 9 ���� King�� �������� �� ����
SELECT * FROM EMPLOYEES e  WHERE LAST_NAME  = 'King';

-- 10 �ӱ� 10000�̻��� �μ�Ƽ�� ���� ����� Ǯ����/ ���� �� ���� �μ�Ƽ�� ����
select FIRST_NAME,LAST_NAME,COMMISSION_PCT,SALARY  FROM EMPLOYEES e  
WHERE EMPLOYEE_ID  in			
(SELECT EMPLOYEE_ID  FROM EMPLOYEES e  WHERE SALARY  >= 10000
 					and COMMISSION_PCT  IS NOT  NULL);
 					
 				
 				
 				
 				
 				
 				---------------------------
 				
 				-- �μ��� ��ձ޿��� ��ȸ�մϴ�. ������ ��ձ޿� ������������ �μ�-ID, �μ���, ��ձ޿�(�Ҽ��� 1�ڸ��� �ݿø�)
 				-- ����Ŭ �Ҽ��� ���� �Լ� : round(�ݿø�), trunc(����), ceil(����)
 				
 				--�׷� �Լ� ��ȸ�� �� group by�� ��� �׷���̿� �� �÷��� SELECT �� ��ȸ�� �� �ֽ��ϴ�.
 				-- �׷���� �÷��ܿ��� �ٸ� �÷� select �� �� �����ϴ�. -> JOIN ,��������
 			-- 1�ܰ� : ����� �׷��Լ� �����ϱ�
			select DEPARTMENT_ID , AVG(salary) FROM EMPLOYEES e group BY DEPARTMENT_ID  ;
 			-- 2�ܰ� :�����ϱ�
 			SELECT * FROM DEPARTMENTS d JOIN
 			(SELECT DEPARTMENT_ID, AVG(salary) CAVG  FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
 			ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID ;
 		
 		-- 3�ܰ� : �÷� �����ϱ�
 			SELECT d.DEPARTMENT_ID ,d.DEPARTMENT_NAME ,round(tavg.cavg,1) FROM DEPARTMENTS d 
 			JOIN
 			(SELECT DEPARTMENT_ID, AVG(salary) CAVG  FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
 			ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID 
 			ORDER BY tavg.cavg DESC;
 		
 		-- 4�ܰ� : ������ ����� Ư�� ��ġ ���� : first n�� ���� n���� ��ȸ. 
 				
 			SELECT d.DEPARTMENT_ID ,d.DEPARTMENT_NAME ,round(tavg.cavg,1) FROM DEPARTMENTS d 
 			JOIN
 			(SELECT DEPARTMENT_ID, AVG(salary) CAVG  FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
 			ON d.DEPARTMENT_ID = tavg.DEPARTMENT_ID 
 			ORDER BY tavg.cavg DESC
 			FETCH FIRST 1 ROWS ONLY; --����Ŭ12c �������� ����մϴ�.
 			
 		-- �ٸ� ����
 		SELECT d.department_id did, d.department_name , e.cnt
 		FROM DEPARTMENTS d 
 		JOIN
 		(SELECT DEPARTMENT_ID, COUNT(*) cnt FROM EMPLOYEES e 
 		group BY DEPARTMENT_ID 	) e
 		ON d.DEPARTMENT_ID  = e.DEPARTMENT_ID 
 		ORDER BY cnt DESC 
 		FETCH FIRST 1 ROWS ONLY;
 		
 	-- ����Ŭ�� rownum�� ������ �÷����� ��ȸ�� ����� ���������� ����Ŭ�� �ο��ϴ� ���Դϴ�. 
 	-- ���� �÷� ����� ���� join�� �ѹ� �� �ʿ��մϴ�.
 	
 	SELECT rownum,tcnt.*FROM
 	(SELECT department_id, COUNT(*) cnt FROM EMPLOYEES e
 		group BY  DEPARTMENT_ID ORDER BY cnt DESC ) tcnt 
 		WHERE rownum < 5;
 	
 	SELECT rownum,tcnt.*FROM
 	(SELECT department_id, COUNT(*) cnt FROM EMPLOYEES e
 		group BY  DEPARTMENT_ID ORDER BY cnt DESC ) tcnt 
 		WHERE rownum = 1;
 	
 	-- rownum ����� �� ��� Ȯ���� �ȵǴ� ���� : rownum 1���� �����ؼ� ã�ư� �� �ִ� ���ǽĸ� ����
 	-- where rownum =3; 
 	-- where rownum > 5;
--�׷��� �ѹ��� ROWNUM �� ������ ��ȸ ����� select �� �մϴ�. �̶� ROWNUM �� ��Ī �ο�.
 	SELECT * FROM 
	 	(SELECT rownum rn,tcnt.*FROM
		 	(SELECT department_id, COUNT(*) cnt FROM EMPLOYEES e
		 		group BY  DEPARTMENT_ID ORDER BY cnt DESC ) tcnt )
		 		WHERE rn BETWEEN 5 AND 9 ;
 	