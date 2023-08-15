--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


-- Stonewrought Pass - Loch Modan (LeverID:17156, DoorID:150138)
-- .worldport 0 -6039.81 -2489.11 311.545
function lever_17156_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-6034.97,-2488.73,311.086,150138):Activate()
end
RegisterGameObjectEvent(17156, 4, "lever_17156_OnUse")

-- Stonewrought Pass - Searing Gorge (LeverID:17157, DoorID:150137)
-- .worldport 0 -6350.34 -2079.46 244.019
function lever_17157_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-6355.19,-2079.83,243.63,150137):Activate()
end
RegisterGameObjectEvent(17157, 4, "lever_17157_OnUse")

-- Shadowfang Keep - Arugal's room (LeverID:18899, DoorID:18971)
-- .worldport 33 -115.192 2163.876 155.679
function door_18971_OnSpawn(pGO, event)
 pGO:SetClickable()
end
function lever_18899_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-118.11,2161.86,155.678,18971):Activate()
end
RegisterGameObjectEvent(18971, 2, "door_18971_OnSpawn")
RegisterGameObjectEvent(18899, 4, "lever_18899_OnUse")

-- Gnomeregan - Workshop Entrance (LeverID:90567, DoorID:90566)
-- .worldport 0 -4855.03 742.434 249.325
function lever_90567_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-4861.05,740.452,249.389,90566):Activate()
end
RegisterGameObjectEvent(90567, 4, "lever_90567_OnUse")

-- Deadmines - Rhahk'Zor (LeverID:101831, DoorID:13965)
-- .worldport 36 -188.136 -460.313 54.5591
function door_13965_OnSpawn(pGO, event)
 pGO:SetClickable()
end
function lever_101831_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-191.414,-457.446,54.4391,13965):Activate()
end
RegisterGameObjectEvent(13965, 2, "door_13965_OnSpawn")
RegisterGameObjectEvent(101831, 4, "lever_101831_OnUse")

-- Deadmines - Sneed's Shredder (LeverID:101832, DoorID:17153)
-- .worldport 36 -287.282 -539.877 49.4321
-- .worldport 36 -289.808533 -528.176392 49.755871
function lever_101832_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-290.294,-536.96,49.4353,17153):Activate()
end
RegisterGameObjectEvent(101832, 4, "lever_101832_OnUse")

-- Deadmines - Defias Cannon (LeverID:101833, DoorID:16397, DefiasCannonID:16398, FireCannonSpellID:6250, OpenDoorSpellID:6247, DefiasGunPowder:5397)
-- .worldport 36 -96.9278 -670.597 7.40338
-- .worldport 36 -101.082466 -657.020081 7.422328
function door_16397_OnSpawn(pGO, event)
 pGO:SetClickable()
end
function lever_101833_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-100.502,-668.771,7.41049,16397):Activate()
end
RegisterGameObjectEvent(16397, 2, "door_16397_OnSpawn")
RegisterGameObjectEvent(101833, 4, "lever_101833_OnUse")

-- Deadmines - Gilnid (LeverID:101834, DoorID:17153)
-- .worldport 36 -165.404 -576.924 19.3064
function lever_101834_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-168.514,-579.861,19.3159,17153):Activate()
end
RegisterGameObjectEvent(101834, 4, "lever_101834_OnUse")

-- Dire Maul West - South Entrance (LeverID:179507, DoorID:177188)
-- .worldport 1 -3821.49 1253.97 162.378
function lever_179507_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-3816.05,1250.29,160.278,177188):Activate()
end
RegisterGameObjectEvent(179507, 4, "lever_179507_OnUse")

-- Dire Maul West - North Entrance (LeverID:179508, DoorID:177189)
-- .worldport 1 -3757.92 1252.95 162.378
function lever_179508_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-3763.5,1249.41,160.278,177189):Activate()
end
RegisterGameObjectEvent(179508, 4, "lever_179508_OnUse")

-- Dire Maul North - Exit (LeverID:179509, DoorID: N/A)
-- .worldport 1 -3523.51 1156.89 162.378
function lever_179509_OnUse(pGO, event, player)
 pGO:Activate()
end
RegisterGameObjectEvent(179509, 4, "lever_179509_OnUse")

-- Dire Maul North - Entrance (LeverID:179510, DoorID:177192)
-- .worldport 1 -3523.77 1092.09 162.378
function lever_179510_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-3520.13,1098.07,161.032,177192):Activate()
end
RegisterGameObjectEvent(179510, 4, "lever_179510_OnUse")

-- Dire Maul East - Outdoor Entrance (LeverID:179513, DoorID:177198)
-- .worldport 1 -4070.46 84.6031 60.0026
function lever_179513_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-4076.42,85.3757,59.7996,177198):Activate()
end
RegisterGameObjectEvent(179513, 4, "lever_179513_OnUse")

