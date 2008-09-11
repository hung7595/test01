DROP TABLE Ya_BlockInstance_Settin_Bak
/

CREATE TABLE Ya_BlockInstance_Settin_Bak (
	 blocktemplate_id               number                    NOT NULL ,
	 blockInstance_id               number                    NOT NULL ,
	 settingname                    varchar2(255)             ,
	 settingvalue                   varchar2(255)             ,
	 status                         int                       NOT NULL,
	 updated_user                   varchar2(20)              ,
	 updated_date                   date               
)
/