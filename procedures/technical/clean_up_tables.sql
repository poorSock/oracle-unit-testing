-- Generic procedure for dropping database objects
CREATE OR REPLACE PROCEDURE drop_db_object(
    p_object_name IN VARCHAR2,
    p_object_type IN VARCHAR2  -- 'TABLE' or 'SEQUENCE'
) IS
    v_sql VARCHAR2(200);
    v_error_code NUMBER;
BEGIN
    v_sql := 'DROP ' || p_object_type || ' ' || p_object_name;
    
    -- Add CASCADE CONSTRAINTS for tables
    IF p_object_type = 'TABLE' THEN
        v_sql := v_sql || ' CASCADE CONSTRAINTS';
        v_error_code := -942;  -- table does not exist
    ELSE
        v_error_code := -2289; -- sequence does not exist
    END IF;
    
    BEGIN
        EXECUTE IMMEDIATE v_sql;
        DBMS_OUTPUT.PUT_LINE(p_object_type || ' ' || p_object_name || ' dropped successfully');
    EXCEPTION 
        WHEN OTHERS THEN
            IF SQLCODE = v_error_code THEN
                DBMS_OUTPUT.PUT_LINE(p_object_type || ' ' || p_object_name || ' did not exist');
            ELSE
                RAISE_APPLICATION_ERROR(-20001, 'Error dropping ' || p_object_type || ' ' || 
                    p_object_name || ': ' || SQLERRM);
            END IF;
    END;
END;
/

-- Main cleanup procedure that uses the generic drop procedure
CREATE OR REPLACE PROCEDURE drop_table_and_sequence(p_table_name IN VARCHAR2) 
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Starting cleanup for ' || p_table_name);
    
    -- Drop table first (with its constraints)
    drop_db_object(p_table_name, 'TABLE');
    
    -- Drop sequence
    drop_db_object(p_table_name || '_seq', 'SEQUENCE');
    
    DBMS_OUTPUT.PUT_LINE('Cleanup completed for ' || p_table_name);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/