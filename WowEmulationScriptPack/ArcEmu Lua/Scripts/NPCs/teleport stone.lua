--
-- 
--
-- Silver Blood

local itemid =6948 
function Tele_Book(item, event, player)
	if (player:IsInCombat() == true) then
		player:SendAreaTriggerMessage("You are in combat!")
	else
		Tele_Menu(item, player)
	end
end

function Tele_Menu(item, player) -- Home Page
item:GossipCreateMenu(5667, player, 0)
item:GossipMenuAddItem(5, "|cffff6060TELEPORT STONE.|r", 998, 0)
item:GossipMenuAddItem(6, "|cFF191970Main Cities|r", 1, 0)
item:GossipMenuAddItem(2, "|cFF191970Azeroth Locations|r", 2, 0)
item:GossipMenuAddItem(2, "|cFF191970Azeroth Instances|r", 3, 0)
item:GossipMenuAddItem(2, "|cFF191970Azeroth Raids|r", 4, 0)
item:GossipMenuAddItem(2, "|cFF191970Outland Locations|r", 5, 0)
item:GossipMenuAddItem(2, "|cFF191970Outland Instances|r", 6, 0)
item:GossipMenuAddItem(2, "|cFF191970Outland Raids|r", 7, 0)
item:GossipMenuAddItem(2, "|cFF191970Northrend Locations|r", 8, 0)
item:GossipMenuAddItem(2, "|cFF191970Northrend Instances|r", 9, 0)
item:GossipMenuAddItem(2, "|cFF191970Northrend Raids|r", 10, 0)
item:GossipMenuAddItem(9, "|cFF191970Gurubashi Arena|r", 13, 0)
item:GossipMenuAddItem(0, "|cFF191970Next Page|r", 997, 0)
item:GossipSendMenu(player)
end

function Tele_Select(item, event, player, id, intid, code)
local plyr = player:GetPlayerRace()
local x, y, z, o = player:GetX(), player:GetY(), player:GetZ(), player:GetO()

if (intid == 997) then -- Home Page Cont.
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(5, "|cFF191970Shattrath City|r", 11, 0)
	item:GossipMenuAddItem(0, "|cFF191970Remove Ressurection Sickness", 16, 0)
	item:GossipMenuAddItem(3, "|cFF191970Professions|r", 17, 0)
	item:GossipMenuAddItem(5, "|cFF191970Set my profession skills to 450", 18, 0)
	item:GossipMenuAddItem(0, "|cFF191970Home Page", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 1) then -- Alliance Cities
	if (plyr == 1) or (plyr == 3) or (plyr == 4) or (plyr == 7) or (plyr == 11) then
		item:GossipCreateMenu(5668, player, 0)
		item:GossipMenuAddItem(2, "|c00FF0000Stormwind|r", 19, 0)
		item:GossipMenuAddItem(2, "|c00FF0000Ironforge|r", 20, 0)
		item:GossipMenuAddItem(2, "|c00FF0000Darnassus|r", 21, 0)
		item:GossipMenuAddItem(2, "|c00FF0000Exodar|r", 22, 0)
		item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
		item:GossipSendMenu(player)
	end
				-- Horde Cities
	if (plyr == 2) or (plyr == 5) or (plyr == 6) or (plyr == 8) or (plyr == 10) then
		item:GossipCreateMenu(5668, player, 0)
		item:GossipMenuAddItem(2, "|c00FF0000Orgimmar|r", 23, 0)
		item:GossipMenuAddItem(2, "|c00FF0000Thunderbluff|r", 24, 0)
		item:GossipMenuAddItem(2, "|c00FF0000Undercity|r", 25, 0)
		item:GossipMenuAddItem(2, "|c00FF0000Silvermoon|r", 26, 0)
		item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
		item:GossipSendMenu(player)
	end
end

