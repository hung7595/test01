DROP TABLE Country_Group_Lookup
/

CREATE TABLE Country_Group_Lookup (
	type_id            int                         NOT NULL ,
	type               nvarchar2(50)               ,
	code_id            int                         NOT NULL ,
	meaning            nvarchar2(500)
)
/

ALTER TABLE Country_Group_Lookup
ADD CONSTRAINT PK_Country_Group_Lookup PRIMARY KEY (type_id, code_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Country_Group_Lookup FOR Country_Group_Lookup
/