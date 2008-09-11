DROP TABLE Tk_Prob_Ya_Rating_lang_Snap
/

CREATE TABLE Tk_Prob_Ya_Rating_lang_Snap (
	rating_id                    int                     NOT NULL ,
	lang_id                      int                     NOT NULL ,
	title                        varchar2(50)            ,
	us_review_id                 int                     ,
	hk_review_id                 int                     ,
	jp_review_id                 int                     ,
	tw_review_id                 int                     ,
	preferred_flag               char(1)                 ,
	rowguid                      varchar2(50)            NOT NULL	
)
/


CREATE PUBLIC SYNONYM Tk_Prob_Ya_Rating_lang_Snap FOR Tk_Prob_Ya_Rating_lang_Snap
/


create or replace TRIGGER TRI_tk_ya_rating_lang_snap
BEFORE INSERT OR UPDATE OF preferred_flag
ON tk_prob_ya_rating_lang_snap
FOR EACH ROW
BEGIN
	:NEW.preferred_flag := UPPER(:NEW.preferred_flag);
END;