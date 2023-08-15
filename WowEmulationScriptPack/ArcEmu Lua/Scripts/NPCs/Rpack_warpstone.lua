local itemid = test
function Item_Trigger(item, event, player)
    Item_menu(item, player)
end
function Item_menu(item, player)
 
    if (player:IsInCombat() == true) then
    player:SendAreaTriggerMessage("You are in combat!") 
    else                          
    item:GossipCreateMenu(100, player, 0)
	local race=player:GetPlayerRace()
if race==2 or race==5 or race==6 or race==8 or race==10 then
	item:GossipMenuAddItem(4, "Horde Cities",2, 0)
	end
	local race=player:GetPlayerRace()
if race==1 or race==3 or race==4 or race==7 or race==11 then
	item:GossipMenuAddItem(4, "Alliance Cities",1, 0)
	end
	item:GossipMenuAddItem(4, "Neutral Locations",3, 0)
	item:GossipMenuAddItem(4, "Global Locations",4, 0)
	item:GossipMenuAddItem(4, "Azeroth Instances",5, 0)
	item:GossipMenuAddItem(4, "Outland Instances",6, 0)
	item:GossipMenuAddItem(4, "PVP Areas",7, 0)
	item:GossipMenuAddItem(4, "Secret Places",8, 0)
	item:GossipMenuAddItem(4, "Remove Ressurection Sickness",9, 0)
    item:GossipSendMenu(player)
    end
end
function OnSelect(item, event, player, id, intid, code)
	if (intid == 1) then
	item:GossipCreateMenu(99, player, 0)  -- Alliance Citys
	item:GossipMenuAddItem(2, "Stormwind", 10, 0) 
	item:GossipMenuAddItem(2, "Ironforge", 11, 0)
	item:GossipMenuAddItem(2, "Darnassus", 12, 0)
	item:GossipMenuAddItem(2, "The Exodar", 13, 0)
	item:GossipSendMenu(player)
end
	if (intid == 2) then
	item:GossipCreateMenu(99, player, 0)  -- Horde Citys
	item:GossipMenuAddItem(2, "Orgrimmar", 14, 0)
	item:GossipMenuAddItem(2, "The Undercity", 15, 0)
	item:GossipMenuAddItem(2, "Thunder Bluff", 16, 0)
	item:GossipMenuAddItem(2, "Silvermoon", 17, 0)
	item:GossipSendMenu(player)
end
	if (intid == 3) then
	item:GossipCreateMenu(99, player, 0)  -- Neutral Locations
	item:GossipMenuAddItem(2, "Alliance/Horde Mall", 18, 0) -- Just Delete These Next Three If you Dont have Spots to fill in
	item:GossipMenuAddItem(2, "Party Room 1", 19, 0)
	item:GossipMenuAddItem(2, "COMING SOON!", 20, 0)
	item:GossipMenuAddItem(2, "Shattrath", 21, 0)
	item:GossipSendMenu(player)
end
	if (intid == 4) then
	item:GossipCreateMenu(99, player, 0) --Global Locations Sub Menu 
	item:GossipMenuAddItem(2, "Eastern Kingdom", 22, 0)
	item:GossipMenuAddItem(2, "Kalimador", 23, 0)
	item:GossipMenuAddItem(2, "The Outlands", 24, 0)
	item:GossipMenuAddItem(2, "Northrend", 128, 0)
	item:GossipSendMenu(player)
end
	if (intid == 22) then
	item:GossipCreateMenu(99, player, 0) --Eastern Kingdom Page 1
	item:GossipMenuAddItem(2, "Eastern Plaguelands", 25, 0)
	item:GossipMenuAddItem(2, "Western Plaguelands", 26, 0)
	item:GossipMenuAddItem(2, "Tristfall Glades", 114, 0)
	item:GossipMenuAddItem(2, "Alterac Mountains", 27, 0)
	item:GossipMenuAddItem(2, "Silverpine Forest", 28, 0)
	item:GossipMenuAddItem(2, "Hillsbrad Foothills", 29, 0)
	item:GossipMenuAddItem(2, "The Hinterlands", 30, 0)
	item:GossipMenuAddItem(2, "Arathi Highlands", 31, 0)
	item:GossipMenuAddItem(2, "Wetlands", 32, 0)
	item:GossipMenuAddItem(2, "Dun Morogh", 33, 0)
	item:GossipMenuAddItem(2, "Loch Modan", 34, 0)
	item:GossipMenuAddItem(2, "--> Second Page -->", 35, 0)
	item:GossipSendMenu(player)
