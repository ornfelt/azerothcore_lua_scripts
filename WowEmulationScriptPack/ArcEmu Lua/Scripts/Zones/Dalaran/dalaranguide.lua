--------------------------------------------------
-------- Dalaran City Guide Script V.1.1 ---------
--  Created by Knaur@2008 Norwegian Elite Team  --
--     Our Web: http://www.chronos-wow.com      --
--   Made for ncdb, linked to all guide npc,s   --
--   except sewer guides. will make one later   --
--                                              --
--   Modifying is allowed as long as original   --
--    credits are not removed from this lua.    --
--------------------------------------------------
--------------------------------------------------

function On_Guide(unit, event, player)
unit:GossipCreateMenu(1, player, 0)
unit:GossipMenuAddItem(0, "Arena", 2, 0)
unit:GossipMenuAddItem(0, "Auction House", 3, 0)
unit:GossipMenuAddItem(0, "Bank", 4, 0)
unit:GossipMenuAddItem(0, "Barber", 5, 0)
unit:GossipMenuAddItem(0, "Battlemasters", 6, 0)
unit:GossipMenuAddItem(0, "Capital Portals", 7, 0)
unit:GossipMenuAddItem(0, "Flight Master", 8, 0)
unit:GossipMenuAddItem(0, "Guild Master", 9, 0)
unit:GossipMenuAddItem(0, "Inn", 10,  0)
unit:GossipMenuAddItem(0, "Mailbox", 11,  0)
unit:GossipMenuAddItem(0, "Points of Interest", 12,  0)
unit:GossipMenuAddItem(0, "Stable Master", 13, 0)
unit:GossipMenuAddItem(0, "Trainers", 14, 0)
unit:GossipMenuAddItem(0, "Vendors", 15, 0)
unit:GossipSendMenu(player)
end

function Guide_Submenu(unit, event, player, id, intid, code)
if(intid == 1) then
unit:GossipCreateMenu(16, player, 0)
unit:GossipMenuAddItem(0, "Arena", 2, 0)
unit:GossipMenuAddItem(0, "Auction House", 3, 0)
unit:GossipMenuAddItem(0, "Bank", 4, 0)
unit:GossipMenuAddItem(0, "Barber", 5, 0)
unit:GossipMenuAddItem(0, "Battlemasters", 6, 0)
unit:GossipMenuAddItem(0, "Capital Portals", 7, 0)
unit:GossipMenuAddItem(0, "Flight Master", 8, 0)
unit:GossipMenuAddItem(0, "Guild Master", 9, 0)
unit:GossipMenuAddItem(0, "Inn", 10,  0)
unit:GossipMenuAddItem(0, "Mailbox", 11,  0)
unit:GossipMenuAddItem(0, "Points of Interest", 12,  0)
unit:GossipMenuAddItem(0, "Stable Master", 13, 0)
unit:GossipMenuAddItem(0, "Trainers", 14, 0)
unit:GossipMenuAddItem(0, "Vendors", 15, 0)
unit:GossipSendMenu(player)
end

