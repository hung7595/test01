DROP TABLE Ya_CM_Mirror_Creative
/

CREATE TABLE Ya_CM_Mirror_Creative (
	creative_id                   int                  NOT NULL ,
	creative_group_id             int                  NOT NULL ,
	type                          int                  NOT NULL ,
	status                        int                  NOT NULL ,
	enable                        char(1)              ,
	name                          varchar2(100)
)
/

ALTER TABLE Ya_CM_Mirror_Creative
ADD CONSTRAINT PK_CM_Mirror_Creative PRIMARY KEY (creative_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_CM_Mirror_Creative FOR Ya_CM_Mirror_Creative
/