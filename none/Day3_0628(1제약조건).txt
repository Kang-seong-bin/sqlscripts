-- 제약 조건 설정은 CREATE table, alter table 에서 합니다.

-- 제약 조건 1) not null : col2 컬럼은 반드시 값을 저장해야 합니다.
CREATE table tbl# (
	col1 varchar2(10),
	col2 number(3) NOT NULL
);

INSERT INTO tbl#(col2) VALUES (98);
INSERT INTO tbl#(col1) VALUES ('korean');	--오류 : col2 컬럼의 NOT NULL 제약조건 위반
INSERT INTO tbl# VALUES ('korean',78);
INSERT INTO tbl# VALUES ('korean',88);

--확인
SELECT * FROM tbl#;
-----------------------------------------------------------------
--새로운 제약조건 2) unique 를 갖는 col3
alter table tbl# ADD col3 varchar2(10) UNIQUE; --UNIQUE 는 유일한 값이어야 합니다.
SELECT * FROM tbl#;

--다음 INSERTfmf 순서대로 실행할 때 오류가 발생하는 것은?
INSERT INTO tbl#(col1) VALUES ('english');--오류
INSERT INTO tbl#(col2) VALUES(77);
INSERT INTO tbl#(col3) VALUES('english');--오류
INSERT INTO tbl#(col1,col2) VALUES ('english',88);
INSERT INTO tbl#(col2,col3) VALUES (88,'science');
INSERT INTO tbl#(col1,col3) VALUES 'science',88); --오류
--오류 : 무결성 제약 조건(C##IDEV.SYS_C008349)에 위배됩니다.
INSERT INTO tbl#(col1,col2,col3) VALUES ('english',89,'science');

INSERT INTO tbl#(col1,col2,col3) VALUES ('english',89,'math');
-- 체크 사항 : unique 컬럼에는 null은 허용됩니다..
SELECT * FROM tbl#;


-- 제약 조건 3) 기본키 (primary key) 는 not null 과 unique 제약조건입니다.

CREATE table tbl2# (
	tno number(3) primary key ,
	tid number(3) unique 
);

INSERT INTO tbl2#(tno) VALUES (123);
SELECT * FROM tbl2#;
--무결성 제약조건(pk 기본키 컬럼은 유일한 값이면서 not null 이어야합니다.)에 위배됩니다.

INSERT INTO tbl2#(tno) VALUES (123);	--unique 
INSERT INTO tbl2#(tid) VALUES (123);	--not null 
SELECT * FROM tbl2#;

-- 제약조건 4) check : 컬럼 값의 범위를 설정 -> age컬럼 값은 16 ~ 80 , null 허용합니다.
alter table TBL2# ADD age number(3) check (age BETWEEN 16 AND 80); 
INSERT INTO tbl2#(tno,tid,age) VALUES (222,123,20);
INSERT INTO tbl2#(tno,tid,age) VALUES (223,124,90);	-- 오류 : 체크 제약조건 위배
-- 성별 gender 컬럼 추가
ALTER table TBL2# ADD gender char(1) check (gender IN ('M','F'));
INSERT INTO TBL2# (tno,GENDER) VALUES (224,'F');
INSERT INTO TBL2# (tno,GENDER) VALUES (225,'M');
INSERT INTO TBL2# (tno,GENDER) VALUES (226,'m');	--오류 : CHECK 제약조건 위반

-- 성별 gender 컬럼의 제약조건 변경은 삭제(drop) 후 추가(add) 해야합니다.

ALTER  table "TBL2#" drop constraint "tbl2__chk_gender"; 
ALTER  table "TBL2#" add constraint tbl2_chk_gender2
check (gender IN ('M','F','m','f'));
-- 현재 gender 컬럼의 제약조건만 변경하는 경우는 다른 명령어로 해야합니다.
--	alter table ~ drop constraints 로 기존 제약조건 삭제해야합니다.
INSERT INTO "TBL2#" (tno,GENDER) VALUES (226,'m');
INSERT INTO "TBL2#" (tno,GENDER) VALUES (227,'f'); 
