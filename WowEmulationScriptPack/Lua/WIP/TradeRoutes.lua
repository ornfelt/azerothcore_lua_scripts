-- Description:
-- This script holds everything related to the trade route system.
-- This the server-side script. There is no client-side script.
-- Author: grimreapaa

-- spawn entry for the NPC
local TRADE_MULE_ENTRY = 1000211

-- gossip menu that is linked to the spawn entry
local TRADE_MULE_GOSSIP = 65029

-- admin level to access hidden buttons
local ADMIN_RANK = 3

-- debuff spell entry
local TRADE_ROUTE_DEBUFF = 2000084

-- checks if player is mounted with the custom mounts, if enabled
local MOUNT_SYSTEM_ENABLED = true

local function Trade_Route_Hello(event, player, creature)
	local creature_guid = creature:GetDBTableGUIDLow()
	local x, y, z, o = creature:GetLocation()
	local Trade_Route_Query1 = WorldDBQuery("SELECT `guid`,`multiplier` FROM `eluna_trade_route_template` WHERE `guid` = " ..creature_guid.. ";")
	if Trade_Route_Query1 == nil and player:GetGMRank() < ADMIN_RANK then
		player:SendBroadcastMessage("[Trade Route]: This trade route is not yet set up.")
		return false
	elseif Trade_Route_Query1 == nil and player:GetGMRank() >= ADMIN_RANK then
		player:SendBroadcastMessage("[Trade Route]: Performing first time setup, please talk to the NPC again.")
		WorldDBExecute("INSERT INTO `elunaworld`.`eluna_trade_route_template` (`guid`, `multiplier`, `map`, `x`, `y`, `z`, `o`) VALUES ('" ..creature_guid.. "', '1', '" ..creature:GetMapId().. "', '" ..x.. "', '" ..y.. "', '" ..z.. "', '" ..o.. "');")
		return false
	end
	
	if player:GetGMRank() >= ADMIN_RANK then -- hidden gm buttons
		local multiplier = Trade_Route_Query1:GetFloat(1)
		player:GossipMenuAddItem(0, "Change multiplier", TRADE_MULE_GOSSIP, 20, true, "The current trade route multiplier is " .. multiplier ..". Change this?")
	end

	if player:HasAura(TRADE_ROUTE_DEBUFF) == true then
		player:GossipMenuAddItem(0, "Turn in trade route", TRADE_MULE_GOSSIP, 11, false, "Turning in this package will give coinage based on the distance travelled. Continue?")
	else
		player:GossipMenuAddItem(0, "Begin trade route", TRADE_MULE_GOSSIP, 10, false, "Accepting will apply a slow debuff, and you must find another " .. creature:GetName() .. " to turn your package in. Continue?")
	end
	
	player:GossipMenuAddItem(0, "Nevermind", TRADE_MULE_GOSSIP, 0)
	player:GossipSendMenu(TRADE_MULE_GOSSIP, creature, MenuId)
end