if (intid == 2) then -- Azeroth Continets
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Eastern Kingdoms|r", 27, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Kalimdor|r", 28, 0)
	item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 3) then -- Azeroth Instances

	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Blackfathom Deeps|r", 29, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Blackrock Depths|r", 30, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Dire Maul|r", 31, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Gnomeregan|r", 32, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Maraudon|r", 33, 0)
	if (plyr == 2) or (plyr == 5) or (plyr == 6) or (plyr == 8) or (plyr == 10) then
		item:GossipMenuAddItem(2, "|c00FF0000Ragefire Chasm|r", 34, 0)
	end
	item:GossipMenuAddItem(2, "|c00FF0000Razorfen Downs|r", 35, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Razorfen Kraul|r", 36, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Scarlet Monastery|r", 37, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Scholomance|r", 38, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Shadowfang Keep|r", 39, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Stratholme|r", 40, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Sunken Temple|r", 41, 0)
	item:GossipMenuAddItem(2, "|c00FF0000The Deadmines|r", 42, 0)
	if (plyr == 1) or (plyr == 3) or (plyr == 4) or (plyr == 7) or (plyr == 11) then
		item:GossipMenuAddItem(2, "|c00FF0000The Stockade|r", 43, 0)
	end
	item:GossipMenuAddItem(0, "|c99006600Next Page|r", 994, 0)
	item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 994) then -- Azeroth Instances Cont.
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Uldaman|r", 44, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Wailing Caverns|r", 45, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Zul'Farrak|r", 46, 0)
	item:GossipMenuAddItem(0, "|c99006600Previous Page|r", 3, 0)
	item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 4) then -- Azeroth Raids
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Blackwing Lair|r", 47, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Molten Core|r", 48, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Onyxia's Lair|r", 49, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Ruins of Ahn'Qiraj|r", 50, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Temple of Ahn'Qiraj|r", 51, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Zul'Gurub", 52, 0)
	item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 5) then -- Outland Locations
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Blade's Edge Mountains|r", 53, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Hellfire Peninsula|r", 54, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Nagrand|r", 55, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Netherstorm|r", 56, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Shadowmoon Valley|r", 57, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Terokkar Forest|r", 58, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Zangarmarsh|r", 59, 0)
	item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 6) then -- Outland Instances
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Auchindoun|r", 60, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Caverns of Time|r", 61, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Coilfang Reservoir|r", 62, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Hellfire Citadel|r", 63, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Magisters' Terrace|r", 64, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Tempest Keep|r", 65, 0)
	item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 7) then -- Outland Raids
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Black Temple|r", 66, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Hyjal Summit|r", 67, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Serpentshrine Cavern|r", 68, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Gruul's Lair|r", 69, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Magtheridon's Lair|r", 70, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Karazhan|r", 71, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Sunwell Plateau|r", 72, 0)
	item:GossipMenuAddItem(2, "|c00FF0000The Eye|r", 73, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Zul'Aman|r", 74, 0)
	item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 8) then -- Northrend Locations
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Borean Tundra|r", 75, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Crystalsong Forest|r", 76, 0)
	item:GossipMenuAddItem(2, "|c00FF0000DragonBlight|r", 77, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Grizzly Hills|r", 78, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Howling Fjord|r", 79, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Icecrown|r", 80, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Sholazar Basin|r", 81, 0)
	item:GossipMenuAddItem(2, "|c00FF0000The Storm Peaks|r", 82, 0)
	item:GossipMenuAddItem(2, "|c00FF0000WinterGrasp|r", 83, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Zul'Drak|r", 84, 0)
	item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 9) then -- Northrend Instances
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Azjol-Nerub|r", 85, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Drak'Tharon Keep|r", 86, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Gundrak|r", 87, 0)
	item:GossipMenuAddItem(2, "|c00FF0000The Culling of Stratholme|r", 88, 0)
	item:GossipMenuAddItem(2, "|c00FF0000The Halls of Lightning|r", 89, 0)
	item:GossipMenuAddItem(2, "|c00FF0000The Halls of Stone|r", 90, 0)
	item:GossipMenuAddItem(2, "|c00FF0000The Nexus|r", 91, 0)
	item:GossipMenuAddItem(2, "|c00FF0000The Violet Hold|r", 92, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Utgarde Keep|r", 93, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Utgarde Pinnacle|r", 94, 0)
	item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 10) then -- Northrend Raids
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Naxxramas|r", 95, 0)
	item:GossipMenuAddItem(2, "|c00FF0000The Eye of Eternity|r", 96, 0)
	item:GossipMenuAddItem(2, "|c00FF0000The Obsidian Sanctum|r", 97, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Ulduar|r", 98, 0)
	item:GossipMenuAddItem(2, "|c00FF0000Vault of Archavon|r", 99, 0)
	item:GossipMenuAddItem(0, "|c99006600Home Page|r", 999, 0)
	item:GossipSendMenu(player)
end


-- Shattrath

if (intid == 11) then
	player:Teleport(530, -1817.82, 5453.04, -12.42)
	player:GossipComplete()
end


-- Murloc Mall

if (intid == 12) then
	player:Teleport(0, -9276.238281, -2288.817627, 67.916161)
	player:GossipComplete()
end


-- Gurubashi Arena

if (intid == 13) then
	player:Teleport(0, -13261.30, 164.45, 35.78)
	player:GossipComplete()
end


-- Buff

if (intid == 14) then
	player:SpawnCreature(90001, x, y, z, o, 35, 30000)
	player:GossipComplete()
end


-- Heal

if (intid == 15) then
	player:SetHealthPct(100)
	player:SendBroadcastMessage("You have been healed.")
	player:GossipComplete()
end


-- Remove Ressurection Sickness

if (intid == 16) then
	player:LearnSpell(15007)
	player:UnlearnSpell(15007)
	player:SendBroadcastMessage("Your sickness has been removed.")
	player:GossipComplete()
end


-- Learn Professions

if (intid == 17) then -- Professions
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(5, "Alchemy", 100, 0)
	item:GossipMenuAddItem(5, "Blacksmithing", 101, 0)
	item:GossipMenuAddItem(5, "Enchanting", 102, 0)
	item:GossipMenuAddItem(5, "Engineering", 103, 0)
	item:GossipMenuAddItem(5, "Herbalism", 104, 0)
	item:GossipMenuAddItem(5, "Inscription", 105, 0)
	item:GossipMenuAddItem(5, "Jewelcrafting", 106, 0)
	item:GossipMenuAddItem(5, "Leatherworking", 107, 0)
	item:GossipMenuAddItem(5, "Mining", 108, 0)
	item:GossipMenuAddItem(5, "Skinning", 109, 0)
	item:GossipMenuAddItem(5, "Tailoring", 110, 0)
	item:GossipMenuAddItem(0, "Secondary Professions", 111, 0)
	item:GossipMenuAddItem(0, "Home Page", 999, 0)
	item:GossipSendMenu(player)
end


-- Advance Professions

if (intid == 18) then
	player:AdvanceSkill(171, 450)
	player:AdvanceSkill(164, 450)
	player:AdvanceSkill(333, 450)
	player:AdvanceSkill(202, 450)
	player:AdvanceSkill(182, 450)
	player:AdvanceSkill(773, 450)
	player:AdvanceSkill(755, 450)
	player:AdvanceSkill(165, 450)
	player:AdvanceSkill(186, 450)
	player:AdvanceSkill(393, 450)
	player:AdvanceSkill(197, 450)
	player:AdvanceSkill(185, 450)
	player:AdvanceSkill(129, 450)
	player:AdvanceSkill(356, 450)
	player:GossipComplete()
end


-- Alliance Cities

if (intid == 19) then -- Stormwind
	player:Teleport(0, -8913.23, 554.63, 93.79)
	player:GossipComplete()
end

if (intid == 20) then -- Ironforge
	player:Teleport(0, -4982.16, -880.75, 501.65)
	player:GossipComplete()
end

if (intid == 21) then -- Darnassus
	player:Teleport(1, 9945.49, 2609.89, 1316.26)
	player:GossipComplete()
end

if (intid == 22) then -- Exodar
	player:Teleport(530, -4002.67, -11875.54, -0.71)
	player:GossipComplete()
end


-- Horde Cities

if (intid == 23) then -- Orgimmar
	player:Teleport(1, 1502.71, -4415.41, 21.77)
	player:GossipComplete()
end

if (intid == 24) then -- Thunderbluff
	player:Teleport(1, -1285.23, 117.86, 129.99)
	player:GossipComplete()
end

if (intid == 25) then -- Undercity
	player:Teleport(0, 1831.26, 238.52, 60.52)
	player:GossipComplete()
end

if (intid == 26) then -- Silvermoon
	player:Teleport(530, 9398.75, -7277.41, 14.21)
	player:GossipComplete()
end


-- Azeroth Locations

if (intid == 27) then -- Eastern Kingdoms
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "Alterac Mountains", 112, 0)
	item:GossipMenuAddItem(2, "Arathi Highlands", 113, 0)
	item:GossipMenuAddItem(2, "Badlands", 114, 0)
	item:GossipMenuAddItem(2, "Blasted Lands", 115, 0)
	item:GossipMenuAddItem(2, "Burning Steppes", 116, 0)
	item:GossipMenuAddItem(2, "Deadwind Pass", 117, 0)
	item:GossipMenuAddItem(2, "Dun Morogh", 118, 0)
	item:GossipMenuAddItem(2, "Duskwood", 119, 0)
	item:GossipMenuAddItem(2, "Eastern Plaguelands", 120, 0)
	item:GossipMenuAddItem(2, "Elwynn Forest", 121, 0)
	item:GossipMenuAddItem(2, "Eversong Woods", 122, 0)
	item:GossipMenuAddItem(2, "Ghostlands", 123, 0)
	item:GossipMenuAddItem(2, "Hillsbrad Foothills", 124, 0)
	item:GossipMenuAddItem(2, "Isle of Quel'Danas", 125, 0)
	item:GossipMenuAddItem(0, "Next Page", 996, 0)
	item:GossipMenuAddItem(0, "Home Page", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 996) then -- Eastern Kingdoms Cont.
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "Loch Modan", 126, 0)
	item:GossipMenuAddItem(2, "Redridge Mountains", 127, 0)
	item:GossipMenuAddItem(2, "Searing Gorge", 128, 0)
	item:GossipMenuAddItem(2, "Silverpine Forest", 129, 0)
	item:GossipMenuAddItem(2, "Stranglethorn Vale", 130, 0)
	item:GossipMenuAddItem(2, "Swamp of Sorrows", 131, 0)
	item:GossipMenuAddItem(2, "The Hinterlands", 132, 0)
	item:GossipMenuAddItem(2, "Tirisfal Glades", 133, 0)
	item:GossipMenuAddItem(2, "Western Plaguelands", 134, 0)
	item:GossipMenuAddItem(2, "Westfall", 135, 0)
	item:GossipMenuAddItem(2, "Wetlands", 136, 0)
	item:GossipMenuAddItem(0, "Previous Page", 27, 0)
	item:GossipMenuAddItem(0, "Home Page", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 28) then -- Kalimdor
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "Ashenvale", 137, 0)
	item:GossipMenuAddItem(2, "Azshara", 138, 0)
	item:GossipMenuAddItem(2, "Azuremyst Isle", 139, 0)
	item:GossipMenuAddItem(2, "Bloodmyst Isle", 140, 0)
	item:GossipMenuAddItem(2, "Darkshore", 141, 0)
	item:GossipMenuAddItem(2, "Desolace", 142, 0)
	item:GossipMenuAddItem(2, "Durotar", 143, 0)
	item:GossipMenuAddItem(2, "Dustwallow Marsh", 144, 0)
	item:GossipMenuAddItem(2, "Felwood", 145, 0)
	item:GossipMenuAddItem(2, "Feralas", 146, 0)
	item:GossipMenuAddItem(2, "Moonglade", 147, 0)
	item:GossipMenuAddItem(2, "Mulgore", 148, 0)
	item:GossipMenuAddItem(2, "Silithus", 149, 0)
	item:GossipMenuAddItem(0, "Next Page", 995, 0)
	item:GossipMenuAddItem(0, "Home Page", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 995) then -- Kalimdor Cont.
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(2, "Stonetalon Mountains", 150, 0)
	item:GossipMenuAddItem(2, "Tanaris", 151, 0)
	item:GossipMenuAddItem(2, "Teldrassil", 152, 0)
	item:GossipMenuAddItem(2, "The Barrens", 153, 0)
	item:GossipMenuAddItem(2, "Thousand Needles", 154, 0)
	item:GossipMenuAddItem(2, "Un'Goro Crater", 155, 0)
	item:GossipMenuAddItem(2, "Winterspring", 156, 0)
	item:GossipMenuAddItem(0, "Previous Page", 28, 0)
	item:GossipMenuAddItem(0, "Home Page", 999, 0)
	item:GossipSendMenu(player)
