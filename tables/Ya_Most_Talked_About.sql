DROP TABLE Ya_Most_Talked_About
/

CREATE TABLE Ya_Most_Talked_About (
	dept_id                      int                   NOT NULL ,
	sku                          int                   NOT NULL ,
	last_count                   int                   NOT NULL ,
	total_count                  int                   NOT NULL ,
	site_id                      int                   NOT NULL ,
	priority                     int                   NOT NULL ,
	created_datetime             date                  DEFAULT SYSDATE NOT NULL
)
/

ALTER TABLE Ya_Most_Talked_About
ADD CONSTRAINT PK_Most_Talked_About PRIMARY KEY (dept_id, sku, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Most_Talked_About FOR Ya_Most_Talked_About
/