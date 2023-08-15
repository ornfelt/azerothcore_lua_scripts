-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------


function On_Gossip(unit, event, player)
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(0, "|cFFFF0000Welcome to the Horde Teleporter!|r", 0, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCNetural Cities|r", 1, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCHorde Cities|r", 2, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCCustom Horde Cities|r", 3, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCAzeroth Locations|r", 4, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCOutland Locations|r", 5, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCNorthrend Locations|r", 6, 0)
unit:GossipMenuAddItem(3, "|cFFCC00CCSpecial area's and Event|r", 7, 0)
unit:GossipMenuAddItem(6, "|cFFCC00CCPvP Arenas|r", 8, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCCustom Instances|r", 9, 0)
unit:GossipMenuAddItem(4, "|cFFCC6600Remove Ressurection sickness|r", 998, 0)
unit:GossipSendMenu(player)
end

function Gossip_Submenus(unit, event, player, id, intid, code)
if(intid == 999) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(0, "|cFF000000Welcome to the Horde Teleporter!|r", 0, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCNetural Cities|r", 1, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCHorde Cities|r", 2, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCCustom Horde Cities|r", 3, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCAzeroth Locations|r", 4, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCOutland Locations|r", 5, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCNorthrend Locations|r", 6, 0)
unit:GossipMenuAddItem(3, "|cFFCC00CCSpecial area's and Event|r", 7, 0)
unit:GossipMenuAddItem(6, "|cFFCC00CCPvP Arenas|r", 8, 0)
unit:GossipMenuAddItem(2, "|cFFCC00CCCustom Instances|r", 9, 0)
unit:GossipMenuAddItem(4, "|cFFCC6600Remove Ressurection sickness|r", 998, 0)
unit:GossipSendMenu(player)
end

if(intid == 1) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000NoN-PvP Mall|r", 534, 0)
unit:GossipMenuAddItem(2, "|cFF000000PvP Mall|r", 535, 0)
unit:GossipMenuAddItem(2, "|cFF000000Dalaran|r", 200, 0)
unit:GossipMenuAddItem(2, "|cFF000000Shattrath|r", 201, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 2) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Orgrimmar City|r", 202, 0)
unit:GossipMenuAddItem(2, "|cFF000000Undercity|r", 203, 0)
unit:GossipMenuAddItem(2, "|cFF000000Thunder Bluff|r", 204, 0)
unit:GossipMenuAddItem(2, "|cFF000000Silvermoon City|r", 205, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 3) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Horde Mall|r", 206, 0)
unit:GossipMenuAddItem(2, "|cFF000000Horde Level Road|r", 207, 0)
unit:GossipMenuAddItem(2, "|cFF000000??|r", 208, 0)
unit:GossipMenuAddItem(2, "|cFF000000Gm Help Desk|r", 209, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 4) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(3, "|cFF000000Eastern Kingdoms|r", 210, 0)
unit:GossipMenuAddItem(3, "|cFF000000Kalimdor|r", 211, 0)
unit:GossipMenuAddItem(2, "|cFF000000Dungeons|r", 212, 0)
unit:GossipMenuAddItem(2, "|cFF000000Raids|r", 213, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 5) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(3, "|cFF000000Locations|r", 214, 0)
unit:GossipMenuAddItem(2, "|cFF000000Dungeons|r", 215, 0)
unit:GossipMenuAddItem(2, "|cFF000000Raids|r", 216, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 6) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(3, "|cFF000000Locations|r", 217, 0)
unit:GossipMenuAddItem(2, "|cFF000000Dungeons|r", 218, 0)
unit:GossipMenuAddItem(2, "|cFF000000Raids|r", 219, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 7) then --Events
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Stormwind Stair Event|r", 220, 0)
unit:GossipMenuAddItem(2, "|cFF000000Orgrimmar Stair Event|r", 221, 0)
unit:GossipMenuAddItem(2, "|cFF000000Dark Portal|r", 222, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 8) then --PvP Arenas
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Gurubashi Arena|r", 223, 0)
unit:GossipMenuAddItem(2, "|cFF000000Dire Maul Arena|r", 224, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 9) then --Custom Instances & Areas
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000??|r", 225, 0)
unit:GossipMenuAddItem(2, "|cFF000000Fake Stormwind City|r", 226, 0)
unit:GossipMenuAddItem(2, "|cFF000000??|r", 227, 0)
unit:GossipMenuAddItem(2, "|cFF000000EmeraldForest|r", 228, 0)
unit:GossipMenuAddItem(2, "|cFF000000??|r", 229, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 210) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Alterac Mountains|r", 400, 0)
unit:GossipMenuAddItem(2, "|cFF000000Badlands|r", 401, 0)
unit:GossipMenuAddItem(2, "|cFF000000Blasted Lands|r", 402, 0)
unit:GossipMenuAddItem(2, "|cFF000000Burning Steppes|r", 403, 0)
unit:GossipMenuAddItem(2, "|cFF000000Deadwind Pass|r", 404, 0)
unit:GossipMenuAddItem(2, "|cFF000000Dun Morogh|r", 405, 0)
unit:GossipMenuAddItem(2, "|cFF000000Duskwood|r", 406, 0)
unit:GossipMenuAddItem(2, "|cFF000000Eastern Plaguelands|r", 407, 0)
unit:GossipMenuAddItem(2, "|cFF000000Elwynn Forest|r", 408, 0)
unit:GossipMenuAddItem(2, "|cFF000000Eversong Woods|r", 409, 0)
unit:GossipMenuAddItem(2, "|cFF000000Ghostlands|r", 410, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Next Page]|r", 800, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 4, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 800) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Hillsbrad Foothills|r", 412, 0)
unit:GossipMenuAddItem(2, "|cFF000000Loch Modan|r", 413, 0)
unit:GossipMenuAddItem(2, "|cFF000000Redridge Mountains|r", 414, 0)
unit:GossipMenuAddItem(2, "|cFF000000Searing Gorge|r", 415, 0)
unit:GossipMenuAddItem(2, "|cFF000000Silverpine Forest|r", 416, 0)
unit:GossipMenuAddItem(2, "|cFF000000Strangethorn Vale|r", 417, 0)
unit:GossipMenuAddItem(2, "|cFF000000Swamp Of Sorrows|r", 418, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Hinterlands|r", 419, 0)
unit:GossipMenuAddItem(2, "|cFF000000Trisfal Glades|r", 420, 0)
unit:GossipMenuAddItem(2, "|cFF000000Westfall|r", 421, 0)
unit:GossipMenuAddItem(2, "|cFF000000Western Plaguelands|r", 422, 0)
unit:GossipMenuAddItem(2, "|cFF000000Wetlands|r", 423, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 210, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 211) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Ashenvale|r", 424, 0)
unit:GossipMenuAddItem(2, "|cFF000000Azuremyst Isle|r", 425, 0)
unit:GossipMenuAddItem(2, "|cFF000000Bloodmyst Isle|r", 426, 0)
unit:GossipMenuAddItem(2, "|cFF000000Darkshore|r", 427, 0)
unit:GossipMenuAddItem(2, "|cFF000000Desolace|r", 428, 0)
unit:GossipMenuAddItem(2, "|cFF000000Durotar|r", 429, 0)
unit:GossipMenuAddItem(2, "|cFF000000Dustwallow Marsh|r", 430, 0)
unit:GossipMenuAddItem(2, "|cFF000000Felwood|r", 431, 0)
unit:GossipMenuAddItem(2, "|cFF000000Moonglade|r", 432, 0)
unit:GossipMenuAddItem(2, "|cFF000000Mulgore|r", 433, 0)
unit:GossipMenuAddItem(2, "|cFF000000Silithus|r", 434, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Next Page]|r", 801, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 4, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 801) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Tanaris|r", 435, 0)
unit:GossipMenuAddItem(2, "|cFF000000Teldrassil|r", 436, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Barrens|r", 437, 0)
unit:GossipMenuAddItem(2, "|cFF000000Thousand Needles|r", 438, 0)
unit:GossipMenuAddItem(2, "|cFF000000Un'Goro Crater|r", 439, 0)
unit:GossipMenuAddItem(2, "|cFF000000Winterspring|r", 440, 0)
unit:GossipMenuAddItem(2, "|cFF000000Azshara|r", 441, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 211, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 212) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Blackfathom Deeps|r", 442, 0)
unit:GossipMenuAddItem(2, "|cFF000000Blackrock Depths|r", 443, 0)
unit:GossipMenuAddItem(2, "|cFF000000Blackrock Spire|r", 444, 0)
unit:GossipMenuAddItem(2, "|cFF000000Dire Maul|r", 445, 0)
unit:GossipMenuAddItem(2, "|cFF000000Gnomeregan|r", 446, 0)
unit:GossipMenuAddItem(2, "|cFF000000Maraudon|r", 447, 0)
unit:GossipMenuAddItem(2, "|cFF000000Ragefire Chasm|r", 448, 0)
unit:GossipMenuAddItem(2, "|cFF000000Razorfen Down|r", 533, 0)
unit:GossipMenuAddItem(2, "|cFF000000Razorfen Kraul|r", 449, 0)
unit:GossipMenuAddItem(2, "|cFF000000Scholomance|r", 450, 0)
unit:GossipMenuAddItem(2, "|cFF000000Shadowfang Keep|r", 451, 0)
unit:GossipMenuAddItem(2, "|cFF000000Stratholme|r", 452, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Next Page]|r", 802, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 4, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 802) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Sunken Temple|r", 453, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Deadmines|r", 454, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Stockade|r", 455, 0)
unit:GossipMenuAddItem(2, "|cFF000000Uldaman|r", 456, 0)
unit:GossipMenuAddItem(2, "|cFF000000Wailing Caverns|r", 457, 0)
unit:GossipMenuAddItem(2, "|cFF000000Zul'Farrak|r", 458, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC- Scarlet Monastery -|r", 0, 0)
unit:GossipMenuAddItem(2, "|cFF000000Graveyard|r", 529, 0)
unit:GossipMenuAddItem(2, "|cFF000000Library|r", 530, 0)
unit:GossipMenuAddItem(2, "|cFF000000Armory|r", 531, 0)
unit:GossipMenuAddItem(2, "|cFF000000Cathedral|r", 532, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 212, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 213) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Blackwing Lair|r", 460, 0)
unit:GossipMenuAddItem(2, "|cFF000000Molten Core|r", 461, 0)
unit:GossipMenuAddItem(2, "|cFF000000Ruins of Ahn'Qiraj|r", 462, 0)
unit:GossipMenuAddItem(2, "|cFF000000Temple of Ahn'Qiraj|r", 463, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 4, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 214) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Hellfire Peninsula|r", 488, 0)
unit:GossipMenuAddItem(2, "|cFF000000Zangarmarsh|r", 489, 0)
unit:GossipMenuAddItem(2, "|cFF000000Nagarad|r", 490, 0)
unit:GossipMenuAddItem(2, "|cFF000000Blades Edge Mountains|r", 491, 0)
unit:GossipMenuAddItem(2, "|cFF000000Netherstorm|r", 492, 0)
unit:GossipMenuAddItem(2, "|cFF000000Terokkar Forest|r", 493, 0)
unit:GossipMenuAddItem(2, "|cFF000000Shadowmoon Valley|r", 494, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 5, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 215) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Auchenai Crypts|r", 472, 0)
unit:GossipMenuAddItem(2, "|cFF000000Mana-Tombs|r", 473, 0)
unit:GossipMenuAddItem(2, "|cFF000000Sethekk Halls|r", 474, 0)
unit:GossipMenuAddItem(2, "|cFF000000Shadow Labyrinth|r", 475, 0)
unit:GossipMenuAddItem(2, "|cFF000000Old Hillsbrad Foothills|r", 476, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Black Morass|r", 477, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Slave Pens|r", 478, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Steamvault|r", 479, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Underbog|r", 480, 0)
unit:GossipMenuAddItem(2, "|cFF000000Hellfire Ramparts|r", 481, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Blood Furnace|r", 482, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Shattered Halls|r", 483, 0)
unit:GossipMenuAddItem(2, "|cFF000000Magisters' Terrace|r", 484, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Arcatraz|r", 485, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Botanica|r", 486, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Mechanar|r", 487, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 5, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 216) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Black Temple|r", 464, 0)
unit:GossipMenuAddItem(2, "|cFF000000Hyjal Summit|r", 465, 0)
unit:GossipMenuAddItem(2, "|cFF000000Serpentshrine Cavern|r", 466, 0)
unit:GossipMenuAddItem(2, "|cFF000000Gruul's Lair|r", 467, 0)
unit:GossipMenuAddItem(2, "|cFF000000Magtheridon's Lair|r", 468, 0)
unit:GossipMenuAddItem(2, "|cFF000000Karazhan|r", 469, 0)
unit:GossipMenuAddItem(2, "|cFF000000Sunwell Plateau|r", 470, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Eye|r", 471, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 5, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end


if(intid == 217) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Borean Tundra|r", 495, 0)
unit:GossipMenuAddItem(2, "|cFF000000Crystalsong Forest|r", 496, 0)
unit:GossipMenuAddItem(2, "|cFF000000Dragonblight|r", 497, 0)
unit:GossipMenuAddItem(2, "|cFF000000Grizzly Hills|r", 498, 0)
unit:GossipMenuAddItem(2, "|cFF000000Howling Fjord|r", 499, 0)
unit:GossipMenuAddItem(2, "|cFF000000Icecrown|r", 500, 0)
unit:GossipMenuAddItem(2, "|cFF000000Sholazar Basin|r", 501, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Storm Peaks|r", 502, 0)
unit:GossipMenuAddItem(2, "|cFF000000Zul'Drak|r", 503, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 6, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 218) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Ahn'kahet: The Old Kingdom|r", 504, 0)
unit:GossipMenuAddItem(2, "|cFF000000Azjol-Nerub|r", 505, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Culling of Stratholme|r", 506, 0)
unit:GossipMenuAddItem(2, "|cFF000000Trial of the Champion*|r", 507, 0)
unit:GossipMenuAddItem(2, "|cFF000000Drak'Tharon Keep|r", 508, 0)
unit:GossipMenuAddItem(2, "|cFF000000Gundrak|r", 509, 0)
unit:GossipMenuAddItem(2, "|cFF000000ICC: Halls of Reflection*|r", 510, 0)
unit:GossipMenuAddItem(2, "|cFF000000ICC: Pit of Saron*|r", 511, 0)
unit:GossipMenuAddItem(2, "|cFF000000ICC: The Forge of Souls*|r", 512, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Next Page]|r", 803, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 6, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 803) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Nexus|r", 513, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Oculus|r", 514, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Violet Hold|r", 515, 0)
unit:GossipMenuAddItem(2, "|cFF000000Ulduar: Halls of Lightning|r", 516, 0)
unit:GossipMenuAddItem(2, "|cFF000000Ulduar: Halls of Stone|r", 517, 0)
unit:GossipMenuAddItem(2, "|cFF000000Utgarde Keep|r", 518, 0)
unit:GossipMenuAddItem(2, "|cFF000000Utgarde Pinnacle|r", 519, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 218, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 219) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "|cFF000000Trial of the Crusader*|r", 520, 0)
unit:GossipMenuAddItem(2, "|cFF000000Icecrown Citadel*|r", 521, 0)
unit:GossipMenuAddItem(2, "|cFF000000Naxxramas|r", 522, 0)
unit:GossipMenuAddItem(2, "|cFF000000Onyxia's Lair|r", 523, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Eye of Eternity|r", 524, 0)
unit:GossipMenuAddItem(2, "|cFF000000Ulduar|r", 525, 0)
unit:GossipMenuAddItem(2, "|cFF000000Vault of Archavon|r", 526, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Obsidian Sanctum|r", 527, 0)
unit:GossipMenuAddItem(2, "|cFF000000The Ruby Sanctum|r", 528, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Back]|r", 6, 0)
unit:GossipMenuAddItem(0, "|cFFCC00CC[Main Menu]|r", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 998) then
player:LearnSpell(15007)
player:UnlearnSpell(15007)
player:GossipComplete()
end

if(intid == 200) then
player:Teleport(571, 5827.108398, 471.056793, 658.783203)
player:GossipComplete()
end

if(intid == 201) then
player:Teleport(530, -1722.58, 5382.7, 2.47504)
player:GossipComplete()
end

if(intid == 202) then
player:Teleport(1, 1505.377319, -4414.602539, 20.598469)
player:GossipComplete()
end

if(intid == 203) then
player:Teleport(0, 1831.750854, 238.543503, 60.478447)
player:GossipComplete()
end

if(intid == 204) then
player:Teleport(1, -1282.347534, 133.302917, 131.218323)
player:GossipComplete()
end

if(intid == 205) then
player:Teleport(530, -4008.085205, -11885.257813, -1.419589)
player:GossipComplete()
end

if(intid == 206) then
player:Teleport(0, 4079.022217, -4759.360352, 128.970886)
player:GossipComplete()
end

if(intid == 207) then
player:Teleport()
player:GossipComplete()
end

if(intid == 208) then
player:Teleport()
player:GossipComplete()
end

if(intid == 209) then
player:Teleport()
player:GossipComplete()
end

if(intid == 220) then
player:Teleport()
player:GossipComplete()
end

if(intid == 221) then
player:Teleport()
player:GossipComplete()
end

if(intid == 222) then
player:Teleport()
player:GossipComplete()
end

if(intid == 223) then
player:Teleport(0, -13152.9, 342.729, 53.1328)
player:GossipComplete()
end

if(intid == 224) then
player:Teleport(429, 252.588, -24.7395, -1.56062)
player:GossipComplete()
end

if(intid == 225) then
player:Teleport()
player:GossipComplete()
end

if(intid == 226) then
player:Teleport(723, -8966.5, 512.701, 96.3532)
player:GossipComplete()
end

if(intid == 227) then
player:Teleport()
player:GossipComplete()
end

if(intid == 228) then
player:Teleport(169, 2732.93, -3319.63, 102.284)
player:GossipComplete()
end

if(intid == 229) then
player:Teleport()
player:GossipComplete()
end

if(intid == 400) then
player:Teleport(0, 522.608, -275.392, 150.689)
player:GossipComplete()
end

if(intid == 401) then
player:Teleport(0, -6380.77, -3139.89, 301.111)
player:GossipComplete()
end

if(intid == 402) then
player:Teleport(0, 11853.6, -3197.44, 27.2186)
player:GossipComplete()
end

if(intid == 403) then
player:Teleport(0, -7924.68, -2624.44, 220.958)
player:GossipComplete()
end

if(intid == 404) then
player:Teleport(0, -10435.4, -1809.28, 101)
player:GossipComplete()
end

if(intid == 405) then
player:Teleport(0, -5660.33, 755.299, 390.605)
player:GossipComplete()
end

if(intid == 406) then
player:Teleport(0, -10517, -1158.39, 40.0542)
player:GossipComplete()
end

if(intid == 407) then
player:Teleport(0, 2823.83, -3727.76, 124.971)
player:GossipComplete()
end

if(intid == 408) then
player:Teleport(0, -9443.45, 59.8944, 56.0704)
player:GossipComplete()
end

if(intid == 409) then
player:Teleport(530, 8481, 5565, 1)
player:GossipComplete()
end

if(intid == 410) then
player:Teleport(530, 7880, -6193, 22)
player:GossipComplete()
end

if(intid == 412) then
player:Teleport(0, -28.1484, -899.243, 56.0704)
player:GossipComplete()
end

if(intid == 413) then
player:Teleport(0, -5755.53, -3998.42, 330.436)
player:GossipComplete()
end

if(intid == 414) then
player:Teleport(0, -9168.66, -2726.31, 90.0426)
player:GossipComplete()
end

if(intid == 415) then
player:Teleport(0, -6892.24, -1342.38, 239.913)
player:GossipComplete()
end

if(intid == 416) then
player:Teleport(0, -757.376, 1527.28, 17.2465)
player:GossipComplete()
end

if(intid == 417) then
player:Teleport(0, -13382.6, 2.10815, 21.8683)
player:GossipComplete()
end

if(intid == 418) then
player:Teleport(0, -10303.5, -3972.28, 20.2882)
player:GossipComplete()
end

if(intid == 419) then
player:Teleport(0, -464.208, -2837.23, 110.073)
player:GossipComplete()
end

if(intid == 420) then
player:Teleport(0, 2955.79, 99.8215, 3.32947)
player:GossipComplete()
end

if(intid == 421) then
player:Teleport(0, -10510, 1046.89, 60.518)
player:GossipComplete()
end

if(intid == 422) then
player:Teleport(0, 1386.47, -1518.8, 72.4034)
player:GossipComplete()
end

if(intid == 423) then
player:Teleport(0, -3465.16, -3727.56, 64.5778)
player:GossipComplete()
end

if(intid == 424) then
player:Teleport(1, 2454.38, -2943.27, 124)
player:GossipComplete()
end

if(intid == 425) then
player:Teleport(530, -4020.48, -13783.3, 74.9001)
player:GossipComplete()
end

if(intid == 426) then
player:Teleport(530, -2721.68, -12208.9, 10.0882)
player:GossipComplete()
end

if(intid == 427) then
player:Teleport(1, 5028.14, 534.745, 7.28397)
player:GossipComplete()
end

if(intid == 428) then
player:Teleport(1, -439.192, 1708.22, 125.856)
player:GossipComplete()
end

if(intid == 429) then
player:Teleport(1, -1124.19, -5535.02, 8.62076)
player:GossipComplete()
end

if(intid == 430) then
player:Teleport(1, -3922.24, -2839.21, 44.6212)
player:GossipComplete()
end

if(intid == 431) then
player:Teleport(1, 3652.24, 928.308, 7.01517)
player:GossipComplete()
end

if(intid == 433) then
player:Teleport(1, -758.744, -149.474, -27.712)
player:GossipComplete()
end

if(intid == 434) then
player:Teleport(1, -6925.356934, 915.713562, 22.929478)
player:GossipComplete()
end

if(intid == 435) then
player:Teleport(1, -7160.649902, 3841.387207, 8.671937)
player:GossipComplete()
end

if(intid == 436) then
player:Teleport(1, 9477.19, 1005.74, 1249.01)
player:GossipComplete()
end

if(intid == 437) then
player:Teleport(1, -4619.15, -1850.91, 86.0563)
player:GossipComplete()
end

if(intid == 438) then
player:Teleport(1, -5437.4, -2437.47, 89.3083)
player:GossipComplete()
end

if(intid == 439) then
player:Teleport(1, -6154.613281, -1090.232422, -203.079956)
player:GossipComplete()
end

if(intid == 440) then
player:Teleport(1, 6695.457031, -4669.457031, 721.567566)
player:GossipComplete()
end

if(intid == 441) then
player:Teleport(1, 3546.8, -5287.96, 109.935)
player:GossipComplete()
end

if(intid == 442) then
player:Teleport(48, -150.0377, 105.3537, -40.0085)
player:GossipComplete()
end

if(intid == 443) then
player:Teleport(0, -7179.629883, -923.666992, 166.416000)
player:GossipComplete()
end

if(intid == 444) then
player:Teleport(0, -7526.548828, -1226.244873, 285.732483)
player:GossipComplete()
end

if(intid == 445) then
item:GossipCreateMenu(3000, player, 0)
item:GossipMenuAddItem(2, "|cFF000000North|r", 802, 0)
item:GossipMenuAddItem(2, "|cFF000000West|r", 801, 0)
item:GossipMenuAddItem(2, "|cFF000000East|r", 800, 0)
item:GossipSendMenu(player)
end

if(intid == 800) then
player:Teleport(1, -3756.756104, 934.899170, 161.023422)
player:GossipComplete()
end

if(intid == 801) then
player:Teleport(1, -3758.720215, 1249.374390, 160.270325)
player:GossipComplete()
end

if(intid == 802) then
player:Teleport(1, -3520.219971, 1092.346069, 161.049561)
player:GossipComplete()
end

if(intid == 446) then
player:Teleport(90, -332.1519, -2.6040, -152.8454)
player:GossipComplete()
end

if(intid == 447) then
player:Teleport(349, 419.84, 11.3365, -131.079)
player:GossipComplete()
end

if(intid == 448) then
player:Teleport(389, 3.6572, -8.7495, -15.8352)
player:GossipComplete()
end

if(intid == 449) then
player:Teleport(47, 1942.2904, 1543.1372, 81.4717)
player:GossipComplete()
end

if(intid == 450) then
player:Teleport(289, 190.8452, 126.7041, 137.2098)
player:GossipComplete()
end

if(intid == 451) then
player:Teleport(33, -227.8457, 2111.7126, 76.8899)
player:GossipComplete()
end

if(intid == 452) then
player:Teleport(329, 3392.0125, -3379.0000, 142.7257)
player:GossipComplete()
end

if(intid == 453) then
player:Teleport(0, -1034.1, -3849.67, -24.6078)
player:GossipComplete()
end

if(intid == 454) then
player:Teleport(0, -11205.666016, 1670.761597, 24.958138)
player:GossipComplete()
end

if(intid == 455) then
player:Teleport(0, -8764.83, 846.075, 88.4842)
player:GossipComplete()
end

if(intid == 456) then
player:Teleport(70, -228.193, 46.1602, -45.0186)
player:GossipComplete()
end

if(intid == 457) then
player:Teleport(1, -735.337952, -2222.269531, 17.564709)
player:GossipComplete()
end

if(intid == 458) then
player:Teleport(209, 1221.82, 840.746, 9.97647)
player:GossipComplete()
end

if(intid == 460) then
player:Teleport(469, -7665.55, -1102.49, 400.679)
player:GossipComplete()
end

if(intid == 461) then
player:Teleport(409, 1115.22, -462.959, -94.0148)
player:GossipComplete()
end

if(intid == 462) then
player:Teleport(509, -8437.5342, 151.8475, 31.9070)
player:GossipComplete()
end

if(intid == 463) then
player:Teleport()
player:GossipComplete()
end

if(intid == 464) then
player:Teleport(564, 439.6234, -169.7441, 8.5809)
player:GossipComplete()
end

if(intid == 465) then
player:Teleport(534, 4608.4888, -3904.1729, 944.1841)
player:GossipComplete()
end

if(intid == 466) then
player:Teleport(548, 11.7795, 15.4273, -57.3773)
player:GossipComplete()
end

if(intid == 467) then
player:Teleport(565, 61.8337, 39.4399, -4.37842)
player:GossipComplete()
end

if(intid == 468) then
player:Teleport(544, 187.8426, 35.9232, 67.9252)
player:GossipComplete()
end

if(intid == 469) then
player:Teleport(532, -11109.36, -2002.97, 49.9)
player:GossipComplete()
end

if(intid == 470) then
player:Teleport(530, 10459.0205, -6366.3696, 39.7917)
player:GossipComplete()
end

if(intid == 471) then
player:Teleport(550, -10.4403, -1.1654, -2.4283)
player:GossipComplete()
end

if(intid == 472) then
player:Teleport(558, -21.8975, 0.1600, -0.1206)
player:GossipComplete()
end

if(intid == 473) then
player:Teleport(557, 0.0191, 0.9478, -0.9543)
player:GossipComplete()
end

if(intid == 474) then
player:Teleport(556, 0.0000, 0.0000, 0.0062)
player:GossipComplete()
end

if(intid == 475) then
player:Teleport(555, 0.0000, 0.0000, -1.1279)
player:GossipComplete()
end

if(intid == 476) then
player:Teleport(560, -1752.68, -288.79, 73.05)
player:GossipComplete()
end

if(intid == 477) then
player:Teleport(269, 1116.7, -323.5, 68.5)
player:GossipComplete()
end

if(intid == 478) then
player:Teleport(547, 119.1046, -130.5463, -0.3474)
player:GossipComplete()
end

if(intid == 479) then
player:Teleport(545, -13.8425, 6.7542, -4.2586)
player:GossipComplete()
end

if(intid == 480) then
player:Teleport(546, 9.7292, -21.3373, -2.7538)
player:GossipComplete()
end

if(intid == 481) then
player:Teleport(543, -1360.6732, 1632.5004, 68.4421)
player:GossipComplete()
end

if(intid == 482) then
player:Teleport(542, -3.9967, 14.6363, -44.8009)
player:GossipComplete()
end

if(intid == 483) then
player:Teleport(540, -41.5824, -23.0868, -13.6441)
player:GossipComplete()
end

if(intid == 484) then
player:Teleport(585, 2.19347, -0.123698, -2.8025)
player:GossipComplete()
end

if(intid == 485) then
player:Teleport(552, 0.0000, 0.0000, -0.2055)
player:GossipComplete()
end

if(intid == 486) then
player:Teleport(553, 153.5272, 391.7262, -27.2532)
player:GossipComplete()
end

if(intid == 487) then
player:Teleport(554, -26.3356, 0.1234, -1.8124)
player:GossipComplete()
end

if(intid == 488) then
player:Teleport(530, -248, 956, 85)
player:GossipComplete()
end

if(intid == 489) then
player:Teleport(530, 1587, 8607, -33)
player:GossipComplete()
end

if(intid == 490) then
player:Teleport(530, -526, 8440, 47)
player:GossipComplete()
end

if(intid == 491) then
player:Teleport(530, 1114, 7091, 123)
player:GossipComplete()
end

if(intid == 492) then
player:Teleport(530, 2342, 2642, 27)
player:GossipComplete()
end

if(intid == 493) then
player:Teleport(530, -1177, 5336, 30)
player:GossipComplete()
end

if(intid == 494) then
player:Teleport(530, -2848, 3190, 8)
player:GossipComplete()
end

if(intid == 495) then
player:Teleport(571, 3008.48, 5290.83, 59.7553)
player:GossipComplete()
end

if(intid == 496) then
player:Teleport(571, 5578.79, -37.3206, 150.171)
player:GossipComplete()
end

if(intid == 497) then
player:Teleport(571, 4155.35, 344.484, 64.7376)
player:GossipComplete()
end

if(intid == 498) then
player:Teleport(571, 4037.19, -3771.74, 476.593)
player:GossipComplete()
end

if(intid == 499) then
player:Teleport(571, 1267.69, -4062.03, 143.187)
player:GossipComplete()
end

if(intid == 500) then
player:Teleport(571, 7105.61, 2091.7, 622.529)
player:GossipComplete()
end

if(intid == 501) then
player:Teleport(5545, 4987, -124, 571)
player:GossipComplete()
end

if(intid == 502) then
player:Teleport(571, 7514.56, -1037.38, 466.844)
player:GossipComplete()
end

if(intid == 503) then
player:Teleport(571, 5520.02, -3602.05, 362.706)
player:GossipComplete()
end

if(intid == 504) then
player:Teleport(619, 341.458, -1103.98, 62.0352)
player:GossipComplete()
end

if(intid == 505) then
player:Teleport(571, 3714.09, 2148.78, 52.6704)
player:GossipComplete()
end

if(intid == 506) then
player:Teleport(1, -8295.94, -4500.13, 9.60819)
player:GossipComplete()
end

if(intid == 507) then
player:Teleport()
player:GossipComplete()
end

if(intid == 508) then
player:Teleport(571, 4774.01, -2050.26, 229.978)
player:GossipComplete()
end

if(intid == 509) then
player:Teleport(571, 6898.99, -4585.53, 450.988)
player:GossipComplete()
end

if(intid == 510) then
player:Teleport()
player:GossipComplete()
end

if(intid == 511) then
player:Teleport()
player:GossipComplete()
end

if(intid == 512) then
player:Teleport()
player:GossipComplete()
end

if(intid == 513) then
player:Teleport(571, 3900.38, 6985.55, 69.4885)
player:GossipComplete()
end

if(intid == 514) then
player:Teleport(571, 3881.3, 7004.83, 104.459)
player:GossipComplete()
end

if(intid == 515) then
player:Teleport(571, 5689.76, 498.691, 652.715)
player:GossipComplete()
end

if(intid == 516) then
player:Teleport(571, 9190.16, -1387.28, 1110.22)
player:GossipComplete()
end

if(intid == 517) then
player:Teleport(571, 8921.78, -968.113, 1039.18)
player:GossipComplete()
end

if(intid == 518) then
player:Teleport(574, 155.937, -90.1936, 12.5517)
player:GossipComplete()
end

if(intid == 519) then
player:Teleport(575, 570, -327, 111 )
player:GossipComplete()
end

if(intid == 520) then
player:Teleport()
player:GossipComplete()
end

if(intid == 521) then
player:Teleport()
player:GossipComplete()
end

if(intid == 522) then
player:Teleport(533, 3005.87, -3435.01, 294.882)
player:GossipComplete()
end

if(intid == 523) then
player:Teleport(249, 29.4548, -68.9609, -5.98402)
player:GossipComplete()
end

if(intid == 524) then
player:Teleport(571, 3773.419922, 6939.600098, 106.174004)
player:GossipComplete()
end

if(intid == 525) then
player:Teleport(571, 9012.47, -1110.25, 1165.28)
player:GossipComplete()
end

if(intid == 526) then
player:Teleport(571, 5485.34, 2840.31, 419.966)
player:GossipComplete()
end

if(intid == 527) then
player:Teleport(571, 3454.33, 262.266, -113.289)
player:GossipComplete()
end

if(intid == 528) then
player:Teleport(571, 3516.448486, 268.855072, -114.035500)
player:GossipComplete()
end

if(intid == 529) then
player:Teleport(189, 1687.2983, 1052.7498, 18.6774)
player:GossipComplete()
end

if(intid == 530) then
player:Teleport(189, 254.7799, -208.7762, 18.6774)
player:GossipComplete()
end

if(intid == 531) then
player:Teleport(189, 1608.4215, -323.7315, 18.6729)
player:GossipComplete()
end

if(intid == 532) then
player:Teleport(189, 853.5711, 1321.2988, 18.6717)
player:GossipComplete()
end

if(intid == 533) then
player:Teleport(129, 2591.99, 1101.25, 52.8593)
player:GossipComplete()
end

if(intid == 534) then
player:Teleport(571, 1704.849976, -2550.800049, 0.300627, 2.396580)
player:GossipComplete()
end

if(intid == 535) then
player:Teleport()
player:GossipComplete()
end
end

RegisterUnitGossipEvent(999901, 1, "On_Gossip")
RegisterUnitGossipEvent(999901, 2, "Gossip_Submenus")