end

if (intid == 29) then -- Blackfathom Deeps
	player:Teleport(1, 4247.34, 744.05, -24.71)
	player:GossipComplete()
end

if (intid == 30) then -- Blackrock Depths
	player:Teleport(0, -7576.74, -1126.68, 262.26)
	player:GossipComplete()
end

if (intid == 31) then -- Dire Maul
	player:Teleport(1, -3879.52, 1095.26, 154.78)
	player:GossipComplete()
end

if (intid == 32) then -- Gnomeregan
	player:Teleport(0, -5162.63, 923.21, 257.17)
	player:GossipComplete()
end

if (intid == 33) then -- Maraudon
	player:Teleport(1, -1412.73, 2816.92, 112.64)
	player:GossipComplete()
end

if (intid == 34) then -- Ragefire Chasm
	player:Teleport(1, 1814.17, -4401.13, -17.67)
	player:GossipComplete()
end

if (intid == 35) then -- Razorfen Downs
	player:Teleport(1, -4378.32, -1949.14, 88.57)
	player:GossipComplete()
end

if (intid == 36) then -- Razorfen Kraul
	player:Teleport(1, -4473.31, -1810.05, 86.11)
	player:GossipComplete()
end

if (intid == 37) then -- Scarlet Monastery
	player:Teleport(0, 2881.84, -816.23, 160.33)
	player:GossipComplete()
end

if (intid == 38) then -- Scholomance
	player:Teleport(0, 1229.45, -2576.66, 90.43)
	player:GossipComplete()
end

if (intid == 39) then -- Shadowfang Keep
	player:Teleport(0, -243.85, 1517.21, 76.23)
	player:GossipComplete()
end

if (intid == 40) then -- Stratholme
	player:Teleport(0, 3362.14, -3380.05, 144.78)
	player:GossipComplete()