end
	if (intid == 35) then
	item:GossipCreateMenu(99, player, 0) --Eastern Kingdom Page 2
	item:GossipMenuAddItem(2, "Badlands", 36, 0)
	item:GossipMenuAddItem(2, "Blackrock Mountain", 37, 0)
	item:GossipMenuAddItem(2, "Redridge Mountain", 38, 0)
	item:GossipMenuAddItem(2, "Elwynn Forest", 39, 0)
	item:GossipMenuAddItem(2, "Duskwood", 40, 0)
	item:GossipMenuAddItem(2, "Westfall", 41, 0)
	item:GossipMenuAddItem(2, "Swamp of Sorrows", 42, 0)
	item:GossipMenuAddItem(2, "The Blasted Lands", 43, 0)
	item:GossipMenuAddItem(2, "Deadwind Pass", 44, 0)
	item:GossipMenuAddItem(2, "Stranglethorn Vale", 45, 0)
	item:GossipMenuAddItem(2, "<-- First Page <--", 22, 0)
	item:GossipSendMenu(player)
end
	if (intid == 23) then
	item:GossipCreateMenu(99, player, 0) --Kalimador Page 1
	item:GossipMenuAddItem(2, "Moonglade", 46, 0)
	item:GossipMenuAddItem(2, "Winterspring", 47, 0)
	item:GossipMenuAddItem(2, "Felwood", 48, 0)
	item:GossipMenuAddItem(2, "Darkshore", 49, 0)
	item:GossipMenuAddItem(2, "Azshara", 50, 0)
	item:GossipMenuAddItem(2, "Ashenvale", 51, 0)
	item:GossipMenuAddItem(2, "Stonetalon Mountains", 52, 0)
	item:GossipMenuAddItem(2, "The Barrens", 53, 0)
	item:GossipMenuAddItem(2, "Durotar", 54, 0)
	item:GossipMenuAddItem(2, "--> Second Page -->", 55, 0)
	item:GossipSendMenu(player)
end
	if (intid == 55) then
	item:GossipCreateMenu(99, player, 0) --Kalimador Page 2
	item:GossipMenuAddItem(2, "Mulgore", 56, 0)
	item:GossipMenuAddItem(2, "Desolace", 57, 0)
	item:GossipMenuAddItem(2, "Dustwallow Marsh", 58, 0)
	item:GossipMenuAddItem(2, "Feralas", 59, 0)
	item:GossipMenuAddItem(2, "Thousand Needles", 60, 0)
	item:GossipMenuAddItem(2, "Tanaris Desert", 61, 0)
	item:GossipMenuAddItem(2, "Un'Goro Crater", 62, 0)
	item:GossipMenuAddItem(2, "Silithus", 63, 0)
	item:GossipMenuAddItem(2, "<-- First Page <--", 23, 0)
	item:GossipSendMenu(player)
end
	if (intid == 24) then
	item:GossipCreateMenu(99, player, 0) --Outlands
	item:GossipMenuAddItem(2, "Hellfire Penninsula", 64, 0)
	item:GossipMenuAddItem(2, "Zangermarsh", 65, 0)
	item:GossipMenuAddItem(2, "Nagrand", 66, 0)
	item:GossipMenuAddItem(2, "Blades Edge Mountain", 67, 0)
	item:GossipMenuAddItem(2, "Netherstorm", 68, 0)
	item:GossipMenuAddItem(2, "Terorkkar Forest", 69, 0)
	item:GossipMenuAddItem(2, "Shadowmoon Valley", 70, 0)
	item:GossipMenuAddItem(2, "Isle of Que'l Thas", 114, 0)
	item:GossipSendMenu(player)