local function Trade_Route_Select(event, player, creature, sender, intid, code)
	player:GossipClearMenu()
	player:GossipComplete()
	if (intid == 10) then -- start route
		local player_guid = player:GetGUIDLow()
		local creature_guid = creature:GetDBTableGUIDLow()
		local Trade_Route_Query2 = WorldDBQuery("SELECT `character_guid`,`creature_guid` FROM `eluna_trade_route` WHERE `character_guid` = " ..player_guid.. ";")
		if Trade_Route_Query2 ~= nil then -- delete previous entry if exists
			WorldDBExecute("DELETE FROM `eluna_trade_route` WHERE `character_guid` = '" ..player_guid.. "';")
		end
		WorldDBExecute("INSERT INTO `elunaworld`.`eluna_trade_route` (`character_guid`, `creature_guid`) VALUES ('" ..player_guid.. "', '" ..creature_guid.. "');")
	
		if MOUNT_SYSTEM_ENABLED == true and player:HasAura(63151) == true then -- player is mounted, do not continue
			player:SendBroadcastMessage("[Trade Route]: You cannot accept a trade route while mounted!")
			return false
		end
	
		player:AddAura(TRADE_ROUTE_DEBUFF, player)
		player:SendBroadcastMessage("[Trade Route]: You have began your trade route, find another " .. creature:GetName() .. " for money!")
	elseif (intid == 11) then -- end route
		local player_guid = player:GetGUIDLow()
		local Trade_Route_Query2 = WorldDBQuery("SELECT `character_guid`,`creature_guid` FROM `eluna_trade_route` WHERE `character_guid` = " ..player_guid.. ";")
		if Trade_Route_Query2 == nil then -- shouldnt be nil because they accepted the package and that inserted to begin with
			player:SendBroadcastMessage("How did you get this?!?!")
			return false
		end
		
		local origin_mule = Trade_Route_Query2:GetInt32(1)
		local new_mule = creature:GetDBTableGUIDLow()
		
		if origin_mule == new_mule then
			player:RemoveAura(TRADE_ROUTE_DEBUFF)
			player:SendBroadcastMessage("[Trade Route]: You have delivered to the same mule you acquired from, earning no money.")
			WorldDBExecute("DELETE FROM `eluna_trade_route` WHERE `character_guid` = '" ..player_guid.. "';")
			return false
		else
			local Trade_Route_Query3 = WorldDBQuery("SELECT `guid`,`multiplier`,`map`,`x`,`y`,`z` FROM `eluna_trade_route_template` WHERE `guid` = " ..origin_mule.. ";")
			local Trade_Route_Query4 = WorldDBQuery("SELECT `guid`,`multiplier`,`map`,`x`,`y`,`z` FROM `eluna_trade_route_template` WHERE `guid` = " ..new_mule.. ";")
			local multiplier = Trade_Route_Query4:GetFloat(1) -- multiplier is applied at destination aka new_mule
			local map_2 = Trade_Route_Query4:GetInt32(2)
			local map_1 = Trade_Route_Query4:GetInt32(2)
			if map_1 ~= map_2 then -- if not on same map, dont continue. no way to calculate distance between maps (yet)
				player:SendBroadcastMessage("[Trade Route]: There is currently no support for trading between maps.")
				return false
			end
			
			-- we do a mathed out distance formula because there is no way for us to get a creature object and inherently its location. also works nicer with db entries.
			-- distance_formula = math.sqrt((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2) https://www.math.usm.edu/lambers/mat169/fall09/lecture17.pdf
			local x_2 = Trade_Route_Query4:GetInt32(3)
			local y_2 = Trade_Route_Query4:GetInt32(4)
			local z_2 = Trade_Route_Query4:GetInt32(5)
			local x_1 = Trade_Route_Query3:GetInt32(3)
			local y_1 = Trade_Route_Query3:GetInt32(4)
			local z_1 = Trade_Route_Query3:GetInt32(5)
			distance_formula = math.sqrt((x_2 - x_1)^2 + (y_2 - y_1)^2 + (z_2 - z_1)^2)
			new_money = string.format("%0.0f", (distance_formula * multiplier)) -- format this string so we dont send a float to ChangeCurrency
			ChangeCurrency(player, new_money)
			player:RemoveAura(TRADE_ROUTE_DEBUFF)
			player:SendBroadcastMessage("[Trade Route]: You have travelled " .. (string.format("%0.2f", distance_formula)) .. " yards for this trade route and earned " .. TranslateCurrency(new_money) .. ".")
			return false
		end
	elseif (intid == 20) then
		local new_multiplier = tonumber(code)
		if new_multiplier == nil then
			player:SendBroadcastMessage("[Trade Route]: You must input a valid number!")
			return false
		end

		local creature_guid = creature:GetDBTableGUIDLow()
		local Trade_Route_Query5 = WorldDBQuery("SELECT `guid`,`multiplier` FROM `eluna_trade_route_template` WHERE `guid` = " ..creature_guid.. ";")
		if Trade_Route_Query5 == nil then
			player:SendBroadcastMessage("wtf howd you get this?")
			return false
		else
			WorldDBExecute("UPDATE `eluna_trade_route_template` SET `multiplier` = '" ..new_multiplier.. "' WHERE `guid` = " ..creature_guid.. ";")
			player:SendBroadcastMessage("[Trade Route]: Successfully set multiplier " ..new_multiplier.. " to trade route " ..creature_guid.. ".")
			return false
		end
	end
end

RegisterCreatureGossipEvent(TRADE_MULE_ENTRY, 1, Trade_Route_Hello)
RegisterCreatureGossipEvent(TRADE_MULE_ENTRY, 2, Trade_Route_Select)