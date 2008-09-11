DROP TABLE Ya_Bargain_Highlight
/

CREATE TABLE Ya_Bargain_Highlight (
	dept_id                        int                     NOT NULL ,
	sku                            int                     NOT NULL ,
	site_id                        int                     NOT NULL ,
	priority                       int                     NOT NULL ,
	created_datetime               date                    NOT NULL
)
/

ALTER TABLE Ya_Bargain_Highlight
ADD CONSTRAINT PK_Bargain_Highlight PRIMARY KEY (dept_id, sku, site_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Bargain_Highlight FOR Ya_Bargain_Highlight
/