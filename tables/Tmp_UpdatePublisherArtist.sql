DROP TABLE Tmp_UpdatePublisherArtist
/

CREATE TABLE Tmp_UpdatePublisherArtist (
	publisher_id      int              ,
	dept_id           int        
)
/


CREATE PUBLIC SYNONYM Tmp_UpdatePublisherArtist FOR Tmp_UpdatePublisherArtist
/
