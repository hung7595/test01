-- Temp tables
DROP TABLE temp_artist_int_table;
CREATE TABLE temp_artist_int_table(
  column1 INT
);

/* Reference to ss_adm package PKG_FE_NEWSLETTERACCESS */
CREATE OR REPLACE PACKAGE PKG_FE_MYACC_ARTISTACCESS
AS
  TYPE refCur IS REF CURSOR;
  
  PROCEDURE GetArtistName (
    cPartist_id_csv IN VARCHAR2,
    cPlang_id IN INT,
    curPresult OUT refcur     
  );  
  
END PKG_FE_MYACC_ARTISTACCESS;
/

CREATE OR REPLACE PACKAGE BODY PKG_FE_MYACC_ARTISTACCESS
AS
  
  PROCEDURE GetArtistName (
    cPartist_id_csv IN VARCHAR2,
    cPlang_id IN INT,
    curPresult OUT refcur    
  )
  AS
    iLstartpos INT := 1;
    iLendpos INT;
    iLtemp INT := 0;
    cLartist_id_csv VARCHAR2(1000);
    cLguid CHAR(32);
  BEGIN
    iLstartpos := 1;
    cLartist_id_csv := cPartist_id_csv;
    
    -- Load CSV into temp table
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_artist_int_table';

    iLtemp := NVL(LENGTH(RTRIM(cLartist_id_csv)), 0);

    IF (iLtemp) > 0 THEN
      BEGIN
        iLendpos := INSTR(cLartist_id_csv, ',');
        WHILE iLendpos  >  0
        LOOP
          BEGIN
            INSERT INTO temp_artist_int_table
              (
                column1 -- artist Id
              )
            VALUES
              (
                CAST(SUBSTR(cLartist_id_csv, 1, iLendpos-1) AS INT)
              );

            cLartist_id_csv := SUBSTR(cLartist_id_csv, iLendpos+1);
            iLendpos := INSTR(cLartist_id_csv, ',');
          END;
        END LOOP;
        INSERT INTO temp_artist_int_table
          (
            column1 -- artist Id
          )
        VALUES
          (
            CAST(cLartist_id_csv AS INT)
          );
      END;
    END IF;
            
    OPEN curPresult FOR
      SELECT 
      art.artist_id as artist_id, al2.lang_id as lang_id, nvl(art.origin_country_id, -1) as country_id,
      nvl(al1.firstname, '') as en_firstname, nvl(al1.lastname, '') as en_lastname, nvl(al1.akaname, '') as en_akaname, 
      nvl(al2.firstname, '') as firstname, nvl(al2.lastname, '') as lastname, nvl(al2.akaname, '') as akaname
      FROM temp_artist_int_table tait
      INNER JOIN ya_artist art ON tait.column1 = art.artist_id
      LEFT JOIN ya_artist_lang al2 ON al2.artist_id = tait.column1 AND al2.lang_id = cPlang_id
      LEFT JOIN ya_artist_lang al1 ON al1.artist_id = tait.column1 AND al1.lang_id = 1;
    
  END GetArtistName;
  
END PKG_FE_MYACC_ARTISTACCESS;
/

