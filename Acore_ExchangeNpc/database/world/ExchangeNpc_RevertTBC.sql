UPDATE `item_template` SET `BuyPrice` = 400, `bonding` = 0 WHERE `entry` IN (40896, 41094, 42906, 42911, 44955, 50045, 42736, 42749, 42753, 41105, 42401, 45908, 42955, 42963, 41527, 41542, 42453, 42471, 43432, 43428);
UPDATE `item_template` SET `BuyPrice` = 100, `bonding` = 0 WHERE `entry` IN (43400);
DELETE FROM `npc_vendor` WHERE (`entry` = 1116001 AND `ITEM` IN (40896, 42906, 42911, 44955, 50045, 42736, 42749, 42753, 41094, 41105, 42401, 45908, 42955, 42963, 41527, 41542, 42453, 42471, 43400, 43432, 43428));
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 23) AND (`SourceEntry` IN (40896, 42906, 42911, 44955, 50045, 42736, 42749, 42753, 41094, 41105, 42401, 45908, 42955, 42963, 41527, 41542, 42453, 42471, 43400, 43432, 43428) AND (`SourceGroup` = 1116001) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 15) AND (`ConditionTarget` = 0) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0));

