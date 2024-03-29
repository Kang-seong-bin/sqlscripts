/*
 * [[[[ ' 도서대여
 * 
 * -대여한다. : rent_date 는 대여일자, ㄷxp_date는 반납기한일자이며 rent_date + 14
 * -반납한다. : return date 는 반납일자, delay_days는 연체일수 return date - exp_date
 * - 대출 중인 것을 확인하는 처리조건 : return_date 가 null이면 대여중, null이 아니면 반납된 도서.
 */


--1)도서를 추가합니다. ‘B1102’ , ‘스트라이크 던지기’, ‘박철순’ ,’KBO’ , ‘2020-11-10’’
INSERT INTO tbl_book (bcode,title,writer,publisher,pdate)
values('B1102', '스트라이크 던지기', '박철순', 'KBO', '2020-11-10');
--2)반납된 도서의 연체일수를 계산하여 delay_days 컬럼값을 update 합니다.
UPDATE TBL_BOOKRENT SET delay_days = RETURN_date - exp_date
WHERE RETURN_date IS NOT NULL;
SELECT * FROM tbl_book ;
SELECT * FROM tbl_bookrent;
--3)현재 대출중인 도서의 연체일수계산해서 회원IDX, 도서코드, 연체 일수 조회합니다.
-- 오늘 날짜 sysdate 는 년월일 패턴이 지정되지 않아 그냥하면 long 값으로 계산됩니다.
SELECT mem_idx, bcode, to_date(to_char(sysdate,'yyyy-MM-dd')) - exp_date 
FROM tbl_bookrent WHERE RETURN_date IS NULL;

--4) 현재 대출 중인 도서 중 연체인 회원의 이름,전화번호를 검색합니다. 오늘 날짜 sysdate 기준으로 확인하기.!
SELECT name,tel FROM BOOK_MEMBER bm JOIN tbl_bookrent tb
ON bm.mem_idx = tb.mem_idx AND SYSDATE > exp_date AND RETURN_date IS NULL;

--5) 현재 대출중인 도서의 도서명 코드와 도서명 검색합니다.
SELECT tb.bcode ,title  FROM tbl_book tb JOIN tbl_bookrent tb2
ON tb.bcode = tb2.bcode AND return_date IS NULL;


--6) 현재 도서를 대여한 회원의 IDX와 회원이름을 검색합니다.
SELECT bm.mem_idx , name  FROM BOOK_MEMBER bm JOIN tbl_bookrent tb
ON bm.mem_idx = tb.mem_idx AND RETURN_date IS NULL;

-- 7) 대출 중인 도서의 회원이름, 도서명, 반납기한 검색합니다.
--join
SELECT name, title  ,exp_date FROM tbl_book tb 
JOIN tbl_bookrent tb2 ON tb.bcode = tb2.bcode 
JOIN BOOK_MEMBER  bm ON bm.mem_idx =tb2.mem_idx 
WHERE  return_date IS NULL; 

-- 또는 join x
SELECT bm.name , tb.title ,tb2.exp_date 
FROM book_member bm, tbl_book tb, tbl_bookrent tb2
WHERE bm.mem_idx = tb2.mem_idx AND tb.bcode = tb2.bcode 
AND tb2.return_date IS NULL;



--8)현재 연체 중인 도서의 회원IDX, 도서코드, 반납기한을 검색합니다.
SELECT mem_idx ,bcode ,exp_date FROM tbl_bookrent tb
WHERE sysdate > exp_date;
--9)회원  IDX ‘10002’는 도서 대출이 가능한지 프로시저를 작성합니다.
--CREATE OR REPLACE PROCEDURE 'WTRT' (param_index NUMBER(5))

-- 일회용으로 실행하는 프로시저
DECLARE
	vcnt NUMBER;
BEGIN 
	SELECT count(*) 
	INTO vcnt -- SELECT 조회 결과 저장할 변수. 여러개 , 로 나열할 수 있음.
	FROM tbl_bookrent tb
	WHERE mem_idx =10001 AND RETURN_date IS NULL;		--rcnt가 0일때만 대여가능
	IF (vcnt = 0) THEN
	DBMS_OUTPUT.put_line('책 대여 가능합니다.');
	ELSE
	DBMS_OUTPUT.put_line('대여 중인 책을 반납해야 가능합니다.');
	END IF;
