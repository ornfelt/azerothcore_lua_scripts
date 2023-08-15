function On_Gossip_Talk(unit, event, player)
unit:GossipCreateMenu(3544, player, 0)
local race=player:GetPlayerRace()
if race==1 or race==3 or race==4 or race==7 or race==11 then
unit:GossipMenuAddItem(6, "|cff0000ffMain Cities", 600, 0)
end
local race=player:GetPlayerRace()
if race==2 or race==5 or race==6 or race==8 or race==10 then
unit:GossipMenuAddItem(4, "|cff0000ffMain Cities", 601, 0)
end
unit:GossipMenuAddItem(1, "|cFF007000 Mall,Level Road & More", 9875,  0)
unit:GossipMenuAddItem(2, "|cFF008080Azeroth Locations", 610, 0)
unit:GossipMenuAddItem(2, "|cFF008080Azeroth Instances", 611, 0)
unit:GossipMenuAddItem(2, "|cFF0000FFOutland Locations", 612, 0)
unit:GossipMenuAddItem(2, "|cFF0000FFOutland Instances", 613, 0)
unit:GossipMenuAddItem(2, "|cffffff00Northrend Locations", 97, 0)
unit:GossipMenuAddItem(2, "|cffffff00Northrend Instances", 777, 0)
unit:GossipMenuAddItem(5, "|cff0000ff Shattrath City", 614, 0)
unit:GossipMenuAddItem(9, "|cFF000000Gurubashi Arena", 45, 0)
unit:GossipMenuAddItem(0, "|cff0000ffBuff me", 99, 0)
unit:GossipMenuAddItem(0, "|cff0000ffRemove Ressurection Sickness", 900, 0)
unit:GossipMenuAddItem(3, "|cff0000ffProfessions", 813, 0)
unit:GossipMenuAddItem(5, "|cff0000ffset my profession skills to 450", 50,0);
unit:GossipSendMenu(player)
end

function On_Gossip_Select (unit, event, player, id, intid, code)

if(intid == 601) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Orgrimmar", 602, 0)
unit:GossipMenuAddItem(2, "|cFF008000Undercity", 603, 0)
unit:GossipMenuAddItem(2, "|cFF008000Thunder Bluff", 604, 0)
unit:GossipMenuAddItem(2, "|cFF008000Silvermoon", 605, 0)
unit:GossipSendMenu(player)
end

if(intid == 600) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Stormwind", 606, 0)
unit:GossipMenuAddItem(2, "|cFF008000Ironforge", 607, 0)
unit:GossipMenuAddItem(2, "|cFF008000Darnassus", 608, 0)
unit:GossipMenuAddItem(2, "|cFF008000Exodar", 609, 0)
unit:GossipSendMenu(player)
end

if(intid == 610) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Eastern Kingdoms", 40, 0)
unit:GossipMenuAddItem(2, "|cFF008000Kalimdor", 41, 0)
unit:GossipSendMenu(player)
end

if(intid == 40) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Alterac Mountains", 208, 0)
unit:GossipMenuAddItem(2, "|cFF008000Badlands", 214, 0)
unit:GossipMenuAddItem(2, "|cFF008000Blasted Lands", 222, 0)
unit:GossipMenuAddItem(2, "|cFF008000Burning Steppes", 216, 0)
unit:GossipMenuAddItem(2, "|cFF008000Deadwind Pass", 221, 0)
unit:GossipMenuAddItem(2, "|cFF008000Dun Morogh", 212, 0)
unit:GossipMenuAddItem(2, "|cFF008000Duskwood", 220, 0)
unit:GossipMenuAddItem(2, "|cFF008000Eastern Plaguelands", 206, 0)
unit:GossipMenuAddItem(2, "|cFF008000Elwynn Forest", 217, 0)
unit:GossipMenuAddItem(2, "|cFF008000Eversong Woods", 201, 0)
unit:GossipMenuAddItem(2, "|cFF008000Ghostlands", 202, 0)
unit:GossipMenuAddItem(0, "-->Second Page-->", 43, 0)
unit:GossipSendMenu(player)
end

if(intid == 41) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Ashenvale", 109, 0)
unit:GossipMenuAddItem(2, "|cFF008000Azuremyst Isle", 103, 0)
unit:GossipMenuAddItem(2, "|cFF008000Bloodmyst Isle", 102, 0)
unit:GossipMenuAddItem(2, "|cFF008000Darkshore", 105, 0)
unit:GossipMenuAddItem(2, "|cFF008000Desolace", 113, 0)
unit:GossipMenuAddItem(2, "|cFF008000Durotar", 111, 0)
unit:GossipMenuAddItem(2, "|cFF008000Dustwallow Marsh", 117, 0)
unit:GossipMenuAddItem(2, "|cFF008000Felwood", 107, 0)
unit:GossipMenuAddItem(2, "|cFF008000Feralas", 116, 0)
unit:GossipMenuAddItem(2, "|cFF008000Moonglade", 106, 0)
unit:GossipMenuAddItem(2, "|cFF008000Mulgore", 115, 0)
unit:GossipMenuAddItem(2, "|cFF008000Silithus", 120, 0)
unit:GossipMenuAddItem(0, "-->Second Page-->", 43, 0)
unit:GossipSendMenu(player)
end

