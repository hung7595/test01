DROP TABLE Ya_Staging_Promotion
/

CREATE TABLE Ya_Staging_Promotion (
	id                     int                 NOT NULL, 
	version                int                 NOT NULL,
	campaign_code          int                 NOT NULL,
	name                   varchar2(100)       NOT NULL,
	sts                    int                 NOT NULL,
	type                   int                 NOT NULL,
	pic_user_id            int                 NOT NULL,
	remark                 varchar2(2000)      ,
	is_archived            char(1)             NOT NULL,
	start_dt               date                ,
	end_dt                 date                ,
	launch_dt              date                ,
	create_user            varchar2(50)        NOT NULL,
	create_dt              date                NOT NULL,
	mod_user               varchar2(50)        NOT NULL,
	mod_dt                 date                NOT NULL
)
/

ALTER TABLE Ya_Staging_Promotion
ADD CONSTRAINT PK_staging_promotion PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Staging_Promotion
ADD CONSTRAINT Fk_Staging_Promotion_01 FOREIGN KEY (pic_user_id) REFERENCES JEWELFISH_USER (id)
/

CREATE PUBLIC SYNONYM Ya_Staging_Promotion FOR Ya_Staging_Promotion
/