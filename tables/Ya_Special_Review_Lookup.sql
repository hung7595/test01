DROP TABLE Ya_Special_Review_Lookup
/

CREATE TABLE Ya_Special_Review_Lookup (
	type_id                     int                     NOT NULL ,
	description                 nvarchar2(200)          NOT NULL
)	
/

ALTER TABLE Ya_Special_Review_Lookup
ADD CONSTRAINT PK_Special_Review_Lookup PRIMARY KEY (type_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Special_Review_Lookup FOR Ya_Special_Review_Lookup
/