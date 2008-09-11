DROP TABLE Ya_Advertisement_System
/

CREATE TABLE Ya_Advertisement_System (
	siteid                              number                            NOT NULL ,
	langid                              number                            NOT NULL ,
	classname                           varchar2(1000)                    NOT NULL ,
	controlid                           varchar2(50)                      NOT NULL ,
	zoneid                              varchar2(50)                      ,
	advertisementsystemname             varchar2(50)                      ,
	stylename                           varchar2(50)
)
/

ALTER TABLE Ya_Advertisement_System
ADD CONSTRAINT PK_Advertisement_System PRIMARY KEY (classname, siteid, langid, controlid)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Advertisement_System FOR Ya_Advertisement_System
/