end

if (intid == 41) then -- Sunken Temple
	player:Teleport(0, -10452.32, -3817.51, 18.06)
	player:GossipComplete()
end

if (intid == 42) then -- The Deadmines
	player:Teleport(0, -11084.10, 1556.17, 48.12)
	player:GossipComplete()
end

if (intid == 43) then -- The Stockade
	player:Teleport(0, -8797.29, 826.67, 97.63)
	player:GossipComplete()
end

if (intid == 44) then -- Uldaman
	player:Teleport(0, -6072.23, -2955.94, 209.61)
	player:GossipComplete()
end

if (intid == 45) then -- Wailing Caverns
	player:Teleport(1, -735.11, -2214.21, 16.83)
	player:GossipComplete()
end

if (intid == 46) then -- Zul'Farrak
	player:Teleport(1, -6825.69, -2882.77, 8.91)
	player:GossipComplete()
end


-- Azeroth Raids

if (intid == 47) then -- Blackwing Lair
	player:Teleport(469, -7666.11, -1101.53, 399.67)
	player:GossipComplete()
end

if (intid == 48) then -- Molten Core
	player:Teleport(230, 1117.61, -457.36, -102.49)
	player:GossipComplete()
end

if (intid == 49) then -- Onyxia's Lair
	player:Teleport(1, -4697.81, -3720.44, 50.35)
	player:GossipComplete()
end

if (intid == 50) then -- Ruins of Ahn'Qiraj
	player:Teleport(1, -8380.47, 1480.84, 14.35)
	player:GossipComplete()
end

if (intid == 51) then -- Temple of Ahn'Qiraj
	player:Teleport(1, -8258.27, 1962.73, 129.89)
	player:GossipComplete()
end

if (intid == 52) then -- Zul'Gurub
	player:Teleport(0, -11916.74, -1203.32, 92.28)
	player:GossipComplete()
end


-- Outland Locations

if (intid == 53) then -- Blade's Edge Mountains
	player:Teleport(530, 2039.24, 6409.27, 134.30)
	player:GossipComplete()
end

if (intid == 54) then -- Hellfire Peninsula
	player:Teleport(530, -247.37, 964.77, 84.33)
	player:GossipComplete()
end

if (intid == 55) then -- Nagrand
	player:Teleport(530, -605.84, 8442.39, 60.76)
	player:GossipComplete()
end

if (intid == 56) then -- Netherstorm
	player:Teleport(530, 3055.70, 3671.63, 142.44)
	player:GossipComplete()
end

if (intid == 57) then -- Shadowmoon Valley
	player:Teleport(530, -2859.75, 3184.24, 9.76)
	player:GossipComplete()
end

if (intid == 58) then -- Terokkar Forest
	player:Teleport(530, -1917.17, 4879.45, 2.10)
	player:GossipComplete()
end

if (intid == 59) then -- Zangarmarsh
	player:Teleport(530, -206.61, 5512.90, 21.58)
	player:GossipComplete()
end


-- Outland Instances

if (intid == 60) then -- Auchindoun
	player:Teleport(530, -3323.76, 4934.31, -100.21)
	player:GossipComplete()
end

if (intid == 61) then -- Caverns of Time
	player:Teleport(1, -8187.16, -4704.91, 19.33)
	player:GossipComplete()
end

if (intid == 62) then -- Coilfang Reservoir
	player:Teleport(530, 731.04, 6849.35, -66.62)
	player:GossipComplete()
end

if (intid == 63) then -- Hellfire Citadel
	player:Teleport(530, -331.87, 3039.30, -16.66)
	player:GossipComplete()
end

if (intid == 64) then -- Magisters' Terrace
	player:Teleport(530, 12884.92, -7333.78, 65.48)
	player:GossipComplete()
end

if (intid == 65) then -- Tempest Keep
	player:Teleport(530, 3088.25, 1388.17, 185.09)
	player:GossipComplete()
end


-- Outland Raids

if (intid == 66) then -- Black Temple
	player:Teleport(530, -3638.16, 316.09, 35.40)
	player:GossipComplete()
end

if (intid == 67) then -- Hyjal Summit
	player:Teleport(1, -8175.94, -4178.52, -166.74)
	player:GossipComplete()
end

if (intid == 68) then -- Serpentshrine Cavern
	player:Teleport(530, 731.04, 6849.35, -66.62)
	player:GossipComplete()
end

if (intid == 69) then -- Gruul's Lair
	player:Teleport(530, 3528.99, 5133.50, 1.31)
	player:GossipComplete()
end

if (intid == 70) then -- Magtheridon's Lair
	player:Teleport(530, -337.50, 3131.88, -102.92)
	player:GossipComplete()
end

if (intid == 71) then -- Karazhan
	player:Teleport(0, -11119.22, -2010.73, 47.09)
	player:GossipComplete()
end

if (intid == 72) then -- Sunwell Plateau
	player:Teleport(530, 12560.79, -6774.58, 15.08)
	player:GossipComplete()
end

if (intid == 73) then -- The Eye
	player:Teleport(530, 3088.25, 1388.17, 185.09)
	player:GossipComplete()
end

if (intid == 74) then -- Zul'Aman
	player:Teleport(530, 6850, -7950, 170)
	player:GossipComplete()
end


-- Northrend Locations

if (intid == 75) then -- Borean Tundra
	player:Teleport(571, 2920.15, 4043.40, 1.82)
	player:GossipComplete()
end

if (intid == 76) then -- Crystalsong Forest
	player:Teleport(571, 5371.18, 109.11, 157.65)
	player:GossipComplete()
end

if (intid == 77) then -- Dragonblight
	player:Teleport(571, 2729.59, 430.70, 66.98)
	player:GossipComplete()
end

if (intid == 78) then -- Grizzly Hills
	player:Teleport(571, 3587.20, -4545.12, 198.75)
	player:GossipComplete()
end

if (intid == 79) then -- Howling Fjord
	player:Teleport(571, 154.39, -4896.33, 296.14)
	player:GossipComplete()
end

if (intid == 80) then -- Icecrown
	player:Teleport(571, 8406.89, 2703.79, 665.17)
	player:GossipComplete()
end

