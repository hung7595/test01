  CREATE TABLE PLAN_TABLE (
	statement_id         varchar2(30)       ,
	plan_id              number             ,
	timestamp            date               ,
	remarks              varchar2(4000)     ,
	operation            varchar2(30)       ,
	options              varchar2(255)      ,
	object_node          varchar2(128)      ,
	object_owner         varchar2(30)       ,
	object_name          varchar2(30)       ,
	object_alias         varchar2(65)       ,
	object_instance      int                ,
	object_type          varchar2(30)       ,
	optimizer            varchar2(255)      ,
	search_columns       number             ,
	id                   int                ,
	parent_id            int                ,
	depth                int                ,
	position             int                ,
	cost                 int                ,
	cardinality          int                ,
  	bytes                int                ,
	other_tag            varchar2(255)      ,
	partition_start      varchar2(255)      ,
	partition_stop       varchar2(255)      ,
	partition_id         int                ,
	other                long               ,
	distribution         varchar2(30)       ,
	cpu_cost             int                ,
	io_cost              int                ,
	temp_space           int                ,
	access_predicates    varchar2(4000)     ,
	filter_predicates    varchar2(4000)     ,
	projection           varchar2(4000)     ,
	time                 int                ,
	qblock_name          varchar2(30)       ,
	other_xml            clob
)
/


CREATE PUBLIC SYNONYM Plan_Table FOR Plan_Table
/                                                  