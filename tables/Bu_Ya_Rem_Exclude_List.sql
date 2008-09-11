DROP TABLE Bu_Ya_Rem_Exclude_List   
/

CREATE TABLE Bu_Ya_Rem_Exclude_List (
	shopper_id                      char(32)                   NOT NULL ,
	reminder_id                     int                        NOT NULL ,
	last_modified_datetime          date                       NOT NULL ,
	site_id                         int                        NOT NULL ,
	rowguid                         varchar2(50)               NOT NULL
)
/