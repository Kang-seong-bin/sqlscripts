CREATE TABLE student# (
	col_st_no char(7) primary key,
	col_name varchar2(10)  NOT NULL,
	co1_age number(3),
	col_add	varchar2(10) 
);
INSERT INTO student# values(2021001,'김모모',16,'서초구');
INSERT INTO student# values(2019019,'강다현',18,'강남구');
SELECT *FROM student# ;


CREATE TABLE grade# (
	col_st_no char(7) NOT null,
	col_sub varchar2(10) NOT null, 
	col_grade number (3) NOT null,	--점수
	col_teacher varchar2 (10) NOT null,
	col_class_term varchar2 (10) NOT NULL, --학기
	PRIMARY KEY (col_st_no,col_sub),	--기본키 설정 (not null 그리고 unique)
	FOREIGN KEY (col_st_no) REFERENCES student#(col_st_no)
	--외래키 설정 REFERENCES (참조) 키워드 뒤에 참조테이블(참조컬럼)
		--	외래키 컬럼과 참조컬럼 모두 col_st_no 로 같으면 (참조 컬럼) 생략가능
	--외래키 컬럼은 FOREIGN KEY 키워드 뒤에 (스코어테이블 col_st_no) 안에 작성.
	--검색해보세요. 참조 컬럼의 조건은? 기본키 또는 unique 제약 조건 컬럼만 됩니다.
	);--기본키 외래키 중요
INSERT INTO grade# values (2021001,'국어',89,'이나연','2022_1');
INSERT INTO grade# values (2021001,'영어',78,'김길동','2022_1');
INSERT INTO grade# values (2021001,'과학',67,'박세리','2021_2');
INSERT INTO grade# values (2019019,'국어',92,'이나연','2019_2');
INSERT INTO grade# values (2019019,'영어',85,'박지성','2019_2');
INSERT INTO grade# values (2019019,'과학',88,'박세리','2020_1');
SELECT *FROM grade# ;