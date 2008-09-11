DROP TABLE Ya_Attribute_Land_Tchn
/

CREATE TABLE Ya_Attribute_Land_Tchn (
	attribute_id                    int                      NOT NULL ,
	lang_id                         int                      NOT NULL ,
	attribute_name                  varchar2(255)
)
/


CREATE PUBLIC SYNONYM Ya_Attribute_Land_Tchn FOR Ya_Attribute_Land_Tchn
/