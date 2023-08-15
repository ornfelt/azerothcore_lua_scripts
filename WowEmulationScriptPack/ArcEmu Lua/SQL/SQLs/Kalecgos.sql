INSERT INTO teleport_coords (id,name,mapid,position_x,position_y,position_z)VALUES('46019','Teleport : Spectral Realm','580','1726.414551','904.234314','-74.558136');
DELETE FROM ai_agents WHERE entry = "24892";
INSERT INTO `gameobject_names` (entry,type,displayid,name)VALUES('187055','1','1327','Spectral Rift');
DELETE FROM creatureloot WHERE entryid = "24850";
INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 29434, 100, 0, 2, 2, 1);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 34164, 15, 0, 1, 1, 0);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 34165, 15, 0, 1, 1, 0);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 34166, 15, 0, 1, 1, 0);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 34167, 15, 0, 1, 1, 0);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 34168, 15, 0, 1, 1, 0);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 34169, 15, 0, 1, 1, 0);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 34170, 15, 0, 1, 1, 0);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 34664, 100, 0, 1, 1, 0);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 34848, 75, 0, 1, 1, 0);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 34851, 75, 0, 1, 1, 0);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 34852, 75, 0, 1, 1, 0);

INSERT INTO creatureloot
  (entryid, itemid, percentchance, heroicpercentchance, mincount, maxcount, ffa_loot)
VALUES
  (24892, 44819, 3, 0, 1, 1, 1);