if (intid == 81) then -- Sholazar Basin
	player:Teleport(571, 5569.49, 5762.99, -75.22)
	player:GossipComplete()
end

if (intid == 82) then -- The Storm Peaks
	player:Teleport(571, 6180.66, -1085.65, 415.54)
	player:GossipComplete()
end

if (intid == 83) then -- Wintergrasp
	player:Teleport(571, 5044.03, 2847.23, 392.64)
	player:GossipComplete()
end

if (intid == 84) then -- Zul'Drak
	player:Teleport(571, 4700.09, -3306.54, 292.41)
	player:GossipComplete()
end


-- Northrend Instances

if (intid == 85) then -- Azjol-Nerub
	player:Teleport(571, 3738.93, 2164.14, 37.29)
	player:GossipComplete()
end

if (intid == 86) then -- Drak'Tharon
	player:Teleport(571, 4772.13, -2035.85, 229.38)
	player:GossipComplete()
end

if (intid == 87) then -- Gundrak
	player:Teleport(571, 6937.12, -4450.80, 450.90)
	player:GossipComplete()
end

if (intid == 88) then -- The Culling of Stratholme
	player:Teleport(1, -8746.94, -4437.69, -199.98)
	player:GossipComplete()
end

if (intid == 89) then -- The Halls of Lightning
	player:Teleport(571, 9171.01, -1375.94, 1099.55)
	player:GossipComplete()
end

if (intid == 90) then -- The Halls of Stone
	player:Teleport(571, 8921.35, -988.56, 1039.37)
	player:GossipComplete()
end

if (intid == 91) then -- The Nexus
	player:Teleport(571, 3784.76, 6941.97, 104.49)
	player:GossipComplete()
end

if (intid == 92) then -- The Violet Hold
	player:Teleport(571, 5695.19, 505.38, 652.68)
	player:GossipComplete()
end

if (intid == 93) then -- Utgarde Keep
	player:Teleport(571, 1222.44, -4862.61, 41.24)
	player:GossipComplete()
end

if (intid == 94) then -- Utgarde Pinnacle
	player:Teleport(571, 1251.10, -4856.31, 215.86)
	player:GossipComplete()
end


-- Northrend Raids

if (intid == 95) then -- Naxxramas
	player:Teleport(571, 3669.77, -1275.48, 243.51)
	player:GossipComplete()
end

if (intid == 96) then -- The Eye of Eternity
	player:Teleport(571, 3873.50, 6974.83, 152.04)
	player:GossipComplete()
end

if (intid == 97) then -- The Obsidian Sanctum
	player:Teleport(571, 3547.39, 267.95, -115.96)
	player:GossipComplete()
end

if (intid == 98) then -- Ulduar
	player:Teleport(571, 9330.53, -1115.40, 1245.14)
	player:GossipComplete()
end

if (intid == 99) then -- Vault of Archavon
	player:Teleport(571, 5410.21, 2842.37, 418.67)
	player:GossipComplete()
end


-- Professions

if (intid == 100) then -- Alchemy
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 158, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(51303)
		player:LearnSpell(58871)
		player:LearnSpell(58868)
		player:LearnSpell(60403)
		player:LearnSpell(60396)
		player:LearnSpell(60405)
		player:LearnSpell(57427)
		player:LearnSpell(57425)
		player:LearnSpell(60350)
		player:LearnSpell(53840)
		player:LearnSpell(53898)
		player:LearnSpell(54218)
		player:LearnSpell(60367)
		player:LearnSpell(53847)
		player:LearnSpell(53903)
		player:LearnSpell(54213)
		player:LearnSpell(53902)
		player:LearnSpell(53901)
		player:LearnSpell(53848)
		player:LearnSpell(53839)
		player:LearnSpell(53905)
		player:LearnSpell(53899)
		player:LearnSpell(53900)
		player:LearnSpell(53812)
		player:LearnSpell(53838)
		player:LearnSpell(53836)
		player:LearnSpell(53837)
		player:LearnSpell(53842)
		player:LearnSpell(53841)
		player:LearnSpell(53042)
		player:LearnSpell(60893)
end

if (intid == 101) then -- Blacksmithing
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 160, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(51298)
		player:LearnSpell(55374)
		player:LearnSpell(55377)
		player:LearnSpell(55372)
		player:LearnSpell(55375)
		player:LearnSpell(55373)
		player:LearnSpell(55376)
		player:LearnSpell(55370)
		player:LearnSpell(55369)
		player:LearnSpell(55371)
		player:LearnSpell(56234)
		player:LearnSpell(56400)
		player:LearnSpell(59406)
		player:LearnSpell(61008)
		player:LearnSpell(55303)
		player:LearnSpell(55302)
		player:LearnSpell(56555)
		player:LearnSpell(56554)
		player:LearnSpell(56556)
		player:LearnSpell(55304)
		player:LearnSpell(55311)
		player:LearnSpell(55310)
		player:LearnSpell(55312)
		player:LearnSpell(61009)
		player:LearnSpell(61010)
		player:LearnSpell(56357)
		player:LearnSpell(55839)
		player:LearnSpell(55732)
		player:LearnSpell(55656)
end

if (intid == 102) then -- Enchanting
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 162, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(51312)
		player:LearnSpell(60619)
		player:LearnSpell(47900)
		player:LearnSpell(60668)
		player:LearnSpell(44593)
		player:LearnSpell(44509)
		player:LearnSpell(60663)
		player:LearnSpell(44489)
		player:LearnSpell(44589)
		player:LearnSpell(44598)
		player:LearnSpell(44529)
		player:LearnSpell(44508)
		player:LearnSpell(44488)
		player:LearnSpell(44633)
		player:LearnSpell(44510)
		player:LearnSpell(44584)
		player:LearnSpell(44484)
		player:LearnSpell(44616)
		player:LearnSpell(47766)
		player:LearnSpell(44645)
		player:LearnSpell(44636)
		player:LearnSpell(59636)
		player:LearnSpell(44635)
		player:LearnSpell(44492)
		player:LearnSpell(44500)
		player:LearnSpell(44513)
		player:LearnSpell(60653)
		player:LearnSpell(44629)
		player:LearnSpell(44582)
		player:LearnSpell(44630)
		player:LearnSpell(60623)
		player:LearnSpell(44528)
		player:LearnSpell(60621)
		player:LearnSpell(60606)
		player:LearnSpell(44555)
		player:LearnSpell(44506)
		player:LearnSpell(32667)
		player:LearnSpell(44623)
		player:LearnSpell(60616)
		player:LearnSpell(44592)
		player:LearnSpell(27958)
		player:LearnSpell(60609)

