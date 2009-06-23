DROP TABLE Ya_Artist_Dept
/

CREATE TABLE Ya_Artist_Dept (
	artist_id        number(10)            NOT NULL ,
	dept_id          number(10)            NOT NULL
)
/

ALTER TABLE Ya_Artist_Dept
ADD CONSTRAINT PK_Artist_Dept PRIMARY KEY (artist_id, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Artist_Dept_01 ON Ya_Artist_Dept(dept_id, artist_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Artist_Dept FOR Ya_Artist_Dept
/