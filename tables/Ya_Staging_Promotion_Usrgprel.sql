DROP TABLE Ya_Staging_Promotion_Usrgprel
/

CREATE TABLE Ya_Staging_Promotion_Usrgprel (
	id                    int                 NOT NULL, 
	version               int                 NOT NULL,
	promotion_id          int                 NOT NULL,
	user_group_id         int                 NOT NULL
)
/

ALTER TABLE Ya_Staging_Promotion_Usrgprel
ADD CONSTRAINT PK_Staging_Promotion_Usrgprel PRIMARY KEY (id)
USING INDEX TABLESPACE SSCommerceserver_Index
/

CREATE UNIQUE INDEX UN_Promotion_Usrgprel_01 ON Ya_Staging_Promotion_Usrgprel(promotion_id, user_group_id) TABLESPACE SSCommerceserver_Index
/

ALTER TABLE Ya_Staging_Promotion_Usrgprel
ADD CONSTRAINT FK_promotion_usrgprel_01 FOREIGN KEY (promotion_id) REFERENCES Ya_Staging_Promotion (id)
/

ALTER TABLE Ya_Staging_Promotion_Usrgprel
ADD CONSTRAINT FK_promotion_usrgprel_02 FOREIGN KEY (user_group_id) REFERENCES Jewelfish_User_Grp (id)
/

CREATE PUBLIC SYNONYM Ya_Staging_Promotion_Usrgprel FOR Ya_Staging_Promotion_Usrgprel
/