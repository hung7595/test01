DROP TABLE Ya_Bargain_Group
/

CREATE TABLE Ya_Bargain_Group (
	bargain_line_id              int                     NOT NULL ,
	group_id                     int                     NOT NULL ,
	dept_id                      int                     NOT NULL
)
/

ALTER TABLE Ya_Bargain_Group
ADD CONSTRAINT PK_Bargain_Group PRIMARY KEY (bargain_line_id, group_id, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Bargain_Group FOR Ya_Bargain_Group
/