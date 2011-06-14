DROP TABLE Ya_Coupon_Constraint
/

CREATE TABLE Ya_Coupon_Constraint (
	coupon_code                varchar2(32)        NOT NULL ,
	constraint_type            int                 NOT NULL ,        
	constraint_value           int                 NOT NULL ,        
	created_datetime           date                NOT NULL
)
/

ALTER TABLE Ya_Coupon_Constraint
ADD CONSTRAINT PK_Coupon_Constraint PRIMARY KEY (coupon_code, constraint_type, constraint_value)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Coupon_Constraint FOR Ya_Coupon_Constraint
/