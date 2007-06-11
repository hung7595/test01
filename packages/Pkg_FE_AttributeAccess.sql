CREATE OR REPLACE package Pkg_FE_AttributeAccess
AS
  TYPE refCur IS REF CURSOR;

  PROCEDURE GetAttributeListByDeptId (
   iPdeptId IN INT,
   iPattrTypeId IN INT,
   iPlangId IN INT,
   curPresult1 OUT refCur
  );
  PROCEDURE GetAttributeListByPublisherId (
   iPpublisherId IN INT,
   iPdeptId IN INT,
   iPattrTypeId IN INT,
   iPlangId IN INT,
   curPresult1 OUT refCur
  );
   PROCEDURE GetAllAttributeListByDeptId (
   iPdeptId IN INT,
   iPattrTypeId IN INT,
   iPlangId IN INT,
   curPresult1 OUT refCur
  );
END Pkg_FE_AttributeAccess;
/

CREATE OR REPLACE package body Pkg_FE_AttributeAccess
is
  PROCEDURE GetAttributeListByDeptId (
    iPdeptId IN INT,
    iPattrTypeId IN INT,
    iPlangId IN INT,
    curPresult1 OUT refCur
  )
  AS
     
  BEGIN
  
	OPEN curPresult1 FOR
		select 
			* 
		from 
			(
			select 
				attribute_id,attribute_name,sum(count_prod ) as count_prod
			from 
			vw_attribute_list 
			where 
				dept_id=iPdeptId
				and attribute_type_id=iPattrTypeId
				and lang_id=iPlangId 
                        
            group by
                attribute_id,attribute_name
            ) a
		order by count_prod desc;

  return;
  END GetAttributeListByDeptId;



 PROCEDURE GetAttributeListByPublisherId (
   iPpublisherId IN INT,
   iPdeptId IN INT,
   iPattrTypeId IN INT,
   iPlangId IN INT,
   curPresult1 OUT refCur
  )
  AS
     
  BEGIN
  

	OPEN curPresult1 FOR
		select 
			* 
		from (
			select 
				attribute_id,attribute_name,publisher_id,dept_id,count_prod 
			from 
				vw_attribute_list 
			where 
				publisher_id=iPpublisherId
				and attribute_type_id=iPattrTypeId 
				and lang_id=iPlangId
				and dept_id=iPdeptId) a
		order by count_prod desc;

return;
  END GetAttributeListByPublisherId;

   PROCEDURE GetAllAttributeListByDeptId (
   iPdeptId IN INT,
   iPattrTypeId IN INT,
   iPlangId IN INT,
   curPresult1 OUT refCur
  )
  AS
     
  BEGIN
  
	OPEN curPresult1 FOR
		select 
			a.attribute_id,a.attribute_name ,a.count_prod,b.attribute_name as en_attribute_name
		from 
			(
			select 
				attribute_id,attribute_name,sum(count_prod ) as count_prod
			from 
			vw_attribute_list 
			where 
				dept_id=iPdeptId
				and attribute_type_id=iPattrTypeId
				and lang_id=iPlangId
                        
            group by
                attribute_id,attribute_name
            ) a, (select attribute_name,attribute_id from ya_attribute_lang al where  al.lang_id=1) b
            where b.attribute_id=a.attribute_id
		order by en_attribute_name;

  return;
  END GetAllAttributeListByDeptId;
  
END Pkg_FE_AttributeAccess;
/

CREATE OR REPLACE PUBLIC SYNONYM Pkg_FE_AttributeAccess FOR Pkg_FE_AttributeAccess;


