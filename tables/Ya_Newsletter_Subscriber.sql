DROP TABLE Ya_Newsletter_Subscriber
/

CREATE TABLE Ya_Newsletter_Subscriber (
	guid                                  char(32)                  NOT NULL ,
	email                                 varchar2(100)             NOT NULL ,
	date_time                             date                      DEFAULT SYSDATE ,        
	last_modified_datetime                date                      ,        
	site_id                               int                       NOT NULL ,
	newsletter_id                         int                       NOT NULL ,
	status                                varchar2(1)               ,        
	pending_status                        varchar2(1)               ,        
	downloaded_flag                       char(1)                   DEFAULT 'Y' NOT NULL ,
	rowguid                               varchar2(50)              DEFAULT SYS_GUID() NOT NULL
)
/

ALTER TABLE Ya_Newsletter_Subscriber
ADD CONSTRAINT PK_Newsletter_Subscriber PRIMARY KEY (site_id, email, newsletter_id)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE INDEX IX_Newsletter_Subscriber_01 ON Ya_Newsletter_Subscriber(guid, status, pending_status, downloaded_flag) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Newsletter_Subscriber_02 ON Ya_Newsletter_Subscriber(rowguid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Newsletter_Subscriber_03 ON Ya_Newsletter_Subscriber(guid) TABLESPACE SSCommerceserver_Index
/

CREATE INDEX IX_Newsletter_Subscriber_04 ON Ya_Newsletter_Subscriber(date_time) TABLESPACE SSCommerceserver_Index
/

create index IX_NEWSLETTER_SUBSCRIBER_05 on ya_NEWSLETTER_SUBSCRIBER
(lower(email)) tablespace sscommerceserver_index
/

CREATE INDEX IX_Newsletter_Subscriber_06 ON Ya_Newsletter_Subscriber(shopper_id) TABLESPACE SSCommerceserver_Index
/

CREATE PUBLIC SYNONYM Ya_Newsletter_Subscriber FOR Ya_Newsletter_Subscriber
/


create or replace TRIGGER TRI_newsletter_subscriber_1
BEFORE INSERT OR UPDATE OF status
ON ya_newsletter_subscriber
FOR EACH ROW
BEGIN
	:NEW.status := UPPER(:NEW.status);
END;

create or replace TRIGGER TRI_newsletter_subscriber_2
BEFORE INSERT OR UPDATE OF pending_status
ON ya_newsletter_subscriber
FOR EACH ROW
BEGIN
	:NEW.pending_status := UPPER(:NEW.pending_status);
END;

create or replace TRIGGER TRI_newsletter_subscriber_3
BEFORE INSERT OR UPDATE OF downloaded_flag
ON ya_newsletter_subscriber
FOR EACH ROW
BEGIN
	:NEW.downloaded_flag := UPPER(:NEW.downloaded_flag);
END;