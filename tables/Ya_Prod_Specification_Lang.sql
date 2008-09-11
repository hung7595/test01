DROP TABLE Ya_Prod_Specification_Lang
/

CREATE TABLE Ya_Prod_Specification_Lang (
	specification_id              int                         ,
	lang_id                       int                         ,
	name                          nvarchar2(256)
)
/


CREATE PUBLIC SYNONYM Ya_Prod_Specification_Lang FOR Ya_Prod_Specification_Lang
/