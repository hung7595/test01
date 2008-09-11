DROP TABLE Tmp_Ya_Asset
/

CREATE TABLE Tmp_Ya_Asset (
	asset_id                    number                      NOT NULL ,
	data                        nclob                       ,
	type_id                     number                      NOT NULL ,
	description                 nvarchar2(1024)             ,
	asset_name                  nvarchar2(255)              NOT NULL ,
	enable                      char(1)                     NOT NULL ,
	status                      number                      NOT NULL ,
	created_user                varchar2(20)                NOT NULL ,
	created_date                date                        NOT NULL ,
	updated_user                varchar2(20)                ,
	updated_date                date             
)
/


CREATE PUBLIC SYNONYM Tmp_Ya_Asset FOR Tmp_Ya_Asset
/