--arena
if(intid == 2) then
unit:GossipCreateMenu(17, player, 0)
unit:GossipMenuAddItem(3, "Dalaran's arena and those who service it are found beneath the city, in the sewers.", 2, 0)
unit:GossipMenuAddItem(3, "       ", 2, 0)
unit:GossipMenuAddItem(3, "There are at least three ways in: Entrances in the east and west, and a well in the north.", 2, 0)
unit:GossipMenuAddItem(3, "       ", 2, 0)
unit:GossipMenuAddItem(0, "Eastern Sewer Entrance", 18, 0)
unit:GossipMenuAddItem(0, "Western Sewer Entrance", 19, 0)
unit:GossipMenuAddItem(0, "Well Entrance", 20, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

if(intid == 18) then
player:Teleport(571, 5801.77, 551.07, 649.27)
end

if(intid == 19) then
player:Teleport(571, 5815.21, 762.65, 640.30)
end

if(intid == 20) then
player:Teleport(571, 5791.60, 561.82, 629.25)
end

--auction house
if(intid == 3) then
unit:GossipCreateMenu(21, player, 0)
unit:GossipMenuAddItem(3, "Dalaran has no auction house of its own. you must take a portal back to one of your capitals.", 3, 0)
unit:GossipMenuAddItem(3, "       ", 3, 0)
unit:GossipMenuAddItem(3, "They can be found in Dalaran's Alliance and Horde quarters: the Silver Enclave and the Sunreaver's Sanctuary.", 3, 0)
unit:GossipMenuAddItem(3, "       ", 3, 0)
unit:GossipMenuAddItem(0, "The Alliance Quarter", 22, 0)
unit:GossipMenuAddItem(0, "The Horde Quarter", 23, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

if(intid == 22) then
player:Teleport(571, 5763.20, 711.77, 641.84)
end

if(intid == 23) then
player:Teleport(571, 5860.35, 592.97, 650.73)
end

--bank
if(intid == 4) then
unit:GossipCreateMenu(24, player, 0)
unit:GossipMenuAddItem(3, "There are three banks in the city: The Bank of Dalaran in the north, the Dalaran Merchant's Bank in the south, and one more beneath the city, in the sewers.", 4, 0)
unit:GossipMenuAddItem(3, "       ", 4, 0)
unit:GossipMenuAddItem(0, "Northern Bank", 25, 0)
unit:GossipMenuAddItem(0, "Southern Bank", 26, 0)
unit:GossipMenuAddItem(0, "Sewers", 27, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

if(intid == 25) then
player:Teleport(571, 5979.58, 608.16, 650.62)
end

if(intid == 26) then
player:Teleport(571, 5631.20, 694.15, 651.99)
end

if(intid == 27) then
player:Teleport(571, 5766.31, 731.66, 618.58)
end

--barber
if(intid == 5) then
player:Teleport(571, 5889.67, 621.21, 649.38)
end

--battlemasters
if(intid == 6) then
unit:GossipCreateMenu(28, player, 0)
unit:GossipMenuAddItem(3, "Portals to the various capitals and battlegrounds can be found in Dalaran's Alliance and Horde quarters: the Silver Enclave and the Sunreaver's Sanctuary.", 6, 0)
unit:GossipMenuAddItem(3, "       ", 6, 0)
unit:GossipMenuAddItem(0, "The Alliance Quarter", 22, 0)
unit:GossipMenuAddItem(0, "The Horde Quarter", 23, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

--capital portals
if(intid == 7) then
unit:GossipCreateMenu(29, player, 0)
unit:GossipMenuAddItem(3, "Portals to the various capitals and battlegrounds can be found in Dalaran's Alliance and Horde quarters: the Silver Enclave and the Sunreaver's Sanctuary.", 7, 0)
unit:GossipMenuAddItem(3, "       ", 7, 0)
unit:GossipMenuAddItem(0, "The Alliance Quarter", 22, 0)
unit:GossipMenuAddItem(0, "The Horde Quarter", 23, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

--flight master
if(intid == 8) then
player:Teleport(571, 5815.91, 453.64, 658.75)
end

--guild master
if(intid == 9) then
player:Teleport(571, 5762.21, 622.84, 650.08)
end

--inn
if(intid == 10) then
unit:GossipCreateMenu(30, player, 0)
unit:GossipMenuAddItem(3, "The most popular inn in Dalaran is the Legerdemain Lounge, just north of the city,s center.", 10, 0)
unit:GossipMenuAddItem(3, "       ", 10, 0)
unit:GossipMenuAddItem(3, "The Alliance and Horde Quarters each have their own inns as well, and i am told there is one more beneath the city, in the sewers.", 10, 0)
unit:GossipMenuAddItem(3, "       ", 10, 0)
unit:GossipMenuAddItem(0, "Legerdemain Lounge", 31, 0)
unit:GossipMenuAddItem(0, "Alliance Inn", 32, 0)
unit:GossipMenuAddItem(0, "Horde Inn", 33, 0)
unit:GossipMenuAddItem(0, "Sewers", 34, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

if(intid == 31) then
player:Teleport(571, 5845.40, 647.37, 647.51)
end

if(intid == 32) then
player:Teleport(571, 5718.01, 689.28, 645.75)
end

if(intid == 33) then
player:Teleport(571, 5890.22, 500.58, 641.57)
end

if(intid == 34) then
player:Teleport(571, 5761.06, 714.45, 618.54)
end

--mailbox
if(intid == 11) then
unit:GossipCreateMenu(35, player, 0)
unit:GossipMenuAddItem(3, "There are many mailboxes in Dalaran: On many corners, outside nearly every inn and bank, even upon Krasus' Landing.", 11, 0)
unit:GossipMenuAddItem(3, "       ", 11, 0)
unit:GossipMenuAddItem(0, "Inn", 10, 0)
unit:GossipMenuAddItem(0, "Bank", 4, 0)
unit:GossipMenuAddItem(0, "Krasus' Landing", 8, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

--points of interest
if(intid == 12) then
unit:GossipCreateMenu(36, player, 0)
unit:GossipMenuAddItem(3, "There are many places of interest in Dalaran. Which do you seek?", 12, 0)
unit:GossipMenuAddItem(3, "       ", 12, 0)
unit:GossipMenuAddItem(0, "The Alliance Quarter", 22, 0)
unit:GossipMenuAddItem(0, "The Horde Quarter", 23, 0)
unit:GossipMenuAddItem(0, "The Violet Citadel", 37, 0)
unit:GossipMenuAddItem(0, "The Violet Hold", 38, 0)
unit:GossipMenuAddItem(0, "Sewers", 27, 0)
unit:GossipMenuAddItem(0, "Trade District", 39, 0)
unit:GossipMenuAddItem(0, "Krasus'Landing", 8, 0)
unit:GossipMenuAddItem(0, "Antonidas Memorial", 40, 0)
unit:GossipMenuAddItem(0, "Runeweaver Square", 41, 0)
unit:GossipMenuAddItem(0, "The Eventide", 42, 0)
unit:GossipMenuAddItem(0, "Cemetary", 43, 0)
unit:GossipMenuAddItem(0, "Lexicon of Power", 44, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

if(intid == 37) then
player:Teleport(571, 5795.11, 769.15, 661.31)
end

if(intid == 38) then
player:Teleport(571, 5720.40, 537.46, 653.16)
end

if(intid == 39) then
player:Teleport(571, 5900.88, 726.65, 639.81)
end

if(intid == 40) then
player:Teleport(571, 5951.74, 683.53, 640.43)
end

if(intid == 41) then
player:Teleport(571, 5810.96, 632.72, 647.42)
end

if(intid == 42) then
player:Teleport(571, 5694.66, 650.82, 646.45)
end

if(intid == 43) then
player:Teleport(571, 5853.35, 769.06, 641.14)
end

if(intid == 44) then
player:Teleport(571, 5860.99, 707.23, 643.45)
end

--stable master
if(intid == 13) then
player:Teleport(571, 5859.68, 557.57, 652.83)
end

--trainers
if(intid == 14) then
unit:GossipCreateMenu(45, player, 0)
unit:GossipMenuAddItem(0, "Class Trainer", 46, 0)
unit:GossipMenuAddItem(0, "Cold Weather Flying Trainer", 8, 0)
unit:GossipMenuAddItem(0, "Portal Trainer", 47, 0)
unit:GossipMenuAddItem(0, "Profession Trainer", 48, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

--class trainer
if(intid == 46) then
unit:GossipCreateMenu(49, player, 0)
unit:GossipMenuAddItem(3, "Dalaran's only class trainers are mages. You must take a portal back to one of your capitals for others.", 46, 0)
unit:GossipMenuAddItem(3, "       ", 46, 0)
unit:GossipMenuAddItem(3, "They can be found in Dalaran's Alliance and Horde quarters: the Silver Enclave and the Sunreaver's Sanctuary.", 46, 0)
unit:GossipMenuAddItem(3, "       ", 46, 0)
unit:GossipMenuAddItem(0, "The Alliance Quarter", 22, 0)
unit:GossipMenuAddItem(0, "The Horde Quarter", 23, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

--portal trainer
if(intid == 47) then
player:Teleport(571, 5810.07, 581.00, 652.83)
end

--profession trainer
if(intid == 48) then
unit:GossipCreateMenu(50, player, 0)
unit:GossipMenuAddItem(0, "Alchemy", 51, 0)
unit:GossipMenuAddItem(0, "Blacksmithing", 52, 0)
unit:GossipMenuAddItem(0, "Cooking", 53, 0)
unit:GossipMenuAddItem(0, "Enchanting", 54, 0)
unit:GossipMenuAddItem(0, "engineering", 55, 0)
unit:GossipMenuAddItem(0, "First Aid", 56, 0)
unit:GossipMenuAddItem(0, "Fishing", 57, 0)
unit:GossipMenuAddItem(0, "Herbalism", 58, 0)
unit:GossipMenuAddItem(0, "Inscription", 59, 0)
unit:GossipMenuAddItem(0, "Jewelcrafting", 60, 0)
unit:GossipMenuAddItem(0, "Leatherworking", 61, 0)
unit:GossipMenuAddItem(0, "Mining", 62, 0)
unit:GossipMenuAddItem(0, "Skinning", 63, 0)
unit:GossipMenuAddItem(0, "Tailoring", 64, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

if(intid == 51) then
player:Teleport(571, 5888.05, 702.44, 643.23)
end

if(intid == 52) then
player:Teleport(571, 5904.86, 680.12, 643.49)
end

if(intid == 53) then
unit:GossipCreateMenu(67, player, 0)
unit:GossipMenuAddItem(3, "Cooking trainers are located in the kitchens of the Alliance and Horde inns in theyr respective quarters.", 53, 0)
unit:GossipMenuAddItem(3, "       ", 53, 0)
unit:GossipMenuAddItem(0, "Alliance Inn", 32, 0)
unit:GossipMenuAddItem(0, "Horde Inn", 33, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

if(intid == 54) then
player:Teleport(571, 5840.01, 726.53, 641.99)
end

if(intid == 55) then
player:Teleport(571, 5922.55, 727.05, 642.13)
end

if(intid == 56) then
player:Teleport(571, 5862.76, 743.71, 640.55)
end

if(intid == 57) then
player:Teleport(571, 5707.45, 614.57, 646.73)
end

if(intid == 58) then
player:Teleport(571, 5873.99, 689.44, 644.72)
end

if(intid == 59) then
player:Teleport(571, 5861.80, 704.30, 643.27)
end

if(intid == 60) then
player:Teleport(571, 5874.27, 719.18, 643.12)
end

if(intid == 61) then
player:Teleport(571, 5903.90, 751.97, 641.04)
end

if(intid == 62) then
player:Teleport(571, 5923.27, 709.86, 642.51)
end

if(intid == 63) then
player:Teleport(571, 5903.90, 751.97, 641.04)
end

if(intid == 64) then
player:Teleport(571, 5881.78, 746.64, 640.37)
end

--vendors
if(intid == 15) then
unit:GossipCreateMenu(65, player, 0)
unit:GossipMenuAddItem(0, "Armor", 66, 0)
unit:GossipMenuAddItem(0, "Clothing", 82, 0)
unit:GossipMenuAddItem(0, "Emblem Gear", 68, 0)
unit:GossipMenuAddItem(0, "Flowers", 69, 0)
unit:GossipMenuAddItem(0, "Fruit", 70, 0)
unit:GossipMenuAddItem(0, "General Goods", 71, 0)
unit:GossipMenuAddItem(0, "Jewelry", 60, 0)
unit:GossipMenuAddItem(0, "Pet Supplies & Exotic Mounts", 73, 0)
unit:GossipMenuAddItem(0, "Pie, Pastry & Cakes", 74, 0)
unit:GossipMenuAddItem(0, "Reagents & Magical Goods", 75, 0)
unit:GossipMenuAddItem(0, "Toys", 76, 0)
unit:GossipMenuAddItem(0, "Trade Supplies", 71, 0)
unit:GossipMenuAddItem(0, "Trinkets. Relics & Off-hand items", 78, 0)
unit:GossipMenuAddItem(0, "Weapons", 79, 0)
unit:GossipMenuAddItem(0, "Wine & Cheese", 80, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

if(intid == 69) then
player:Teleport(571, 5772.27, 576.61, 650.40)
end

if(intid == 70) then
player:Teleport(571, 5754.02, 694.18, 643.33)
end

if(intid == 71) then
player:Teleport(571, 5681.22, 616.57, 648.23)
end

if(intid == 73) then
player:Teleport(571, 5833.13, 572.72, 651.61)
end

if(intid == 74) then
player:Teleport(571, 5905.86, 629.29, 646.35)
end

if(intid == 75) then
player:Teleport(571, 5758.70, 737.24, 641.69)
end

if(intid == 76) then
player:Teleport(571, 5813.48, 688.49, 647.04)
end

if(intid == 78) then
player:Teleport(571, 5755.53, 642.03, 650.14)
end

if(intid == 80) then
player:Teleport(571, 5885.66, 606.89, 650.29)
end

--armor
if(intid == 66) then
unit:GossipCreateMenu(81, player, 0)
unit:GossipMenuAddItem(3, "What sort of armor?", 66, 0)
unit:GossipMenuAddItem(3, "       ", 66, 0)
unit:GossipMenuAddItem(0, "Cloth Armor", 82, 0)
unit:GossipMenuAddItem(0, "Leather Armor", 83, 0)
unit:GossipMenuAddItem(0, "Mail Armor", 84, 0)
unit:GossipMenuAddItem(0, "Plate Armor", 85, 0)
unit:GossipMenuAddItem(0, "Shields", 86, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

if(intid == 82) then
player:Teleport(571, 5793.11, 686.44, 647.09)
end

if(intid == 83) then
player:Teleport(571, 5667.76, 627.16, 648.10)
end

if(intid == 84) then
player:Teleport(571, 5667.76, 627.16, 648.10)
end

if(intid == 85) then
player:Teleport(571, 5914.85, 667.22, 643.49)
end

if(intid == 86) then
player:Teleport(571, 5914.85, 667.22, 643.49)
end

--emblem gear
if(intid == 68) then
unit:GossipCreateMenu(87, player, 0)
unit:GossipMenuAddItem(3, "Adventurers turn in their Emblems of Heroism or Valor in the Silver Enclave or Sunreaver's Sactuary", 68, 0)
unit:GossipMenuAddItem(3, "       ", 68, 0)
unit:GossipMenuAddItem(0, "The Alliance Quarter", 22, 0)
unit:GossipMenuAddItem(0, "The Horde Quarter", 23, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

--weapons
if(intid == 79) then
unit:GossipCreateMenu(88, player, 0)
unit:GossipMenuAddItem(3, "What sorts of weapons?", 79, 0)
unit:GossipMenuAddItem(3, "       ", 79, 0)
unit:GossipMenuAddItem(0, "Melee Weapons", 89, 0)
unit:GossipMenuAddItem(0, "Ranged & Thrown Weapons", 90, 0)
unit:GossipMenuAddItem(0, "Staves & Wands", 91, 0)
unit:GossipMenuAddItem(0, "[Back]", 1, 0)
unit:GossipSendMenu(player)
end

if(intid == 89) then
player:Teleport(571, 5725.11, 602.57, 648.90)
end

if(intid == 90) then
player:Teleport(571, 5778.50, 556.18, 651.63)
end

if(intid == 91) then
player:Teleport(571, 5665.40, 644.91, 647.98)
end
end

RegisterUnitGossipEvent(32675, 1, "On_Guide")
RegisterUnitGossipEvent(32675, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32676, 1, "On_Guide")
RegisterUnitGossipEvent(32676, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32677, 1, "On_Guide")
RegisterUnitGossipEvent(32677, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32678, 1, "On_Guide")
RegisterUnitGossipEvent(32678, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32679, 1, "On_Guide")
RegisterUnitGossipEvent(32679, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32680, 1, "On_Guide")
RegisterUnitGossipEvent(32680, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32681, 1, "On_Guide")
RegisterUnitGossipEvent(32681, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32683, 1, "On_Guide")
RegisterUnitGossipEvent(32683, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32684, 1, "On_Guide")
RegisterUnitGossipEvent(32684, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32685, 1, "On_Guide")
RegisterUnitGossipEvent(32685, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32686, 1, "On_Guide")
RegisterUnitGossipEvent(32686, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32687, 1, "On_Guide")
RegisterUnitGossipEvent(32687, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32688, 1, "On_Guide")
RegisterUnitGossipEvent(32688, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32689, 1, "On_Guide")
RegisterUnitGossipEvent(32689, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32690, 1, "On_Guide")
RegisterUnitGossipEvent(32690, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32691, 1, "On_Guide")
RegisterUnitGossipEvent(32691, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32692, 1, "On_Guide")
RegisterUnitGossipEvent(32692, 2, "Guide_Submenu")
RegisterUnitGossipEvent(32693, 1, "On_Guide")
RegisterUnitGossipEvent(32693, 2, "Guide_Submenu")