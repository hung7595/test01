DROP TABLE Ya_Campaign_Lookup
/

CREATE TABLE Ya_Campaign_Lookup (
	campaign_code                        int                        NOT NULL ,
	campaing_description                 varchar2(200)              NOT NULL ,
	campaign_datetime                    date                       NOT NULL ,
	site_id                              int                        NOT NULL ,
	campaign_type                        int
)
/


ALTER TABLE Ya_Campaign_Lookup
ADD CONSTRAINT PK_Campaign_Lookup PRIMARY KEY (campaign_code)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Campaign_Lookup FOR Ya_Campaign_Lookup
/