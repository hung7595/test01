DROP TABLE Tmp_Toys_Character_Pool
/

CREATE TABLE Tmp_Toys_Character_Pool (
	rand_num          int              ,
	artist_id         int              ,
	country_id        int          
)
/


CREATE PUBLIC SYNONYM Tmp_Toys_Character_Pool FOR Tmp_Toys_Character_Pool
/
