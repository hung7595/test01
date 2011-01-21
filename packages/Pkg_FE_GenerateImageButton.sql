create or replace
PACKAGE Pkg_FE_GenerateImageButton AS

  PROCEDURE Cron_Fe_UpdateToysCharPool;
  
  PROCEDURE Corn_Fe_UpdateArtistImagePool (
    iPdept_id IN VARCHAR2
  );
  
END Pkg_FE_GenerateImageButton;
/


create or replace
PACKAGE BODY Pkg_FE_GenerateImageButton AS

  PROCEDURE Cron_Fe_UpdateToysCharPool AS
  BEGIN
  
    EXECUTE IMMEDIATE 'TRUNCATE TABLE ya_toys_character_pool';
  
    -- Chinese	  
    INSERT INTO tmp_toys_character_pool 
      (
        rand_num, 
        artist_id, 
        country_id
      )
    SELECT dbms_random.value * 1000, a.artist_id, b.origin_country_id FROM ya_artist_image a, ya_artist b
    WHERE a.artist_id = b.artist_id
    AND a.type = 5
    AND b.origin_country_id in (44, 98, 209, 115, 109);
    
    -- Korean
    INSERT INTO ya_toys_character_pool 
      (
        artist_id, 
        country_id, 
        priority
      )
    SELECT artist_id, country_id, rand_num + 10000 FROM tmp_toys_character_pool
    WHERE artist_id=1206603 or artist_id = 1428769;
    
    INSERT INTO ya_toys_character_pool
      (
        artist_id, 
        country_id, 
        priority
      )
    SELECT artist_id, country_id, rand_num + 20000 FROM tmp_toys_character_pool
    WHERE country_id = 115 and artist_id<>1206602 or artist_id<>1206599;
    
    -- Japan
    INSERT INTO ya_toys_character_pool
      (
        artist_id, 
        country_id, 
        priority
      )
    SELECT artist_id, country_id, rand_num + 30000 FROM tmp_toys_character_pool
    WHERE country_id = 109 and rownum<=9
    ORDER BY rand_num;
    
    -- Set All Image Button Lot for Index Page Inactive
    UPDATE ya_artist_image_button_log SET active=0, end_date = sysdate
    WHERE dept_id = 7153 AND active=1 AND artist_id NOT IN(
    	SELECT artist_id FROM ya_toys_character_pool
    );
    
    INSERT INTO ya_artist_image_button_log
      (
        log_id,
        dept_id, 
        artist_id, 
        start_date, 
        active
      )
    SELECT seq_artist_image_button_log.nextval, 7153, artist_id, sysdate, 1 FROM ya_toys_character_pool
    WHERE artist_id NOT IN(
    	SELECT artist_id FROM ya_artist_image_button_log WHERE dept_id=7153 AND active=1
    );
   
    COMMIT;
    
      
  END Cron_Fe_UpdateToysCharPool;
  
  
  
  PROCEDURE Corn_Fe_UpdateArtistImagePool
  (
    iPdept_id IN VARCHAR2
  )
  AS
  BEGIN
  
    UPDATE ya_artist_image_button_log SET active = 0, end_date = sysdate
    WHERE dept_id = iPdept_id and active = 1 and artist_id NOT IN (
      SELECT a.artist_id FROM ya_artist_image a, ya_artist_dept d WHERE a.artist_id = d.artist_id AND a.type=5 AND d.dept_id = iPdept_id and rownum<=15
    );
    
    INSERT INTO ya_artist_image_button_log
      (
        dept_id, 
        artist_id, 
        start_date, 
        active
      )
    SELECT iPdept_id, a.artist_id, sysdate, 1 FROM (SELECT a.artist_id FROM ya_artist_image a, ya_artist_dept d WHERE a.artist_id = d.artist_id AND a.type=5 AND d.dept_id = iPdept_id and rownum<=15) a
       WHERE NOT EXISTS(  
            SELECT 1 FROM ya_artist_image_button_log WHERE dept_id=iPdept_id AND artist_id=a.artist_id AND active=1  
       );
       
    COMMIT;

  
  END Corn_Fe_UpdateArtistImagePool;
    
    
END Pkg_FE_GenerateImageButton;
/

