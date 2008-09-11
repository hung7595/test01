DROP TABLE Ya_Bargain_Prod_Count
/

CREATE TABLE Ya_Bargain_Prod_Count (
	site_id               int                     NOT NULL ,
	dept_id               int                     NOT NULL ,
	count                 nvarchar2(20)           NOT NULL
)
/

ALTER TABLE Ya_Bargain_Prod_Count
ADD CONSTRAINT PK_Bargain_Prod_Count PRIMARY KEY (site_id, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Bargain_Prod_Count FOR Ya_Bargain_Prod_Count
/