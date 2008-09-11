DROP TABLE Ya_Toys_Character_Pool
/

CREATE TABLE Ya_Toys_Character_Pool (
	artist_id              int                  NOT NULL ,
	country_id             int                  DEFAULT 0 NOT NULL ,
	priority               int                  NOT NULL
)
/

ALTER TABLE Ya_Toys_Character_Pool
ADD CONSTRAINT PK_Toys_Character_Pool PRIMARY KEY (artist_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Toys_Character_Pool FOR Ya_Toys_Character_Pool
/