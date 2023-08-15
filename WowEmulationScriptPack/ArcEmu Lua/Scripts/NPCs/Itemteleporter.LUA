function Item_Trigger(item, event, player)
    Item_menu(item, player)
end


function Item_Trigger(Unit, Event, Player)
Unit:GossipCreateMenu(1000, Player, 0)
    local race = Player:GetPlayerRace()
    if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
        Unit:GossipMenuAddItem(2, "|cff0000ffAlliance Upgrade Center", 1, 0)
        Unit:GossipMenuAddItem(3, "Alliance Cities", 3, 0)
end
    local race = Player:GetPlayerRace()
    if race == 2 or race == 5 or race == 6 or race == 8 or race == 10 then
        Unit:GossipMenuAddItem(2, "|cffff0000Horde Upgrade Center", 2, 0)
        Unit:GossipMenuAddItem(3, "Horde Cities", 4, 0)
end
	Unit:GossipMenuAddItem(2, "Custom Zones", 122, 0)
	Unit:GossipMenuAddItem(2, "|cff0000ff-+Gm Island Quest Zone+-", 9995, 0)
Unit:GossipMenuAddItem(3, "Teleport Locations", 5, 0)
	Unit:GossipMenuAddItem(4, "Buff Me", 6, 0)
	Unit:GossipMenuAddItem(4, "Change the Weather", 114, 0)
	Unit:GossipMenuAddItem(4, "Max Out All Skills", 105, 0)
	Unit:GossipMenuAddItem(4, "Reset Talent Points", 106, 0)
	Unit:GossipMenuAddItem(4, "|cff00ff00Remove Resurrection Sickness", 7, 0)
	Unit:GossipMenuAddItem(7, "|cffff0000[Nevermind]", 8, 0)
	Unit:GossipSendMenu(Player)
end

function OnSelect(Unit, Event, Player, id, intid, code, pMisc)

if(intid == 999) then
	Unit:GossipCreateMenu(999, Player, 0)
    local race = Player:GetPlayerRace()
    if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
        Unit:GossipMenuAddItem(2, "|cff0000ffAlliance Upgrade Center", 1, 0)
        Unit:GossipMenuAddItem(3, "Alliance Cities", 3, 0)
end
    local race = Player:GetPlayerRace()
    if race == 2 or race == 5 or race == 6 or race == 8 or race == 10 then
        Unit:GossipMenuAddItem(2, "|cffff0000Horde Upgrade Center", 2, 0)
        Unit:GossipMenuAddItem(3, "Horde Cities", 4, 0)
end
	Unit:GossipMenuAddItem(3, "Custom Zones", 122, 0)
	
	Unit:GossipMenuAddItem(2, "|cff0000ff-+Gm Island Quest Zone+-", 9995, 0)
	
	Unit:GossipMenuAddItem(3, "Teleport Locations", 5, 0)
	Unit:GossipMenuAddItem(4, "Buff Me", 6, 0)
	Unit:GossipMenuAddItem(4, "Change the Weather", 114, 0)
	Unit:GossipMenuAddItem(4, "Max Out All Skills", 105, 0)
	Unit:GossipMenuAddItem(4, "Reset Talent Points", 106, 0)
	Unit:GossipMenuAddItem(4, "|cff00ff00Remove Resurrection Sickness", 7, 0)
	Unit:GossipMenuAddItem(7, "|cffff0000[Nevermind]", 8, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 8) then
    Player:GossipComplete()
end

