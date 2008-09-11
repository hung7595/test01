DROP TABLE Ora_Stg_Content   
/

CREATE TABLE Ora_Stg_Content (
	content_id                 int                         NOT NULL ,
	content_img_loc            varchar2(200)               ,
	content_img_width          int                         ,
	content_img_height         int                         ,
	content                    clob                        ,
	content_u                  nclob                       ,
	actiontype                 char(1)                     ,
	markaction                 char(1)                     ,
	actionseq                  int                         NOT NULL
)
/

ALTER TABLE Ora_Stg_Content
ADD CONSTRAINT PK_Ora_Stg_Content PRIMARY KEY (content_id, actionseq)
USING INDEX TABLESPACE SSCommerceserver_Index
/