CREATE OR REPLACE FUNCTION build_allowed(
    p_building_name IN VARCHAR2,
    p_available_space IN VARCHAR2
) 
RETURN VARCHAR2
IS
BEGIN

    

    RETURN  'TRUE';

END;
/


CREATE OR REPLACE FUNCTION grid_size_fits(
    p_building_name IN VARCHAR2,
    p_available_space IN VARCHAR2
) 
RETURN VARCHAR2
IS
    v_building_id NUMBER;
    v_building_grid_size VARCHAR2(5);
BEGIN
    v_building_id := get_building_id_by_building_name(p_building_name);
    SELECT b.grid_size
        INTO v_building_grid_size
        FROM building b WHERE b.building_id = v_building_id;

    RETURN 'TRUE';
    --compare available_space vs grid_size
END;


CREATE OR REPLACE FUNCTION surface_pressure_fits(
    p_building_name IN VARCHAR2
) 
RETURN VARCHAR2
IS
    v_building_id NUMBER;
    v_players_planet_surface_pressure NUMBER;
    v_building_min_pressure NUMBER;
    v_building_max_pressure NUMBER;
BEGIN
    v_building_id := get_building_id_by_building_name(p_building_name);
    SELECT b.min_surface_pressure
        INTO v_building_min_pressure
        FROM building b WHERE b.building_id = v_building_id;

    SELECT b.max_surface_pressure
        INTO v_building_max_pressure
        FROM building b WHERE b.building_id = v_building_id;

    v_players_planet_surface_pressure := get_players_planet_surface_pressure();
    
    RETURN 'TRUE';
    --compare planet pressure between min and max 
END;


CREATE OR REPLACE FUNCTION get_building_id_by_building_name (
    p_building_name IN VARCHAR2
) 
RETURN NUMBER
IS
    v_current_building_id NUMBER;
BEGIN
    SELECT b.building_id
        INTO v_current_building_id
        FROM building b WHERE b.entity_id =
            (SELECT e.entity_id FROM entity e WHERE e.entity_name = p_building_name);

    RETURN v_current_building_id;
END;


CREATE OR REPLACE FUNCTION get_players_planet_surface_pressure
RETURN NUMBER
IS
    v_players_planet_surface_pressure NUMBER;
BEGIN
    SELECT pl.surface_pressure 
        INTO v_players_planet_surface_pressure
        FROM planet pl WHERE pl.planet_name = 
            (SELECT planet_name from planet WHERE planet_id = 
                (SELECT planet_id FROM player));

    RETURN v_players_planet_surface_pressure;
END;