DROP TABLE Ya_Associate_Hits_Summary
/

CREATE TABLE Ya_Associate_Hits_Summary (
	hit_day               date                   NOT NULL ,
	link_id               int                    NOT NULL ,
	hits                  int                    NOT NULL ,
	rowguid               varchar2(50)           DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Associate_Hits_Summary
ADD CONSTRAINT PK_Associate_Hits_Summary PRIMARY KEY (link_id, hit_day)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE UNIQUE INDEX UN_Associate_Hits_Summary ON Ya_Associate_Hits_Summary(rowguid) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Associate_Hits_Summary FOR Ya_Associate_Hits_Summary
/