end

if (intid == 103) then -- Engineering
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 164, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(51305)
		player:LearnSpell(56479)
		player:LearnSpell(60874)
		player:LearnSpell(56462)
		player:LearnSpell(56478)
		player:LearnSpell(56469)
		player:LearnSpell(56472)
		player:LearnSpell(56470)
		player:LearnSpell(56467)
		player:LearnSpell(56466)
		player:LearnSpell(61483)
		player:LearnSpell(56477)
		player:LearnSpell(56475)
		player:LearnSpell(56476)
		player:LearnSpell(56474)
		player:LearnSpell(56468)
		player:LearnSpell(55016)
		player:LearnSpell(54353)
		player:LearnSpell(54998)
		player:LearnSpell(54999)
		player:LearnSpell(63770)
		player:LearnSpell(61471)
		player:LearnSpell(56471)
		player:LearnSpell(54736)
		player:LearnSpell(55002)
		player:LearnSpell(54793)
		player:LearnSpell(63765)
		player:LearnSpell(56463)
		player:LearnSpell(56461)
		player:LearnSpell(56459)
		player:LearnSpell(56464)
end

if (intid == 104) then -- Herbalism
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 166, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(50301)
end

if (intid == 105) then -- Inscription
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 168, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(45380)
		player:LearnSpell(58483)
		player:LearnSpell(58491)
		player:LearnSpell(50604)
		player:LearnSpell(50611)
		player:LearnSpell(59504)
		player:LearnSpell(59498)
		player:LearnSpell(59497)
		player:LearnSpell(50620)
		player:LearnSpell(59501)
		player:LearnSpell(61117)
		player:LearnSpell(61118)
		player:LearnSpell(61119)
		player:LearnSpell(61120)
		player:LearnSpell(61177)
		player:LearnSpell(57715)
		player:LearnSpell(60337)
end


if (intid == 106) then -- Jewelcrafting
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 170, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(51310)
		player:LearnSpell(56197)
		player:LearnSpell(55402)
		player:LearnSpell(55399)
		player:LearnSpell(55394)
		player:LearnSpell(55386)
		player:LearnSpell(56203)
		player:LearnSpell(59759)
		player:LearnSpell(56199)
		player:LearnSpell(56202)
		player:LearnSpell(56201)
		player:LearnSpell(53969)
		player:LearnSpell(53947)
		player:LearnSpell(53956)
		player:LearnSpell(54007)
		player:LearnSpell(56531)
		player:LearnSpell(53989)
		player:LearnSpell(53953)
end

if (intid == 107) then -- Leatherworking
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 172, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(51301)
		player:LearnSpell(60640)
		player:LearnSpell(60637)
		player:LearnSpell(50965)
		player:LearnSpell(50967)
		player:LearnSpell(60643)
		player:LearnSpell(60583)
		player:LearnSpell(57683)
		player:LearnSpell(57691)
		player:LearnSpell(57690)
end

if (intid == 108) then -- Mining
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 174, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(50309)
end

if (intid == 109) then -- Skinning
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 176, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		-------------------------
		player:LearnSpell(50307)
end

if (intid == 110) then -- Tailoring
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 178, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(51308)
		player:LearnSpell(56026)
		player:LearnSpell(56024)
		player:LearnSpell(56028)
		player:LearnSpell(56027)
		player:LearnSpell(56025)
		player:LearnSpell(56029)
		player:LearnSpell(60993)
		player:LearnSpell(60971)
		player:LearnSpell(60994)
		player:LearnSpell(60990)
		player:LearnSpell(55769)
		player:LearnSpell(55642)
		player:LearnSpell(55777)
		player:LearnSpell(56002)
		player:LearnSpell(56001)
		player:LearnSpell(56003)
		player:LearnSpell(56007)
		player:LearnSpell(60969)
end


if (intid == 111) then -- Secondary Professions
	item:GossipCreateMenu(5668, player, 0)
	item:GossipMenuAddItem(5, "Cooking", 179, 0)
	item:GossipMenuAddItem(5, "First Aid", 180, 0)
	item:GossipMenuAddItem(5, "Fishing", 181, 0)
	item:GossipMenuAddItem(0, "Previous Page", 17, 0)
	item:GossipMenuAddItem(0, "Home Page", 999, 0)
	item:GossipSendMenu(player)
end


-- Eastern Kingdoms

if (intid == 112) then -- Alterac Mountains
	player:Teleport(0, 353.79, -607.08, 150.76)
	player:GossipComplete()
end

if (intid == 113) then -- Arathi Highlands
	player:Teleport(0, -2269.78, -2501.06, 79.04)
	player:GossipComplete()
end

if (intid == 114) then -- Badlands
	player:Teleport(0, -6026.58, -3318.27, 260.64)
	player:GossipComplete()
end

if (intid == 115) then -- Blasted Lands
	player:Teleport(0, -10797.67, -2994.29, 44.42)
	player:GossipComplete()
end

if (intid == 116) then -- Burning Steppes
	player:Teleport(0, -8357.72, -2537.49, 135.01)
	player:GossipComplete()
end

if (intid == 117) then -- Deadwind Pass
	player:Teleport(0, -10460.22, -1699.33, 81.85)
	player:GossipComplete()
end

if (intid == 118) then -- Dun Morogh
	player:Teleport(0, -6234.99, 341.24, 383.22)
	player:GossipComplete()
end

if (intid == 119) then -- Duskwood
	player:Teleport(0, -10068.30, -1501.07, 28.41)
	player:GossipComplete()
end

if (intid == 120) then -- Eastern Plaguelands
	player:Teleport(0, 1924.70, -2653.54, 59.70)
	player:GossipComplete()
end

if (intid == 121) then -- Elwynn Forest
	player:Teleport(0, -8939.71, -131.22, 83.62)
	player:GossipComplete()