-- Scarlet Monastery - Armory (LeverID:101852, DoorID:101851)
-- .worldport 0 2889.18 -827.798 160.293
function lever_101852_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(2886.31,-827.261,160.336,101851):Activate()
end
RegisterGameObjectEvent(101852, 4, "lever_101852_OnUse")

-- Scarlet Monastery - Cathedral (LeverID:101853, DoorID:101850)
-- .worldport 0 2910.81 -818.836 160.293
function lever_101853_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(2908.18,-818.203,160.332,101850):Activate()
end
RegisterGameObjectEvent(101853, 4, "lever_101853_OnUse")

-- Broggok's room - Blood Furnace - Hellfire Citadel (LeverID:181982, DoorID:181819)
-- .worldport 542 456.086 60.3489 9.47833
function lever_181982_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(495.532,84.4274,11.1708,181817):Activate() --Prison Cell Door
 player:GetGameObjectNearestCoords(494.697,115.16,11.5749,181820):Activate() --Prison Cell Door
 player:GetGameObjectNearestCoords(417.967,114.674,11.1708,181821):Activate() --Prison Cell Door
 player:GetGameObjectNearestCoords(416.665,83.5567,11.1708,181818):Activate() --Prison Cell Door
 player:GetGameObjectNearestCoords(456.291,34.1513,23.8317,181819):Activate() --Broggok's Door
end
RegisterGameObjectEvent(181982, 4, "lever_181982_OnUse")

-- Shattered Halls - Hellfire Citadel (LeverID:183517, DoorID:184912)
-- .worldport 530 -313.133 3085.26 -3.83561
function lever_183517_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-309.658,3078.96,-3.54555,184912):Activate()
end
RegisterGameObjectEvent(183517, 4, "lever_183517_OnUse")

-- Shadow Labyrinth - Auchindoun (LeverID:183518, DoorID:183294)
-- .worldport 530 -3559.55 4934.38 -101.073
function lever_183518_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-3556.41,4943.07,-101.119,183294):Activate()
end
RegisterGameObjectEvent(183518, 4, "lever_183518_OnUse")

-- The Deathforge - Shadowmoon Valley (LeverID:185123, DoorID:184246)
-- .worldport 530 -3523.27 2174.25 34.5994
function lever_185123_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-3513.89,2169.14,34.3507,184246):Activate()
end
RegisterGameObjectEvent(185123, 4, "lever_185123_OnUse")

-- Scarlet Monastery - Herod (LeverID:101855, DoorID:101854)
-- .worldport 189 1939.48 -427.998 17.0815
function lever_101855_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(1933.69,-431.654,18.671,101854):Activate()
end
RegisterGameObjectEvent(101855, 4, "lever_101855_OnUse")

-- Scarlet Monastery - Mograine (LeverID:104589, DoorID:104591)
-- .worldport 189 1073.91 1405.92 30.2722
function lever_104589_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(1069.95,1399.14,30.7956,104591):Activate()
end
RegisterGameObjectEvent(104589, 4, "lever_104589_OnUse")

-- Scarlet Monastery - Secret Door (LeverID:97701, DoorID:97700, OpenDoorSpellID:6477)
-- .worldport 189 1167.369507 1344.022095 31.549520
function door_97700_OnSpawn(pGO, event)
 pGO:SetClickable()
end
function lever_97701_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(1167.79,1347.26,31.5494,97700):Activate()
end
RegisterGameObjectEvent(97701, 4, "lever_97701_OnUse")
RegisterGameObjectEvent(97700, 2, "door_97700_OnSpawn")

-- Scholomance - Entrance (LeverID:176767, DoorID:174626)
-- .worldport 0 1262.97 -2563.08 96.8452
function lever_176767_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(1267.59,-2567.38,94.1143,174626):Activate()
end
RegisterGameObjectEvent(176767, 4, "lever_176767_OnUse")

-- Scholomance - Secret Door (LeverID:177385, DoorID:175610)
-- .worldport 289 227.261 88.3103 99.1947
function lever_177385_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(172.046,99.4433,105.135,175610):Activate()
end
RegisterGameObjectEvent(177385, 4, "lever_177385_OnUse")

-- Shadowfang Keep - Rethilgore (LeverID:18900, DoorID:18934)
-- .worldport 33 -252.696 2114.22 82.8052
function lever_18900_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-251.244,2116.38,81.218,18934):Activate()
end
RegisterGameObjectEvent(18900, 4, "lever_18900_OnUse")

-- Shadowfang Keep - Rethilgore (LeverID:18901, DoorID:18936)
-- .worldport 33 -249.22 2123.1 82.8052
function lever_18901_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-247.757,2125.23,81.0625,18936):Activate()
end
RegisterGameObjectEvent(18901, 4, "lever_18901_OnUse")

