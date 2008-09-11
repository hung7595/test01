DROP TABLE Ya_Dept_Upcoming
/

CREATE TABLE Ya_Dept_Upcoming (
	dept_id                        int                  NOT NULL ,
	site_id                        int                  NOT NULL
)
/

ALTER TABLE Ya_Dept_Upcoming
ADD CONSTRAINT PK_Dept_Upcoming PRIMARY KEY (dept_id, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Dept_Upcoming FOR Ya_Dept_Upcoming
/