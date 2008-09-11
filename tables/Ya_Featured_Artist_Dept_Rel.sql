DROP TABLE Ya_Featured_Artist_Dept_Rel
/

CREATE TABLE Ya_Featured_Artist_Dept_Rel (
	dept_id                           int                     NOT NULL ,
	artist_id                         int                     NOT NULL ,
	artist_role                       varchar2(50)            NOT NULL ,
	created_datetime                  date                    NOT NULL
)
/

ALTER TABLE Ya_Featured_Artist_Dept_Rel
ADD CONSTRAINT PK_Featured_Artist_Dept_Rel PRIMARY KEY (dept_id, artist_id, artist_role)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Featured_Artist_Dept_Rel FOR Ya_Featured_Artist_Dept_Rel
/