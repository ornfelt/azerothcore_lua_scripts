
-- array for the teleporter options
-- 
local teleport_options = {
--[[
	"Redridge Mountains", 
--	"Duskwood", 
	"Westfall",
	"Elwynn", -- alliance only
	"Stormwind", -- alliance only
--	"Deadwind Pass",
	"Swamp of Sorrows",
]]

	"Northern Stranglethorn",
	"Central Stranglethorn",
	"Booty Bay (Neutral)",
	"Grom'gol (Horde)",
	"Seacrest Harbor (Alliance)",
}

	-- needs teleport_info[1] is the information for teleport_options[1]
local teleport_info = {
	-- mapid, x, y, z, o, racecheck?
	
	-- Wake: Red CHapter
--[[
	{0, -9581.8213, -1941.5477, 65.3007, 4.8}, -- Redridge
	{0, -10804.93, 307.40, 31.30, 3.27}, -- Duskwood
	{0, -9969.1211, 1004.7848, 31.4710, 3.0618}, -- Westfall
	{0, -9403.945312, 17.4398, 59.26, 2.3557}, -- Elwynn
	{0, -8927.5811, 541.6812, 94.2977, 0.6710}, -- Stormwind
	{0, -10432.3477, -1780.13, 95.99, 4.65}, -- Deadwind Pass
	{0, -9792.0791, -3831.0444, 22.3584, 4.637}, -- Swamp of Sorrows
]]

	{0, -11814, -48, 39.73, 4.30}, -- northern stv
	{0, -13292.606445, 101.966934, 24, 4.26}, -- Central Stranglethorn
	{0, -14286.80, 554, 8.87, 4.32}, -- Booty Bay (Neutral)
	{0, -12425.914062, 187.381821, 32, 1.8}, -- Grom'gol (Horde)
	{0, -13354.200, 788.12, 2, 5.5}, -- Seacrest Harbor (Alliance)
}


-- raceid = {skinid, skinid},
local blacklist_skins_female = {
--	[10] = {10, 11, 12, 13, 14},
--	[3] = {10},
--	[1] = {11},
}

local blacklist_skins_male = {
--	[10] = {11, 12, 13, 14, 15},
--	[3] = {9},
--	[1] = {11},
--	[2] = {10},
}

local function TeleportGossipHello(event, player, creature)
	if (player:HasAura(2000008) == true) then
		creature:SendUnitSay("What? Yer dead?! How are you 'sposed to come with?", 0)
		player:GossipComplete()
		return false
	elseif player:GetGender() == 1 and blacklist_skins_female[player:GetRace()] ~= nil then
		for x=1,#blacklist_skins_female[player:GetRace()],1 do
			if blacklist_skins_female[player:GetRace()][x] == player:GetSkin() then
				creature:SendUnitSay("And where do ye think yer goin' lass? Yer kind needs tae be APPROVED before ridin' with me.", 0)
				player:SendBroadcastMessage("The race you are using is not allowed. Please see the #help-desk and apply.")
				player:GossipComplete()
				return false
			end
		end
	elseif player:GetGender() == 0 and blacklist_skins_male[player:GetRace()] ~= nil then
		for x=1,#blacklist_skins_male[player:GetRace()],1 do
			if blacklist_skins_male[player:GetRace()][x] == player:GetSkin() then
				creature:SendUnitSay("And where do ye think yer goin' lad? Yer kind needs tae be APPROVED before ridin' with me.", 0)
				player:SendBroadcastMessage("The race you are using is not allowed. Please see the #help-desk and apply.")
				player:GossipComplete()
				return false
			end
		end	
	end

	player:GossipMenuAddItem(2, "Alright Hemet Nesingwary Jr., let's get out of here!", 65009, 0)
	
	-- flavor text. if missing black jelly
	if (player:HasAchieved(65497) == false) then
		funny = "Wait a minute, Hemet Nesingwary Jr., I still have no clue how to use the shop!"
	elseif (player:HasItem(45932) == false) then
		funny = "Oh, hold on! I forgot my black jelly!"
	elseif (player:GetClass() == 9) and (player:HasItem(6265) == false) then
		funny = "Put a raincheck on that, Hemet Nesingwary Jr. I'm a warlock and almost forgot my Soul Shards!"
	elseif (player:GetClass() == 3) and (player:HasItem(52021) == false) and (player:HasItem(52020) == false) then
		funny = "On second thought, I'll be needing to turn around for some ammo."
	elseif (player:HasItem(34722) == false) then
		funny = "I should probably go back and grab a few band-aids..."
	elseif (player:HasItem(1999996) == true) then
		funny = "Maybe I should go spend the rest of my gear tokens while I've got the chance."
	elseif (player:HasAchieved(65494) == false) then
		funny = "Small thought Hemet Nesingwary Jr., but have you ever wanted to make those Warpweavers your slave to summon? Have them in your 'pet' collection? No? Just me? Okay."
	else
		funny = "I've got my bags, black jelly, band aids, and all the tasks done but I REFUSE!"
	end
	
	player:GossipMenuAddItem(0, funny, 65009, 1)
	player:GossipSendMenu(65008, creature, MenuId)
end

local function TeleportGossipSelect(event, player, creature, sender, intid, code)
	player:GossipClearMenu()
	if (intid == 0) then
--		local NoWildHammers = CharDBQuery("SELECT `skin` FROM `characters` WHERE `guid` = " ..player:GetGUIDLow().. ";")
--[[	
		elseif (player:GetRace() == 3) and (player:GetGender() == 0) and (NoWildHammers:GetInt32(0) == 16) or (NoWildHammers:GetInt32(0) == 17) then
			creature:SendUnitSay("Sorry but we've got a NO WILDHAMMERS POLICY.", 0)
		elseif (player:GetRace() == 3) and (player:GetGender() == 1) and (NoWildHammers:GetInt32(0) == 9) then
			creature:SendUnitSay("Sorry but we've got a NO WILDHAMMERS POLICY, lass.", 0)
]]	
		for x=1,#teleport_options,1 do
			player:GossipMenuAddItem(0, teleport_options[x], 65020, (x + 10))
		end
		player:GossipComplete()
		player:GossipSendMenu(65020, creature, MenuId)
	elseif (intid == 1) then
		if (funny == "I've got my bags, black jelly, band aids, and all the tasks done but I REFUSE!") then
			creature:SendUnitSay("Go on then " ..player:GetName().. ", git! I ain't got time fer yer wee pansy arse.", 0)
			player:GossipComplete()
		end
	elseif (intid >= 10) then
		-- here we go into the second gossip menu where all teleport options are located
		new_intid = intid - 10
		player:AdvanceSkillsToMax()
		player:Teleport(teleport_info[new_intid][1], teleport_info[new_intid][2], teleport_info[new_intid][3], teleport_info[new_intid][4], teleport_info[new_intid][5])
		local logmessage = player:GetAccountName() .. " just teleported their character " .. player:GetName() .. " to " ..teleport_options[new_intid].. " chapter."
		PrintInfo(logmessage)
		SendToDiscordLog(logmessage)
		AwardAchievement(player, 1999992)
	end
end

RegisterCreatureGossipEvent(1000007, 1, TeleportGossipHello)
RegisterCreatureGossipEvent(1000007, 2, TeleportGossipSelect)