end
	if (intid == 128) then
	item:GossipCreateMenu(99, player, 0)
	item:GossipMenuAddItem(2, "Fort Wildervar in Howling Fjord - Alliance", 132, 0)
	item:GossipMenuAddItem(2, "Venture Bay in Grizzly Hills - Alliance", 133, 0)
	item:GossipMenuAddItem(2, "Moonrest Gardens in DragonBlight - Alliance", 134, 0)
	item:GossipMenuAddItem(2, "Vengeance Landing in Howling Fjord - Horde", 135, 0)
	item:GossipMenuAddItem(2, "Conquest Hold in Grizzly Hills - Horde", 136, 0)
	item:GossipMenuAddItem(2, "Agmar's Hammer in DragonBlight - Horde", 137, 0)
	item:GossipMenuAddItem(2, "Kamagua in Howling Fjord - Neutral", 138, 0)
	item:GossipSendMenu(player)
end
	if (intid == 5) then
	item:GossipCreateMenu(99, player, 0) --Azeroth Instances
	item:GossipMenuAddItem(2, "Shadowfang Keep", 71, 0)
	item:GossipMenuAddItem(2, "Scarlet Monastery", 72, 0)
	item:GossipMenuAddItem(2, "Zul'Farrak", 73, 0)
	item:GossipMenuAddItem(2, "Stratholme", 74, 0)
	item:GossipMenuAddItem(2, "Scholomance", 75, 0)
	item:GossipMenuAddItem(2, "Blackrock Spire", 76, 0)
	item:GossipMenuAddItem(2, "Onyxia's Lair", 77, 0)
	item:GossipMenuAddItem(2, "Molten Core", 78, 0)
	item:GossipMenuAddItem(2, "Zul'Gurub", 79, 0)
	item:GossipMenuAddItem(2, "Karazhan", 80, 0)
	item:GossipMenuAddItem(2, "Ahn'Qirai 20", 81, 0)
	item:GossipMenuAddItem(2, "Ahn'Qirai 40", 82, 0)
	item:GossipMenuAddItem(2, "Naxxramas", 83, 0)
	item:GossipMenuAddItem(2, "Caverns of Time", 84, 0)
	item:GossipSendMenu(player)
end
	if (intid == 6) then
	item:GossipCreateMenu(99, player, 0) --Outlands Instances
	item:GossipMenuAddItem(2, "Outlands Raids", 85, 0)
	item:GossipMenuAddItem(2, "Hellfire Ramparts", 86, 0)
	item:GossipMenuAddItem(2, "The Blood Furnace", 87, 0)
	item:GossipMenuAddItem(2, "The Shattered Halls", 88, 0)
	item:GossipMenuAddItem(2, "The Underbog", 89, 0)
	item:GossipMenuAddItem(2, "The Slave Pens", 90, 0)
	item:GossipMenuAddItem(2, "The Steamvault", 91, 0)
	item:GossipMenuAddItem(2, "Mana-Tombs", 92, 0)
	item:GossipMenuAddItem(2, "Auchenai Crypts", 93, 0)
	item:GossipMenuAddItem(2, "Sethekk Halls", 94, 0)
	item:GossipMenuAddItem(2, "Shadow Labyrinth", 95, 0)
	item:GossipMenuAddItem(2, "The Mechanar", 96, 0)
	item:GossipMenuAddItem(2, "The Botanica", 97, 0)
	item:GossipMenuAddItem(2, "The Arcatraz", 98, 0)
	item:GossipSendMenu(player)
end
	if (intid == 85) then
	item:GossipCreateMenu(99, player, 0) --Outlands Raids
	item:GossipMenuAddItem(2, "Magtheridon's Lair", 99, 0)
	item:GossipMenuAddItem(2, "Serpentshrine Cavern", 100, 0)
	item:GossipMenuAddItem(2, "Gruul's Lair", 101, 0)
	item:GossipMenuAddItem(2, "The Eye", 102, 0)
	item:GossipMenuAddItem(2, "Black Temple", 103, 0)
	item:GossipSendMenu(player)
end
	if (intid == 7) then
	item:GossipCreateMenu(99, player, 0) --PVP Areas
	item:GossipMenuAddItem(2, "Battlegrounds (not working)", 104, 0)
	item:GossipMenuAddItem(2, "Arenas", 105, 0)
	item:GossipSendMenu(player)
