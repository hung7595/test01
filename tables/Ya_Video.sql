Drop Table Ya_Video
/

CREATE TABLE Ya_Video (
	id                int              NOT NULL
)
/

ALTER TABLE Ya_Video
ADD CONSTRAINT PK_Video PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Video FOR Ya_Video
/