if(intid == 42) then
pUnitGossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Hillsbrad Foothills", 210, 0)
unit:GossipMenuAddItem(2, "|cFF008000Loch Modan", 213, 0)
unit:GossipMenuAddItem(2, "|cFF008000Redridge Mountains", 218, 0)
unit:GossipMenuAddItem(2, "|cFF008000Searing Gorge", 215, 0)
unit:GossipMenuAddItem(2, "|cFF008000Silverpine Forest", 207, 0)
unit:GossipMenuAddItem(2, "|cFF008000Strangethorn Vale", 223, 0)
unit:GossipMenuAddItem(2, "|cFF008000Swamp Of Sorrows", 219, 0)
unit:GossipMenuAddItem(2, "|cFF008000Trisfal Glades", 205, 0)
unit:GossipMenuAddItem(2, "|cFF008000Western Plaguelands", 203, 0)
unit:GossipMenuAddItem(2, "|cFF008000Wetlands", 211, 0)
unit:GossipSendMenu(player)
end

if(intid == 43) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Stonetalon Mountains", 112, 0)
unit:GossipMenuAddItem(2, "|cFF008000Tanaris", 121, 0)
unit:GossipMenuAddItem(2, "|cFF008000Teldrassil", 100, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Barrens", 114, 0)
unit:GossipMenuAddItem(2, "|cFF008000Thousand Needles", 118, 0)
unit:GossipMenuAddItem(2, "|cFF008000Un'Goro Crater", 119, 0)
unit:GossipMenuAddItem(2, "|cFF008000Winterspring", 108, 0)
unit:GossipSendMenu(player)
end

if(intid == 611) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Shadowfang Keep", 615, 0)
unit:GossipMenuAddItem(2, "|cFF008000Zul'Gurub", 616, 0)
unit:GossipMenuAddItem(2, "|cFF008000Scarlet Monastery", 617, 0)
unit:GossipMenuAddItem(2, "|cFF008000Stratholme", 22, 0)
unit:GossipMenuAddItem(2, "|cFF008000Scholomance", 23, 0)
unit:GossipMenuAddItem(2, "|cFF008000Blackrock", 24, 0)
unit:GossipMenuAddItem(2, "|cFF008000Onyxia's Lair", 25, 0)
unit:GossipMenuAddItem(2, "|cFF008000Molten Core", 26, 0)
unit:GossipMenuAddItem(2, "|cFF008000Karazhan", 27, 0)
unit:GossipMenuAddItem(2, "|cFF008000Caverns Of Time", 29, 0)
unit:GossipSendMenu(player)
end

if(intid == 612) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Hellfire", 30, 0)
unit:GossipMenuAddItem(2, "|cFF008000Zangremarsh", 31, 0)
unit:GossipMenuAddItem(2, "|cFF008000Nagrand", 32, 0)
unit:GossipMenuAddItem(2, "|cFF008000Blades Edge", 33, 0)
unit:GossipMenuAddItem(2, "|cFF008000Netherstorm", 34, 0)
unit:GossipMenuAddItem(2, "|cFF008000Terokkar Forest", 35, 0)
unit:GossipMenuAddItem(2, "|cFF008000Shadowmoon Valley", 36, 0)
unit:GossipMenuAddItem(2, "|cFF008000Shattrath", 37, 0)
unit:GossipSendMenu(player)
end

if(intid == 613) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Outland Raids", 41, 0)
unit:GossipMenuAddItem(2, "|cFF008000Hellfire Ramparts", 618, 0)
unit:GossipMenuAddItem(2, "|cFF008000The BloodFurnace", 619, 0)
unit:GossipMenuAddItem(2, "|cFF008000Shattered Halls", 620, 0)
unit:GossipMenuAddItem(2, "|cFF008000Mana-Tombs", 621, 0)
unit:GossipMenuAddItem(2, "|cFF008000Sethekk Halls", 622, 0)
unit:GossipMenuAddItem(2, "|cFF008000Auchenai Crypts", 623, 0)
unit:GossipMenuAddItem(2, "|cFF008000Shadow Labyrinth",624, 0)
unit:GossipMenuAddItem(2, "|cFF008000Caverns of Time", 625, 0)
unit:GossipMenuAddItem(2, "|cFF008000Magisters Terrace", 445, 0)
unit:GossipMenuAddItem(0, "-->Second Page-->", 47, 0)
unit:GossipSendMenu(player)
end

if(intid == 47) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Gruul's Lair", 446, 0)
unit:GossipMenuAddItem(2, "|cFF008000Magtheridon's Lair", 447, 0)
unit:GossipMenuAddItem(2, "|cFF008000Zul'Aman", 448, 0)
unit:GossipMenuAddItem(2, "|cFF008000Serpentshrine Cavern", 449, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Eye", 450, 0)
unit:GossipMenuAddItem(2, "|cFF008000Black Temple", 451, 0)
unit:GossipMenuAddItem(2, "|cFF008000Sunwell Plateau", 452, 0)
unit:GossipSendMenu(player)
end

if(intid == 48) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Mechanar", 627, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Botanica", 628, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Arcatraz", 629, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Steamvault", 630, 0)
unit:GossipMenuAddItem(2, "|cFF008000Slave Pens", 631, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Underbog", 632, 0)
unit:GossipSendMenu(player)
end

if(intid == 9875) then
unit:GossipCreateMenu(50, player, 0)
unit:GossipMenuAddItem(5, "|cff0000ff [Mall]", 6146, 0)
unit:GossipMenuAddItem(2, "|cff0000ff Quest Zone T10", 1002, 0)
unit:GossipMenuAddItem(2, "|cff0000ff Quest Zone S8", 1001, 0)
unit:GossipMenuAddItem(2, "|cFF007000 Custom Instance and Raids", 98755,  0)
unit:GossipMenuAddItem(2, "|cFF007000 Leveling Zone", 1400,  0)
unit:GossipMenuAddItem(2, "|cFF007000 Insane Stair Event", 500,  0)
unit:GossipMenuAddItem(2, "|cFF007000 Hard Stair Event", 11200,  0)
unit:GossipMenuAddItem(2, "|cFF007000 Easy Stair Event", 6000,  0)
unit:GossipMenuAddItem(2, "|cFF007000 SnowBall Arena", 7900,  0)
unit:GossipMenuAddItem(2, "|cFF007000 PVP Area", 8900,  0)
unit:GossipMenuAddItem(2, "|cFF007000 Casino Zone", 99000,  0)
unit:GossipMenuAddItem(2, "|cFF007000 Quiz Zone", 9000,  0)
unit:GossipMenuAddItem(2, "|cFF007000 Village Zone", 71100,  0)
unit:GossipMenuAddItem(2, "|cFF007000 24hour Party", 8232,  0)
Unit:GossipMenuAddItem(2, "|cFF007000 Wedding Church", 604, 0)
unit:GossipSendMenu(player)
end

if(intid == 98755) then
unit:GossipCreateMenu(50, player, 0)
unit:GossipMenuAddItem(2, "|cFF007000 Worgen Instance", 700,  0)
unit:GossipMenuAddItem(2, "|cFF007000 FireStrom Instance", 90000,  0)
unit:GossipMenuAddItem(2, "|cFF007000 Epic Raid With Movie [10-20 Man]", 177700,  0)
unit:GossipMenuAddItem(2, "|cFF007000 Giants Raid[5-10]", 1700,  0)
unit:GossipSendMenu(player)
end


if(intid == 614) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Terrace of Light", 38, 0)
unit:GossipSendMenu(player)
end

if(intid == 97) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Borean Tundra", 501, 0)
unit:GossipMenuAddItem(2, "|cFF008000Crystalsong Forest", 502, 0)
unit:GossipMenuAddItem(2, "|cFF008000Dalaran (City)", 503, 0)
unit:GossipMenuAddItem(2, "|cFF008000Dragonblight", 504, 0)
unit:GossipMenuAddItem(2, "|cFF008000Grizzly Hills", 505, 0)
unit:GossipMenuAddItem(2, "|cFF008000Howling Fjord", 506, 0)
unit:GossipMenuAddItem(2, "|cFF008000Icecrown", 507, 0)
unit:GossipMenuAddItem(2, "|cFF008000Sholazar Basin", 508, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Storm Peaks", 509, 0)
unit:GossipMenuAddItem(2, "|cFF008000Zul'Dark", 510, 0)
unit:GossipMenuAddItem(2, "|cFF008000DK Start Zone", 511, 0)
unit:GossipMenuAddItem(2, "|cFF008000Angrathar the Wrathgate", 802, 0)
unit:GossipSendMenu(player)
end

if(intid == 777) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Utgarde Keep", 779, 0)
unit:GossipMenuAddItem(2, "|cFF008000Utgard Pinnacle", 778, 0)
unit:GossipMenuAddItem(2, "|cFF008000Draktharon Keep", 780, 0)
unit:GossipMenuAddItem(2, "|cFF008000Halls of Stone", 781, 0)
unit:GossipMenuAddItem(2, "|cFF008000Halls of Lighting", 782, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Nexus", 785, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Oculus", 786, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Old Kingdom", 787, 0)
unit:GossipMenuAddItem(2, "|cFF008000Azjol-nerub", 788, 0)
unit:GossipMenuAddItem(2, "|cFF800080Northrend Raids--->", 888, 0)
unit:GossipSendMenu(player)
end

if(intid == 888) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "|cFF008000Naxxramas", 783, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Eye of Eternity", 784, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Siege of Ulduar", 800, 0)
unit:GossipMenuAddItem(2, "|cFF008000The Antechamber of Ulduar", 801, 0)
unit:GossipSendMenu(player)
end

if (intid == 5) then
unit:GossipMenuAddItem(3, "Professions", 813, 0)
unit:GossipMenuAddItem(5, "set my profession skills to 450", 50,0);
unit:GossipSendMenu(player)
end

if(intid == 813) then
unit:GossipCreateMenu(50, player, 0)
unit:GossipMenuAddItem(0, "|cff0000ffAlchemy", 400, 0)
unit:GossipMenuAddItem(0, "|cff0000ffBlacksmithing", 401, 0)
unit:GossipMenuAddItem(0, "|cff0000ffEnchanting", 402, 0)
unit:GossipMenuAddItem(0, "|cff0000ffEngineering", 403, 0)
unit:GossipMenuAddItem(0, "|cff0000ffHerbalism", 404, 0)
unit:GossipMenuAddItem(0, "|cff0000ffInscription", 405, 0)
unit:GossipMenuAddItem(0, "|cff0000ffJewelcrafting", 406, 0)
unit:GossipMenuAddItem(0, "|cff0000ffLeatherworking", 407, 0)
unit:GossipMenuAddItem(0, "|cff0000ffMining", 408, 0)
unit:GossipMenuAddItem(0, "|cff0000ffSkinning", 409, 0)
unit:GossipMenuAddItem(0, "|cff0000ffCooking", 410, 0)
unit:GossipMenuAddItem(0, "|cff0000ffFirst Aid", 411, 0)
unit:GossipMenuAddItem(0, "|cff0000ffFishing", 412, 0)
unit:GossipMenuAddItem(0, "|cff0000ffTailoring", 413, 0)
unit:GossipSendMenu(player)
end

if(intid == 99) then
unit:GossipCreateMenu(3543, player, 0)
unit:FullCastSpellOnTarget(48100, player)
unit:FullCastSpellOnTarget(48102, player)
unit:FullCastSpellOnTarget(48104, player)
unit:FullCastSpellOnTarget(58449, player)
unit:FullCastSpellOnTarget(58451, player)
unit:FullCastSpellOnTarget(58452, player)
unit:GossipSendMenu(player)
end

if(intid == 98) then
unit:GossipCreateMenu(3543, player, 0)
unit:FullCastSpellOnTarget(26565, player)
unit:GossipSendMenu(player)
end

if(intid == 900) then
unit:GossipCreateMenu(62, player, 0)
player:LearnSpell(15007)
player:UnlearnSpell(15007)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 400) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Alchemy", 415, 0)
unit:GossipMenuAddItem(3, "Grand Master Alchemy", 416, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 401) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Blacksmithing", 417, 0)
unit:GossipMenuAddItem(3, "Grand Master Blacksmithing", 418, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 402) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "UnlearnGrand Master Enchanting", 419, 0)
unit:GossipMenuAddItem(3, "Grand Master Enchanting", 420, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 403) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Engineering", 421, 0)
unit:GossipMenuAddItem(3, "Grand Master Engineering", 422, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 404) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Herbalism", 423, 0)
unit:GossipMenuAddItem(3, "Grand Master Herbalism", 424, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 405) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Inscription", 425, 0)
unit:GossipMenuAddItem(3, "Grand Master Inscription", 426, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 406) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Jewelcrafting", 427, 0)
unit:GossipMenuAddItem(3, "Grand Master Jewelcrafting", 428, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 407) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Leatherworking", 429, 0)
unit:GossipMenuAddItem(3, "Grand Master Leatherworking", 430, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 408) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Mining", 431, 0)
unit:GossipMenuAddItem(3, "Grand Master Mining", 432, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 409) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Skinning", 433, 0)
unit:GossipMenuAddItem(3, "Grand Master Skinning", 434, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 410) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Cooking", 435, 0)
unit:GossipMenuAddItem(3, "Grand Master Cooking", 436, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 411) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master First Aid", 437, 0)
unit:GossipMenuAddItem(3, "Grand Master First Aid", 438, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end

if(intid == 412) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Fishing", 439, 0)
unit:GossipMenuAddItem(3, "Grand Master Fishing", 440, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end
if(intid == 413) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Tailor", 441, 0)
unit:GossipMenuAddItem(3, "Grand Master Tailor", 442, 0)
unit:GossipMenuAddItem(0, "[Back]", 813, 0)
unit:GossipSendMenu(player)
end
if(intid == 889) then 
player:Teleport(1, 4613.19, -3861.61, 944.178)
end

if(intid == 602) then
player:Teleport(1, 1484, -4417, 25)
end

if(intid == 603) then
player:Teleport(0, 1831, 238, 60)
end

if(intid == 604) then
player:Teleport(1, -1277, 118, 131)
end

if(intid == 200) then
player:Teleport(0, -9276.238281, -2288.817627, 67.916161)
end

if(intid == 300) then
player:Teleport(530, -920.231323, 7096.489258, 170.352890)
end

if(intid == 1400) then
player:Teleport(1, 4620.737793, -3844.409668, 943.844666)
end

if(intid == 500) then
player:Teleport(1, 1363.667603, -4310.065430, 107.948868)
end

if(intid == 5500) then
player:Teleport(1, -10422.131836, 2302.332320, 143.118851)
end

if(intid == 6000) then
player:Teleport(530, 9321.222656, -8205.225586, 2.797099)
end

if(intid == 700) then
player:Teleport(0, -8647.316406, 598.606995, 94.833893)
end

if(intid == 8900) then
player:Teleport(169, 1855.248657, -2319.349121, -20.998129)
end

if(intid == 7900) then
player:Teleport(0, -6342.469727, -47.131123, 392.653259)
end

if(intid == 8232) then
player:Teleport(0, 4244.6, -2731.4, 6.1)
end

if(intid == 7000) then
player:Teleport(1, -8840.733398, -1547.908569, 8.876630)
end

if(intid == 8000) then
player:Teleport(0, -8646.179688, 596.569641, 95.702301)
end

if(intid == 9000) then
player:Teleport(1, 16228.524414, 16403.5800782, -64.379349)
end

if(intid == 99000) then
player:Teleport(0, -8526.582031, 593.800964, 101.399002)
end

if(intid == 90000) then
player:Teleport(0, -4842.982422, -1065.681885, 501.573639)
end

if(intid == 605) then
player:Teleport(530, 9413, -7277, 14)
end

if(intid == 606) then
player:Teleport(0, -8913.23, 554.633, 94.7944)
end

if(intid == 607) then
player:Teleport(0, -4981.25, -881.542, 502.66)
end

if(intid == 608) then
player:Teleport(1, 9948, 2413, 1327)
end

if(intid == 609) then
player:Teleport(530, -4014.080078, -11895.799805, -1.990842)
end

if(intid == 615) then
player:Teleport(0, -234.495087, 1561.946411, 76.892143)
end

if(intid == 616) then
player:Teleport(0, -11919.073242, -1202.459374, 92.298744)
end

if(intid == 6146) then
player:Teleport(1, -8621.922852, 1976.028198, 100.720665)
end

if(intid == 617) then
player:Teleport(0, 2870.442627, -819.985229, 160.331085)
end

if(intid == 22) then
player:Teleport(0, 3359.111572, -3380.8444238, 144.781860)
end

if(intid == 23) then
player:Teleport(0, 1267.468628, -2556.651367, 94.127983)
end

if(intid == 24) then
player:Teleport(0, -7527.129883, -1224.997437, 285.733002)
end

if(intid == 25) then
player:Teleport(1, -4708.491699, -3727.672363, 54.535076)
end

if(intid == 26) then
player:Teleport(0, -7515.409668, -1045.369629, 182.301208)
end

if(intid == 27) then
player:Teleport(0, -11122.913086, -2014.498779, 47.079350)
end

if(intid == 28) then
player:Teleport(0, 3132.915283, -3731.012939, 138.658371)
end

if(intid == 29) then
player:Teleport(1, -8519.718750, -4297.542480, -208.441376)
end

if(intid == 30) then
player:Teleport(530, -247.9672, 948.5709, 84.3798)
end

if(intid == 31) then
player:Teleport(530, -1045.0179, 5380.0288, 22.1216)
end

if (intid == 32) then
player:Teleport(530, -468, 8418, 28)
end

if(intid == 33) then
player:Teleport(530, 1552.2236, 6813.3798, 125.1364)
end

if(intid == 34) then
player:Teleport(530, 3396, 4185, 137)
end

if(intid == 35) then
player:Teleport(530, -2276.82, 5132.03, -8.62994)
end

if(intid == 36) then
player:Teleport(530, -3004.3488, 2968.4343, 81.8821)
end

if(intid == 37) then
player:Teleport(530, -1849.4200, 5401.4599, -12.4279)
end

if(intid == 38) then
player:Teleport(530, -1849.4200, 5401.4599, -12.4279)
end

if(intid == 45) then
player:Teleport(0, -13243.240234, 197.949799, 32.112690)
end

if(intid == 46) then
player:Teleport(530, 12956.072266, -6943.814453, 9.968110)
end

if(intid == 100) then
player:Teleport(1, 9874.646484, 595.742432, 1303.874023)
end

if(intid == 102) then
player:Teleport(530, -2721.68, -12208.9, 10.0882)
end

if(intid == 11100) then
player:Teleport(0, -13392.915039, -876.992798, 4.036050)
end

if(intid == 10011) then
player:Teleport(1, -8621.922852, 1976.028198, 100.720665)
end

if(intid == 103) then
player:Teleport(530, -4020.48, -13783.3, 74.9001)
end

if(intid == 105) then
player:Teleport(1, 6207.5, -152.833, 80.8185)
end

if(intid == 106) then
player:Teleport(1, 7101.68, -2670.2, 512.2)
end

if(intid == 107) then
player:Teleport(1, 5483.9, -749.881, 335.621)
end

if(intid == 108) then
player:Teleport(1, 6107.62, -4181.6, 853.322)
end

if(intid == 109) then
player:Teleport(1, 2717.1, 5967.91, 107.4)
end

if(intid == 111) then
player:Teleport(1, 341.42, -4684.7, 31.9493)
end

if(intid == 112) then
player:Teleport(1, 1145.85, 664.812, 143)
end

if(intid == 113) then
player:Teleport(1, -93.1614, 1691.15, 90.0649)
end

if(intid == 114) then
player:Teleport(1, -90.19003, -1943.44, -180.4727)
end

if(intid == 115) then
player:Teleport(1, -1840.75, 5359, -7.845)
end

if(intid == 116) then
player:Teleport(1, -4458.93, 243.415, -65.6136)
end

if(intid == 71100) then
player:Teleport(0, -8186.021973, -303.717865, 238.314270)
end

if(intid == 117) then
player:Teleport(1, -3463.26, -4123.13, 18.1043)
end

if(intid == 118) then
player:Teleport(1, -4932.53, -1596.05, 85.8157)
end

if(intid == 119) then
player:Teleport(1, -7932.61, -2139.61, -229.728)
end

if(intid == 120) then
player:Teleport(1, -7373.69, -2950.2, -11.7598)
end

if(intid == 121) then
player:Teleport(1, -7167.86, -3807.46, 11.7068)
end

if(intid == 201) then
player:Teleport(530, 9449.15, -6782.61, 16.6167)
end

if(intid == 202) then
player:Teleport(530, 7880, -6193, 22)
end

if(intid == 203) then
player:Teleport(0, 1224.36, -1151.97, 61.7327)
end

if(intid == 205) then
player:Teleport(0, 2019.35, 1904.36, 106.144)
end

if(intid == 206) then
player:Teleport(0, 1919.44, -4306.23, 77.838)
end

if(intid == 207) then
player:Teleport(0, 511.536, 1638.63, 121.417)
end

if(intid == 208) then
player:Teleport(0, 272.704, -654.514, 129.609)
end

if(intid == 209) then
player:Teleport(0, 139.375, -1982.79, 134.043)
end

if(intid == 210) then
player:Teleport(0, -852.854, -576.712, 21.0293)
end

if(intid == 211) then
player:Teleport(0, -4086.36, -2610.95, 47.0143)
end

if(intid == 212) then
player:Teleport(0, -5425.924316, -224.271957, 404.984344)
end

if(intid == 213) then
player:Teleport(0, -4939.1, -3423.74, 306.595)
end

if(intid == 214) then
player:Teleport(0, -6018.138184, -3311.517822, 261.744324)
end

if(intid == 215) then
player:Teleport(0, -7176.63, -937.667, 171.206)
end

if(intid == 216) then
player:Teleport(0, -7907.41, -1128.66, 192.056)
end

if(intid == 217) then
player:Teleport(0, -9621.383789, -371.068207, 57.471478)
end

if(intid == 218) then
player:Teleport(0, -9219.37, -2149.94, 71.606)
end

if(intid == 219) then
player:Teleport(0, -10264.6, -3059.9, 19.9356)
end

if(intid == 220) then
player:Teleport(0, -11224.254883, -378.471802, 52.764240)
end

if(intid == 221) then
player:Teleport(0, -10435.4, -1809.28, 101)
end

if(intid == 222) then
player:Teleport(0, -11204.5, -2730.61, 15.8972)
end

if(intid == 223) then
player:Teleport(0, -11634.8, -54.0697, 14.4439)
end

if(intid == 618) then
player:Teleport(530, -360.671, 3071.9, -15.0977)
end

if(intid == 619) then
player:Teleport(542, -3.9967, 14.6363, -44.8009)
end

if(intid == 631) then
player:Teleport(530, 721.926, 7012.24, -73.065)
end

if(intid == 632) then
player:Teleport(530, 779.802, 6769.33, -71.4282)
end

if(intid == 621) then
player:Teleport(530, -3101.47, 4947.11, -101.177)
end

if(intid == 623) then
player:Teleport(530, -3357.32, 5216.77, -101.049)
end

if(intid == 625) then
player:Teleport(1, -8195.94, -4500.13, 9.60819)
end

if(intid == 622) then
player:Teleport(530, -3360.13, 4667.85, -101.047)
end

if(intid == 630) then
player:Teleport(0, -11634.8, -54.0697, 14.4439)
end

if(intid == 624) then
player:Teleport(530, -3635.76, 4931.82, -100.034)
end

if(intid == 620) then
player:Teleport(530, -309.83, 3080.08, -3.63538)
end

if(intid == 627) then
player:Teleport(530, 2885.2, 1564.73, 248.874)
end

if(intid == 628) then
player:Teleport(530, 3405.48, 1489.14, 183.838)
end

if(intid == 629) then
player:Teleport(530, 2872, 1555.29, 253.159)
end

if(intid == 445) then
player:Teleport(585, 2.19347, -0.123698, -2.8025)
end

if(intid == 446) then
player:Teleport(530, 3606.85, 5260.49, 4.1724)
end

if(intid == 447) then
player:Teleport(530, -319.635, 3102.03, -113.937)
end

if(intid == 448) then
player:Teleport(530, 6850, -7950, 170)
end

if(intid == 1002) then
player:Teleport(169, 1832.160156, -3088.207275, -20.999229)
end

if(intid == 449) then
player:Teleport(530, 742.883, 6867.19, -68.8289)
end

if(intid == 450) then
player:Teleport(530, 3087.22, 1380.7, 184.883)
end

if(intid == 11200) then
player:Teleport(1, -10736.500977, 2460.961182, 6.909386, 4.407654)
end

if(intid == 451) then
player:Teleport(530, -3604.74, 328.252, 38.3077)
end

if(intid == 452) then
player:Teleport(580, 1791.17, 926.31, 15.1135)
end

if(intid == 501) then
player:Teleport(571, 2087.0109, 6508.6171, 1.4727)
end

if(intid == 502) then
player:Teleport(571, 5434.8281, -1022.4812, 175.0125)
end

if(intid == 503) then
player:Teleport(571, 5811.4067, 647.7883, 647.4152)
end

if(intid == 504) then
player:Teleport(571, 3511.6850, 2841.8454, 36.7473)
end

if(intid == 505) then
player:Teleport(571, 3346.2551, -4486.8173, 259.2319)
end

if(intid == 506) then
player:Teleport(571, 2195.3654, -4526.7729, 216.7943)
end

if(intid == 507) then
player:Teleport(571, 6729.2387, 2510.4931, 427.7868)
end

if(intid == 508) then
player:Teleport(570, 4913.3090, 5536.0737, -76.4190)
end

if(intid == 509) then
player:Teleport(571, 6196.4174, -776.7462, 402.3688)
end

if(intid == 510) then
player:Teleport(571, 5443.4326, -1259.7487, 248.7494)
end

if(intid == 511) then
player:Teleport(609, 2355.7048, -5662.7075, 426.0274)
end

if(intid == 1700) then
player:Teleport(36, -1646.924683, 470.985229, 3.739470)
end

if(intid == 177700) then
player:Teleport(0, -11139.400391, -1717.920044, -29.737038)
end

if(intid == 521) then
player:Teleport(574, 149, -88, 13)
end

if(intid == 522) then
player:Teleport(575, 570, -327, 111)
end

if(intid == 523) then
player:Teleport(576, 146, -10, -16)
end

if(intid == 524) then
player:Teleport(578, 1129, 1052, 70)
end

if(intid == 525) then
player:Teleport(599, 1153, 811, 196)
end

if(intid == 526) then
player:Teleport(602, 1333, -237, 41)
end

if(intid == 527) then
player:Teleport(603, 1739, 310, 119)
end

if(intid == 528) then
player:Teleport(600, -518, -488, 11)
end

if(intid == 529) then
player:Teleport(604, 2031, 805, 246)
end

if(intid == 530) then
player:Teleport(1, -8638, -4382, -207)
end

if(intid == 531) then
player:Teleport(595, 1967, 1287, 146)
end

if(intid == 532) then
player:Teleport(595, 2300, 1495, 129)
end

if(intid == 533) then
player:Teleport(595, 2258.3, 1153.6, 139)
end

if(intid == 534) then
player:Teleport(595, 1560.4, 603.3, 100)
end

if(intid == 535) then
player:Teleport(595, 1654.3, 1611.9, 117)
end

if(intid == 536) then
player:Teleport(607, 1605, 32, 23)
end

if(intid == 778) then 
player:Teleport(571, 1248.92, -4853.94, 219.231)
end

if(intid == 779) then 
player:Teleport(571, 1215.37, -4866.46, 47.8483)
end

if(intid == 780) then
player:Teleport(571, 4775.11, -2035.08, 229.387)
end

if(intid == 781) then
player:Teleport(571, 9174.49, -1377.79, 1102.41)
end

if(intid == 782) then
player:Teleport(571, 8923.74, -986.607, 1039.35)
end

if(intid == 783) then
player:Teleport(571, 3674, -1270, 244)
end

if(intid == 784) then
player:Teleport(571, 3879.34, 6979.7, 152.042)
end

if(intid == 785) then
player:Teleport(571, 3881.67, 6984.54, 73.7606)
end

if(intid == 786) then
player:Teleport(571, 3879.99, 6984.38, 106.321)
end

if(intid == 787) then
player:Teleport(571, 3717.18, 2154.97, 36.4342)
end

if(intid == 788) then
player:Teleport(571, 3717.18, 2154.97, 36.4342)
end

if(intid == 800) then
player:Teleport(603, -863.575, -149.027, 458.885)
end

if(intid == 801) then
player:Teleport(603, 1497.971, -24.3288, 420.966)
end

if(intid == 802) then
player:Teleport(571, 4687.669922, 1245.670044, 142.494995)
end

if(intid == 60111) then
player:Teleport(0, -9275.851563, -2288.102051, 67.950417) --NoN PvP mall

end
if(intid == 602) then
player:Teleport(0, -5133.77, -1710.88, 497.83) --Ice thing

end
if(intid == 603) then
player:Teleport(0, -8190.44, -297.20, 237.89) --

end
if(intid == 604) then
player:Teleport(0, 1596.04, -5566.19, 111.17) --
end 

if(intid == 1001) then
player:Teleport(169, 2787, -3639, 92)
end
if(intid == 415) then
player:UnlearnSpell(51303)
end
if(intid == 416) then
player:LearnSpell(51303)
end
if(intid == 417) then
player:UnlearnSpell(51298)
end
if(intid == 418) then
player:LearnSpell(51298)
end
if(intid == 419) then
player:UnlearnSpell(51312)
end
if(intid == 420) then
player:LearnSpell(51312)
end
if(intid == 421) then
player:UnlearnSpell(51305)
end
if(intid == 422) then
player:LearnSpell(51305)
end
if(intid == 423) then
player:UnlearnSpell(50301)
end
if(intid == 424) then
player:LearnSpell(50301)
end
if(intid == 425) then
player:UnlearnSpell(45380)
end
if(intid == 426) then
player:LearnSpell(45380)
end
if(intid == 427) then
player:UnlearnSpell(51310)
end
if(intid == 428) then
player:LearnSpell(51310)
end
if(intid == 429) then
player:UnlearnSpell(51301)
end
if(intid == 430) then
player:LearnSpell(51301)
end
if(intid == 431) then
player:UnlearnSpell(50309)
end
if(intid == 432) then
player:LearnSpell(50309)
end
if(intid == 433) then
player:UnlearnSpell(50307)
end
if(intid == 434) then
player:LearnSpell(50307)
end
if(intid == 435) then
player:UnlearnSpell(51295)
end
if(intid == 436) then
player:LearnSpell(51295)
end
if(intid == 437) then
player:UnlearnSpell(50299)
end
if(intid == 438) then
player:LearnSpell(50299)
end
if(intid == 439) then
player:UnlearnSpell(51293)
end
if(intid == 440) then
player:LearnSpell(51293)
end

if(intid == 441) then
player:UnlearnSpell(51308)
end
if(intid == 442) then
player:LearnSpell(51308)
end

if (intid == 50) then
player:AdvanceSkill(333, 450);
player:AdvanceSkill(197, 450);
player:AdvanceSkill(202, 450);
player:AdvanceSkill(755, 450);
player:AdvanceSkill(171, 450);
player:AdvanceSkill(164, 450);
player:AdvanceSkill(182, 450);
player:AdvanceSkill(165, 450);
player:AdvanceSkill(186, 450);
player:AdvanceSkill(393, 450);
player:AdvanceSkill(185, 450);
player:AdvanceSkill(129, 450);
player:AdvanceSkill(356, 450);
player:AdvanceSkill(773, 450);
player:AdvanceSkill(633, 1000);
unit:GossipComplete(player)
unit:SendChatMessage(12,0,"All Skills At Max")
unit:GossipMenuAddItem(0, "[Back]", 5, 0)
end

end

RegisterUnitGossipEvent(400035, 1, "On_Gossip_Talk")
RegisterUnitGossipEvent(400035, 2, "On_Gossip_Select")