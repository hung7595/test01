DROP TABLE Ya_Chinese_Address_Rel
/

CREATE TABLE Ya_Chinese_Address_Rel (
	provinces_id                  int                       NOT NULL ,
	city_id                       int                       NOT NULL
)
/


ALTER TABLE Ya_Chinese_Address_Rel
ADD CONSTRAINT PK_Chinese_Address_Rel PRIMARY KEY (provinces_id, city_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Chinese_Address_Rel FOR Ya_Chinese_Address_Rel
/