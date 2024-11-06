CREATE OR REPLACE PACKAGE test_surface_pressure_fits AS
    c_testbuilding CONSTANT VARCHAR2(20) := 'Testbuilding';
    c_testplanet CONSTANT VARCHAR2(20) := 'Testplanet';

    --%suite
    --%displayname(Check if a specific building can be build on a surface with a specific pressure)

    --%beforeall
    PROCEDURE setup;

    --%test
    PROCEDURE test_surface_pressure_fits_OK_low_boundary;
END;

CREATE OR REPLACE PACKAGE BODY test_surface_pressure_fits AS
    PROCEDURE setup IS
    BEGIN
        INSERT INTO entity VALUES (DEFAULT, c_testbuilding, 
            (SELECT category_id FROM category WHERE category_name = 'Logistics'));
        INSERT INTO planet VALUES (DEFAULT, c_testplanet, 11);
        UPDATE player SET planet_id = (SELECT p.PLANET_ID FROM planet p WHERE p.PLANET_NAME = c_testplanet);

    END;

    PROCEDURE test_surface_pressure_fits_OK_low_boundary IS
    v_surface_pressure_fits VARCHAR2(5);
    BEGIN
        --Given
        INSERT INTO building VALUES (DEFAULT,
            (SELECT entity_id FROM entity WHERE entity_name = c_testbuilding),
            '2x3', 2, 5, 11, 14);
        --When
        v_surface_pressure_fits := surface_pressure_fits(c_testbuilding);
        --Then
        ut.EXPECT(v_surface_pressure_fits).to_equal('TRUE');
    END;
END;


CREATE OR REPLACE PACKAGE test_get_building_id_by_building_name AS
    --%suite(get_building_id_by_building_name function)

    --%test
    PROCEDURE test_get_building_id_by_building_name_OK;
END;

CREATE OR REPLACE PACKAGE BODY test_get_building_id_by_building_name AS
    PROCEDURE test_get_building_id_by_building_name_OK IS
    BEGIN
        ut.EXPECT(get_building_id_by_building_name('Assembling Machine')).to_equal(7);
    END;
END;

CREATE OR REPLACE PACKAGE test_get_players_surface_pressure AS
    --%suite(get_players_planet_surface_pressure function)

    --%test(surface pressure can be retrieved)
    PROCEDURE test_get_players_planet_surface_pressure_OK;
END;

CREATE OR REPLACE PACKAGE BODY test_get_players_surface_pressure AS
    PROCEDURE test_get_players_planet_surface_pressure_OK IS
    BEGIN
        ut.EXPECT(get_players_planet_surface_pressure()).to_equal(15);
    END;
END;

