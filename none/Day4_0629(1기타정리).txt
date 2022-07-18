--DDL : create, alter, drop, TRUNCATE
-- (대상은 user,table,sequence, view, .. 단 truncate 는 테이블만 사용 )
--DML : insert, update,  delete 


DROP TABLE students0;	--오류 : students 테이블 먼저 삭제하면
			-- 원인 : 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다
DROP TABLE scores0;
			-- update 테이블명 set 컬럼명 - 값, 컬럼명 = 값, 컬럼명 = 값,....
			-- WHERE 조건 컬럼 관계식
			-- DELETE FROM 테이블명 WHERE 조건컬럼관계식
			-- 주의할점 : update와 delete는 where 없이 사용하는 것은 위험한 동작
			-- 			모든 데이터를 삭제할 때는 delete 대신에 TRUNCATE를 사용합니다
			--			truncate는 실행을 취소(rollback)할 수 없기 때문에 DDL에 속합니다.

SELECT * FROM students0;
-- update, delete, select 에서 where의 컬럼이 기본키 컬럼이면
--	실행되는 결과가 반영되는 행은 최대 1개이다
--	기본키의 목적은 테이블의 여러행들을 구분(식별)하는 것이 목적 이므로!
UPDATE students0 SET age = 16 WHERE STUNO = 2021001;	-- num컬럼 값이 2021001인 대상의 age 값을 17로 

-- rollback , commit 테스트 (데이터베이스 메뉴에서 트랙잭션 모드를 manual로 변경합니다.)
UPDATE students0 SET NAME = '쯔위', ADDRESS = '서초구', age = 17 WHERE STUNO = 2021001; 
ROLLBACK;	--위의 UPDATE 실행을 취소
SELECT * FROM STUDENTS0;	-- 다시 '서초구', 17세로 복구
UPDATE students0 SET ADDRESS  = '성북구', age = 16 WHERE STUNO = 2021001;
COMMIT;
SELECT * FROM students0;		--'성북구' , 16세로 반영됨.
ROLLBACK;			
SELECT * FROM students0;		--이미 COMMIT이 된 명령어는 ROLLBACK 못함.
------------------------------------------여기까지
-- 트랜잭션 관리명령 : ROLLBACK, COMMIT


DELETE FROM scores0;
DELETE FROM scores0;
SELECT * FROM scores0;
DELETE form score WHERE STUNO = 2019019;
SELECT * FROM scores0;
--39라인 실행했을때
--이 편집기는 트랜잭션 수동 모드이고 같은 창에서는 select 결과 2019019가 없습니다.
-- 다른 편집기는 다른 클라이언트 이므로 이전 상태(최종 커밋한 상태)로 보여집니다.
ROLLBACK;
SELECT * FROM scores0;

--------------------------------------------여기까지 두번째 예시
TRUNCATE TABLE scores0;		--모든 데이터를 지웁니다. ROLLBACK 여부 확인?
							--답 : rollback 불가.
--모든데이터를 지울 것이 확실하면 다른 것들과 섞여서 롤백되지 않게 확실하게 TRUNCATE 해라.
--------------------------------------------

/*
 *  INSERT
 * DELETE
 * COMMIT;		(1) 라인 43, 44
 * UPDATE
 * DELETE;
 * ROLLBACK;	(2) 라인 46, 47
 * INSERT;
 * INSERT;
 * ROLLBACK;	(3) 라인 49, 50
 * INSERT
 * UPDATE;
 * COMMIT;		(4) 라인 52, 53
 * 
 */




--1번문제 데이터 용어 10개 보고서 형식으로 정리  웹 방화벽, port,논리주소( ip), 라우터, NIC, 스위치, 물리주소(MAC), 허브, 이블

--2 번문제E_R다이어그램 그리기
--표기법 chen ,** 정보공학표기법** 그림으로 그려서 제출 테이블 3개임 간단한 구조일듯 관계 표기법 -> 정보 공학 -> 까마귀발 표기 오늘한 3가지 예시 중 하나로 시험문제 풀이
--오라클의 시퀀스 - 자동 순서기능


