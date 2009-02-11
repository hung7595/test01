DROP TABLE Ya_Address_Conv
/

CREATE TABLE Ya_Address_Conv (
	address_id              int                NOT NULL ,
	lang_id                 int
)
/

ALTER TABLE Ya_Address_Conv
ADD CONSTRAINT PK_Address_Conv PRIMARY KEY (address_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Address_Conv FOR Ya_Address_Conv
/