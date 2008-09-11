DROP TABLE Ora_Ya_Poll   
/

CREATE TABLE Ora_Ya_Poll (
	poll_id                  int                         NOT NULL ,
	poll_topic               varchar2(500)               ,        
	site_id                  int                         ,        
	created_datetime         date                        NOT NULL ,
	rowguid                  varchar2(50)                DEFAULT SYS_GUID() NOT NULL ,
	actiontype               char(1)                     ,
	markaction               char(1)                     ,
	actionseq                int                         NOT NULL
)
/

ALTER TABLE Ora_Ya_Poll
ADD CONSTRAINT PK_Ora_Ya_Poll PRIMARY KEY (poll_id, actionseq)
USING INDEX TABLESPACE SSCommerceserver_Index
/


create or replace TRIGGER TrIn_ora_poll
  AFTER INSERT ON ora_ya_poll
  FOR EACH ROW
DECLARE
  Tpoll_topic varchar(500) := NULL;
  NumOfRecord NUMBER;
BEGIN
  IF NOT ((ASCII(:new.poll_topic) = 0) AND (LENGTH(:new.poll_topic) = 1)) THEN
    Tpoll_topic := :new.poll_topic;
  END IF;

  IF :new.actiontype = 'I' THEN
    SELECT COUNT(1) INTO NumOfRecord
    FROM ya_poll
    WHERE poll_id = :new.poll_id
    ;

    IF NumOfRecord > 0 THEN
      DELETE FROM ya_poll
      WHERE poll_id = :new.poll_id
      ;
    END IF;


    INSERT INTO ya_poll
    (poll_id, poll_topic, site_id, created_datetime, rowguid
    ) VALUES (
     :new.poll_id, Tpoll_topic, :new.site_id, :new.created_datetime, :new.rowguid
    );
  ELSE
    DELETE FROM ya_poll
    WHERE poll_id = :new.poll_id
    ;
  END IF;
END;