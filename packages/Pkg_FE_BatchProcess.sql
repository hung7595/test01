DROP TABLE browse_path
/

CREATE TABLE browse_path  (
	terminal_dept_id int not null,  
	node_sequence_id int not null,  
	dept_id int not null
)
/

CREATE OR REPLACE PACKAGE Pkg_FE_BatchProcess
AS
  TYPE refCur IS REF CURSOR;

	PROCEDURE UpdateBrowsePath(
			iPdept_id INT,
			curPresult OUT refCur
	);

	PROCEDURE UpdateEmptyBrowsePath(
			curPresult OUT refCur
	);
		
	PROCEDURE UpdateAllBrowsePath(
			curPresult OUT refCur
	);

END Pkg_FE_BatchProcess;
/

CREATE OR REPLACE PACKAGE BODY Pkg_FE_BatchProcess
AS
  PROCEDURE UpdateBrowsePath (
    iPdept_id INT,
    curPresult OUT refCur
  )
  AS
		iTerminalDeptId int;
		iNodeSequenceId int;
		iTempNodeId int;
		iCounter int;
  BEGIN

		DELETE FROM browse_path;

		iTerminalDeptId := iPdept_id;
		iNodeSequenceId := 1;
		iTempNodeId := iTerminalDeptId;

		SELECT count(1) INTO iCounter FROM ya_dept_rel WHERE dept_id = iTempNodeId;
		WHILE (iCounter > 0)
		LOOP
			INSERT INTO browse_path(terminal_dept_id, node_sequence_id, dept_id)  
				SELECT iTerminalDeptId, iNodeSequenceId, dl.dept_id  
				FROM ya_dept_lang dl  
				WHERE dept_id = iTempNodeId  
				AND dl.lang_id = 1;

			SELECT parent_dept_id INTO iTempNodeId
			FROM ya_dept_rel
			WHERE dept_id = iTempNodeId
			AND rownum<=1;

			iNodeSequenceId := iNodeSequenceId + 1;
			
			SELECT count(1) INTO iCounter FROM ya_dept_rel WHERE dept_id = iTempNodeId;
		END LOOP; 

		-- Include the last one (Top level)
		INSERT INTO browse_path(terminal_dept_id, node_sequence_id, dept_id)  
			SELECT iTerminalDeptId, iNodeSequenceId, dl.dept_id
			FROM ya_dept_lang dl  
			WHERE dept_id = iTempNodeId  
			AND dl.lang_id = 1  
			AND dept_id not in (0);

		DELETE ya_browse_dept_path WHERE terminal_dept_id = iTerminalDeptId;
		INSERT INTO ya_browse_dept_path(terminal_dept_id, node_sequence_id, dept_id, last_updated_datetime)  
		  SELECT terminal_dept_id, node_sequence_id, dept_id, SYSDATE FROM browse_path;

		OPEN curPresult FOR
			SELECT * FROM ya_browse_dept_path WHERE terminal_dept_id = iTerminalDeptId;

		IF sqlcode = 0 THEN
			COMMIT;
		ELSE
			ROLLBACK;
		END IF;

  END UpdateBrowsePath;

	PROCEDURE UpdateEmptyBrowsePath (
			curPresult OUT refCur
	)
	AS
		total_val number(6);
		curPupdate refCur;

		cursor c1 is
			select a.dept_id as dept_id
			from ya_dept a
			left join ya_browse_dept_path b on a.dept_id = b.terminal_dept_id
			where b.terminal_dept_id is null;
	BEGIN
			total_val := 0;
			FOR dept in c1
			LOOP
					Pkg_FE_BatchProcess.UpdateBrowsePath(dept.dept_id, curPupdate);
					total_val := total_val + 1;
			END LOOP;

			OPEN curPresult FOR
				SELECT total_val FROM dual;
	END UpdateEmptyBrowsePath;

	PROCEDURE UpdateAllBrowsePath (
			curPresult OUT refCur
	)
	AS
		total_val number(6);
		curPupdate refCur;

		cursor c1 is
			select dept_id from ya_dept;
	BEGIN
			total_val := 0;
			FOR dept in c1
			LOOP
					Pkg_FE_BatchProcess.UpdateBrowsePath(dept.dept_id, curPupdate);
					total_val := total_val + 1;
			END LOOP;

			OPEN curPresult FOR
				SELECT total_val FROM dual;
	END UpdateAllBrowsePath;

END Pkg_FE_BatchProcess;
/

