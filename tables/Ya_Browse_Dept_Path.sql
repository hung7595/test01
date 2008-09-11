DROP TABLE Ya_Browse_Dept_Path
/

CREATE TABLE Ya_Browse_Dept_Path (
	terminal_dept_id                  int               NOT NULL ,
	node_sequence_id                  int               ,
	dept_id                           int               ,
	last_updated_datetime             date
)
/


ALTER TABLE Ya_Browse_Dept_Path
ADD CONSTRAINT PK_Browse_Dept_Path PRIMARY KEY (terminal_dept_id, node_sequence_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Browse_Dept_Path FOR Ya_Browse_Dept_Path
/