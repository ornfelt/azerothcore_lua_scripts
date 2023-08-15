--  647 - alliance creature
--  32659 - horde creature`

teleporter_gossip_menu = 65021

creature_list = {
	1000023,
	1000024,
	1000025,
	1000026,
}

-- map id, x, y, z, o, racecheck
-- false = alliance
-- true = horde
creature_tp = {
	[1000023] = {0, -9780, -3969.70, 19.67, 0.06, true}, -- STONARD -> BOGPADDLE
	[1000024] = {0, -10372, -3245, 19.4, 3.81, true}, -- BOGPADDLE -> STONARD
	[1000025] = {0, -9549, -4046, 8.42, 3.05, false}, -- STORMWIND -> BOGPADDLE
	[1000026] = {0, -8373, 1328, 5.23, 3.14, false}, -- BOGPADDLE -> STORMWIND
}

creature_cost = {
	[1000023] = {6}, -- 3 hours
	[1000024] = {6}, -- 3 hours
	[1000025] = {12}, -- 6 hours
	[1000026] = {12}, -- 6 hours
}

local function TeleporterHello(event, player, creature)
	local creature_entry = creature:GetEntry() 
	local champion_fac = player:GetChampioningFaction()
	print(champion_fac)
	if (player:IsHorde() == creature_tp[creature_entry][6]) then
		player:GossipMenuAddItem(0, "Let's go!", teleporter_gossip_menu, 1, false, "Taking this transport will cost " ..creature_cost[creature_entry][1].. " silver coins. Accept?")
		player:GossipSendMenu(teleporter_gossip_menu, creature, MenuId)
	else
		player:SendBroadcastMessage("You are not the correct faction for this transport.")
	end
end

local function TeleporterSelect(event, player, creature, sender, intid, code)
	local creature_entry = creature:GetEntry()
	player:GossipClearMenu()
	if (intid == 1) then
		-- if player has X amoutn of silver coins
		if (player:HasItem(1999999, creature_cost[creature_entry][1]) == false) then
			player:SendBroadcastMessage("You do not have enough coin to take this transport.")
			player:GossipComplete()
			return
			
		else
			-- tp in relation to above arrays and remove X cost of silver coins
			player:RemoveItem(1999999, creature_cost[creature_entry][1])
			player:Teleport(creature_tp[creature_entry][1], creature_tp[creature_entry][2], creature_tp[creature_entry][3], creature_tp[creature_entry][4], creature_tp[creature_entry][5])
			player:GossipComplete()
			return
		end
	end
	player:GossipComplete()
end

-- generates events for every entry in creature_list
for x=1,#creature_list,1 do
	RegisterCreatureGossipEvent(creature_list[x], 1, TeleporterHello)
	RegisterCreatureGossipEvent(creature_list[x], 2, TeleporterSelect)
end

--[[

REPLACE INTO `creature_template` VALUES (1000023, 0, 0, 0, 0, 0, 28129, 0, 0, 0, 'Dread Captain Winge', 'Captain of the Casket Carrier', NULL, 65021, 80, 80, 0, 35, 1, 1, 1.14286, 1, 0, 0, 2000, 1771, 1, 1, 1, 4, 2048, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 8, 1, 1, 16, 1, 0, 0, 1, 0, 0, 66, '', 12340);
REPLACE INTO `creature_template` VALUES (1000024, 0, 0, 0, 0, 0, 28129, 0, 0, 0, 'Dread Captain Winge', 'Captain of the Casket Carrier', NULL, 65021, 80, 80, 0, 35, 1, 1, 1.14286, 1, 0, 0, 2000, 1771, 1, 1, 1, 4, 2048, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 8, 1, 1, 16, 1, 0, 0, 1, 0, 0, 66, '', 12340);
REPLACE INTO `creature_template` VALUES (1000025, 0, 0, 0, 0, 0, 7113, 0, 0, 0, 'Captain Greenskin', '', NULL, 65021, 80, 80, 0, 35, 1, 1, 1.14286, 1, 0, 0, 2000, 1771, 1, 1, 1, 4, 2048, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 8, 1, 1, 16, 1, 0, 0, 1, 0, 0, 66, '', 12340);
REPLACE INTO `creature_template` VALUES (1000026, 0, 0, 0, 0, 0, 7113, 0, 0, 0, 'Captain Greenskin', '', NULL, 65021, 80, 80, 0, 35, 1, 1, 1.14286, 1, 0, 0, 2000, 1771, 1, 1, 1, 4, 2048, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'SmartAI', 0, 1, 8, 1, 1, 16, 1, 0, 0, 1, 0, 0, 66, '', 12340);
INSERT INTO `gossip_menu` VALUES (65021, 65021, 0);
INSERT INTO `npc_text` VALUES (65021, 'Hello, $n. Are you ready for the long journey ahead?', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);


]]