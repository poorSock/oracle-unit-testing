<<add_categories>>
BEGIN
   DELETE FROM category;
   INSERT INTO category VALUES (DEFAULT, 'Logistics');
   INSERT INTO category VALUES (DEFAULT, 'Production');
   INSERT INTO category VALUES (DEFAULT, 'Intermediates');
   INSERT INTO category VALUES (DEFAULT, 'Space');
   INSERT INTO category VALUES (DEFAULT, 'Combat');
   INSERT INTO category VALUES (DEFAULT, 'Fluids');
   COMMIT;
END add_categories;
/

<<add_entities>>
BEGIN
   DELETE FROM entity;
   INSERT INTO entity VALUES (DEFAULT, 'Inserter', 
      (SELECT category_id FROM category WHERE category_name = 'Logistics'));
   INSERT INTO entity VALUES (DEFAULT, 'Fast Inserter', 
      (SELECT category_id FROM category WHERE category_name = 'Logistics'));
   INSERT INTO entity VALUES (DEFAULT, 'Pipe', 
      (SELECT category_id FROM category WHERE category_name = 'Logistics'));
   INSERT INTO entity VALUES (DEFAULT, 'Transport Belt', 
      (SELECT category_id FROM category WHERE category_name = 'Logistics'));
   INSERT INTO entity VALUES (DEFAULT, 'Underground Belt', 
      (SELECT category_id FROM category WHERE category_name = 'Logistics'));
   INSERT INTO entity VALUES (DEFAULT, 'Splitter', 
      (SELECT category_id FROM category WHERE category_name = 'Logistics'));
   INSERT INTO entity VALUES (DEFAULT, 'Assembling Machine', 
      (SELECT category_id FROM category WHERE category_name = 'Production'));
   INSERT INTO entity VALUES (DEFAULT, 'Chemical Plant', 
      (SELECT category_id FROM category WHERE category_name = 'Production'));
   INSERT INTO entity VALUES (DEFAULT, 'Electronic Circuit', 
      (SELECT category_id FROM category WHERE category_name = 'Intermediates'));
   INSERT INTO entity VALUES (DEFAULT, 'Advanced Circuit', 
      (SELECT category_id FROM category WHERE category_name = 'Intermediates'));
   INSERT INTO entity VALUES (DEFAULT, 'Copper Cable', 
      (SELECT category_id FROM category WHERE category_name = 'Intermediates'));
   INSERT INTO entity VALUES (DEFAULT, 'Iron Gear Wheel', 
      (SELECT category_id FROM category WHERE category_name = 'Intermediates'));
   --The next 4 Items are "base items" and don't need to be created
   INSERT INTO entity VALUES (DEFAULT, 'Plastic Bar', 
      (SELECT category_id FROM category WHERE category_name = 'Intermediates'));
   INSERT INTO entity VALUES (DEFAULT, 'Copper Plate', 
      (SELECT category_id FROM category WHERE category_name = 'Intermediates'));
   INSERT INTO entity VALUES (DEFAULT, 'Iron Plate', 
      (SELECT category_id FROM category WHERE category_name = 'Intermediates'));
   INSERT INTO entity VALUES (DEFAULT, 'Steel Plate', 
      (SELECT category_id FROM category WHERE category_name = 'Intermediates'));
   COMMIT;
END add_entities;
/

<<add_buildings>>
BEGIN
   DELETE FROM building;
   INSERT INTO building VALUES (DEFAULT,
      (SELECT entity_id FROM entity WHERE entity_name = 'Inserter'),
      '1x1', 2, 5, 9, 14);
   INSERT INTO building VALUES (DEFAULT,
      (SELECT entity_id FROM entity WHERE entity_name = 'Fast Inserter'),
      '1x1', 7, 12, 10, 15);
   INSERT INTO building VALUES (DEFAULT,
      (SELECT entity_id FROM entity WHERE entity_name = 'Pipe'),
      '1x1', 0, 0, 11, 19);
   INSERT INTO building VALUES (DEFAULT,
      (SELECT entity_id FROM entity WHERE entity_name = 'Transport Belt'),
      '1x1', 0, 0, 9, 29);
   INSERT INTO building VALUES (DEFAULT,
      (SELECT entity_id FROM entity WHERE entity_name = 'Underground Belt'),
      '1x1', 0, 0, 9, 29);
   INSERT INTO building VALUES (DEFAULT,
      (SELECT entity_id FROM entity WHERE entity_name = 'Splitter'),
      '1x2', 0, 0, 9, 24);
   INSERT INTO building VALUES (DEFAULT,
      (SELECT entity_id FROM entity WHERE entity_name = 'Assembling Machine'),
      '3x3', 4, 6, 10, 14);
   INSERT INTO building VALUES (DEFAULT,
      (SELECT entity_id FROM entity WHERE entity_name = 'Chemical Plant'),
      '3x4', 9, 16, 11, 11);
