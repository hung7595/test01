DROP TABLE Ya_Prod_Game
/

CREATE TABLE Ya_Prod_Game (
	sku                          int                     NOT NULL ,
	memory                       varchar2(50)            ,
	cpu                          varchar2(50)            ,        
	hard_disk                    varchar2(50)            ,
	video_card                   varchar2(100)           ,
	directx_version              varchar2(50)            ,
	accessories                  varchar2(200)           ,
	sound_card                   varchar2(100)           ,
	num_player                   int                     ,
	net_support                  varchar2(100)           ,
	cdrom_speed                  varchar2(50)            ,
	demo_loc                     varchar2(200)           ,
	controller                   varchar2(50)
)
/

ALTER TABLE Ya_Prod_Game
ADD CONSTRAINT PK_Prod_Game PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Prod_Game FOR Ya_Prod_Game
/