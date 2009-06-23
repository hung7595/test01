Drop Table Ya_Region
/

CREATE TABLE Ya_Region (
	region_id              int              NOT NULL ,
	currency               char(3)          NOT NULL ,
	ya_grp_id              int              NOT NULL ,
	name                   varchar2(200)    NOT NULL ,
	default_origin_id      int              NOT NULL ,
	default_category       int              NOT NULL ,
 	is_grp_mandatory       char(1)          NOT NULL
)
/

ALTER TABLE Ya_Region
ADD CONSTRAINT PK_Region PRIMARY KEY (region_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Region FOR Ya_Region
/