end
	if (intid == 104) then
	item:GossipCreateMenu(99, player, 0) --Battlegrounds
	item:GossipMenuAddItem(2, "Eye of the Storm", 106, 0)
	item:GossipMenuAddItem(2, "Alterac Valley", 107, 0)
	item:GossipMenuAddItem(2, "Arathi Basin", 108, 0)
	item:GossipMenuAddItem(2, "Warsong Gulch", 109, 0)
	item:GossipSendMenu(player)
end
	if (intid == 105) then
	item:GossipCreateMenu(99, player, 0) --Arenas
	item:GossipMenuAddItem(2, "Gurubashi Arena", 110, 0)
	item:GossipMenuAddItem(2, "Ring of Trials", 111, 0)
	item:GossipMenuAddItem(2, "Circle of Blood", 112, 0)
	item:GossipMenuAddItem(2, "Ring of Valor", 113, 0)
	item:GossipSendMenu(player)
end
if (intid == 8) then
	item:GossipCreateMenu(99, player, 0) --Cool Places
	item:GossipMenuAddItem(2, "Old Ironforge", 115, 0)
	item:GossipMenuAddItem(2, "Crypt", 116, 0)
	item:GossipMenuAddItem(2, "Azhara Crater", 123, 0)
	item:GossipMenuAddItem(2, "Hyjal", 117, 0)
	item:GossipMenuAddItem(2, "Secret troll village", 118, 0)
	item:GossipMenuAddItem(2, "Larce secret crypt", 119, 0)
	item:GossipMenuAddItem(2, "Secret dwarf village", 120, 0)
	item:GossipMenuAddItem(2, "Secret Furbog Huts", 121, 0)
	item:GossipMenuAddItem(2, "Ironforge Airport", 122, 0)
	item:GossipMenuAddItem(2, "Secret Tauren farm", 124, 0)
	item:GossipMenuAddItem(2, "Beta level of undercity", 125, 0)
	item:GossipMenuAddItem(2, "Deepruntram Water", 126, 0)
	item:GossipMenuAddItem(2, "Tanaris Islands", 127, 0)
	item:GossipSendMenu(player)
end
----Northrend----
	if (intid == 132) then
	player:Teleport(571, 2471.3, -5031.1, 284) -- Fort Wildervar
	player:GossipComplete()
	end
	if (intid == 133) then
	player:Teleport(571, 2497.3, -1909.3, 9) -- venture bay
	player:GossipComplete()
	end
	if (intid == 134) then
	player:Teleport(571, 3487.6, 1996.68, 65) -- Moonrest Gardens
	player:GossipComplete()
	end
	if (intid == 135) then
	player:Teleport(571, 1922.9, -6171.1, 24) -- Vengeance Landing
	player:GossipComplete()
	end
	if (intid == 136) then
	player:Teleport(571, 3147.3, -2246.42, 112) -- Conquest Hold
	player:GossipComplete()
	end
	if (intid == 137) then
	player:Teleport(571, 3748, 1521, 90) -- Agmar's Hammer
	player:GossipComplete()
	end
	if (intid == 138) then
	player:Teleport(571, 772.7, -2880.6, 4) -- Kamagua
	player:GossipComplete()
	end
----Alliance Citys----
    if (intid == 10) then -- Stormwind
    player:Teleport(0, -9100.480469, 406.950745, 92.594185)
    player:GossipComplete()
    end
	if (intid == 11) then -- Ironforge
    player:Teleport(0, -5028.265137, -825.976563, 495.301575)
    player:GossipComplete()
    end
	if (intid == 12) then -- Darnassus
    player:Teleport(1, 9985.907227, 1971.155640, 1326.815674)
    player:GossipComplete()
    end
	if (intid == 13) then -- The Exodar
    player:Teleport(530, -4072.202393, -12014.337891, -1.277277)
    player:GossipComplete()
    end
