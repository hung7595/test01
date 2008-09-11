DROP TABLE Ya_Promotion_Iden
/

CREATE TABLE Ya_Promotion_Iden (
	id                         int                        NOT NULL ,
	combination_id             varchar2(150)              NOT NULL ,
	keyword                    varchar2(150)
)	
/

ALTER TABLE Ya_Promotion_Iden
ADD CONSTRAINT PK_Promotion_Iden PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Promotion_Iden_01 ON Ya_Promotion_Iden(combination_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Promotion_Iden FOR Ya_Promotion_Iden
/