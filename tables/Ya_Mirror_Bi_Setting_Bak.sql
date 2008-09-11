DROP TABLE Ya_Mirror_Bi_Setting_Bak
/

CREATE TABLE Ya_Mirror_Bi_Setting_Bak (
	blocktemplate_id                 number                        NOT NULL ,
	blockinstance_id                 number                        NOT NULL ,
	settingname                      varchar2(255)                 ,
	settingvalue                     varchar2(255)                 ,
	status                           int                           NOT NULL ,
	updated_user                     varchar2(20)                  ,        
	updated_date                     date
)
/