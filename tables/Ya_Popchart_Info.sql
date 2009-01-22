DROP TABLE Ya_Popchart_Info
/

CREATE TABLE Ya_Popchart_Info (
	id               int         NOT NULL ,
	file_id          int         NOT NULL , 
	start_dt         date        NOT NULL ,
	end_dt           date        NOT NULL
)
/

ALTER TABLE Ya_Popchart_Info
ADD CONSTRAINT PK_Ya_popchart_Info PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM ya_popchart_info FOR ss_adm.ya_popchart_info
/