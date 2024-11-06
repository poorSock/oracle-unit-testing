BEGIN
    DROP_TABLE_AND_SEQUENCE('player');
    DROP_TABLE_AND_SEQUENCE('player_inventory');
    DROP_TABLE_AND_SEQUENCE('planet');
    DROP_TABLE_AND_SEQUENCE('recipe');
    DROP_TABLE_AND_SEQUENCE('building');
    DROP_TABLE_AND_SEQUENCE('entity');
    DROP_TABLE_AND_SEQUENCE('category');
END;
/

CREATE SEQUENCE category_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE category (
    category_id NUMBER DEFAULT category_seq.NEXTVAL PRIMARY KEY,
    category_name VARCHAR2(50) NOT NULL UNIQUE
);

CREATE SEQUENCE entity_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE entity (
    entity_id NUMBER DEFAULT entity_seq.NEXTVAL PRIMARY KEY,
    entity_name VARCHAR2(50) NOT NULL UNIQUE,
    category_id NUMBER NOT NULL,
    CONSTRAINT fk_category FOREIGN KEY (category_id)
        REFERENCES category(category_id)
);

CREATE SEQUENCE building_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE building (
    building_id NUMBER DEFAULT building_seq.NEXTVAL PRIMARY KEY,
    entity_id NUMBER NOT NULL UNIQUE,
    grid_size VARCHAR2(10) NOT NULL,
    min_power_consumption NUMBER(5,2),
    max_power_consumption NUMBER(5,2),
    min_surface_pressure NUMBER(5,2),
    max_surface_pressure NUMBER(5,2),
    CONSTRAINT fk_building_entity FOREIGN KEY (entity_id)
        REFERENCES entity(entity_id)
);

CREATE SEQUENCE recipe_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE recipe (
    recipe_id NUMBER DEFAULT recipe_seq.NEXTVAL PRIMARY KEY,
    product_count NUMBER(5) NOT NULL,
    ingredient_count NUMBER(5) NOT NULL,
    crafting_time NUMBER(2) NOT NULL,
    product_id NUMBER NOT NULL,
    ingredient_id NUMBER NOT NULL,
    CONSTRAINT fk_product FOREIGN KEY (product_id)
        REFERENCES entity(entity_id),
    CONSTRAINT fk_ingredient FOREIGN KEY (ingredient_id)
        REFERENCES entity(entity_id),
    CONSTRAINT unique_recipe UNIQUE (product_id, ingredient_id)
);

CREATE SEQUENCE planet_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE planet (
    planet_id NUMBER DEFAULT planet_seq.NEXTVAL PRIMARY KEY,
    planet_name VARCHAR(50) NOT NULL UNIQUE,
    surface_pressure NUMBER (5,2) NOT NULL
);

CREATE TABLE player_inventory (
    entity_id NUMBER PRIMARY KEY,
    count NUMBER(4) NOT NULL,
    CONSTRAINT fk_player_inventory_entity FOREIGN KEY (entity_id)
        REFERENCES entity(entity_id)
);

CREATE SEQUENCE player_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

CREATE TABLE player (
    player_id NUMBER DEFAULT player_seq.NEXTVAL PRIMARY KEY,
    planet_id NUMBER NOT NULL,
    CONSTRAINT fk_player_planet FOREIGN KEY (planet_id)
        REFERENCES planet(planet_id)
);