COMMIT;
END add_buildings;
/

<<add_recipes>>
BEGIN
   DELETE FROM recipe;
   --Inserter
   INSERT INTO recipe VALUES (DEFAULT, 1, 1, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Inserter'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Electronic Circuit')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 1, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Inserter'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Plate')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 1, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Inserter'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Gear Wheel')
   );

   --Fast Inserter
   INSERT INTO recipe VALUES (DEFAULT, 1, 1, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Fast Inserter'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Inserter')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 2, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Fast Inserter'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Electronic Circuit')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 2, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Fast Inserter'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Plate')
   );

   --Pipe
   INSERT INTO recipe VALUES (DEFAULT, 1, 1, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Pipe'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Plate')
   );

   --Transport Belt
   INSERT INTO recipe VALUES (DEFAULT, 2, 1, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Transport Belt'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Plate')
   );
   INSERT INTO recipe VALUES (DEFAULT, 2, 1, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Transport Belt'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Gear Wheel')
   );

   --Underground Belt
   INSERT INTO recipe VALUES (DEFAULT, 2, 10, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Underground Belt'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Plate')
   );
   INSERT INTO recipe VALUES (DEFAULT, 2, 5, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Underground Belt'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Transport Belt')
   );

   --Splitter
   INSERT INTO recipe VALUES (DEFAULT, 1, 4, 2,
      (SELECT entity_id FROM entity WHERE entity_name = 'Splitter'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Transport Belt')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 5, 2,
      (SELECT entity_id FROM entity WHERE entity_name = 'Splitter'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Electronic Circuit')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 5, 2,
      (SELECT entity_id FROM entity WHERE entity_name = 'Splitter'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Plate')
   );

   --Assembling Machine
   INSERT INTO recipe VALUES (DEFAULT, 1, 5, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Assembling Machine'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Gear Wheel')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 3, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Assembling Machine'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Electronic Circuit')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 9, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Assembling Machine'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Plate')
   );

   --Chemical Plant
   INSERT INTO recipe VALUES (DEFAULT, 1, 5, 10,
      (SELECT entity_id FROM entity WHERE entity_name = 'Chemical Plant'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Steel Plate')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 5, 10,
      (SELECT entity_id FROM entity WHERE entity_name = 'Chemical Plant'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Gear Wheel')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 5, 10,
      (SELECT entity_id FROM entity WHERE entity_name = 'Chemical Plant'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Electronic Circuit')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 5, 10,
      (SELECT entity_id FROM entity WHERE entity_name = 'Chemical Plant'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Pipe')
   );

   --Electronic Circuit
   INSERT INTO recipe VALUES (DEFAULT, 1, 1, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Electronic Circuit'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Plate')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 3, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Electronic Circuit'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Copper Cable')
   );

   --Advanced Circuit
   INSERT INTO recipe VALUES (DEFAULT, 1, 2, 12,
      (SELECT entity_id FROM entity WHERE entity_name = 'Advanced Circuit'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Electronic Circuit')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 2, 12,
      (SELECT entity_id FROM entity WHERE entity_name = 'Advanced Circuit'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Plastic Bar')
   );
   INSERT INTO recipe VALUES (DEFAULT, 1, 4, 12,
      (SELECT entity_id FROM entity WHERE entity_name = 'Advanced Circuit'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Copper Cable')
   );

   --Copper Cable
   INSERT INTO recipe VALUES (DEFAULT, 2, 1, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Copper Cable'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Copper Plate')
   );

   --Iron Gear Wheel
   INSERT INTO recipe VALUES (DEFAULT, 1, 2, 1,
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Gear Wheel'),
      (SELECT entity_id FROM entity WHERE entity_name = 'Iron Plate')
   );
   COMMIT;
END add_recipes;
/

<<add_planets>>
BEGIN
   DELETE FROM planet;
   INSERT INTO planet VALUES (DEFAULT, 'Space Platform', 0);
   INSERT INTO planet VALUES (DEFAULT, 'Nauvis', 10);
   INSERT INTO planet VALUES (DEFAULT, 'Vulcanus', 15);
   INSERT INTO planet VALUES (DEFAULT, 'Gleba', 20);
   INSERT INTO planet VALUES (DEFAULT, 'Fulgora', 25);
   INSERT INTO planet VALUES (DEFAULT, 'Aquilo', 30);
   COMMIT;
END add_planets;
/


