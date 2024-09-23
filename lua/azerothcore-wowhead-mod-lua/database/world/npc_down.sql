SET @ENTRY := 210000;

DELETE FROM creature_template
WHERE entry = @ENTRY;

DELETE FROM creature
WHERE id1 = @ENTRY;
