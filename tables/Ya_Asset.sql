DROP TABLE YA_ASSET
/

CREATE TABLE YA_ASSET ( 
  asset_id             number               NOT NULL ,
  data                 nclob,               ,
  type_id              number               NOT NULL ,
  description          nvarchar2 (1024)     ,
  asset_name           nvarchar2 (255)      NOT NULL ,
  enable               char(1)              NOT NULL ,
  status               number               NOT NULL ,
  created_user         varchar2(20)         NOT NULL ,
  created_date         date                 NOT NULL ,
  updated_user         varchar2(20)         ,
  updated_date         date
)
/


ALTER TABLE YA_ASSET 
ADD CONSTRAINT PK_Asset PRIMARY KEY (asset_id) 
USING INDEX TABLESPACE SScommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Asset FOR Ya_Asset
/
