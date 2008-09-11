DROP TABLE Ya_Product_Nutrition_Facts
/

CREATE TABLE Ya_Product_Nutrition_Facts (
	sku                                         int                  NOT NULL ,
	serving_size                                varchar2(50)         ,
	servings_per_container                      varchar2(50)         ,
	calories                                    varchar2(50)         ,
	calories_from_fat                           varchar2(50)         ,
	total_fat_gram                              varchar2(50)         ,
	total_fat_percentage                        varchar2(50)         ,
	saturated_fat_gram                          varchar2(50)         ,
	saturated_fat_percentage                    varchar2(50)         ,
	cholestrol_milli_gram                       varchar2(50)         ,
	cholestrol_percentage                       varchar2(50)         ,
	sodium_milli_gram                           varchar2(50)         ,
	sodium_percentage                           varchar2(50)         ,
	total_carbohydrate_gram                     varchar2(50)         ,
	total_carbohydrate_percentage               varchar2(50)         ,
	dietary_fiber_gram                          varchar2(50)         ,
	dietary_fiber_percentage                    varchar2(50)         ,
	sugar_gram                                  varchar2(50)         ,
	protein_gram                                varchar2(50)         ,
	vitamin_a_percentage                        varchar2(50)         ,
	vitamin_c_percentage                        varchar2(50)         ,
	calcium_percentage                          varchar2(50)         ,
	iron_percentage                             varchar2(50)
)
/

ALTER TABLE Ya_Product_Nutrition_Facts
ADD CONSTRAINT PK_Product_Nutrition_Facts PRIMARY KEY (sku)
USING INDEX TABLESPACE SSCommerceserver_Index
/


CREATE PUBLIC SYNONYM Ya_Product_Nutrition_Facts FOR Ya_Product_Nutrition_Facts
/                                  