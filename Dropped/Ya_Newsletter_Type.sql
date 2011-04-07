DROP TABLE Ya_Newsletter_Type
/

CREATE TABLE Ya_Newsletter_Type (
	newsletter_type_id             int                    NOT NULL ,
	newsletter_id                  int                    NOT NULL
)
/

ALTER TABLE Ya_Newsletter_Type
ADD CONSTRAINT PK_Newsletter_Type PRIMARY KEY (newsletter_type_id, newsletter_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Newsletter_Type FOR Ya_Newsletter_Type
/