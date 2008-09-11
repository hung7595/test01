DROP TABLE Ya_Publisher_File_Rel
/

CREATE TABLE Ya_Publisher_File_Rel (
	file_id                    int                        NOT NULL ,
	publisher_id               int                        NOT NULL ,
	dept_id                    int                        NOT NULL
)	
/

ALTER TABLE Ya_Publisher_File_Rel
ADD CONSTRAINT PK_Publisher_File_Rel PRIMARY KEY (file_id, publisher_id, dept_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Publisher_File_Rel FOR Ya_Publisher_File_Rel
/