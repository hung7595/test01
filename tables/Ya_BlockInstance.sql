DROP TABLE Ya_BlockInstance
/

CREATE TABLE Ya_BlockInstance (
	blocktemplate_id               int                        NOT NULL ,
	BlockInstance_id               int                        NOT NULL ,
	remark                         varchar2(255)              ,
	status                         int                        DEFAULT 1 NOT NULL ,
	updated_user                   varchar2(20)               ,
	updated_date                   date                       ,
	id                             int                        NOT NULL
)
/


ALTER TABLE Ya_BlockInstance
ADD CONSTRAINT PK_BlockInstance PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_BlockInstance FOR Ya_BlockInstance
/