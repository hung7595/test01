DROP TABLE Temp_Assoc_Hit_Summary
/

CREATE GLOBAL TEMPORARY TABLE Temp_Assoc_Hit_Summary (
	link_id               int                NOT NULL ,
	hit_day               date               NOT NULL ,
	hits                  int                NOT NULL
	CONSTRAINT PK_Temp_Assoc_Hit_Summary PRIMARY KEY (link_id, hit_day)
) ON COMMIT PRESERVE ROWS
/