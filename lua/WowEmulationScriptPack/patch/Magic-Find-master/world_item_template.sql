SET @ENTRY1 := 45290;
SET @ENTRY2 := 34643;
SET @ENTRY3 := 29557;

SET @DISPLAYID1 := 58209;
SET @DISPLAYID2 := 19572;
SET @DISPLAYID3 := 37887;

-- DELETE FROM `item_template` WHERE `entry` IN (@ENTRY1,@ENTRY2,@ENTRY3);
INSERT INTO `item_template`
(`entry`,`class`,`name`,`displayid`,`Quality`,`Flags`,`ItemLevel`,`stackable`,`delay`,`bonding`,`description`,`Material`,`MaxDurability`)
VALUES
(@ENTRY1,'15','Charm of Fortune',@DISPLAYID1,'2','134217728','1','100','0','1','20% Better chance of getting magic items.','4','20'),
(@ENTRY2,'7','Charm of Fortune',@DISPLAYID2,'2','134217728','1','100','0','1','50% Better chance of getting magic items.','2','50'),
(@ENTRY3,'15','Charm of Fortune',@DISPLAYID3,'3','134217728','1','100','0','1','100% Better chance of getting magic items.','-1','100');
