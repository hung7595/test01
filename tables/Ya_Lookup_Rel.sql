DROP TABLE Ya_Lookup_Rel
/

CREATE TABLE Ya_Lookup_Rel (
	parent_lookup_id           int               NOT NULL ,
	child_lookup_id            int               NOT NULL
)
/


ALTER TABLE Ya_Lookup_Rel
ADD CONSTRAINT PK_Lookup_Rel PRIMARY KEY (parent_lookup_id, child_lookup_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Lookup_Rel FOR Ya_Lookup_Rel
/