----Horde Citys----
	if (intid == 14) then -- Orgrimmar
    player:Teleport(1, 1371.068970, -4370.801758, 26.052483)
    player:GossipComplete()
    end
	if (intid == 15) then -- The Undercity
    player:Teleport(0, 2050.203125, 285.650604, 56.994549)
    player:GossipComplete()
    end
	if (intid == 16) then -- Thunder Bluff
    player:Teleport(1, -1304.569946, 205.285004, 68.681396)
    player:GossipComplete()
    end
	if (intid == 17) then -- Silvermoon
    player:Teleport(530, 9400.486328, -7278.376953, 14.206780)
    player:GossipComplete()
    end
----Neutral Locations----
	if (intid == 18) then -- Terrormall
    player:Teleport(572, 1067.985840, 1458.041382, 33.691071)
    player:GossipComplete()
    end
	if (intid == 19) then -- Party Room 1
    player:Teleport(1, -8674.880859, 1956.348755, 109.123428)
    player:GossipComplete()
    end
	if (intid == 20) then -- Coming SOon
    player:Teleport(530, 9400.486328, -7278.376953, 14.206780)
    player:GossipComplete()
    end
	if (intid == 21) then -- Shattrath
    player:Teleport(530, -1887.510010, 5359.379883, -12.427300)
    player:GossipComplete()
    end
