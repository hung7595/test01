DROP TABLE Arch_Ya_Associate_Hits_Raw   
/

CREATE TABLE Arch_Ya_Associate_Hits_Raw (
	hit_datetime                date                    NOT NULL ,
	link_id                     int                     NOT NULL ,
	rowguid                     varchar2(50)            NOT NULL
)
/