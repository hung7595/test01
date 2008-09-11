DROP TABLE Tmp_Ya_Campaign_Lookup
/

CREATE TABLE Tmp_Ya_Campaign_Lookup (
	campaign_code                   number(10)                  NOT NULL ,
	campaing_description            varchar2(200)               NOT NULL ,
	campaign_datetime               date                        NOT NULL ,
	site_id                         number(3)                   NOT NULL ,
	campaign_type                   number(10)
)
/