END;

--프로시저 오라클 객체
CREATE OR REPLACE PROCEDURE CHECK_member(
	arg_mem IN book_member.MEM_IDX%TYPE,	-- 프로시저 실행할때 값을 받을 매개변수 
	isOK OUT varchar2		--자바의 리턴값에 해당하는 부분
	)
IS 
vcnt NUMBER;
vname varchar2(100);
	BEGIN 	--입력매개변수가 없는 회원인가를 확인하는 sql과 EXCEPTION 처리 . arg_mem으로 회원테이블에서 name조회
		-- 없으면 exception 처리
		SELECT name
		INTO vname		--변수에 저장.
		FROM BOOK_MEMBER bm WHERE mem_idx = arg_mem ;
		
	SELECT count(*) 
	INTO vcnt 
	FROM tbl_bookrent tb
	WHERE mem_idx =arg_mem AND RETURN_date IS NULL;		--rcnt가 0일때만 대여가능
	IF (vcnt = 0) THEN
	DBMS_OUTPUT.put_line('책 대여 가능합니다.');
	isOK := '가능';
	ELSE
	DBMS_OUTPUT.put_line('대여 중인 책을 반납해야 가능합니다.');
	isOK := '불가능';
	END IF;
EXCEPTION		-- 예외(오류)처리
	WHEN no_data_found THEN  
		DBMS_OUTPUT.PUT_LINE('회원이 아닙니다.');	
	isOK := 'no match'; 
END;
	--프로시저 실행하기
	DECLARE
		vresult varchar2(20);
	BEGIN


		CHECK_member(10003,vresult);
		DBMS_OUTPUT.put_line('결과 : ' || vresult);
	END;
	



--10)도서명에 ‘스트’ 라는 글자가 들어가는 도서를 검색하여 도서 대출이 가능한지 프로시저를 작성합니다. 프로시저이름은 check_book 으로 하세요.
DECLARE
	v_bcode varchar2(20);
	v_cnt NUMBER;
	BEGIN 
	SELECT bcode  INTO v_bcode		--v_bcode는 'A1102'
	FROM tbl_book tb WHERE title LIKE '페스트'; 		
	SELECT count(*) INTO v_cnt		--v_cnt값이 1이면 v_bcode 책은 대출중
			FROM tbl_bookrent tb2 WHERE bcode = v_bcode AND return_date IS NULL;
	IF (v_cnt = 0) THEN
	dbms_output.put_line('그 책은 대여 가능합니다.');
	ELSE
	dbms_output.put_line('그 책은 대여 중입니다.');
	END IF;
END; 

--

--프로시저 오라클 객체
CREATE OR REPLACE PROCEDURE CHECK_BOOK(
			arg_book IN tbl_book.TITLE%TYPE,	-- 프로시저 실행할때 값을 받을 매개변수 
			isOK OUT varchar2		--자바의 리턴값에 해당하는 부분
	)
		IS 	
		v_bcode varchar2(100);
		v_cnt NUMBER;
	BEGIN 
	SELECT BCODE INTO v_bcode 		---v_bcode는 'A1102'
		FROM tbl_book tb WHERE title = arg_book;
	SELECT count(*) INTO v_cnt		-- v_cnt 값이 1이면 v_bcode 책은 대출중
	FROM tbl_bookrent tb2 WHERE bcode = v_bcode AND return_date IS NULL; 
	IF (v_cnt = 1) THEN
	DBMS_OUTPUT.put_line('대여 중인 책 입니다.');
	isOK := 'FALSE';
	ELSE
	DBMS_OUTPUT.put_line('책 대여 가능합니다.');
	isOK := 'TRUE';
	END IF;
EXCEPTION		-- 예외(오류)처리
	WHEN no_data_found THEN  
		DBMS_OUTPUT.PUT_LINE('찾는 데이터가 없습니다.');	
	isOK := 'no match'; 
END;
	--프로시저 실행하기
	DECLARE
		vresult varchar2(100);
	BEGIN
		CHECK_book('페스트',vresult); 	--코스모스, 푸른사자 와니니 는 FALSE 나머지는 TRUE
		DBMS_OUTPUT.put_line('결과 : ' || vresult);
	END;
--

--11)9과 10을 이용해서 insert 를 하는 프로시저를 작성합니다. 