end

if (intid == 122) then -- Eversong Woods
	player:Teleport(530, 10341.73, -6366.29, 34.31)
	player:GossipComplete()
end

if (intid == 123) then -- Ghostlands
	player:Teleport(530, 7969.87, -6872.63, 58.66)
	player:GossipComplete()
end

if (intid == 124) then -- Hillsbrad Foothills
	player:Teleport(0, -585.70, 612.18, 83.80)
	player:GossipComplete()
end

if (intid == 125) then -- Isle of Quel'Danas
	player:Teleport(530, 12916.81, -6867.82, 7.69)
	player:GossipComplete()
end

if (intid == 126) then -- Loch Modan
	player:Teleport(0, -4702.59, -2698.61, 318.75)
	player:GossipComplete()
end

if (intid == 127) then -- Redridge Mountains
	player:Teleport(0, -9600.62, -2123.21, 66.23)
	player:GossipComplete()
end

if (intid == 128) then -- Searing Gorge
	player:Teleport(0, -6897.73, -1821.58, 241.16)
	player:GossipComplete()
end

if (intid == 129) then -- Silverpine Forest
	player:Teleport(0, 1499.57, 623.98, 47.01)
	player:GossipComplete()
end

if (intid == 130) then -- Stranglethorn Vale
	player:Teleport(0, -11355.90, -383.40, 65.14)
	player:GossipComplete()
end

if (intid == 131) then -- Swamp of Sorrows
	player:Teleport(0, -10552.60, -2355.25, 85.95)
	player:GossipComplete()
end

if (intid == 132) then -- The Hinterlands
	player:Teleport(0, 92.63, -1942.31, 154.11)
	player:GossipComplete()
end

if (intid == 133) then -- Tirisfal Glades
	player:Teleport(0, 1676.13, 1669.37, 137.02)
	player:GossipComplete()
end

if (intid == 134) then -- Western Plaguelands
	player:Teleport(0, 1635.57, -1068.50, 66.57)
	player:GossipComplete()
end

if (intid == 135) then -- Westfall
	player:Teleport(0, -9827.95, 865.80, 25.80)
	player:GossipComplete()
end

if (intid == 136) then -- Wetlands
	player:Teleport(0, -4086.32, -2620.72, 43.55)
	player:GossipComplete()
end


-- Kalimdor

if (intid == 137) then -- Ashenvale
	player:Teleport(1, 3474.41, 853.47, 5.76)
	player:GossipComplete()
end

if (intid == 138) then -- Azshara
	player:Teleport(1, 2763.93, -3881.34, 92.52)
	player:GossipComplete()
end

if (intid == 139) then -- Azuremyst Isle
	player:Teleport(530, -3972.72, -13914.99, 98.88)
	player:GossipComplete()
end

if (intid == 140) then -- Bloodmyst Isle
	player:Teleport(530, -2721.67, -12208.90, 9.08)
	player:GossipComplete()
end

if (intid == 141) then -- Darkshore
	player:Teleport(1, 4336.61, 173.83, 46.84)
	player:GossipComplete()
end

if (intid == 142) then -- Desolace
	player:Teleport(1, 47.28, 1684.64, 93.55)
	player:GossipComplete()
end

if (intid == 143) then -- Durotar
	player:Teleport(1, -611.61, -4263.16, 38.95)
	player:GossipComplete()
end

if (intid == 144) then -- Dustwallow Marsh
	player:Teleport(1, -3682.58, -2556.93, 58.43)
	player:GossipComplete()
end

if (intid == 145) then -- Felwood
	player:Teleport(1, 3590.56, -1516.69, 169.98)
	player:GossipComplete()
end

if (intid == 146) then -- Feralas
	player:Teleport(1, -4300.02, -631.56, -9.35)
	player:GossipComplete()
end

if (intid == 147) then -- Moonglade
	player:Teleport(1, 7999.68, -2670.19, 512.09)
	player:GossipComplete()
end

if (intid == 148) then -- Mulgore
	player:Teleport(1, -2931.49, -262.82, 53.25)
	player:GossipComplete()
end

if (intid == 149) then -- Silithus
	player:Teleport(1, -6814.57, 833.77, 49.74)
	player:GossipComplete()
end

if (intid == 150) then -- Stonetalon Mountains
	player:Teleport(1, -225.34, -765.16, 6.4)
	player:GossipComplete()
end

if (intid == 151) then -- Tanaris
	player:Teleport(1, -6999.47, -3707.94, 26.44)
	player:GossipComplete()
end

if (intid == 152) then -- Teldrassil
	player:Teleport(1, 8754.06, 949.62, 25.99)
	player:GossipComplete()
end

if (intid == 153) then -- The Barrens
	player:Teleport(1, -948.46, -3738.60, 5.98)
	player:GossipComplete()
end

if (intid == 154) then -- Thousand Needles
	player:Teleport(1, -4685.72, -1836.24, -44.04)
	player:GossipComplete()
end

if (intid == 155) then -- Un'Goro Crater
	player:Teleport(1, -6162.47, -1098.74, -208.99)
	player:GossipComplete()
end

if (intid == 156) then -- Winterspring
	player:Teleport(1, 6896.27, -2302.51, 586.69)
	player:GossipComplete()
end


-- Profession Trainers

if (intid == 157) then -- Alchemy

	player:GossipComplete()
end

if (intid == 158) then -- Unlearn ^^
	player:UnlearnSpell(51303)
	player:UnlearnSpell(51304)
	player:UnlearnSpell(53042)
	player:GossipComplete()
end

if (intid == 159) then -- Blacksmithing

	player:GossipComplete()
end

if (intid == 160) then -- Unlearn ^^
	player:UnlearnSpell(51298)
	player:UnlearnSpell(51300)
	player:GossipComplete()
end

if (intid == 161) then -- Enchanting
	
	player:GossipComplete()
end

if (intid == 162) then -- Unlearn ^^
	player:UnlearnSpell(51312)
	player:UnlearnSpell(51313)
	player:GossipComplete()
end

if (intid == 163) then -- Engineering

	player:GossipComplete()
end

if (intid == 164) then -- Unlearn ^^
	player:UnlearnSpell(51305)
	player:UnlearnSpell(51306)
	player:GossipComplete()