-- Shadowfang Keep - Rethilgore (LeverID:101811, DoorID:18935)
-- .worldport 33 -245.598 2132.32 82.8052
function lever_101811_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-244.14,2134.41,81.0625,18935):Activate()
end
RegisterGameObjectEvent(101811, 4, "lever_101811_OnUse")

-- Shadowfang Keep - Courtyard (LeverID:101812, DoorID:18895)
-- .worldport 33 -236.251 2164.04 91.1562
function lever_101812_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-242.581,2159.05,90.6226,18895):Activate()
end
RegisterGameObjectEvent(101812, 4, "lever_101812_OnUse")

-- Stratholme - Side Entrance (LeverID:175432, DoorID:175369)
-- .worldport 0 3191.1 -4044.29 108.423
function lever_175432_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(3185.48,-4039.1,107.792,175369):Activate()
end
RegisterGameObjectEvent(175432, 4, "lever_175432_OnUse")

-- Stratholme - Misc Doors
function stratholme_door_OnSpawn(pGO, event)
 pGO:SetClickable()
end
RegisterGameObjectEvent(175380, 2, "stratholme_door_OnSpawn") --Doodad_ZigguratDoor01
RegisterGameObjectEvent(175379, 2, "stratholme_door_OnSpawn") --Doodad_ZigguratDoor02
RegisterGameObjectEvent(175381, 2, "stratholme_door_OnSpawn") --Doodad_ZigguratDoor03
RegisterGameObjectEvent(175405, 2, "stratholme_door_OnSpawn") --Doodad_ZigguratDoor04
RegisterGameObjectEvent(175796, 2, "stratholme_door_OnSpawn") --Doodad_ZigguratDoor05
RegisterGameObjectEvent(175375, 2, "stratholme_door_OnSpawn") --Doodad_LargePortcullis01
RegisterGameObjectEvent(175376, 2, "stratholme_door_OnSpawn") --Doodad_LargePortcullis02
RegisterGameObjectEvent(175377, 2, "stratholme_door_OnSpawn") --Doodad_LargePortcullis03
RegisterGameObjectEvent(175372, 2, "stratholme_door_OnSpawn") --Doodad_LargePortcullis04
RegisterGameObjectEvent(175373, 2, "stratholme_door_OnSpawn") --Doodad_LargePortcullis05
RegisterGameObjectEvent(175374, 2, "stratholme_door_OnSpawn") --Doodad_LargePortcullis06
RegisterGameObjectEvent(175351, 2, "stratholme_door_OnSpawn") --Doodad_SmallPortcullis03
RegisterGameObjectEvent(175350, 2, "stratholme_door_OnSpawn") --Doodad_SmallPortcullis04
RegisterGameObjectEvent(175355, 2, "stratholme_door_OnSpawn") --Doodad_SmallPortcullis08
RegisterGameObjectEvent(175354, 2, "stratholme_door_OnSpawn") --Doodad_SmallPortcullis09
RegisterGameObjectEvent(175359, 2, "stratholme_door_OnSpawn") --Doodad_SmallPortcullis11
RegisterGameObjectEvent(175356, 2, "stratholme_door_OnSpawn") --Gauntlet Gate
RegisterGameObjectEvent(175357, 2, "stratholme_door_OnSpawn") --Gauntlet Gate
RegisterGameObjectEvent(175353, 2, "stratholme_door_OnSpawn") --King's Squire Gate

-- Large Harpoon lever - Howling Fjord (LeverID:186894, DoorID:N/A, RideHarpoonSpellId:44145)
-- .worldport 571 810.159 -5341.74 189.535

-- Zol'Maz Stronghold - Zul'Drak (LeverID:190834, DoorID:190784)
-- .worldport 571 6568.3 -3897.55 493.396
function lever_190834_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(6558.13,-3904.05,492.327,190784):Activate()
end
RegisterGameObjectEvent(190834, 4, "lever_190834_OnUse")

-- The Violet Hold - Dalaran (LeverID:193020, DoorID:193019)
-- .worldport 571 5678.39 489.66 652.22
function lever_193020_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(5688.81,497.206,652.656,193019):Activate()
end
RegisterGameObjectEvent(193020, 4, "lever_193020_OnUse")

-- Ulduar - Thorim (LeverID:194264, DoorID:194560)
-- .worldport 603 2173.27 -252.867 420.146
function lever_194264_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(2180.76,-263.021,414.681,194560):Activate()
end
RegisterGameObjectEvent(194264, 4, "lever_194264_OnUse")

-- Blackwing Lair - Chromaggus (LeverID:179148, DoorID:176966)
-- .worldport 469 -7510.98 -1094.69 476.554
function lever_179148_OnUse(pGO, event, player)
 pGO:Activate()
 player:GetGameObjectNearestCoords(-7488.169922,-1150.540039,476.712006,176966):Activate()
end
RegisterGameObjectEvent(179148, 4, "lever_179148_OnUse")

-- Unknown (LeverID:201818, DoorID:???)