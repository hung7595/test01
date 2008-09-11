DROP TABLE Ya_Popchart_Lang
/

CREATE TABLE Ya_Popchart_Lang (
	popchart_id                int                       NOT NULL ,
	lang_id                    int                       NOT NULL ,
	title_desc                 nvarchar2(100)
)
/

ALTER TABLE Ya_Popchart_Lang
ADD CONSTRAINT PK_Popchart_Lang PRIMARY KEY (popchart_id, lang_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Popchart_Lang FOR Ya_Popchart_Lang
/