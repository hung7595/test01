DROP TABLE Temp_Assoc_Hit_Snapshot
/

CREATE GLOBAL TEMPORARY TABLE Temp_Assoc_Hit_Snapshot (
	link_id               int                NOT NULL ,
	hit_datetime          date               NOT NULL
) ON COMMIT PRESERVE ROWS
/ 


CREATE INDEX IX_Temp_Assoc_Hit_Snapshot ON Temp_Assoc_Hit_Snapshot (link_id, hit_datetime)
/