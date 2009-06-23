Drop Table Ya_Brand
/

CREATE TABLE Ya_Brand (
	id                          int                   NOT NULL ,
	country_id                  int                   ,
	override_manu_country_id    int                   ,
	launch_dt                   date                  ,
	created_dt                  date                  NOT NULL ,
	created_user                varchar2(50)          NOT NULL ,
	mod_dt                      date                  NOT NULL ,
 	mod_user                    varchar2(50)          NOT NULL ,
 	enable_mod_dt               date                  NOT NULL
)
/

ALTER TABLE Ya_Brand
ADD CONSTRAINT PK_Brand PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Brand FOR Ya_Brand
/