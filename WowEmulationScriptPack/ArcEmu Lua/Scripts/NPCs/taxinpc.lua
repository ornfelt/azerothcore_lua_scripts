local npcid = 900011
function WarpNPC_OnGossipTalk(pUnit, event, player, pMisc)
	pUnit:VendorRemoveAllItems()
	if (player:IsInCombat() == true) then
		player:SendAreaTriggerMessage("You are in combat!") 
	else 
		pUnit:GossipCreateMenu(3544, player, 0)
		local race=player:GetPlayerRace()
		if race==1 or race==3 or race==4 or race==7 or race==11 then
			pUnit:GossipMenuAddItem(3, "Alliance Cities", 1, 0)
		end
		local race=player:GetPlayerRace()
		if race==2 or race==5 or race==6 or race==8 or race==10 then
			pUnit:GossipMenuAddItem(3, "Horde Cities", 2, 0)
		end
		pUnit:GossipMenuAddItem(3, "|cFF008080Eastern Kingdom Locations", 3, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080Outland Locations", 5, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080Outland Instances", 7, 0)
		pUnit:GossipMenuAddItem(1, "|cFF008080Custom Bosses", 1992, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080WOTLK Locations", 8, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080WOTLK Instances", 9, 0)
		pUnit:GossipMenuAddItem(4, "|cFF008080Remove Resurrection Sickness", 998, 0)
		pUnit:GossipMenuAddItem(4, "|cFF008080Repair All Items", 909, 0)
		pUnit:GossipMenuAddItem(4, "|cFF008080Restore My Health", 908, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080Custom Instances", 14,  0)
		pUnit:GossipMenuAddItem(1, "|cFF0000ccArena!", 907,  0)

		pUnit:GossipSendMenu(player)
	end
end

function WarpNPC_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
	if(intid == 999) then
		pUnit:GossipCreateMenu(99, player, 0)
		local race=player:GetPlayerRace()
		if race==1 or race==3 or race==4 or race==7 or race==11 then
			pUnit:GossipMenuAddItem(3, "Alliance Cities", 1, 0)
		end
		local race=player:GetPlayerRace()
		if race==2 or race==5 or race==6 or race==8 or race==10 then
			pUnit:GossipMenuAddItem(3, "Horde Cities", 2, 0)
		end
		pUnit:GossipMenuAddItem(3, "|cFF008080Eastern Kingdom Locations", 3, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080Outland Locations", 5, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080Outland Instances", 7, 0)
		pUnit:GossipMenuAddItem(1, "|cFF008080Custom Bosses", 1992, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080WOTLK Locations", 8, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080WOTLK Instances", 9, 0)
		pUnit:GossipMenuAddItem(4, "|cFF008080Remove Resurrection Sickness", 998, 0)
		pUnit:GossipMenuAddItem(4, "|cFF008080Repair All Items.", 909, 0)
		pUnit:GossipMenuAddItem(4, "|cFF008080Restore My Health", 908, 0)
		pUnit:GossipMenuAddItem(3, "|cFF008080Custom Instances", 14,  0)
		pUnit:GossipMenuAddItem(1, "|cFF0000ccArena!", 907,  0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 1) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Stormwind", 300, 0)
		pUnit:GossipMenuAddItem(1, "Ironforge", 301, 0)
		pUnit:GossipMenuAddItem(1, "Darnassus", 302, 0)
		pUnit:GossipMenuAddItem(1, "Exodar", 303, 0)
		pUnit:GossipMenuAddItem(1, "Mall", 418, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 2) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Orgrimmar", 304, 0)
		pUnit:GossipMenuAddItem(1, "Thunder Bluff", 305, 0)
		pUnit:GossipMenuAddItem(1, "Undercity", 306, 0)
		pUnit:GossipMenuAddItem(1, "Silvermoon", 307, 0)
		pUnit:GossipMenuAddItem(1, "Mall", 419, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 3) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Alterac Mountains", 308, 0)
		pUnit:GossipMenuAddItem(1, "Arathi Highlands", 309, 0)
		pUnit:GossipMenuAddItem(1, "Badlands", 310, 0)
		pUnit:GossipMenuAddItem(1, "Burning Steppes", 311, 0)
		pUnit:GossipMenuAddItem(1, "Deadwind Pass", 312, 0)
		pUnit:GossipMenuAddItem(1, "Dun Morogh", 313, 0)
		pUnit:GossipMenuAddItem(1, "Duskwood", 314, 0)
		pUnit:GossipMenuAddItem(1, "Eastern Plaguelands", 315, 0)
		pUnit:GossipMenuAddItem(1, "Elwynn Forest", 316, 0)
		pUnit:GossipMenuAddItem(1, "Eversong Woods", 317, 0)
		pUnit:GossipMenuAddItem(1, "Ghostlands", 318, 0)
		pUnit:GossipMenuAddItem(1, "Hillsbrad Foothills", 319, 0)
		pUnit:GossipMenuAddItem(1, "Hinterlands", 320, 0)
		pUnit:GossipMenuAddItem(1, "Loch Modan", 321, 0)
		pUnit:GossipMenuAddItem(0, "--> Page 2 -->", 10, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 4) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Custom PvP Arena", 331, 0)
		pUnit:GossipMenuAddItem(1, "Azshara", 332, 0)
		pUnit:GossipMenuAddItem(1, "Azuremyst Isle", 333, 0)
		pUnit:GossipMenuAddItem(1, "Bloodmyst Isle", 334, 0)
		pUnit:GossipMenuAddItem(1, "Darkshore", 335, 0)
		pUnit:GossipMenuAddItem(1, "Durotar", 336, 0)
		pUnit:GossipMenuAddItem(1, "Desolace", 337, 0)
		pUnit:GossipMenuAddItem(1, "Dustwallow Marsh", 338, 0)
		pUnit:GossipMenuAddItem(1, "Felwood", 339, 0)
		pUnit:GossipMenuAddItem(1, "Feralas", 340, 0)
		pUnit:GossipMenuAddItem(1, "Moonglade", 341, 0)
		pUnit:GossipMenuAddItem(1, "Mulgore", 342, 0)
		pUnit:GossipMenuAddItem(1, "Silithus", 343, 0)
		pUnit:GossipMenuAddItem(1, "Stonetalon Mountains", 344, 0)
		pUnit:GossipMenuAddItem(0, "--> Page 2 -->", 11, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 5) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Blade's Edge Mountains", 351, 0)
		pUnit:GossipMenuAddItem(1, "Hellfire Peninsula", 352, 0)
		pUnit:GossipMenuAddItem(1, "Nagrand", 353, 0)
		pUnit:GossipMenuAddItem(1, "Netherstorm", 354, 0)
		pUnit:GossipMenuAddItem(1, "Shadowmoon Valley", 355, 0)
		pUnit:GossipMenuAddItem(1, "Terokkar Forest", 356, 0)
		pUnit:GossipMenuAddItem(1, "Zangarmarsh", 357, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 6) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Crypt Of Exile", 358, 0)
		pUnit:GossipMenuAddItem(1, "Blackfathom Depths", 359, 0)
		pUnit:GossipMenuAddItem(1, "Blackrock Depths", 360, 0)
		pUnit:GossipMenuAddItem(1, "Blackrock Spire", 361, 0)
		pUnit:GossipMenuAddItem(1, "Blackwing Lair", 362, 0)
		pUnit:GossipMenuAddItem(1, "Caverns of Time", 363, 0)
		pUnit:GossipMenuAddItem(1, "Deadmines", 364, 0)
		pUnit:GossipMenuAddItem(1, "Dire Maul", 365, 0)
		pUnit:GossipMenuAddItem(1, "Gnomeregan", 366, 0)
		pUnit:GossipMenuAddItem(1, "Maraudon", 367, 0)
		pUnit:GossipMenuAddItem(1, "Molten Core", 368, 0)
		pUnit:GossipMenuAddItem(1, "Onyxia's Lair", 369, 0)
		pUnit:GossipMenuAddItem(1, "Ragefire Chasm", 370, 0)
		pUnit:GossipMenuAddItem(0, "--> Page 2 -->", 12, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 7) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(0, "Outland Raids", 13, 0)
		pUnit:GossipMenuAddItem(1, "Auchenai Crypts", 383, 0)
		pUnit:GossipMenuAddItem(1, "Coilfang Reservoir", 385, 0)
		pUnit:GossipMenuAddItem(1, "Hellfire Ramparts", 387, 0)
		pUnit:GossipMenuAddItem(1, "Mana Tombs", 388, 0)
		pUnit:GossipMenuAddItem(1, "Pheonix Hall", 389, 0)
		pUnit:GossipMenuAddItem(1, "Sethekk Halls", 390, 0)
		pUnit:GossipMenuAddItem(1, "Shadow Labyrinth", 391, 0)
		pUnit:GossipMenuAddItem(1, "The Blood Furnace", 423, 0)
		pUnit:GossipMenuAddItem(1, "The Botanica", 392, 0)
		pUnit:GossipMenuAddItem(1, "The Mechanar", 393, 0)
		pUnit:GossipMenuAddItem(1, "The Shattered Halls", 425, 0)
		pUnit:GossipMenuAddItem(1, "The Slave Pens", 426, 0)
		pUnit:GossipMenuAddItem(1, "The Steamvault", 427, 0)
		pUnit:GossipMenuAddItem(1, "The Underbog", 428, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 8) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Dalaran", 403, 0)
		pUnit:GossipMenuAddItem(1, "DK Start Zone", 405, 0)
		pUnit:GossipMenuAddItem(1, "Borean Tundra", 394, 0)
		pUnit:GossipMenuAddItem(1, "Crystalsong Forest", 404, 0)
		pUnit:GossipMenuAddItem(1, "Dragonblight", 395, 0)
		pUnit:GossipMenuAddItem(1, "Grizzly Hills", 396, 0)
		pUnit:GossipMenuAddItem(1, "Howling Fjord", 397, 0)
		pUnit:GossipMenuAddItem(1, "Icecrown", 398, 0)
		pUnit:GossipMenuAddItem(1, "Sholazar Basin", 399, 0)
		pUnit:GossipMenuAddItem(1, "Storm Peaks", 400, 0)
		pUnit:GossipMenuAddItem(1, "Wintergrasp", 401, 0)
		pUnit:GossipMenuAddItem(1, "Zul'Drak", 402, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 9) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Azjol'Nerub", 406, 0)
		pUnit:GossipMenuAddItem(1, "Drak'Tharon", 407, 0)
		pUnit:GossipMenuAddItem(1, "Gun'Drak", 408, 0)
		pUnit:GossipMenuAddItem(1, "Icecrown Citadel", 409, 0)
		pUnit:GossipMenuAddItem(1, "Naxxaramas", 410, 0)
		pUnit:GossipMenuAddItem(1, "Obsidian Sanctum", 411, 0)
		pUnit:GossipMenuAddItem(1, "The Nexus/Occulus/Eye of Eternity", 412, 0)
		pUnit:GossipMenuAddItem(1, "Halls of Stone/Halls of Lightning", 413, 0)
		pUnit:GossipMenuAddItem(1, "Utgarde Keep", 414, 0)
		pUnit:GossipMenuAddItem(1, "Utgarde Pinnacle", 415, 0)
		pUnit:GossipMenuAddItem(1, "Vault of Archevon", 416, 0)
		pUnit:GossipMenuAddItem(1, "Violet Hold", 417, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 1337) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "[UNFINISHED] Maze", 1339, 0)
		pUnit:GossipMenuAddItem(1, "Bullets, Arrows and Reagents", 10101, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if (intid == 10101) then
		pUnit:GossipMenuAddItem(1, "Bullets and Arrows", 700, 0)
		pUnit:GossipMenuAddItem(1, "Reagents", 701, 0)
		pUnit:GossipSendMenu(player)
	end
	if (intid == 700) then
		pUnit:VendorAddItem(41164,1,0)
		pUnit:VendorAddItem(41165,1,0) 
		pUnit:VendorAddItem(41584,1,0) 
		pUnit:VendorAddItem(41586,1,0) 
		pUnit:VendorAddItem(52021,1,0) 
		pUnit:VendorAddItem(52020,1,0) 
		pUnit:VendorAddItem(32760,1,0) 
		pUnit:VendorAddItem(32761,1,0) 
		pUnit:VendorAddItem(32882,1,0) 
		pUnit:VendorAddItem(32883,1,0) 
		pUnit:VendorAddItem(33803,1,0) 
		pUnit:VendorAddItem(34581,1,0) 
		pUnit:VendorAddItem(34582,1,0) 
		pUnit:VendorAddItem(29885,1,0) 
		pUnit:VendorAddItem(30319,1,0) 
		pUnit:VendorAddItem(30611,1,0) 
		pUnit:VendorAddItem(30612,1,0) 
		pUnit:VendorAddItem(28053,1,0) 
		pUnit:VendorAddItem(28056,1,0) 
		pUnit:VendorAddItem(28060,1,0) 
		pUnit:VendorAddItem(28061,1,0) 
		pUnit:VendorAddItem(31735,1,0) 
		pUnit:VendorAddItem(31737,1,0) 
		pUnit:VendorAddItem(31949,1,0) 
		pUnit:VendorAddItem(2512,1,0) 
		pUnit:VendorAddItem(2515,1,0) 
		pUnit:VendorAddItem(2516,1,0) 
		pUnit:VendorAddItem(2519,1,0) 
		pUnit:VendorAddItem(8067,1,0) 
		pUnit:VendorAddItem(8068,1,0) 
		pUnit:VendorAddItem(8069,1,0) 
		pUnit:VendorAddItem(9399,1,0) 
		pUnit:VendorAddItem(12654,1,0) 
		pUnit:VendorAddItem(13377,1,0) 
		pUnit:VendorAddItem(10512,1,0) 
		pUnit:VendorAddItem(10513,1,0)  
		pUnit:VendorAddItem(10579,1,0) 
		pUnit:VendorAddItem(11284,1,0) 
		pUnit:VendorAddItem(11285,1,0) 
		pUnit:VendorAddItem(11630,1,0) 
		pUnit:VendorAddItem(4960,1,0) 
		pUnit:VendorAddItem(5568,1,0) 
		pUnit:VendorAddItem(3030,1,0) 
		pUnit:VendorAddItem(3033,1,0) 
		pUnit:VendorAddItem(3034,1,0) 
		pUnit:VendorAddItem(3464,1,0) 
		pUnit:VendorAddItem(3465,1,0) 
		pUnit:VendorAddItem(18042,1,0)
		pUnit:VendorAddItem(19316,1,0) 
		pUnit:VendorAddItem(19317,1,0) 
		pUnit:VendorAddItem(24412,1,0) 
		pUnit:VendorAddItem(24417,1,0)  
		pUnit:VendorAddItem(23772,1,0) 
		pUnit:VendorAddItem(23773,1,0) 
		pUnit:VendorAddItem(15997,1,0) 
		pUnit:GossipCreateMenu(100, player, 0)
		pUnit:GossipMenuAddItem(0,"Continue",99,0)
		pUnit:GossipMenuAddItem(4,"Main Menu",999,0)
		pUnit:GossipSendMenu(player)
	end
	if (intid == 701) then
		pUnit:VendorAddItem(5178,1,0) 
		pUnit:VendorAddItem(7030,1,0) 
		pUnit:VendorAddItem(17020,1,0)
		pUnit:VendorAddItem(17036,1,0)
		pUnit:VendorAddItem(37201,1,0)
		pUnit:VendorAddItem(16583,1,0)
		pUnit:VendorAddItem(44615,1,0)
		pUnit:VendorAddItem(5175,1,0)
		pUnit:VendorAddItem(5176,1,0)
		pUnit:VendorAddItem(17058,1,0)
		pUnit:VendorAddItem(22147,1,0)
		pUnit:VendorAddItem(17028,1,0)
		pUnit:VendorAddItem(17037,1,0)
		pUnit:VendorAddItem(5565,1,0)
		pUnit:VendorAddItem(17038,1,0)
		pUnit:VendorAddItem(17056,1,0)
		pUnit:VendorAddItem(17034,1,0)
		pUnit:VendorAddItem(17032,1,0)
		pUnit:VendorAddItem(17031,1,0)
		pUnit:VendorAddItem(17029,1,0)
		pUnit:VendorAddItem(17057,1,0)
		pUnit:VendorAddItem(6265,1,0)
		pUnit:VendorAddItem(44614,1,0)
		pUnit:VendorAddItem(17035,1,0)
		pUnit:VendorAddItem(17033,1,0)
		pUnit:VendorAddItem(21177,1,0)
		pUnit:VendorAddItem(5060,1,0)
		pUnit:VendorAddItem(5517,1,0)
		pUnit:VendorAddItem(5518,1,0)
		pUnit:VendorAddItem(5177,1,0)
		pUnit:VendorAddItem(17021,1,0)
		pUnit:VendorAddItem(22148,1,0)
		pUnit:VendorAddItem(44605,1,0)
		pUnit:VendorAddItem(17026,1,0)
		pUnit:GossipCreateMenu(101, player, 0)
		pUnit:GossipMenuAddItem(0,"Continue",99,0)
		pUnit:GossipMenuAddItem(4,"Main Menu",999,0)
		pUnit:GossipSendMenu(player)
	end
	if (intid == 700) then
		player:SendVendorWindow(pUnit)
	end
	if (intid == 701) then
		player:SendVendorWindow(pUnit)
	end
	if(intid == 10) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Searing Gorge", 322, 0)
		pUnit:GossipMenuAddItem(1, "Silverpine Forest", 323, 0)
		pUnit:GossipMenuAddItem(1, "Stranglethorn Vale", 324, 0)
		pUnit:GossipMenuAddItem(1, "Swamp of Sorrows", 325, 0)
		pUnit:GossipMenuAddItem(1, "The Blasted Lands", 326, 0)
		pUnit:GossipMenuAddItem(1, "Trisfal Glades", 327, 0)
		pUnit:GossipMenuAddItem(1, "Western Plaguelands", 328, 0)
		pUnit:GossipMenuAddItem(1, "Westfall", 329, 0)
		pUnit:GossipMenuAddItem(1, "Wetlands", 330, 0)
		pUnit:GossipMenuAddItem(0, "<-- Page 1 <--", 3, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 11) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Tanaris", 345, 0)
		pUnit:GossipMenuAddItem(1, "Teldrassil", 346, 0)
		pUnit:GossipMenuAddItem(1, "The Barrens", 347, 0)
		pUnit:GossipMenuAddItem(1, "Thousand Needles", 348, 0)
		pUnit:GossipMenuAddItem(1, "Un Goro Crater", 349, 0)
		pUnit:GossipMenuAddItem(1, "Winterspring", 350, 0)
		pUnit:GossipMenuAddItem(0, "<-- Page 1 <--", 4, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 12) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Razorfen Downs", 371, 0)
		pUnit:GossipMenuAddItem(1, "Razorfen Kraul", 372, 0)
		pUnit:GossipMenuAddItem(1, "Scarlet Monestary", 373, 0)
		pUnit:GossipMenuAddItem(1, "Scholomance", 374, 0)
		pUnit:GossipMenuAddItem(1, "Shadowfang Keep", 375, 0)
		pUnit:GossipMenuAddItem(1, "Stratholme", 376, 0)
		pUnit:GossipMenuAddItem(1, "Sunken Temple", 377, 0)
		pUnit:GossipMenuAddItem(1, "Uldaman", 378, 0)
		pUnit:GossipMenuAddItem(1, "Wailing Caverns", 379, 0)
		pUnit:GossipMenuAddItem(1, "Zul'Aman", 380, 0)
		pUnit:GossipMenuAddItem(1, "Zul'Farrak", 381, 0)
		pUnit:GossipMenuAddItem(1, "Zul'Gurub", 382, 0)
		pUnit:GossipMenuAddItem(0, "<-- Page 1 <--", 6, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 13) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Magtheridon's Lair", 421, 0)
		pUnit:GossipMenuAddItem(1, "Sepentshrine Cavern", 422, 0)
		pUnit:GossipMenuAddItem(1, "Gruul's Lair", 386, 0)
		pUnit:GossipMenuAddItem(1, "The Eye", 424, 0)
		pUnit:GossipMenuAddItem(1, "Black Temple", 384, 0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end
	if(intid == 14) then
		pUnit:GossipCreateMenu(99, player, 0)
		pUnit:GossipMenuAddItem(1, "Grave of Ammenar (Beginner)", 903,  0)
		pUnit:GossipMenuAddItem(1, "Treehouse Labyrinth (Easy)", 904,  0)
		pUnit:GossipMenuAddItem(1, "Vanished Sky temple (Medium)", 906,  0)
		pUnit:GossipMenuAddItem(1, "Crypt of the Forgotten (Hard)", 905,  0)
		pUnit:GossipMenuAddItem(1, "Halls of Old (Insane)", 902,  0)
		pUnit:GossipMenuAddItem(0, "[Back]", 999, 0)
		pUnit:GossipSendMenu(player)
	end

	if(intid == 998) then
		if(player:HasAura(15007) == true) then
			player:RemoveAura(15007)
			player:SendBroadcastMessage("You have been cured of Resurrection Sickness!")
		else
			player:SendBroadcastMessage("You do not currently have Resurrection Sickness!")
			end
		player:GossipComplete()
	end
	if(intid == 1338) then --STAIR EVENT [HARD]
		player:Teleport(0, -10739, 2458, 6)
		pUnit:GossipComplete(player)
	end
	if(intid == 1339) then --Maze
		player:Teleport(0, -7585.241211, 1122,796997, 131.406998 )
		pUnit:GossipComplete(player)
	end
	if(intid == 300) then --Stormwind
		player:Teleport(0, -8928, 540, 95)
		pUnit:GossipComplete(player)
	end
	if(intid == 99988) then --Mall
		player:Teleport(530, -1847.71, 5506.61, -12.24)
		pUnit:GossipComplete(player)
	end
	if(intid == 301) then --Ironforge
		player:Teleport(0, -4981, -881, 502)
		pUnit:GossipComplete(player)
	end 
	if(intid == 302) then --Darnassus
		player:Teleport(1, 9978, 2033, 1328.5)
		pUnit:GossipComplete(player)
	end
	if(intid == 303) then --Exodar
		player:Teleport(530, -4014, -11895, -1.5)
		pUnit:GossipComplete(player)
	end
	if(intid == 304) then --Orgrimmar
		player:Teleport(1, 1502, -4415, 22)
		pUnit:GossipComplete(player)
	end
	if(intid == 305) then --Thunder Bluff
		player:Teleport(1, -1283, 158, 130)
		pUnit:GossipComplete(player)
	end
	if(intid == 306) then --Undercity
		player:Teleport(0, 1752, 239, 61.5)
		pUnit:GossipComplete(player)
	end
	if(intid == 307) then --Silvermoon
		player:Teleport(530, 9392, -7277, 14.5)
		pUnit:GossipComplete(player)
	end
	if(intid == 308) then --Alterac Mountains
		player:Teleport(0, 237, -652, 119)
		pUnit:GossipComplete(player)
	end
	if(intid == 309) then --Arathi Highlands
		player:Teleport(0, -1550, -2495, 55)
		pUnit:GossipComplete(player)
	end
	if(intid == 310) then --Badlands
		player:Teleport(0, -6775, -3286, 242)
		pUnit:GossipComplete(player)
	end
	if(intid == 311) then --Burning Steppes
		player:Teleport(0, -7975, -1786, 133.5)
		pUnit:GossipComplete(player)
	end
	if(intid == 312) then --Deadwind Pass
		player:Teleport(0, -10447, -1872, 105)
		pUnit:GossipComplete(player)
	end
	if(intid == 313) then --Dun Morogh
		player:Teleport(0, -5709, -1339, 395)
		pUnit:GossipComplete(player)
	end
	if(intid == 314) then --Duskwood
		player:Teleport(0, -10914, -528, 54)
		pUnit:GossipComplete(player)
	end
	if(intid == 315) then --Eastern Plaguelands
		player:Teleport(0, 1739, -3623, 120)
		pUnit:GossipComplete(player)
	end
	if(intid == 316) then --Elwynn Forest
		player:Teleport(0, -9591, -463, 58)
		pUnit:GossipComplete(player)
	end
	if(intid == 317) then --Eversong Woods
		player:Teleport(530, 8250, -7214, 140)
		pUnit:GossipComplete(player)
	end
	if(intid == 318) then --Ghostlands
		player:Teleport(530, 6396, -6848, 101)
		pUnit:GossipComplete(player)
	end
	if(intid == 319) then --Hillsbrad Foothills
		player:Teleport(0, -440, -582, 54)
		pUnit:GossipComplete(player)
	end
	if(intid == 320) then --Hinterlands
		player:Teleport(0, 235, -3298, 110)
		pUnit:GossipComplete(player)
	end
	if(intid == 321) then --Loch Modan
		player:Teleport(0, -5853, -3251, 303)
		pUnit:GossipComplete(player)
	end
	if(intid == 322) then --Searing Gorge
		player:Teleport(0, -6645, -1918, 245)
		pUnit:GossipComplete(player)
	end
	if(intid == 323) then --Silverpine Forest
		player:Teleport(0, 628, 1291, 87)
		pUnit:GossipComplete(player)
	end
	if(intid == 324) then --Stranglethorn Vale
		player:Teleport(0, -14246, 301, 28)
		pUnit:GossipComplete(player)
	end
	if(intid == 325) then --Swamp of Sorrows
		player:Teleport(0, -10476, -2408, 74)
		pUnit:GossipComplete(player)
	end
	if(intid == 326) then --The Blasted Lands
		player:Teleport(0, -11189, -3023, 8)
		pUnit:GossipComplete(player)
	end
	if(intid == 327) then --Tirisfal Glades
		player:Teleport(0, 1599, 569, 38)
		pUnit:GossipComplete(player)
	end
	if(intid == 328) then --Western Plaguelands
		player:Teleport(0, 1676, -1366, 70)
		pUnit:GossipComplete(player)
	end
	if(intid == 329) then --Westfall
		player:Teleport(0, -10922, 998, 36)
		pUnit:GossipComplete(player)
	end
	if(intid == 330) then --Wetlands
		player:Teleport(0, -3604, -2711, 20)
		pUnit:GossipComplete(player)
	end
	if(intid == 331) then --Custom PvP Arena
		player:Teleport(0, -13230.952148, 222.109467, 32.362778)
		pUnit:GossipComplete(player)
	end
	if(intid == 332) then --Azshara
		player:Teleport(1, 3336, -4599, 93)
		pUnit:GossipComplete(player)
	end
	if(intid == 333) then --Azuremyst Isle
		player:Teleport(530, -4540, -11933, 28)
		pUnit:GossipComplete(player)
	end
	if(intid == 334) then --Bloodmyst Isle
		player:Teleport(530, -2721, -12206, 10)
		pUnit:GossipComplete(player)
	end
	if(intid == 335) then --Darkshore
		player:Teleport(1, 5084, 242, 29)
		pUnit:GossipComplete(player)
	end
	if(intid == 336) then --Desolace
		player:Teleport(1, -548, 1276, 90)
		pUnit:GossipComplete(player)
	end
	if(intid == 337) then --Durotar
		player:Teleport(1, 301, -4184, 28)
		pUnit:GossipComplete(player)
	end
	if(intid == 338) then --Dustwallow Marsh
		player:Teleport(1, -3345, -3078, 33)
		pUnit:GossipComplete(player)
	end
	if(intid == 339) then --Felwood
		player:Teleport(1, 5537, -585, 359)
		pUnit:GossipComplete(player)
	end
	if(intid == 340) then --Feralas
		player:Teleport(1, -4811, 1037, 105)
		pUnit:GossipComplete(player)
	end
	if(intid == 341) then --Moonglade
		player:Teleport(1, 7931, -2616, 493)
		pUnit:GossipComplete(player)
	end
	if(intid == 342) then --Mulgore
		player:Teleport(1, -2372, -893, -9)
		pUnit:GossipComplete(player)
	end
	if(intid == 343) then --Silithus
		player:Teleport(1, -6839, 763, 43)
		pUnit:GossipComplete(player)
	end
	if(intid == 344) then --Stonetalon Mountains
		player:Teleport(1, 588, 330, 48)
		pUnit:GossipComplete(player)
	end
	if(intid == 345) then --Tanaris
		player:Teleport(1, -7149, -3746, 9)
		pUnit:GossipComplete(player)
	end
	if(intid == 346) then --Teldrassil
		player:Teleport(1, 9947, 649, 1310)
		pUnit:GossipComplete(player)
	end
	if(intid == 347) then --The Barrens
		player:Teleport(1, 567, -2573, 96)
		pUnit:GossipComplete(player)
	end
	if(intid == 348) then --Thousand Needles
		player:Teleport(1, -4969, -1723, -61)
		pUnit:GossipComplete(player)
	end
	if(intid == 349) then --Un Goro Crater
		player:Teleport(1, -7932, -2139, -230)
		pUnit:GossipComplete(player)
	end
	if(intid == 350) then --Winterspring
		player:Teleport(1, 6719, -4646, 722)
		pUnit:GossipComplete(player)
	end
	if(intid == 351) then --Blade's Edge Mountains
		player:Teleport(530, 2924, 5982, -1)
		pUnit:GossipComplete(player)
	end
	if(intid == 352) then --Hellfire Peninsula
		player:Teleport(530, -220, 2217, 86)
		pUnit:GossipComplete(player)
	end
	if(intid == 353) then --Nagrand
		player:Teleport(530, -1525, 6571, 21)
		pUnit:GossipComplete(player)
	end
	if(intid == 354) then --Netherstorm
		player:Teleport(530, 3052, 3670, 143)
		pUnit:GossipComplete(player)
	end
	if(intid == 355) then --Shadowmoon Valley
		player:Teleport(530, -3693, 2344, 77)
		pUnit:GossipComplete(player)
	end
	if(intid == 356) then --Terokkar Forest
		player:Teleport(530, -1975, 4516, 13)
		pUnit:GossipComplete(player)
	end
	if(intid == 357) then --Zangarmarsh
		player:Teleport(530, -205, 5545, 24)
		pUnit:GossipComplete(player)
	end
	if(intid == 358) then --Crypt Of Exile
		player:Teleport(0, 1251.761841, -2587.760254, 92.886948)
		pUnit:GossipComplete(player)
	end
	if(intid == 359) then --Blackfathom Depths
		player:Teleport(1, 4248, 736, -26)
		pUnit:GossipComplete(player)
	end
	if(intid == 360) then --Blackrock Depths
		player:Teleport(0, -7187, -914, 166)
		pUnit:GossipComplete(player)
	end
	if(intid == 361) then --Blackrock Spire
		player:Teleport(0, -7532, -1221, 286)
		pUnit:GossipComplete(player)
	end
	if(intid == 362) then --Blackwing Lair
		player:Teleport(229, 137, -474, 117)
		pUnit:GossipComplete(player)
	end
	if(intid == 363) then --Caverns of Time
		player:Teleport(1, -8568, -4260, -213)
		pUnit:GossipComplete(player)
	end
	if(intid == 364) then --Deadmines
		player:Teleport(0, 11209, 1664, 25)
		pUnit:GossipComplete(player)
	end
	if(intid == 365) then --Dire Maul
		player:Teleport(1, -3524, 1124, 162)
		pUnit:GossipComplete(player)
	end
	if(intid == 366) then --Gnomeregan
		player:Teleport(0, -5164, 918,258)
		pUnit:GossipComplete(player)
	end
	if(intid == 367) then --Maraudon
		player:Teleport(1, -1458, 2606, 76)
		pUnit:GossipComplete(player)
	end
	if(intid == 368) then --Molten Core
		player:Teleport(230, 1123, -455, -101)
		pUnit:GossipComplete(player)
	end
	if(intid == 369) then --Onyxia's Lair
		player:Teleport(1, -4709, -3729, 55)
		pUnit:GossipComplete(player)
	end
	if(intid == 370) then --Ragefire Chasm
		player:Teleport(1, 1805, -4404, -18)
		pUnit:GossipComplete(player)
	end
	if(intid == 371) then --Razorfen Downs
		player:Teleport(1, -4661, -2511, 81)
		pUnit:GossipComplete(player)
	end
	if(intid == 372) then --Razorfen Kraul
		player:Teleport(1, -4473, -1690, 82)
		pUnit:GossipComplete(player)
	end
	if(intid == 373) then --Scarlet Monestary
		player:Teleport(0, 2841, -692, 140)
		pUnit:GossipComplete(player)
	end
	if(intid == 374) then --Scholomance
		player:Teleport(0, 1265, -2560, 95)
		pUnit:GossipComplete(player)
	end
	if(intid == 375) then --Shadowfang Keep
		player:Teleport(0, -241, 1545, 77)
		pUnit:GossipComplete(player)
	end
	if(intid == 376) then --Stratholme
		player:Teleport(0, 3345, -3380, 145)
		pUnit:GossipComplete(player)
	end
	if(intid == 377) then --Sunken Temple
		player:Teleport(0, -10457, -3828, 19)
		pUnit:GossipComplete(player)
	end
	if(intid == 378) then --Uldaman
		player:Teleport(0, -6704, -2955, 209)
		pUnit:GossipComplete(player)
	end
	if(intid == 379) then --Wailing Caverns
		player:Teleport(1, -737, -2219, 17)
		pUnit:GossipComplete(player)
	end
	if(intid == 380) then --Zul'Aman
		player:Teleport(530, 6850, -7950, 171)
		pUnit:GossipComplete(player)
	end
	if(intid == 381) then --Zul'Farrak
		player:Teleport(1, -6821, -2890, 9)
		pUnit:GossipComplete(player)
	end
	if(intid == 382) then --Zul'Gurub
		player:Teleport(0, -11916, -1204, 93)
		pUnit:GossipComplete(player)
	end
	if(intid == 383) then --Auchenai Crypts
		player:Teleport(530, -3367, 5216, -101)
		pUnit:GossipComplete(player)
	end
	if(intid == 384) then --Black Temple
		player:Teleport(530, -3614, 310, 40)
		pUnit:GossipComplete(player)
	end
	if(intid == 385) then --Coilfang Reservoir
		player:Teleport(530, 792, 6863, -64)
		pUnit:GossipComplete(player)
	end
	if(intid == 386) then --Gruul's Lair
		player:Teleport(530, 3529, 5096, 3)
		pUnit:GossipComplete(player)
	end
	if(intid == 387) then --Hellfire Ramparts
		player:Teleport(530, -360, 3071, -16)
		pUnit:GossipComplete(player)
	end
	if(intid == 388) then --Mana Tombs
		player:Teleport(530, -3100, 4950, -100)
		pUnit:GossipComplete(player)
	end
	if(intid == 389) then --Pheonix Hall
		player:Teleport(530, 3084, 1385, 185)
		pUnit:GossipComplete(player)
	end
	if(intid == 390) then --Sethekk Halls
		player:Teleport(530, -3364, 4675, -101)
		pUnit:GossipComplete(player)
	end
	if(intid == 391) then --Shadow Labyrinth
		player:Teleport(530, -3630, 4941, -101)
		pUnit:GossipComplete(player)
	end
	if(intid == 392) then --The Botanica
		player:Teleport(530, 3404, 1488, 183)
		pUnit:GossipComplete(player)
	end
	if(intid == 393) then --The Mechanar
		player:Teleport(530, 2870, 1557, 252)
		pUnit:GossipComplete(player)
	end
	if(intid == 394) then --Borean Tundra
		player:Teleport(571, 3008, 5290, 60)
		pUnit:GossipComplete(player)
	end
	if(intid == 395) then --Dragonblight
		player:Teleport(571, 3118, 107, 72)
		pUnit:GossipComplete(player)
	end
	if(intid == 396) then --Grizzly Hills
		player:Teleport(571, 3681, -3472, 243)
		pUnit:GossipComplete(player)
	end
	if(intid == 1992) then --Level Road
		player:Teleport(0, -1224.833, 410.862, 3.136)
		pUnit:GossipComplete(player)
	end
	if(intid == 397) then --Howling Fjord
		player:Teleport(571, 1267, -4062, 143)
		pUnit:GossipComplete(player)
	end
	if(intid == 398) then --Icecrown
		player:Teleport(571, 7514, 2091, 623)
		pUnit:GossipComplete(player)
	end
	if(intid == 399) then --Sholazar Basin
		player:Teleport(571, 5501, 4879, -198)
		pUnit:GossipComplete(player)
	end
	if(intid == 400) then --Storm Peaks
		player:Teleport(571, 7514, -1037, 467)
		pUnit:GossipComplete(player)
	end
	if(intid == 401) then --Wintergrasp
		player:Teleport(571, 4611, 2848, 3397)
		pUnit:GossipComplete(player)
	end
	if(intid == 402) then --Zul'Drak
		player:Teleport(571, 5441, -2304, 298)
		pUnit:GossipComplete(player)
	end
	if(intid == 403) then --Dalaran
		player:Teleport(571, 5797, 629, 648)
		pUnit:GossipComplete(player)
	end
	if(intid == 404) then --Crystalsong Forest
		player:Teleport(571, 5402, 72, 151)
		pUnit:GossipComplete(player)
	end
	if(intid == 405) then --DK Start Zone
		player:Teleport(609, 2353, -5666, 427)
		pUnit:GossipComplete(player)
	end
	if(intid == 406) then --Azjol'Nerub
		player:Teleport(571, 3721, 2155, 37)
		pUnit:GossipComplete(player)
	end
	if(intid == 407) then --Drak'Tharon
		player:Teleport(571, 4897, 2046, 249)
		pUnit:GossipComplete(player)
	end
	if(intid == 408) then --Gun'Drak
		player:Teleport(571, 6925, 4447, 451)
		pUnit:GossipComplete(player)
	end
	if(intid == 409) then --Icecrown Citadel
		player:Teleport(571, 6151, 2244, 508)
		pUnit:GossipComplete(player)
	end
	if(intid == 410) then --Naxxaramas
		player:Teleport(571, 3668, -1049, 131)
		pUnit:GossipComplete(player)
	end
	if(intid == 411) then --Obsidian Sanctum
		player:Teleport(571, 3561, 275, -115)
		pUnit:GossipComplete(player)
	end
	if(intid == 412) then --The Nexus/Occulus/Eye of Eternity
		player:Teleport(571, 3783, 6942, 105)
		pUnit:GossipComplete(player)
	end
	if(intid == 413) then --Halls of Stone/Halls of Lightning
		player:Teleport(571, 8937, 1266, 1026)
		pUnit:GossipComplete(player)
	end
	if(intid == 414) then --Utgarde Keep
		player:Teleport(571, 1228, -4943, 36)
		pUnit:GossipComplete(player)
	end
	if(intid == 415) then --Utgarde Pinnacle
		player:Teleport(571, 1274, -4857, 216)
		pUnit:GossipComplete(player)
	end
	if(intid == 416) then --Vault of Archevon
		player:Teleport(571, 5440, 2840, 421)
		pUnit:GossipComplete(player)
	end
	if(intid == 417) then --Violet Hold
		player:Teleport(571, 5708, 521, 650)
		pUnit:GossipComplete(player)
	end
	if(intid == 418) then --Alliance Mall
		player:Teleport(619, 522, -510, 27)
		player:SetOrientation(1.602212)
		pUnit:GossipComplete(player)
	end
	if(intid == 419) then --Horde Mall
		player:Teleport(619, 522, -510, 27)
		player:SetOrientation(1.602212)
		pUnit:GossipComplete(player)
	end
	if(intid == 420) then --Mall
		player:Teleport(619, 522, -510, 27)
		player:SetOrientation(1.602212)
		pUnit:GossipComplete(player)
	end
	if(intid == 421) then --Magtheridon's Lair
		player:Teleport(530, -313, 3088, -116)
		pUnit:GossipComplete(player)
	end
	if(intid == 422) then --Serpentshrine Cavern
		player:Teleport(530, 830, 6865, -63)
		pUnit:GossipComplete(player)
	end
	if(intid == 423) then --The Blood Furnace
		player:Teleport(530, -303, 3164, 32)
		pUnit:GossipComplete(player)
	end
	if(intid == 424) then --The Eye
		player:Teleport(530, 3087, 1373, 185)
		pUnit:GossipComplete(player)
	end
	if(intid == 425) then --The Shattered Halls
		player:Teleport(530, -311, 3083, -3)
		pUnit:GossipComplete(player)
	end
	if(intid == 426) then --The Slave Pens
		player:Teleport(530, 719, 6999, -73)
		pUnit:GossipComplete(player)
	end
	if(intid == 427) then --The Steamvault
		player:Teleport(530, 816, 6934, -80)
		pUnit:GossipComplete(player)
	end
	if(intid == 428) then --The Underbog
		player:Teleport(530, 777, 6763, -72)
		pUnit:GossipComplete(player)
	end
	if(intid == 902) then
		player:Teleport(44, 75.30, -0.84, 18.67)
		pUnit:GossipComplete(player)
	end
	if(intid == 903) then
		player:Teleport(37, 384.252, -248.25, 271.058)
		pUnit:GossipComplete(player)
	end

	if(intid == 904) then
		player:Teleport(37, 880.9044, 440.9771, 284.24722)
		pUnit:GossipComplete(player)
	end
	if(intid == 905) then
		player:Teleport(0, -11069.059, -1808.611, 53.79 )
		pUnit:GossipComplete(player)
	end
	if(intid == 906) then
		player:Teleport(37, -453.058868, -111.538803, 316.325195)
		player:CastSpell(59737)
		pUnit:GossipComplete(player)
	end
	if(intid == 9999) then
		player:Teleport(0,-3692,-2270.53, 166.372)
		pUnit:GossipComplete(player)
	end
	if(intid == 907) then
		player:Teleport(0, -13282, 117, 25)
		pUnit:GossipComplete(player)
	end

	if(intid == 909) then
	player:RepairAllPlayerItems()
	player:SendBroadcastMessage("Your items have been repaired!")
	player:GossipComplete()
	end

	if(intid == 908) then
	player:SetHealth(50000)
	player:SetMana(50000)
	player:SendBroadcastMessage("Your health is now restored!")
	player:GossipComplete()
	end

	if(intid == 555) then

	local test = test

	for k, v in pairs(player:GetGroupLeader()	 ()) do
		target:SendBroadcastMessage(k.." - "..v)
	end
	

	
	end
	

end

RegisterUnitGossipEvent(900011, 1, "WarpNPC_OnGossipTalk")
RegisterUnitGossipEvent(900011, 2, "WarpNPC_OnGossipSelect")