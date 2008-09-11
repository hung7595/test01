DROP TABLE Ya_Prod_Type_Mapper
/

CREATE TABLE Ya_Prod_Type_Mapper (
	type                      varchar2(13)                   NOT NULL ,
	attr_id                   int                            NOT NULL ,
	map_type                  varchar2(13)                   ,
	map_id                    int                            NOT NULL ,
	priority                  int                            NOT NULL
)
/

ALTER TABLE Ya_Prod_Type_Mapper
ADD CONSTRAINT PK_Prod_Type_Mapper PRIMARY KEY (priority)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Prod_Type_Mapper_01 ON Ya_Prod_Type_Mapper(priority, map_type) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Type_Mapper FOR Ya_Prod_Type_Mapper
/