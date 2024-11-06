CREATE OR REPLACE PROCEDURE create_entity(
    p_entity_name IN VARCHAR2,
    p_entity_count IN NUMBER
) IS

BEGIN
SELECT * FROM dual;
END;


CREATE OR REPLACE PROCEDURE create_entity(
    p_object_name IN VARCHAR2,
    p_object_type IN VARCHAR2  -- 'TABLE' or 'SEQUENCE'
) IS
    v_sql VARCHAR2(200);
    v_error_code NUMBER;
BEGIN
    SELECT * FROM dual;
END;
/

CREATE OR REPLACE PROCEDURE check_ingredients_available(
    p_entity_name IN VARCHAR2,
    p_entity_count IN NUMBER
) IS
    v_sql VARCHAR2(200);
    v_error_code NUMBER;
BEGIN
    SELECT * FROM dual;
END;
/