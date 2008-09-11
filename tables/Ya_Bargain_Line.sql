DROP TABLE Ya_Bargain_Line
/

CREATE TABLE Ya_Bargain_Line (
	bargain_line_id                int                     NOT NULL ,
	attribute_id                   int                     NOT NULL
)
/

ALTER TABLE Ya_Bargain_Line
ADD CONSTRAINT PK_Bargain_Highlight PRIMARY KEY (bargain_line_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Bargain_Line_01 ON Ya_Bargain_Line(attribute_id) TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Bargain_Line FOR Ya_Bargain_Line
/