end

if (intid == 165) then -- Herbalism

	player:GossipComplete()
end

if (intid == 166) then -- Unlearn Herbalism
	player:UnlearnSpell(50300)
	player:UnlearnSpell(50301)
	player:GossipComplete()
end

if (intid == 167) then -- Inscription

	player:GossipComplete()
end

if (intid == 168) then -- Unlearn ^^
	player:UnlearnSpell(45363)
	player:UnlearnSpell(45380)
	player:GossipComplete()
end

if (intid == 169) then -- Jewelcrafting

	player:GossipComplete()
end

if (intid == 170) then -- Unlearn ^^
	player:UnlearnSpell(51310)
	player:UnlearnSpell(51311)
	player:GossipComplete()
end

if (intid == 171) then -- Leatherworking

	player:GossipComplete()
end

if (intid == 172) then -- Unlearn ^^
	player:UnlearnSpell(51301)
	player:UnlearnSpell(51302)
	player:GossipComplete()
end

if (intid == 173) then -- Mining

	player:GossipComplete()
end

if (intid == 174) then -- Unlearn ^^
	player:UnlearnSpell(50309)
	player:UnlearnSpell(50310)
	player:GossipComplete()
end

if (intid == 175) then -- Skinning

	player:GossipComplete()
end

if (intid == 176) then -- Unlearn ^^
	player:UnlearnSpell(50305)
	player:UnlearnSpell(50306)
	player:GossipComplete()
end

if (intid == 177) then -- Tailoring

	player:GossipComplete()
end

if (intid == 178) then -- Unlearn ^^
	player:UnlearnSpell(51308)
	player:UnlearnSpell(51309)
	player:GossipComplete()
end



-- Secondary Professions

if (intid == 179) then -- Cooking
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 183, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(51295)
end

if (intid == 180) then -- First Aid
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 185, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(50299)
end

if (intid == 181) then -- Fishing
		item:GossipCreateMenu(5668, player, 0)

		item:GossipMenuAddItem(0, "I'd like to unlearn this profession.", 187, 0)
		item:GossipMenuAddItem(0, "Home Page", 999, 0)
		item:GossipSendMenu(player)
		------------------------
		player:LearnSpell(51293)
end


-- Secondary Profession Trainers

if (intid == 182) then -- Cooking

	player:GossipComplete()
end

if (intid == 183) then -- Unlearn ^^
	player:UnlearnSpell(51296)
	player:UnlearnSpell(51295)
	player:GossipComplete()
end

if (intid == 184) then -- First Aid

	player:GossipComplete()
end

if (intid == 185) then -- Unlearn ^^
	player:UnlearnSpell(50299)
	player:UnlearnSpell(45442)
	player:GossipComplete()
end

if (intid == 186) then -- Fishing

	player:GossipComplete()
end

if (intid == 187) then -- Unlearn ^^
	player:UnlearnSpell(51294)
	player:UnlearnSpell(51293)
	player:GossipComplete()
end


-- Foothills

if(intid == 9997) then
	if (plyr == 1) or (plyr == 3) or (plyr == 4) or (plyr == 7) or (plyr == 11) then
		item:GossipCreateMenu(5668, player, 0)
		item:GossipMenuAddItem(2, "Qurantis", 1235, 0)
		item:GossipSendMenu(player)
	end

	if (plyr == 2) or (plyr == 5) or (plyr == 6) or (plyr == 8) or (plyr == 10) then
		item:GossipCreateMenu(5668, player, 0)
		item:GossipMenuAddItem(2, "Mulderan", 1236, 0)
		item:GossipSendMenu(player)
	end
end

if(intid == 1235) then -- Qurantis
	player:Teleport(560, 3611.490723, 2288.865967, 59.283901)
end

if(intid == 1236) then -- Mulderan
	player:Teleport(560, 2539.483643, 2423.052734, 63.581509)
end



if (intid == 999) then -- Main page
item:GossipCreateMenu(5667, player, 0)
item:GossipMenuAddItem(5, "|cffff6060TELEPORTER STONE.|r", 998, 0)
item:GossipMenuAddItem(6, "|cFF191970Main Cities|r", 1, 0)
item:GossipMenuAddItem(2, "|cFF191970Azeroth Locations|r", 2, 0)
item:GossipMenuAddItem(2, "|cFF191970Azeroth Instances|r", 3, 0)
item:GossipMenuAddItem(2, "|cFF191970Azeroth Raids|r", 4, 0)
item:GossipMenuAddItem(2, "|cFF191970Outland Locations|r", 5, 0)
item:GossipMenuAddItem(2, "|cFF191970Outland Instances|r", 6, 0)
item:GossipMenuAddItem(2, "|cFF191970Outland Raids|r", 7, 0)
item:GossipMenuAddItem(2, "|cFF191970Northrend Locations|r", 8, 0)
item:GossipMenuAddItem(2, "|cFF191970Northrend Instances|r", 9, 0)
item:GossipMenuAddItem(2, "|cFF191970Northrend Raids|r", 10, 0)
item:GossipMenuAddItem(0, "|cFF191970Foothills|r", 9997, 0)
item:GossipMenuAddItem(5, "|cFF191970Murloc Mall|r", 12, 0)
item:GossipMenuAddItem(9, "|cFF191970Gurubashi Arena|r", 13, 0)
item:GossipMenuAddItem(0, "|cFF191970Next Page|r", 997, 0)
item:GossipSendMenu(player)
end
end

RegisterItemGossipEvent(6948, 1, "Tele_Book")
RegisterItemGossipEvent(6948, 2, "Tele_Select")


function Whelp_OnSpawn(Unit, event)
local plyr = Unit:GetClosestPlayer()
	if (plyr ~= nil) then
		Unit:FullCastSpellOnTarget(56520, plyr)
		Unit:FullCastSpellOnTarget(56521, plyr)
		Unit:FullCastSpellOnTarget(58054, plyr)
		Unit:FullCastSpellOnTarget(48469, plyr)
		Unit:FullCastSpellOnTarget(42995, plyr)
		Unit:FullCastSpellOnTarget(48161, plyr)
	end
end

RegisterUnitEvent(6948, 18, "Whelp_OnSpawn")