----Eastern Kindom----
	if (intid == 25) then -- Eastern Plaguelands
    player:Teleport( 0, 2278, -5311, 89)
    player:GossipComplete()
    end
	if (intid == 26) then -- Western Plaguelands
    player:Teleport( 0, 1855, -1569, 61)
    player:GossipComplete()
    end
	if (intid == 114) then --Tristfall Glades
    player:Teleport( 0, 552, -275, 152)
    player:GossipComplete()
    end
	if (intid == 27) then -- Alterac Mountains
    player:Teleport( 0, 552, -275, 152)
    player:GossipComplete()
    end
	if (intid == 28) then -- Silverpine Forest
    player:Teleport( 0, -126, 815, 68);
    player:GossipComplete()
    end
	if (intid == 29) then -- Hillsbrad
    player:Teleport( 0, -502, 91, 61);
    player:GossipComplete()
    end
	if (intid == 30) then -- The Hinterlands
    player:Teleport( 0, -678, -4018, 240);
    player:GossipComplete()
    end
	if (intid == 31) then -- Arathi Higlands
    player:Teleport( 0, -797, -2068, 35);
    player:GossipComplete()
    end
	if (intid == 32) then -- Wetlands
    player:Teleport( 0, -3256, -2718, 11);
    player:GossipComplete()
    end
	if (intid == 33) then -- Dun Morogh
    player:Teleport(0, -5826, -1586, 366);
    player:GossipComplete()
    end
	if (intid == 34) then -- Lochmodan
    player:Teleport( 0, -4771, -3329, 347);
    player:GossipComplete()
    end
	if (intid == 36) then -- Bad lands
    player:Teleport ( 0, -7027, -3330, 243);
    player:GossipComplete()
    end
	if (intid == 37) then -- Black Rock Mountain
    player:Teleport( 0, -7317, -1072, 279);
    player:GossipComplete()
    end
	if (intid == 38) then -- Red Ridge Mountain
    player:Teleport( 0, -9168, -2726, 92);
    player:GossipComplete()
    end
	if (intid == 39) then -- Elwynn Forest
    player:Teleport( 0, -9325, -1038, 67);
    player:GossipComplete()
    end
	if (intid == 40) then -- Duskwood
    player:Teleport( 0, -10694, -884, 80);
    player:GossipComplete()
    end
	if (intid == 41) then -- Westfall
    player:Teleport( 0, -11018, 1513, 45);
    player:GossipComplete()
    end
	if (intid == 42) then -- Swamp of Sorrows
    player:Teleport( 0, -10429, -3828, -29);
    player:GossipComplete()
    end
	if (intid == 43) then -- Blasted Lands
    player:Teleport( 0, -11853, -3197, -25);
    player:GossipComplete()
    end
	if (intid == 44) then -- Deadwind Pass
    player:Teleport( 0, -10435, -1809, 101);
    player:GossipComplete()
    end
	if (intid == 45) then -- Staglethorn Vale
    player:Teleport( 0, -13382, 2, 23);
    player:GossipComplete()
    end
	----Kalimador----
	if (intid == 46) then -- Moonglade
    player:Teleport( 1, 7978, -2501, 490);
    player:GossipComplete()
    end
	if (intid == 47) then -- Winterspring
    player:Teleport( 1, 6721, -4659, 722);
    player:GossipComplete()
    end
	if (intid == 48) then -- Felwood
    player:Teleport( 1, 4878, -614, 362);
    player:GossipComplete()
    end
	if (intid == 49) then -- Darsk Shore
    player:Teleport( 1, 4565, 438, 34);
    player:GossipComplete()
    end
	if (intid == 50) then -- Azshara
    player:Teleport( 1, 2717, -5968, 108);
    player:GossipComplete()
    end
	if (intid == 51) then -- Ashenvale
    player:Teleport( 1, 3469, 847, 7);
    player:GossipComplete()
    end
	if (intid == 52) then -- Stonetalon
    player:Teleport( 1, 898, 922, 128);
    player:GossipComplete()
    end
	if (intid == 53) then -- The Barrens 
    player:Teleport( 1, -1330, -3120, 93);
    player:GossipComplete()
    end
	if (intid == 54) then -- Durotar
    player:Teleport( 1, 242, -5151, 3);
    player:GossipComplete()
    end
	if (intid == 56) then -- Mulgore
    player:Teleport(1, -2326, -367, -6);
    player:GossipComplete()
    end
	if (intid == 57) then -- Desolace
    player:Teleport( 1, -939, 1091, 95);
    player:GossipComplete()
    end
	if (intid == 58) then -- Dustwallow
    player:Teleport( 1, -3719, -2530, 71);
    player:GossipComplete()
    end
	if (intid == 59) then --Feralas
    player:Teleport( 1, -4508, 2041, 53);
    player:GossipComplete()
    end
	if (intid == 60) then -- Thousand Needles
    player:Teleport( 1, -4619, -1850, 88);
    player:GossipComplete()
    end
	if (intid == 61) then -- Tanaris
    player:Teleport( 1, -7373, -2950, 12);
    player:GossipComplete()
    end
	if (intid == 62) then -- Ungoro
    player:Teleport( 1, -6186, -1106, -215);
    player:GossipComplete()
    end
	if (intid == 63) then -- Silithus
    player:Teleport( 1, -6824, 821, 51);
    player:GossipComplete()
    end
	----Outlands Locations----
	if (intid == 64) then -- Hellfire Peninsula
    player:Teleport(530, -248.160004, 922.348999, 84.379799);
    player:GossipComplete()
    end
	if (intid == 65) then -- Zangermarsh
    player:Teleport(530, -225.863632, 5405.927246, 22.346397);
    player:GossipComplete()
    end
	if (intid == 66) then -- Nagrand
    player:Teleport(530, -468.232330, 8418.666016, 28.031298);
    player:GossipComplete()
    end
	if (intid == 67) then -- Blades Edge Mountains
    player:Teleport(530, 1471.672852, 6828.047852, 107.759239);
    player:GossipComplete()
    end
	if (intid == 68) then -- Netherstorm
    player:Teleport(530, 3396.123779, 4182.208008, 137.097992);
    player:GossipComplete()
    end
	if (intid == 69) then -- Terokkar Forest
    player:Teleport(530, -1202.426636, 5313.692871, 33.774723);
    player:GossipComplete()
    end
	if (intid == 70) then -- Shadowmoon Valley
    player:Teleport(530, -2859.522461, 3182.34773, 10.008426);
    player:GossipComplete()
    end
	if (intid == 114) then -- Isle of Que'l Thas
    player:Teleport(530, 12930, -6971.437988, 18.942474);
    player:GossipComplete()
    end
	----Azeroth Instances----
	if (intid == 71) then -- Shadowfang Keep
    player:Teleport(0, -234.495087, 1561.946411, 76.892143);
    player:GossipComplete()
    end
	if (intid == 72) then -- Scarlet Monastery
    player:Teleport(0, 2870.442627, -819.985229, 160.331085);
    player:GossipComplete()
    end
	if (intid == 73) then -- Zul'Farak
    player:Teleport(1, -6797.278809, -2903.917969, 9.953360);
    player:GossipComplete()
    end
	if (intid == 74) then -- Zul'Gurub
    player:Teleport(0, -11919.073242, -1202.459374, 92.298744);
    player:GossipComplete()
    end
	if (intid == 75) then --Ahn'Qirai 20
    player:Teleport(1, -8394.730469, 1485.658447, 21.038563);
    player:GossipComplete()
    end
	if (intid == 76) then -- Ahn'Qirai 40
    player:Teleport(1, -8247.316406, 1970.156860, 129.071472);
    player:GossipComplete()
    end
	if (intid == 77) then -- Molten Core
    player:Teleport(409, 1089.6, -470.19, -106.41);
    player:GossipComplete()
    end
	if (intid == 78) then -- Onyxia's Lair
    player:Teleport(249, 30.0, -64.0, -5.0);
    player:GossipComplete()
    end
	if (intid == 79) then -- Naxxaramas
    player:Teleport(533, 3006.06, -3436.72, 293.891);
    player:GossipComplete()
    end
	if (intid == 80) then -- Scholomance
    player:Teleport(0, 1267.468628, -2556.651367, 94.127983);
    player:GossipComplete()
    end
	if (intid == 81) then -- Stratholme
    player:Teleport(0, 3359.111572, -3380.8444238, 144.781860);
    player:GossipComplete()
    end
	if (intid == 82) then -- Black Rock Spire
    player:Teleport(0, -7527.129883, -1224.997437, 285.733002);
    player:GossipComplete()
    end
	if (intid == 83) then -- Kharazan
    player:Teleport(532, -11087.3, -1977.47, 49.6135);
    player:GossipComplete()
    end
	if (intid == 84) then -- Caverns of Time
    player:Teleport(1, -8519.718750, -4297.542480, -208.441376);
    player:GossipComplete()
    end
	----Outland Intances----
	if (intid == 86) then -- Hellfire Ramparts
    player:Teleport(530, -360.670990, 3071.899902, -15.097700);
    player:GossipComplete()
    end
	if (intid == 87) then -- Blood Furnace
    player:Teleport(530, -303.506012, 3164.820068, 31.742500);
    player:GossipComplete()
    end
	if (intid == 88) then -- Shattered Halls
    player:Teleport(530, -311.083527, 3083.291748, -3.745923);
    player:GossipComplete()
    end
	if (intid == 89) then -- Underbog
    player:Teleport(530, 777.088989, 6763.450195, -72.062561);
    player:GossipComplete()
    end
	if (intid == 90) then -- Slave Pens
    player:Teleport(530, 719.507996, 6999.339844, -73.074303);
    player:GossipComplete()
    end
	if (intid == 91) then -- Steamvault
    player:Teleport(530, 816.590027, 6934.669922, -80.544601);
    player:GossipComplete()
    end
	if (intid == 92) then -- Mana tombs
    player:Teleport(530, -3079.810059, 4943.040039, -101.046997);
    player:GossipComplete()
    end
	if (intid == 93) then -- Auchenai Crypts
    player:Teleport(530, -3361.959961, 5225.770020, -101.047997);
    player:GossipComplete()
    end
	if (intid == 94) then -- Sethekk Halls
    player:Teleport(530, -3362.219971, 4660.410156, -101.049004);
    player:GossipComplete()
    end
	if (intid == 95) then -- Shadow Labyrinth
    player:Teleport(530, -3645.060059, 4943.620117, -101.047997);
    player:GossipComplete()
    end
	if (intid == 96) then -- The Mechanar
    player:Teleport(530, 2862.409912, 1546.089966, 252.158691);
    player:GossipComplete()
    end
	if (intid == 97) then -- The Botanica
    player:Teleport(530, 3413.649902, 1483.319946, 182.837997);
    player:GossipComplete()
    end
	if (intid == 98) then -- The Alcatraz
    player:Teleport(530, 3311.598145, 1332.745117, 505.557251);
    player:GossipComplete()
    end
	----Outlands Raids----
	if (intid == 99) then -- Magtheridons Lair
    player:Teleport(530, -313.678986, 3088.350098, -116.501999);
    player:GossipComplete()
    end
	if (intid == 100) then -- Serpentshrine Caverns
    player:Teleport(530, 830.542908, 6865.445801, -63.785503);
    player:GossipComplete()
    end
	if (intid == 101) then --Gruul's Lair
    player:Teleport(530, 3549.424072, 5179.854004, -4.430779);
    player:GossipComplete()
    end
	if (intid == 102) then -- The Eye
    player:Teleport(530, 3087.310059, 1373.790039, 184.643005);
    player:GossipComplete()
    end
	if (intid == 103) then -- Black Temple
    player:Teleport(564, 97.0894, 1001.96, -86.8798);
    player:GossipComplete()
    end
	----PVP AREAS----
	----Battlegrounds
	if (intid == 106) then --Eye of the storm
    player:Teleport(550, 183.159, -0.782332, -2.43013);
    player:GossipComplete()
    end
	if (intid == 107) then --Alterac Valley
    player:Teleport(30, 628.53, -207.67, 39.0523);
    player:GossipComplete()
    end
	if (intid == 108) then --Arathi Basin
    player:Teleport(529, 1181.62, 1183.39, -45.329);
    player:GossipComplete()
    end
	if (intid == 109) then --Warsong Gulch
    player:Teleport(48, -152.984, 106.33, -40.0953);
    player:GossipComplete()
    end
	----Arenas----
	if (intid == 110) then --Gurabashi Arena
    player:Teleport(0, -13236.3114, 212.1922, 31.0258);
    player:GossipComplete()
    end
	if (intid == 111) then --Ring of Trials
    player:Teleport(530, -2099.831543, 6739.550293, -2.014147);
    player:GossipComplete()
    end
	if (intid == 112) then --Circle of Blood
    player:Teleport(530, 2905.815674, 5982.974609, 0.919953);
    player:GossipComplete()
    end
	if (intid == 113) then --Ring of Valor
    player:Teleport(1, 2206.395752, -4739.570313, 54.911106 );
    player:GossipComplete()
    end
	----Secret Spots----
	if (intid == 115) then --Old Ironforge
    player:Teleport(0, -4815.6, -1033.32, 438.683);
    player:GossipComplete()
    end
	if (intid == 116) then --Crypt
    player:Teleport(0, -6554, -3499, 293);
    player:GossipComplete()
    end
	if (intid == 117) then --Hyjal
    player:Teleport(1, 4674.8798, -3638.3701, 966.2639);
    player:GossipComplete()
    end
	if (intid == 118) then --Secret Troll village
    player:Teleport(1, 7441, -1618, 200);
    player:GossipComplete()
    end
	if (intid == 119) then --large secret crypt
    player:Teleport(0, -11072, -1800, 53);
    player:GossipComplete()
    end
	if (intid == 120) then --Secret Dwarf Village
    player:Teleport(0, -3968, -1389, 160);
    player:GossipComplete()
    end
	if (intid == 121) then --Secret Furblog Huts
    player:Teleport(1, 9712, -14, 18);
    player:GossipComplete()
    end
	if (intid == 122) then --Ironforge Airport
    player:Teleport(0, -4653.808105, -1688.603882, 503.324615);
    player:GossipComplete()
    end
	if (intid == 123) then --Azhara Crater
    player:Teleport(37, 58, 23, 266);
    player:GossipComplete()
    end
	if (intid == 124) then --Secret Tauren Farm
    player:Teleport(1, -10735, 2463, 7);
    player:GossipComplete()
    end
	if (intid == 125) then --Beta level of undercity
    player:Teleport(0, 1659, 175, -41);
    player:GossipComplete()
    end
	if (intid == 126) then --Deepruntram Water
    player:Teleport(369, -63.065926, 1369.090942, -125.195541);
    player:GossipComplete()
    end
	if (intid == 127) then --Tanaris Islands
    player:Teleport(1, -11805, -4754, 6);
    player:GossipComplete()
    end
	---Spells and other stuff----
	if (intid == 9) then
    if(player:HasAura(15007) == true) then
    player:RemoveAura(15007)
    player:SendBroadcastMessage("You have been cured of that wretched sickness!")
    else
    player:SendBroadcastMessage("You do not currently have Resurrection Sickness!")
    end
    player:GossipComplete()
    end
end

RegisterItemGossipEvent(test,1,"Item_Trigger")
RegisterItemGossipEvent(test,2,"OnSelect")
