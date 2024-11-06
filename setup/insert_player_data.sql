<<add_player_inventory>>
BEGIN
    DELETE FROM player_inventory;
    INSERT INTO player_inventory VALUES (
        (SELECT entity_id FROM entity WHERE entity_name = 'Inserter'),
        79
   );
    INSERT INTO player_inventory VALUES (
        (SELECT entity_id FROM entity WHERE entity_name = 'Transport Belt'),
        394
   );
    INSERT INTO player_inventory VALUES (
        (SELECT entity_id FROM entity WHERE entity_name = 'Underground Belt'),
        50
   );
    INSERT INTO player_inventory VALUES (
        (SELECT entity_id FROM entity WHERE entity_name = 'Splitter'),
        50
   );
    INSERT INTO player_inventory VALUES (
        (SELECT entity_id FROM entity WHERE entity_name = 'Electronic Circuit'),
        3
   );
    INSERT INTO player_inventory VALUES (
        (SELECT entity_id FROM entity WHERE entity_name = 'Iron Gear Wheel'),
        77
   );
    INSERT INTO player_inventory VALUES (
        (SELECT entity_id FROM entity WHERE entity_name = 'Iron Plate'),
        297
   );
    INSERT INTO player_inventory VALUES (
        (SELECT entity_id FROM entity WHERE entity_name = 'Copper Plate'),
        309
   );
    INSERT INTO player_inventory VALUES (
        (SELECT entity_id FROM entity WHERE entity_name = 'Plastic Bar'),
        168
   );
    INSERT INTO player_inventory VALUES (
        (SELECT entity_id FROM entity WHERE entity_name = 'Steel Plate'),
        122
   );
   COMMIT;
END add_player_inventory;
/

<<add_player>>
BEGIN
    DELETE FROM player;
    INSERT INTO player VALUES ( DEFAULT,
        (SELECT planet_id FROM planet WHERE planet_name = 'Vulcanus')
   );
   COMMIT;
END add_player;
/