if(intid == 3) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Stormwind", 9, 0)
	Unit:GossipMenuAddItem(2, "Ironforge", 10, 0)
	Unit:GossipMenuAddItem(2, "Darnassus", 11, 0)
	Unit:GossipMenuAddItem(2, "The Exodar", 12, 0)
	Unit:GossipMenuAddItem(7, "[Main Menu]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 4) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Orgrimmar", 13, 0)
	Unit:GossipMenuAddItem(2, "Undercity", 14, 0)
	Unit:GossipMenuAddItem(2, "Thunderbluff", 15, 0)
	Unit:GossipMenuAddItem(2, "Silvermoon", 16, 0)
	Unit:GossipMenuAddItem(7, "[Main Menu]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 5) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Classic Instances", 17, 0)
	Unit:GossipMenuAddItem(2, "Outland Instances", 18, 0)
	Unit:GossipMenuAddItem(2, "Northrend Instances", 19, 0)
	Unit:GossipMenuAddItem(2, "Shattrath City", 20, 0)
	Unit:GossipMenuAddItem(2, "Dalaran", 21, 0)
	Unit:GossipMenuAddItem(2, "PvP Arena", 22, 0)
	Unit:GossipMenuAddItem(7, "[Main Menu]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 17) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Ragefire Chasm (13-20)", 23, 0)
	Unit:GossipMenuAddItem(2, "Deadmines (17-23)", 24, 0)
	Unit:GossipMenuAddItem(2, "Wailing Caverns (17-23)", 25, 0)
	Unit:GossipMenuAddItem(2, "Shadowfang Keep (18-23)", 26, 0)
	Unit:GossipMenuAddItem(2, "Blackfathom Deeps (22-27)", 27, 0)
	Unit:GossipMenuAddItem(2, "The Stockade (23-27)", 28, 0)
	Unit:GossipMenuAddItem(2, "Razorfen Kraul (22-31)", 29, 0)
	Unit:GossipMenuAddItem(2, "Gnomeregan (25-32)", 30, 0)

	Unit:GossipMenuAddItem(2, "Razorfen Downs (33-37)", 31, 0)
	Unit:GossipMenuAddItem(2, "Scarlet Monestary (29-44)", 32, 0)
	Unit:GossipMenuAddItem(2, "Uldaman (37-44)", 33, 0)
	Unit:GossipMenuAddItem(2, "[Next]->", 34, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 34) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Zul'Farak (42-46)", 35, 0)
	Unit:GossipMenuAddItem(2, "Mauradon (42-52)", 36, 0)
	Unit:GossipMenuAddItem(2, "Temple of Atal'Hakkar (47-52)", 37, 0)
	Unit:GossipMenuAddItem(2, "Blackrock Depths (48-60)", 38, 0)
	Unit:GossipMenuAddItem(2, "Dire Maul (55-60)", 39, 0)
	Unit:GossipMenuAddItem(2, "Scholomance (56-60)", 40, 0)
	Unit:GossipMenuAddItem(2, "Stratholme (56-60)", 41, 0)
	Unit:GossipMenuAddItem(2, "Lower Blackrock Spire (54-60)", 42, 0)
	Unit:GossipMenuAddItem(2, "Upper Blackrock Spire (56-60)", 43, 0)
	Unit:GossipMenuAddItem(2, "[Next]->", 44, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 44) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Zul'Gurub (60+)", 45, 0)
	Unit:GossipMenuAddItem(2, "Molten Core (60+)", 46, 0)
	Unit:GossipMenuAddItem(2, "Blackwing Lair (60++)", 47, 0)
	Unit:GossipMenuAddItem(2, "Ruins of Ahn'Qiraj (60++)", 48, 0)
	Unit:GossipMenuAddItem(2, "Temple of Ahn'Qiraj (60+++)", 49, 0)
	Unit:GossipMenuAddItem(7, "[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 18) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Hellfire Citadel", 51, 0)
	Unit:GossipMenuAddItem(2, "Coilfang Reservoir", 52, 0)
	Unit:GossipMenuAddItem(2, "Auchindoun", 53, 0)
	Unit:GossipMenuAddItem(2, "Caverns of Time", 54, 0)
	Unit:GossipMenuAddItem(2, "Tempest Keep", 55, 0)
	Unit:GossipMenuAddItem(2, "Magisters' Terrace (70)", 56, 0)
	Unit:GossipMenuAddItem(2, "Karazhan (70+)", 57, 0)
	Unit:GossipMenuAddItem(2, "Gruul's Lair (70+)", 58, 0)
	Unit:GossipMenuAddItem(2, "Zul'Aman (70++)", 59, 0)
	Unit:GossipMenuAddItem(2, "Black Temple (70+++)", 60, 0)
	Unit:GossipMenuAddItem(2, "Sunwell Plateau (70++++)", 61, 0)
	Unit:GossipMenuAddItem(7, "[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 51) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Hellfire Ramparts (60-62)", 62, 0)
	Unit:GossipMenuAddItem(2, "The Blood Furnace (61-63)", 63, 0)
	Unit:GossipMenuAddItem(2, "The Shattered Halls (69-70)", 64, 0)
	Unit:GossipMenuAddItem(2, "Magtheridon's Lair (70+)", 65, 0)
	Unit:GossipMenuAddItem(7, "[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 52) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "The Slave Pens (62-64)", 66, 0)
	Unit:GossipMenuAddItem(2, "The Underbog (63-65)", 67, 0)
	Unit:GossipMenuAddItem(2, "The Steamvault (68-70)", 68, 0)
	Unit:GossipMenuAddItem(2, "Serpentshine Cavern (70++)", 69, 0)
	Unit:GossipMenuAddItem(7, "[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 53) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Mana-Tombs (64-66)", 70, 0)
	Unit:GossipMenuAddItem(2, "Auchenai Crypts (65-67)", 71, 0)
	Unit:GossipMenuAddItem(2, "Sethekk Halls (67-69)", 72, 0)
	Unit:GossipMenuAddItem(2, "Shadow Labyrinth (69-70)", 73, 0)
	Unit:GossipMenuAddItem(7, "[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 54) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Old Hillsbrad Foothills (66-68)", 74, 0)
	Unit:GossipMenuAddItem(2, "The Black Morass (70)", 75, 0)
	Unit:GossipMenuAddItem(2, "Hyjal Summit (70+++)", 76, 0)
	Unit:GossipMenuAddItem(7, "[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 55) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "The Mechanar (70)", 77, 0)
	Unit:GossipMenuAddItem(2, "The Botanica (70)", 78, 0)
	Unit:GossipMenuAddItem(2, "The Arcatraz (70)", 79, 0)
	Unit:GossipMenuAddItem(2, "The Eye (70++)", 80, 0)
	Unit:GossipMenuAddItem(7, "[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 19) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Utgarde Keep (70-72)", 81, 0)
	Unit:GossipMenuAddItem(2, "The Nexus (71-73)", 82, 0)
	Unit:GossipMenuAddItem(2, "Azjol-Nerub (72-74)", 83, 0)
	Unit:GossipMenuAddItem(2, "Ahn'kahet: The Old Kingdom (73-75)", 84, 0)
	Unit:GossipMenuAddItem(2, "Drak'Tharon Keep (74-76)", 85, 0)
	Unit:GossipMenuAddItem(2, "The Violet Hold (75-77)", 86, 0)
	Unit:GossipMenuAddItem(2, "Gundrak (76-78)", 87, 0)
	Unit:GossipMenuAddItem(2, "Halls of Stone (77-79)", 88, 0)
	Unit:GossipMenuAddItem(2, "Halls of Lightning (80)", 89, 0)
	Unit:GossipMenuAddItem(2, "The Oculus (80)", 90, 0)
	Unit:GossipMenuAddItem(2, "Culling of Stratholme (80)", 91, 0)
	Unit:GossipMenuAddItem(7, "[Next]->", 92, 0)
	Unit:GossipSendMenu(Player)
end

if(intid == 92) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "Utgarde Pinnacle (80)", 93, 0)
	Unit:GossipMenuAddItem(2, "Trial of the Champion (80+)", 94, 0)
	Unit:GossipMenuAddItem(2, "Vault of Archavon (80+)", 95, 0)
	Unit:GossipMenuAddItem(2, "Naxxramas (80+)", 96, 0)
	Unit:GossipMenuAddItem(2, "Obsidian Sanctum (80+)", 97, 0)
	Unit:GossipMenuAddItem(2, "Eye of Eternity (80++)", 98, 0)
	Unit:GossipMenuAddItem(2, "Ulduar (80++)", 99, 0)
	Unit:GossipMenuAddItem(2, "Trial of the Crusader (80+++)", 101, 0)
	Unit:GossipMenuAddItem(2, "Onyxia's Lair (80+++)", 102, 0)
	Unit:GossipMenuAddItem(2, "Icecrown Citadel (80++++)", 103, 0)
	Unit:GossipMenuAddItem(7, "[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if (intid == 114) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(4, "Sunny", 115, 0)
	Unit:GossipMenuAddItem(4, "Foggy", 116, 0)
	Unit:GossipMenuAddItem(4, "Rainy", 117, 0)
	Unit:GossipMenuAddItem(4, "Snowy", 118, 0)
	Unit:GossipMenuAddItem(7, "[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end


if (intid == 122) then
	Unit:GossipMenuAddItem(2, "-Party Tree House-", 120, 0)
	Unit:GossipMenuAddItem(2, "-+Gm Help Desk+-", 9994, 0)
	Unit:GossipMenuAddItem(2, "-+Stair Event 1+-", 9997, 0)
	Unit:GossipMenuAddItem(2, "-+Stair Event 2+-", 9986, 0)
	Unit:GossipMenuAddItem(2, "-+Snow Ball Arena+-", 9999, 0)
	Unit:GossipMenuAddItem(2, "-+Swimming Pool+-", 9992, 0)
	Unit:GossipMenuAddItem(2, "-+Ice Rink+-", 9991, 0)
	Unit:GossipMenuAddItem(2, "-+Dance Floor+-", 9990, 0)
	Unit:GossipMenuAddItem(7, "[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if (intid == 9988) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "|cff0000ff-+CRAIGY109 KING OF HEROES OF SUNRISE+-", 9985, 0)
	Unit:GossipMenuAddItem(2, "|cff0000ff-+King Drani World Boss+-", 9993, 0)
	Unit:GossipMenuAddItem(2, "|cff0000ff-+Lord Xyolexus World Boss+-", 9987, 0)
	Unit:GossipMenuAddItem(7, "[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if (intid == 10005) then
	Unit:GossipCreateMenu(99, Player, 0)
	Unit:GossipMenuAddItem(2, "|cff0000ff-+Do you hate instant 80 fun servers? If you want to level up form level 1 go collect gear and train your spells first and come back to me. Click on me and i will take you to the master of level changing he will then ask you if you want to be level 80 or 1 and then you can level up at Hyjal.+-", 10006, 0)
	Unit:GossipMenuAddItem(7, "|cffff0000[Back]", 999, 0)
	Unit:GossipSendMenu(Player)
end

if (intid == 115) then
        Player:SetPlayerWeather(0, 2.0)
        Player:SendBroadcastMessage("Its sunny! Might be a good idea to put on some sunscreen!")
        Player:GossipComplete()
end
if (intid == 116) then
        Player:SetPlayerWeather(1, 2.0)
        Player:SendBroadcastMessage("Its foggy! You should try to get a flashlight!")
        Player:GossipComplete()
end
if (intid == 117) then
        Player:SetPlayerWeather(2, 2.0)
        Player:SendBroadcastMessage("Its raining! Quick, get your rain coat!")
        Player:GossipComplete()
end
if (intid == 118) then
        Player:SetPlayerWeather(8, 2.0)
        Player:SendBroadcastMessage("Its snowing! Better bundle up!")
        Player:GossipComplete()
end

if(intid == 105) then
	Player:AdvanceSkill(43, 399)
	Player:AdvanceSkill(44, 399)
	Player:AdvanceSkill(45, 399)
	Player:AdvanceSkill(46, 399)
	Player:AdvanceSkill(54, 399)
	Player:AdvanceSkill(55, 399)
	Player:AdvanceSkill(95, 399)
	Player:AdvanceSkill(136, 399)
	Player:AdvanceSkill(160, 399)
	Player:AdvanceSkill(162, 399)
	Player:AdvanceSkill(172, 399)
	Player:AdvanceSkill(173, 399)
	Player:AdvanceSkill(176, 399)
	Player:AdvanceSkill(226, 399)
	Player:AdvanceSkill(228, 399)
	Player:AdvanceSkill(229, 399)
	Player:AdvanceSkill(473, 399)	
	Player:AdvanceSkill(164, 449)
	Player:AdvanceSkill(165, 449)
	Player:AdvanceSkill(171, 449)
	Player:AdvanceSkill(182, 449)
	Player:AdvanceSkill(186, 449)
	Player:AdvanceSkill(197, 449)
	Player:AdvanceSkill(202, 449)
	Player:AdvanceSkill(333, 449)
	Player:AdvanceSkill(393, 449)
	Player:AdvanceSkill(755, 449)
	Player:AdvanceSkill(773, 449)
	Player:AdvanceSkill(129, 449)
	Player:AdvanceSkill(185, 449)
	Player:AdvanceSkill(356, 449)
	Player:SendBroadcastMessage("You have maxed out all skills!")
	return Creature_OnSelect(Unit, Event, Player, id, 999, code, pMisc)
end

if (intid == 106) then
	Player:ResetTalents()
	Player:SendBroadcastMessage("All talents have been reset!")
	return Creature_OnSelect(Unit, Event, Player, id, 999, code, pMisc)
end

if(intid == 6) then
	Player:CastSpell(25898)
	Player:CastSpell(48162)
	Player:CastSpell(61024)
	Player:CastSpell(48074)
	Player:CastSpell(48470)
	Player:SendBroadcastMessage("You have been buffed!")
	return Creature_OnSelect(Unit, Event, Player, id, 999, code, pMisc)
end

if(intid == 7) then
	if (Player:HasAura(15007) == true) then
		Player:SendBroadcastMessage("Your Resurrection Sickness has been Removed!")
		Player:RemoveAura(15007)
		return Creature_OnSelect(Unit, Event, Player, id, 999, code, pMisc)
	else
		Player:SendBroadcastMessage("Stop lying! You don't have resurrection sickness!")
		return Creature_OnSelect(Unit, Event, Player, id, 999, code, pMisc)
	end
end

if (intid == 123) then --Hyjal level road
Player:Teleport(1, 4619.239, -3850.57, 944.005554)
end

if (intid == 120) then --Party tree house
Player:Teleport(0, -14722.500000, -106.509003, 4.434840)
end

if (intid == 124) then --Stormwind instance
Player:Teleport(0, -8644.821289, 600.941101, 94.730377)
end

if(intid == 1) then --alliance mall
Player:Teleport(0, 4321.921387, -2868.260986, 2.982461)
end

if(intid == 2) then --horde mall
Player:Teleport(530, -1683.88, 8361.05, -16.6463)
end

if(intid == 9) then --stormwind
Player:Teleport(0, -8928, 540, 95)
end

if(intid == 10) then --ironforge
Player:Teleport(0, -4981, -881, 502)
end

if(intid == 11) then --darnassus
Player:Teleport(1, 9978, 2033, 1328.5)
end

if(intid == 12) then --the exodar
Player:Teleport(530, -4014, -11895, -1.5)
end

if(intid == 13) then --orgrimmar
Player:Teleport(1, 1502, -4415, 22)
end

if(intid == 14) then --undercity
Player:Teleport(0, 1752, 239, 61.5)
end

if(intid == 15) then --thunderbluff
Player:Teleport(1, -1283, 158, 130)
end

if(intid == 16) then --silvermoon
Player:Teleport(530, 9392, -7277, 14.5)
end

if(intid == 20) then --shattrath
Player:Teleport(530, -1877.57, 5457.82, -12.42)
end

if(intid == 21) then --dalaran
Player:Teleport(571, 5797, 629, 648)
end

if(intid == 22) then --gurubashi arena
Player:Teleport(0, -13282, 117, 25)
end

if(intid == 23) then --ragefire chasm
Player:Teleport(1, 1805, -4404, -18)
end

if(intid == 24) then --deadmines
Player:Teleport(36, -16.4, 383.07, 61.77)
end

if(intid == 25) then --wailing caverns
Player:Teleport(1, -737, -2219, 17)
end

if(intid == 26) then --shadowfang keep
Player:Teleport(0, -241, 1545, 77)
end

if(intid == 27) then --blackfathom deeps
Player:Teleport(48, -151.76, 105.14, -40.23)
end

if(intid == 28) then --the stockade
Player:Teleport(34, 49.8, 0.87, -16.7)
end

if(intid == 29) then --razorfen kraul
Player:Teleport(1, -4473, -1690, 82)
end

if(intid == 30) then --gnomeregan
Player:Teleport(0, -5164, 918,258)
end

if(intid == 31) then --razorfen downs
Player:Teleport(1, -4661, -2511, 81)
end

if(intid == 32) then --scarlet monestary
Player:Teleport(0, 2841, -692, 140)
end

if(intid == 33) then --uldaman
Player:Teleport(0, -6704, -2955, 209)
end

if(intid == 35) then --zulfarak
Player:Teleport(1, -6821, -2890, 9)
end

if(intid == 36) then --maraudon
Player:Teleport(349, 1019.7, -458.3, -43.43)
end

if(intid == 37) then --atalhakkar
Player:Teleport(0, -10457, -3828, 19)
end

if(intid == 38) then --blackrock depths
Player:Teleport(0, -7187, -914, 166)
end

if(intid == 39) then --dire maul
Player:Teleport(1, -4435.65, 1324.18, 126)
end

if(intid == 40) then --scholomance
Player:Teleport(0, 1265, -2560, 95)
end

if(intid == 41) then --stratholme
Player:Teleport(0, 3345, -3380, 145)
end

if(intid == 42) then --LBRS
Player:Teleport(0, -7527.17, -1225, 285.7)
end

if(intid == 43) then --UBRS
Player:Teleport(0, -7527.17, -1225, 285.7)
end

if(intid == 45) then --Zulgurub
Player:Teleport(0, -11916.16, -1183.62, 85.14)
end

if(intid == 46) then --molten core
Player:Teleport(409, 1078.92, -480.9, -108.2)
end

if(intid == 47) then --blackwing lair
Player:Teleport(469, -7672.12, -1107.14, 396.65)
end

if(intid == 48) then --ruins of aq
Player:Teleport(509, -8438.7, 1516.18, 31.9)
end

if(intid == 49) then --temple of aq
Player:Teleport(531, -8229.14, 2014, 129.1)
end

if(intid == 56) then --Magisters terrace
Player:Teleport(1, 12884.38, -7307.2, 65.5)
end

if(intid == 57) then --karazhan
Player:Teleport(532, -11105, 2000.38, 49.9)
end

if(intid == 58) then --gruuls lair
Player:Teleport(530, 3529, 5096, 3)
end

if(intid == 59) then --zulaman
Player:Teleport(530, 6850, -7950, 171)
end

if(intid == 60) then --black temple
Player:Teleport(530, -3614, 310, 40)
end

if(intid == 61) then --sunwell plateau
Player:Teleport(1, 1766.78, 906.08, 14.62)
end

if(intid == 62) then --hellfire ramparts
Player:Teleport(530, -360.67, 3071.9, -15.1)
end

if(intid == 63) then --blood furnace
Player:Teleport(530, -303, 3164, 32)
end

if(intid == 64) then --shattered halls
Player:Teleport(530, -311, 3083, -3)
end

if(intid == 65) then --magtheridons lair
Player:Teleport(530, -313, 3088, -116)
end

if(intid == 66) then --slave pens
Player:Teleport(547, 123, -126.6, -0.86)
end

if(intid == 67) then --underbog
Player:Teleport(546, 35.22, -29.64, -2.75)
end

if(intid == 68) then --steamvault
Player:Teleport(545, -13.8, 6.75, -4.25)
end

if(intid == 69) then --serpentshrine cavern
Player:Teleport(548, 10.29, 0.01, 822.35)
end

if(intid == 70) then --mana-tombs
Player:Teleport(530, -3100, 4950, -100)
end

if(intid == 71) then --auchenai crypts
Player:Teleport(530, -3367, 5216, -101)
end

if(intid == 72) then --sethekk halls
Player:Teleport(530, -3364, 4675, -101)
end

if(intid == 73) then --shadow labryinth
Player:Teleport(530, -3630, 4941, -101)
end

if(intid == 74) then --Old hillsbrad foothills
Player:Teleport(560, 2387.58, 1192.94, 67.47)
end

if(intid == 75) then --black morass
Player:Teleport(269, -1492.27, 7046.35, 32.24)
end

if(intid == 76) then --hyjal summit
Player:Teleport(534, 4244.5, -4219.56, 868.4)
end

if(intid == 77) then --mechanar
Player:Teleport(530, 2870, 1557, 252)
end

if(intid == 78) then --botanica
Player:Teleport(530, 3404, 1488, 183)
end

if(intid == 79) then --arcatraz
Player:Teleport(1, 5.48, 0, -0.2)
end

if(intid == 80) then --the eye
Player:Teleport(530, 3088, 1384, 185)
end

if(intid == 81) then --utgarde keep
Player:Teleport(574, 159.2, -84.64, 12.55)
end

if(intid == 82) then --the nexus
Player:Teleport(571, 3783, 6942, 105)
end

if(intid == 83) then --azjolnerub
Player:Teleport(571, 3721, 2155, 37)
end

if(intid == 84) then --ahn'kahet
Player:Teleport(619, 344, -1103, 60.3)
end

if(intid == 85) then --drak'tharon keep
Player:Teleport(571, 4897, 2046, 249)
end

if(intid == 86) then --violet hold
Player:Teleport(608, 1305, 358.6, 1)
end

if(intid == 87) then --gundrak
Player:Teleport(604, 2031, 805, 246)
end

if(intid == 88) then --hall of stone
Player:Teleport(599, 1153, 811, 196)
end

if(intid == 89) then --hall of lightning
Player:Teleport(602, 1333, -237, 41)
end

if(intid == 90) then --the oculus
Player:Teleport(571, 3783, 6942, 105)
end

if(intid == 91) then --culling of stratholme
Player:Teleport(1, -8638, -4382, -207)
end

if(intid == 93) then --utgarde pinnacle
Player:Teleport(575, 570, -327, 111)
end

if(intid == 94) then --trial of the champion
Player:Teleport(1, -3345, -3078, 33)
end


if(intid == 95) then --vault of archavon
Player:Teleport(624, -358.56, -103.28, 104.66)
end


if(intid == 96) then --naxxramas
Player:Teleport(571, 3561, 275, -115)
end


if(intid == 97) then --obisidian sanctum
Player:Teleport(571, 3516.1, 270, -114)
end


if(intid == 98) then --eye of eternity
Player:Teleport(571, 3783, 6942, 105)
end


if(intid == 99) then --ulduar
Player:Teleport(571, 9013, 1114.4, 1165.3)
end

if(intid == 101) then --trial of the crusader
Player:Teleport(1, -3345, -3078, 33)
end

if(intid == 102) then --onyxia's lair
Player:Teleport(249, 29.4, -69.8, -7.3)
end

if(intid == 103) then --Icecrown Citadel
Player:Teleport(571, 6151, 2244, 508)
end

if(intid == 9985) then --craigy109 boss
Player:Teleport(0, -6494.249512, -1438.970, 151.348785)
end

if(intid == 9986) then --Stair event 2
Player:Teleport(0, 3635.850830, -2863.940918, 176.894440)
end

if(intid == 9987) then --Lord Xyolexus
Player:Teleport(0, 3249.593994, -3080.216553, 233.092545)
end

if(intid == 9989) then --Extra Gear
Player:Teleport(1, -2944.935059, 58.211891, 189.913422)
end

if(intid == 9990) then --Dance Floor
Player:Teleport(530, 4173.12, 3057.2, 336.726)
end

if(intid == 9991) then --Ice Rink
Player:Teleport(0, -5102.58, -1668.04, 497.885)
end

if(intid == 9992) then --Swimming Pool
Player:Teleport(0, -8160.3, -368.168, 249.325)
end

if(intid == 9993) then --King Drani World Boss + mini Stair event
Player:Teleport(0, 3603.443115, -2868.502686, 179.966415)
end

if(intid == 9994) then --Gm Help Desk
Player:Teleport(0, -1278.354004, -1204.691162, 40.178349)
end

if(intid == 9995) then --GmIsland Quest Zone
Player:Teleport(1, 16225.783203, 15724.895508, 4.471714)
end

if(intid == 9996) then --Super Power USers
Player:Teleport(0, -4822.056641, -980.121338, 464.708832)
end

if(intid == 9997) then --Stair Event 1
Player:Teleport(0, -7693.741211, 1086.945801, 131.407211)
end


if(intid == 9999) then --Snowball Arena
Player:Teleport(0, -5261.435547, -1541.436279, 497.836823)
end

if(intid == 10001) then --Trade District battle
Player:Teleport(0, -8932.520508, 537.431824, 94.366180)
end

if(intid == 10006) then --Level question
Player:Teleport(37, 973.698120, 504.460785, 253.949112)
end
end

RegisterItemGossipEvent(6948,1,"Item_Trigger")
RegisterItemGossipEvent(6948,2,"OnSelect")