DROP TABLE Sl_Book_Update
/

CREATE TABLE Sl_Book_Update (
	sku                         int                         NOT NULL ,
	cover_img_loc               varchar2(200)               ,
	cover_img_width             int                         ,
	cover_img_height            int                         ,
	us_sale_price               number(18,2)                ,
	tw_sale_price               number(18,2)                ,
	us_sale_start               date                        ,
	us_sale_end                 date                        ,
	tw_sale_start               date                        ,
	tw_sale_end                 date
)
/


CREATE PUBLIC SYNONYM Sl_Book_Update FOR Sl_Book_Update
/