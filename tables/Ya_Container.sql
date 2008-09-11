DROP TABLE Ya_Container
/

CREATE TABLE Ya_Container (
	container_id               int                    NOT NULL ,
	description                varchar2(50)           NOT NULL
)
/

ALTER TABLE Ya_Container
ADD CONSTRAINT PK_Container PRIMARY KEY (container_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Container FOR Ya_Container
/