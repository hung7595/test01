DROP TABLE Ya_Bargain_Category
/

CREATE TABLE Ya_Bargain_Category (
	category_attribute_id              int                     NOT NULL ,
	dept_id                            int                     NOT NULL ,
	priority                           int                     NOT NULL
)
/

ALTER TABLE Ya_Bargain_Category
ADD CONSTRAINT PK_Bargain_Category PRIMARY KEY (category_attribute_id, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Bargain_Category_01 ON Ya_Bargain_Category(priority) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Bargain_Category FOR Ya_Bargain_Category
/