local AIO = AIO or require("AIO")
local PropertyHandlers = AIO.AddHandlers("Properties", {})


-- Property NPC
PROPERTY_NPC = 1000204

-- level admin to set up these npcs
ADMIN_LEVEL = 3

-- list of property types
local property_types = {
	"inn",
	"farm",
	"mine",
}

local property_types_keyed = {
	["inn"] = "inn",
	["farm"] = "farm",
	["mine"] = "mine",
}

-- object ids to register events for
local property_types_objects = {
	1000011,
	1000012,
	1000013,
	1000014,
	1000015,
	1000016,
	1000017,
	1000018,	
	1000005,
	1000019,
	1000020,
}

-- what object linked to what type of property
local property_types_objects_keyed = {
	["inn"] = {1000005},
}

-- what object casts what spell
local property_types_objects_spells = {
	[1000005] = 2000042,
	[1000016] = 2000044,
	[1000017] = 2000046,
	[1000018] = 2000049,
	[1000019] = 2000045,
	[1000020] = 2000048,
	[1000011] = 2000051,
	[1000012] = 2000053,
	[1000013] = 2000055,
	[1000014] = 2000057,
	[1000015] = 2000059,
}

-- spellid, reagent1, reagent2, reagent3, reagent4, reagentcount1, reagentcount2, reagentcount3, reagentcount4
local crafting_materials = {
	[2000046] = {1999960, 0, 0, 0, 1, 0, 0, 0},
	[2000048] = {1999958, 0, 0, 0, 1, 0, 0, 0},
	[2000049] = {1999957, 0, 0, 0, 5, 0, 0, 0},
	[2000051] = {1999965, 0, 0, 0, 5, 0, 0, 0},
	[2000053] = {1999964, 0, 0, 0, 5, 0, 0, 0},
	[2000055] = {1999963, 0, 0, 0, 5, 0, 0, 0},
	[2000057] = {1999962, 0, 0, 0, 5, 0, 0, 0},
	[2000059] = {1999961, 0, 0, 0, 5, 0, 0, 0},
}

--[[
local function Static_Property_Hello(event, player, creature)
	local setup = false
	local creature_guid = creature:GetDBTableGUIDLow()
	local Static_Property_Query1 = WorldDBQuery("SELECT `property_name`, `property_lease`, `property_type`, `confirmed`, `property_fee` FROM `eluna_property_static` WHERE `creature_guid` = " ..creature_guid.. ";")
	if Static_Property_Query1 == nil then
		WorldDBExecute("INSERT INTO `elunaworld`.`eluna_property_static` (`creature_guid`, `property_name`, `property_lease`, `property_fee`, `property_type`, `confirmed`) VALUES ('" ..creature_guid.. "','Empty', '0', '10', 'empty', '0');")
		player:SendBroadcastMessage("[Property System]: Performing first time setup. Please talk to the NPC again.")
		player:GossipClearMenu()
		player:GossipComplete()
		return false
	elseif Static_Property_Query1 ~= nil and Static_Property_Query1:GetInt32(3) == 0 then
		setup = true
	end
	
	-- setup stuff
	if (player:GetGMRank() < ADMIN_LEVEL) and setup == true then
		player:SendBroadcastMessage("[Property System]: This property is not setup yet.")
		player:GossipClearMenu()
		player:GossipComplete()
		return false
	elseif (player:GetGMRank() >= ADMIN_LEVEL) and setup == true then
		player:SendBroadcastMessage("[Property System]: This property is not set up. The options presented to you will disappear after clicking confirm.")
		player:GossipMenuAddItem(0, "Set Name of Property", 65027, 10, true, "Set the name. The current name is: " ..Static_Property_Query1:GetString(0).. ".")
		player:GossipMenuAddItem(0, "Set Property Lease", 65027, 11, true, "Set the price to buy the property. The current price is: " ..Static_Property_Query1:GetInt32(1).. ".")
		player:GossipMenuAddItem(0, "Set Property Type", 65027, 12,  true, "Set the type. The current type is: " ..Static_Property_Query1:GetString(2).. ".")
		player:GossipMenuAddItem(0, "Set Service Fee", 65027, 13,  true, "Set the service fee for using objects linked to this property. The current fee is: " ..Static_Property_Query1:GetInt32(4).. ".")
		player:GossipMenuAddItem(0, "Get Objects", 65027, 14)
		player:GossipMenuAddItem(0, "Confirm", 65027, 19, false, "This will confirm the options for this property. You cannot go back.")
		player:GossipMenuAddItem(0, "Nevermind", 65027, 0)
		player:GossipSendMenu(65027, creature, MenuId)
		return
	end


	-- what shows when setup is finished
--	if player:GetGMRank() >= ADMIN_LEVEL then
--		player:GossipMenuAddItem(0, "Un-Confirm", 65027, 19, false, "This will un-confirm the options for this property, sending it back for editing. You cannot go back.")
--	end
	
	local Static_Property_Query2 = WorldDBQuery("SELECT `character`, `property_lease`, `character_guid`, `property_fee` FROM `eluna_property_owner` WHERE `creature_guid` = " ..creature_guid.. " AND `owner_current` = 1;")
	lease_amount = 0
	char_guid = 0
	service_fee = 0
	if Static_Property_Query2 ~= nil then
		char_guid = Static_Property_Query2:GetInt32(2)
		lease_amount = Static_Property_Query2:GetInt32(1)
		service_fee = Static_Property_Query2:GetInt32(3)
	end
	
	if lease_amount == 0 then
		lease_amount = Static_Property_Query1:GetInt32(1)
		service_fee = Static_Property_Query1:GetInt32(4)
	end
	
	
	lease_amount_raw = lease_amount
	lease_amount = math.floor(lease_amount * 1.25)
	if char_guid == 0 or char_guid ~= player:GetGUIDLow() then
		-- not owner
		player:GossipMenuAddItem(0, "View Property Information", 65027, 1)
		player:GossipMenuAddItem(0, "View Service Fee", 65027, 4)
		player:GossipMenuAddItem(0, "Purchase Property", 65027, 2, false, "Do you wish to purchase this property for " ..lease_amount.. "?")
		player:GossipMenuAddItem(0, "Purchase Inventory", 65027, 3) -- shows list of items in property inventory, clicking on them shows popup of quantity at cost per. editbox buys X.
		player:GossipMenuAddItem(0, "Nevermind", 65027, 0)
		player:GossipSendMenu(65027, creature, MenuId)
		return
	else
		player:GossipMenuAddItem(0, "Change Name", 65027, 21, true, "Do you wish to change the property name? It is currently " ..Static_Property_Query1:GetString(0).. ".")
		player:GossipMenuAddItem(0, "Increase Lease", 65027, 22, true, "Do you wish to increase the lease amount? The base amount is currently " ..lease_amount_raw.. ".")
		player:GossipMenuAddItem(0, "Set Service Fee", 65027, 23, true, "The service fee is how much you charge individuals for using your property. The current fee is " ..service_fee.. ". Do you wish to change it?")
		player:GossipMenuAddItem(0, "Withdraw Treasury", 65027, 24, true, "Do you wish to withdraw from your treasury? It currently contains STUFF.")
		player:GossipMenuAddItem(0, "Withdraw Inventory", 65027, 25, true, "Do you wish to withdraw ITEM from your property? There is currently AMOUNT.") -- lists items, clicking on them shows quantity amount popup and editbox to withdraw x amount.
		player:GossipMenuAddItem(0, "Sell Inventory", 65027, 26, true, "The service charge is how much you charge individuals for using your property. The current service charge is SERVICE CHARGE. Do you wish to change it?") -- lists items, shows price popup and editbox to withdraw x amount.
		player:GossipMenuAddItem(0, "Nevermind", 65027, 0)
		player:GossipSendMenu(65027, creature, MenuId)
		return
	end
end
]]

--[[
local function Static_Property_Select(event, player, creature, sender, intid, code)
	player:GossipClearMenu()
	player:GossipComplete()
	local creature_guid = creature:GetDBTableGUIDLow()
	local Static_Property_Query1 = WorldDBQuery("SELECT `property_name`, `property_lease`, `property_type`, `confirmed`, `property_fee` FROM `eluna_property_static` WHERE `creature_guid` = " ..creature_guid.. ";")
	if (Static_Property_Query1 == nil) then
		player:SendBroadcastMessage("[Property System]: Something went horribly wrong.")
		return false
	end

	-- setup intids
	if (intid >= 10) and (intid < 20) then
		if (intid == 10) then
			code = sterilize.generic(code)
			WorldDBExecute("UPDATE `eluna_property_static` SET `property_name` = '" ..code.. "' WHERE `creature_guid` = " ..creature_guid.. ";")
			player:SendBroadcastMessage("[Property System]: The property linked to creature GUID " ..creature_guid.. " has been renamed to " ..code.. ".")
			return false
		elseif (intid == 11) then
			if tonumber(code) == nil then
				player:SendBroadcastMessage("[Property System]: You must input a valid number.")
				return false
			else
				WorldDBExecute("UPDATE `eluna_property_static` SET `property_lease` = '" ..code.. "' WHERE `creature_guid` = " ..creature_guid.. ";")
				player:SendBroadcastMessage("[Property System]: The property linked to creature GUID " ..creature_guid.. " has been priced to " ..code.. ".")
				return false				
			end
		elseif (intid == 12) then
			code = sterilize.generic(code)
			if property_types_keyed[code] == nil then
				player:SendBroadcastMessage("[Property System]: You must input a valid property type. Below are valid property types.")
				for x=1,#property_types,1 do
					player:SendBroadcastMessage(property_types[x])
				end
				return false
			else
				WorldDBExecute("UPDATE `eluna_property_static` SET `property_type` = '" ..code.. "' WHERE `creature_guid` = " ..creature_guid.. ";")
				player:SendBroadcastMessage("[Property System]: The property linked to creature GUID " ..creature_guid.. " has been typed to " ..code.. ".")
				return false
			end
		elseif (intid == 13) then
			if tonumber(code) == nil then
				player:SendBroadcastMessage("[Property System]: You must input a valid number.")
				return false
			else
				WorldDBExecute("UPDATE `eluna_property_static` SET `property_fee` = '" ..code.. "' WHERE `creature_guid` = " ..creature_guid.. ";")
				player:SendBroadcastMessage("[Property System]: The property service fee to creature GUID " ..creature_guid.. " has been priced to " ..code.. ".")
				return false			
			end
		elseif (intid == 14) then
			if Static_Property_Query1:GetString(2) == "empty" then
				player:SendBroadcastMessage("[Property System]: Error. Cannot grab objects because property type is not yet specified.")
				return false
			end
			
			for x=1,#property_types_objects_keyed[Static_Property_Query1:GetString(2)],1 do
				local gameobjects_table = creature:GetGameObjectsInRange( 300, property_types_objects_keyed[Static_Property_Query1:GetString(2)][x] )
				if #gameobjects_table == 0 then
					player:SendBroadcastMessage("[Property System]: No valid gameobjects found for gameobject entry " ..property_types_objects_keyed[Static_Property_Query1:GetString(2)][x].. ".")
					return false
				end
				
				z = 0
				for m=1,#gameobjects_table,1 do
					object_guid = gameobjects_table[m]:GetDBTableGUIDLow()
					local Static_Property_Query6 = WorldDBQuery("SELECT `guid`, `creature_guid` FROM `eluna_property_gameobjects` WHERE `guid` = " ..object_guid.. ";")
					if Static_Property_Query6 ~= nil then
						if Static_Property_Query6:GetInt32(1) ~= creature:GetDBTableGUIDLow() then
							player:SendBroadcastMessage("[Property System]: The gameobject with GUID " ..object_guid.. " is being used by another property with creature GUID " ..Static_Property_Query6:GetInt32(1).. ". Please contact a developer to fix this.")
						else
							player:SendBroadcastMessage("[Property System]: The gameobject with GUID " ..object_guid.. " is being used by your property.")
						end
					else
						WorldDBExecute("INSERT INTO `elunaworld`.`eluna_property_gameobjects` (`guid`, `entry`, `creature_guid`) VALUES ('" ..object_guid.. "', '" ..gameobjects_table[m]:GetEntry().. "', '" ..creature:GetDBTableGUIDLow().. "');")
						player:SendBroadcastMessage("[Property System]: Acquired gameobject with GUID " ..object_guid.. ".")
						z = z + 1
					end
				end
			end
			player:SendBroadcastMessage("[Property System]: " ..z.. " objects linked to creature GUID " ..creature:GetDBTableGUIDLow().. ".")
		elseif (intid == 19) then
			WorldDBExecute("UPDATE `eluna_property_static` SET `confirmed` = 1 WHERE `creature_guid` = " ..creature_guid.. ";")
			WorldDBExecute("INSERT INTO `elunaworld`.`eluna_property_owner` (`creature_guid`, `owner_current`, `account`, `character`, `character_guid`, `property_lease`, `property_fee`) VALUES ('" ..creature_guid.. "', '1', '" ..player:GetAccountName().. "', 'none', '0', '0', '" ..Static_Property_Query1:GetInt32(4).. "');")
			player:SendBroadcastMessage("[Property System]: The property linked to creature GUID " ..creature_guid.. " has been confirmed and ready for players.")
			return false
		end
	end
	
	-- viewer, but not owner intids
	if (intid >= 1) and (intid < 10) then
		local Static_Property_Query3 = WorldDBQuery("SELECT `character`, `property_lease`, `property_fee` FROM `eluna_property_owner` WHERE `creature_guid` = " ..creature_guid.. " AND `owner_current` = 1;")
		property_name = Static_Property_Query1:GetString(0)
		owner_name = Static_Property_Query3:GetString(0)
		if (intid == 1) then
			player:SendBroadcastMessage("[Property System]: This " ..Static_Property_Query1:GetString(2).. ", named " ..property_name.. " is owned by " ..owner_name.. ".")
			return false
		elseif (intid == 2) then
			lease_amount = Static_Property_Query3:GetInt32(1)
			if lease_amount == 0 then
				lease_amount = Static_Property_Query1:GetInt32(1)
			end
			
			lease_amount = math.floor(lease_amount * 1.25)
			if GetCurrency(player) < lease_amount then
				player:SendBroadcastMessage("[Property System]: You do not have enough to purchase this property.")
				return false
			end
			
			ChangeCurrency(player, -1 * lease_amount)
			WorldDBExecute("UPDATE `eluna_property_owner` SET `owner_current` = 0 WHERE `creature_guid` = " ..creature_guid.. " AND `owner_current` = 1;")
			local Static_Property_Query4 = WorldDBQuery("SELECT `character` FROM `eluna_property_owner` WHERE `character_guid` = " ..player:GetGUIDLow().. " AND `creature_guid` = " ..creature_guid.. ";")
			if Static_Property_Query4 == nil then
				WorldDBExecute("INSERT INTO `elunaworld`.`eluna_property_owner` (`creature_guid`, `owner_current`, `account`, `character`, `character_guid`, `property_lease`) VALUES ('" ..creature_guid.. "', '1', '" ..player:GetAccountName().. "', '" ..player:GetName().. "', '" ..player:GetGUIDLow().. "', '" ..lease_amount.. "');")
			else
				WorldDBExecute("UPDATE `eluna_property_owner` SET `owner_current` = 1 WHERE `creature_guid` = " ..creature_guid.. " AND `character_guid` = " ..player:GetGUIDLow().. ";")
			end
			player:SendBroadcastMessage("[Property System]: You bought " ..property_name.. " from " ..owner_name.. " for " ..lease_amount.. ".")
			return false
		elseif (intid == 4) then
			service_fee = Static_Property_Query3:GetInt32(2)
			auto_string, gold, silver, copper = TranslateCurrency(service_fee)
--			player:SendBroadcastMessage("[Property System]: The fee to operate on this property is " ..gold.. " Gold " ..silver.. " Silver " ..copper.. " Copper.")
			player:SendBroadcastMessage("[Property System]: The fee to operate on this property is " ..auto_string.. ".")
			return false
		end
	end
	
	-- owner intids
	if (intid >= 20) and (intid < 30) then
		local Static_Property_Query3 = WorldDBQuery("SELECT `character`, `property_lease` FROM `eluna_property_owner` WHERE `creature_guid` = " ..creature_guid.. " AND `owner_current` = 1;")
		if (intid == 21) then
			code = sterilize.generic(code)
			WorldDBExecute("UPDATE `eluna_property_static` SET `property_name` = '" ..code.. "' WHERE `creature_guid` = " ..creature_guid.. ";")
			player:SendBroadcastMessage("[Property System]: The property linked to creature GUID " ..creature_guid.. " has been renamed to " ..code.. ".")
			return false		
		elseif (intid == 22) then
			lease_amount_raw = Static_Property_Query3:GetInt32(1)
			if tonumber(code) == nil then
				player:SendBroadcastMessage("[Property System]: You must input a valid number.")
				return false
			elseif GetCurrency(player) < (code + lease_amount_raw) then
				player:SendBroadcastMessage("[Property System]: You do not have enough currency.")
				return false
			else
				ChangeCurrency(player, -1 * (code + lease_amount_raw))
				WorldDBExecute("UPDATE `eluna_property_owner` SET `property_lease` = '" ..(code + lease_amount_raw).. "' WHERE `creature_guid` = " ..creature_guid.. " AND `owner_current` = 1;")
				player:SendBroadcastMessage("[Property System]: The property linked to creature GUID " ..creature_guid.. " has been priced to " ..(code + lease_amount_raw).. ".")
				return false				
			end
		elseif (intid == 23) then
			if tonumber(code) == nil then
				player:SendBroadcastMessage("[Property System]: You must input a valid number.")
				return false
			else
				WorldDBExecute("UPDATE `eluna_property_owner` SET `property_fee` = '" ..code.. "' WHERE `creature_guid` = " ..creature_guid.. " AND `owner_current` = 1;")
				player:SendBroadcastMessage("[Property System]: The property service fee to creature GUID " ..creature_guid.. " has been priced to " ..code.. ".")
				return false	
			end
		end
	end
end
]]


-- temp solution for owners to get property items while an inventory UI is made
function PropertyHandlers.Temp_Get_Items(player)
	local target = player:GetSelection()
	if target == nil then
		player:SendBroadcastMessage("???")
		return false
	end
	
	print("SELECT item_entry, item_quantity FROM eluna_property_inventory WHERE creature_guid = " ..target:GetDBTableGUIDLow().. " AND char_guid = " ..player:GetGUIDLow().. ";")
	local Property_Query8 = WorldDBQuery("SELECT item_entry, item_quantity FROM eluna_property_inventory WHERE creature_guid = " ..target:GetDBTableGUIDLow().. " AND char_guid = " ..player:GetGUIDLow().. ";")
	if Property_Query8 == nil then
		player:SendBroadcastMessage("no inventory detected.")
		return false
	end
	
	for x=1,Property_Query8:GetRowCount(),1 do
		item_entry = Property_Query8:GetInt32(0)
		item_quantity = Property_Query8:GetInt32(1)
		player:AddItem(item_entry, item_quantity)
--		PrintInfo("[Property]: Player " ..player:GetGUIDLow().. " " ..player:GetName().. " has withdrawn " ..item_entry.. " " ..item_quantity.. ".")
		Property_Query8:NextRow()
	end
	player:SendBroadcastMessage("[Property System]: You have successfully withdrawn all items.")
	WorldDBExecute("UPDATE eluna_property_inventory SET item_quantity = 0 WHERE creature_guid = " ..target:GetDBTableGUIDLow().. " AND char_guid = " ..player:GetGUIDLow().. ";")
	PrintInfo("[Property]: Player " ..player:GetGUIDLow().. " " ..player:GetName().. " has withdrawn their inventory.")
end

-- here we make clicking an object cost money $$$
-- SERVICE FEE START
function PropertyHandlers.Service_Confirm(player, object_guid, object_entry)
	local Static_Property_Query7 = WorldDBQuery("SELECT eluna_property_owner.creature_guid,eluna_property_gameobjects.guid,eluna_property_owner.property_fee,eluna_property_owner.character_guid FROM eluna_property_gameobjects INNER JOIN eluna_property_owner ON eluna_property_owner.creature_guid WHERE eluna_property_owner.owner_current = 1 AND eluna_property_owner.creature_guid = eluna_property_gameobjects.creature_guid AND eluna_property_gameobjects.guid = " ..object_guid.. ";")
	if Static_Property_Query7 == nil then
		player:SendBroadcastMessage("HOW DID YOU GET THIS?")
		return false
	end
	
	local spell_to_cast = property_types_objects_spells[object_entry]
	if crafting_materials[spell_to_cast] ~= nil then
		for m=1,4,1 do
			if crafting_materials[spell_to_cast][m] == 0 then
				break
			elseif player:GetItemCount(crafting_materials[spell_to_cast][m]) < crafting_materials[spell_to_cast][(m + 4)] then
				player:SendBroadcastMessage("[Property System]: You do not have enough materials to craft this. Missing: " ..crafting_materials[spell_to_cast][(m + 4)].. "x " ..GetItemLink(crafting_materials[spell_to_cast][m]).. ".")
				return false
			end
		end
	end
	
	service_fee = Static_Property_Query7:GetInt32(2)
	creature_guid = Static_Property_Query7:GetInt32(0)
	owner_guid = Static_Property_Query7:GetInt32(3)
	if GetCurrency(player) < service_fee then
		player:SendBroadcastMessage("[Property System]: You do not have enough money to perform this action.")
		return false
	elseif GetCurrency(player) >= service_fee then
		ChangeCurrency(player, -1 * service_fee)
		-- add currency to owners
		_, gold_count, silver_count, copper_count = TranslateCurrency(service_fee)
		print("UPDATE eluna_property_inventory SET item_quantity = item_quantity + " ..gold_count.. " WHERE item_entry = 1999998 AND creature_guid = " ..creature_guid.. " AND char_guid = " ..owner_guid.. ";")
		WorldDBExecute("UPDATE eluna_property_inventory SET item_quantity = item_quantity + " ..gold_count.. " WHERE item_entry = 1999998 AND creature_guid = " ..creature_guid.. " AND char_guid = " ..owner_guid.. ";")
		WorldDBExecute("UPDATE eluna_property_inventory SET item_quantity = item_quantity + " ..copper_count.. " WHERE item_entry = 1999997 AND creature_guid = " ..creature_guid.. " AND char_guid = " ..owner_guid.. ";")
		WorldDBExecute("UPDATE eluna_property_inventory SET item_quantity = item_quantity + " ..silver_count.. " WHERE item_entry = 1999999 AND creature_guid = " ..creature_guid.. " AND char_guid = " ..owner_guid.. ";")
	end
	
	local gameobjects_table = player:GetGameObjectsInRange( 25, object_entry )
	if #gameobjects_table == nil then
		player:SendBroadcastMessage("WHAT?")
		return false
	end
	
	for x=1,#gameobjects_table,1 do
		if gameobjects_table[x]:GetDBTableGUIDLow() == object_guid then
			player:CastSpell( player, spell_to_cast, false)
		end
	end
end

local function Static_Property_OnUse(event, go, player)
	spell = property_types_objects_spells[go:GetEntry()]
	local Static_Property_Query7 = WorldDBQuery("SELECT eluna_property_owner.creature_guid,eluna_property_gameobjects.guid,eluna_property_owner.property_fee,eluna_property_gameobjects.entry FROM eluna_property_gameobjects INNER JOIN eluna_property_owner ON eluna_property_owner.creature_guid WHERE eluna_property_owner.owner_current = 1 AND eluna_property_owner.creature_guid = eluna_property_gameobjects.creature_guid AND eluna_property_gameobjects.guid = " ..go:GetDBTableGUIDLow().. ";")
	if Static_Property_Query7 == nil then
		player:SendBroadcastMessage("[Property System]: The object you just tried to use is not yet synced to an existing property.")
		return false
	else
		object_guid = go:GetDBTableGUIDLow()
		service_fee = TranslateCurrency(Static_Property_Query7:GetInt32(2))
		object_entry = Static_Property_Query7:GetInt32(3)
		AIO.Handle(player, "Properties", "POPUP_SERVICE", service_fee, object_guid, object_entry, spell)
	end
end

local function Static_Property_RegisterEvents()
	m = 0
	for x=1,#property_types_objects,1 do
		m = m + 1
		RegisterGameObjectEvent( property_types_objects[x], 14, Static_Property_OnUse)
	end
	print("[Property System]: " ..m.. " Object IDs registered for properties.")
end
Static_Property_RegisterEvents()
-- SERVICE FEE STOP



-- experimental stuff start

local function Property_Hello(event, player, creature)
	local creature_guid = creature:GetDBTableGUIDLow()
	local Property_Query1 = WorldDBQuery("SELECT creature_guid, property_name, property_lease, property_fee, confirmed, property_type FROM eluna_property_static WHERE creature_guid = " ..creature_guid.. ";")
	if Property_Query1 == nil then
		player:SendBroadcastMessage("[Property System]: Performing first time setup. Please talk to the NPC again.")
		WorldDBExecute("INSERT INTO `elunaworld`.`eluna_property_static` (`creature_guid`, `property_name`, `property_lease`, `property_fee`, `property_type`, `confirmed`) VALUES ('" ..creature_guid.. "', 'None', '54321', '12345', 'None', '0');")
		player:GossipClearMenu()
		player:GossipComplete()
		return false
	end

	is_confirmed = Property_Query1:GetInt32(4)
	property_name = Property_Query1:GetString(1)
	property_lease = Property_Query1:GetInt32(2)
	property_fee = Property_Query1:GetInt32(3)
	property_type = Property_Query1:GetString(5)
	is_owner = false
	race = 0
	gender = 0
	character = "None"
	
	local Property_Query3 = WorldDBQuery("SELECT `owner_current`,`character`,`property_lease`,`property_fee`,`gender`,`race`,`character_guid` FROM `eluna_property_owner` WHERE `creature_guid` = " ..creature_guid.. " AND `owner_current` = 1;")
	if Property_Query3 ~= nil then
		property_lease = Property_Query3:GetInt32(2)
		property_fee = Property_Query3:GetInt32(3)
		race = Property_Query3:GetInt32(5)
		gender = Property_Query3:GetInt32(4)
		character = Property_Query3:GetString(1)
		if Property_Query3:GetInt32(6) == player:GetGUIDLow() then
			is_owner = true
		end
	end
	
	is_gm = false
	_, gold_count_lease, silver_count_lease, copper_count_lease = TranslateCurrency(property_lease)
	_, gold_count_fee, silver_count_fee, copper_count_fee = TranslateCurrency(property_fee)
	if player:GetGMRank() >= ADMIN_LEVEL then
		is_gm = true
	end
	
	AIO.Handle(player, "Properties", "Show_Frame_Properties", is_gm, is_confirmed, property_name, gold_count_fee, silver_count_fee, copper_count_fee, gold_count_lease, silver_count_lease, copper_count_lease, property_type, gender, race, is_owner, character)
end

function PropertyHandlers.GM_Confirm(player, property_name, lease_gold, lease_silver, lease_copper, fee_gold, fee_silver, fee_copper, property_type, item_entries, item_quantities, property_type)
	
	if player:GetGMRank() < ADMIN_LEVEL then
		player:SendBroadcastMessage("How did you get this? Hax.")
		return false
	elseif (tonumber(lease_gold) == nil) or (tonumber(lease_silver) == nil) or (tonumber(lease_copper) == nil) or (tonumber(fee_gold) == nil) or (tonumber(fee_silver) == nil) or (tonumber(fee_copper) == nil) then
		player:SendBroadcastMessage("How did you get this? !!!")
		return false	
	end

	item_entries_list = {}
	item_entries_list = getCommandParameters(item_entries)	
	for x=1,#item_entries_list,1 do
		if tonumber(item_entries_list[x]) == nil then
			player:SendBroadcastMessage("[Property System]: You did not input a correct number for entry.")
			return false
		end
	end
	
	item_quantities_list = {}
	item_quantities_list = getCommandParameters(item_quantities)
	for x=1,#item_quantities_list,1 do
		if tonumber(item_quantities_list[x]) == nil then
			player:SendBroadcastMessage("[Property System]: You did not input a correct number for quantity.")
			return false
		end
	end
	
	if #item_quantities_list ~= #item_entries_list then
		player:SendBroadcastMessage("[Property System]: The entries and quantities provided do not align. Do you have an item quantity for every item entry?")
		return false
	end

	
	target = player:GetSelection()
	if target == nil then
		player:SendBroadcastMessage("How did you get this? :O")
		return false
	end
	
	creature_guid = target:GetDBTableGUIDLow()
	property_name = sterilize.generic(property_name)
	_, property_lease = TranslateCurrency(nil, lease_gold, lease_silver, lease_copper)
	_, property_fee = TranslateCurrency(nil, fee_gold, fee_silver, fee_copper)
	property_type = property_type
	WorldDBExecute("UPDATE `eluna_property_static` SET `property_name` = '" ..property_name.. "',`property_lease` = " ..property_lease.. ",`property_fee` = " ..property_fee.. ",`property_type` = '" ..property_type.. "',`item_entries` = '" ..item_entries.. "',`item_quantities` = '" ..item_quantities.. "',`confirmed` = 1 WHERE `creature_guid` = " ..creature_guid.. ";")
	WorldDBExecute("INSERT INTO `elunaworld`.`eluna_property_owner` (`creature_guid`, `owner_current`, `account`, `character`, `character_guid`, `property_lease`, `property_fee`, `gender`, `race`, `for_sale`) VALUES ('" ..creature_guid.. "', '1', '" ..player:GetAccountName().. "', 'None', '0', '" ..property_lease.. "', '" ..property_fee.. "', '0', '0', '0');")
	for m=1,#item_entries_list,1 do
		WorldDBExecute("INSERT INTO `elunaworld`.`eluna_property_inventory` (`creature_guid`, `char_guid`, `item_entry`, `item_quantity`, `sell_price`, `sell_active`) VALUES ('" ..creature_guid.. "', '0', '" ..item_entries_list[m].. "', '0', '0', '0');")
	end	
--	WorldDBExecute("INSERT INTO `elunaworld`.`eluna_property_inventory` (`creature_guid`, `char_guid`, `item_entry`, `item_quantity`, `sell_price`, `sell_active`) VALUES ('" ..creature_guid.. "', '" ..player:GetGUIDLow().. "', '" .. "', '123', '0', '0');")
	CloseNearbyMenus(player)
end

function PropertyHandlers.GM_Link(player, object_entry)
	if player:GetGMRank() < ADMIN_LEVEL then
		player:SendBroadcastMessage("oi this is for admins only m8")
		return false
	end
	
	local target = player:GetSelection()
	if target == nil then
		player:SendBroadcastMessage("howd you get this?")
		return false
	end
	
	local creature_guid = target:GetDBTableGUIDLow()
	local objects_in_range = player:GetGameObjectsInRange( 300, object_entry )
	local b = 0
	for m=1,#objects_in_range,1 do
		local object_guid = objects_in_range[m]:GetDBTableGUIDLow()
		local Property_Query6 = WorldDBQuery("SELECT `guid`,`creature_guid` FROM `eluna_property_gameobjects` WHERE `guid` = " ..object_guid.. ";")
		if Property_Query6 ~= nil then
			if Property_Query6:GetInt32(1) == creature_guid then
				player:SendBroadcastMessage("[Property System]: Gameobject with GUID " ..object_guid.. " is already linked to this property.")
			else
				player:SendBroadcastMessage("[Property System]: Gameobject with GUID " ..object_guid.. " is already linked to Property NPC " ..Property_Query6:GetInt32(1).. ".")
			end
		else
			WorldDBExecute("INSERT INTO `elunaworld`.`eluna_property_gameobjects` (`guid`, `entry`, `creature_guid`) VALUES ('" ..object_guid.. "', '" ..object_entry.. "', '" ..creature_guid.. "');")
			player:SendBroadcastMessage("[Property System]: Gameobject with GUID "..object_guid.. " has been successfully linked.")
			b = b + 1
		end
	end
	
	player:SendBroadcastMessage("[Property System]: " ..b.. " objects with entry " ..object_entry.. " have been linked to this property.")
	return false
end

function PropertyHandlers.Purchase_Property_Confirm(player)
	local target = player:GetSelection()
	if target == nil then
		player:SendBroadcastMessage("How did you get this message? :((")
		return false
	end
	
	local creature_guid = target:GetDBTableGUIDLow()
	local Property_Query3 = WorldDBQuery("SELECT `owner_current`,`character`,`property_lease`,`property_fee`,`gender`,`race`,`character_guid`,`for_sale`,`account` FROM `eluna_property_owner` WHERE `creature_guid` = " ..creature_guid.. " AND `owner_current` = 1;")
	if Property_Query3 == nil then
		player:SendBroadcastMessage("Uh oh you came across a boo boo. A fucky wucky.")
		return false
	end
	
	property_lease = Property_Query3:GetInt32(2)
	property_fee = Property_Query3:GetInt32(3)
	player_currency = GetCurrency(player)
	for_sale = Property_Query3:GetInt32(7)
	if player_currency < property_lease then
		player:SendBroadcastMessage("[Property System]: You do not have enough money to purchase this property.")
		return false
	elseif for_sale == 1 then
		player:SendBroadcastMessage("[Property System]: This property is not currently for sale.")
		return false
	end
	
	ChangeCurrency(player, -1 * property_lease)
	
	-- has the player ever been an owner?
	local player_guid = player:GetGUIDLow()
	local Property_Query4 = WorldDBQuery("SELECT `character_guid` FROM `eluna_property_owner` WHERE `creature_guid` = " ..creature_guid.." AND `character_guid` = " ..player_guid.. ";")
	WorldDBExecute("UPDATE `eluna_property_owner` SET `owner_current` = 0 WHERE `owner_current` = 1 AND `creature_guid` = " ..creature_guid.. ";")
	if Property_Query4 == nil then
		WorldDBExecute("INSERT INTO `elunaworld`.`eluna_property_owner` (`creature_guid`, `owner_current`, `account`, `character`, `character_guid`, `property_lease`, `property_fee`, `gender`, `race`, `for_sale`) VALUES ('" ..creature_guid.. "', '1', '" ..player:GetAccountName().. "', '" ..player:GetName().. "', '" ..player_guid.. "', '" ..property_lease.. "', '" ..property_fee.. "', '" ..player:GetGender().. "', '" ..player:GetRace().. "', '1');")
		local Property_Query7 = WorldDBQuery("SELECT item_entries FROM `eluna_property_static` WHERE `creature_guid` = " ..creature_guid.. ";")
		item_entries = {}
		item_entries = getCommandParameters(Property_Query7:GetString(0))
		for m=1,#item_entries,1 do
			WorldDBExecute("INSERT INTO `elunaworld`.`eluna_property_inventory` (`creature_guid`, `char_guid`, `item_entry`, `item_quantity`, `sell_price`, `sell_active`) VALUES ('" ..creature_guid.. "', '" ..player_guid.. "', '" ..item_entries[m].. "', '0', '0', '0');")
		end		
	else
		WorldDBExecute("UPDATE `eluna_property_owner` SET `owner_current` = 1, `for_sale` = 1 WHERE `creature_guid` = " ..creature_guid.. " AND `character_guid` = " ..player_guid.. ";")
	end
	
	-- dump inventory and property $$$ in new mail for previous owner
	local previous_owner_name = Property_Query3:GetString(1)
	local previous_owner_guid = Property_Query3:GetInt32(6)
	local previous_owner_account = Property_Query3:GetString(8)
	local Mail_Query3 = WorldDBQuery("SELECT `item_entry`,`item_quantity` FROM `eluna_property_inventory` WHERE `char_guid` = '" ..previous_owner_guid.. "' AND `creature_guid` = '" ..creature_guid.. "';") -- query for rest of inventory
	local auto_string, gold_count, silver_count, copper_count = TranslateCurrency(property_lease)
	local mail_text = "Congratulations! Your property has been bought for " ..gold_count.. " Gold " ..silver_count.. " Silver " ..copper_count.. " Copper."
	SendMail( "Property Purchased", mail_text, previous_owner_guid, player_guid, 61, 0, 0, 0, GOLD_COIN, gold_count )
	SendMail( "Property Purchased", mail_text, previous_owner_guid, player_guid, 61, 0, 0, 0, SILVER_COIN, silver_count )
	SendMail( "Property Purchased", mail_text, previous_owner_guid, player_guid, 61, 0, 0, 0, COPPER_COIN, copper_count )
	local mail_text = "Here is your inventory from your purchased property"
	
	if Mail_Query3 ~= nil then -- if inventory exists, do thing
		for m=1,Mail_Query3:GetRowCount(),1 do
			local mail_item_entry = Mail_Query3:GetInt32(0)
			local mail_item_quantity = Mail_Query3:GetInt32(1)
			--print(mail_item_entry, mail_item_quantity) -- debug statement
			if mail_item_quantity > 0 then
				SendMail( "Property Purchased", mail_text, previous_owner_guid, player_guid, 61, 0, 0, 0, mail_item_entry, mail_item_quantity )
			end
			Mail_Query3:NextRow()
		end
		WorldDBExecute("UPDATE `eluna_property_inventory` SET `item_quantity` = 0 WHERE `char_guid` = '" ..previous_owner_guid.. "' AND `creature_guid` = '" ..creature_guid.. "';")
	end
	
	player:SendBroadcastMessage("[Property System]: You have purchased this property from " ..previous_owner_name.. " for " ..auto_string.. ".")
	print("[Property System]: " ..player:GetName().. " : " ..player:GetAccountName().. " has purchased property from " ..previous_owner_name.. " : " ..previous_owner_account.. " with creature GUID: " ..creature_guid.. " for " ..property_lease.. ".")
	CloseNearbyMenus(player, target)
end

function PropertyHandlers.Property_Name_Confirm(player, property_name)
	local target = player:GetSelection()
	if target == nil then
		player:SendBroadcastMessage("huh?")
		return false
	end
	
	creature_guid = target:GetDBTableGUIDLow()
	property_name = sterilize.generic(property_name)
	local Property_Query5 = WorldDBQuery("SELECT `character_guid` FROM `eluna_property_owner` WHERE `owner_current` = 1 AND `character_guid` = " ..player:GetGUIDLow().. " AND `creature_guid` = '" ..creature_guid.. "';")
	if Property_Query5 == nil then
		player:SendBroadcastMessage("[Property System]: You are not the owner of this property.")
		return false
	else
		WorldDBExecute("UPDATE `eluna_property_static` SET `property_name` = '" ..property_name.. "' WHERE `creature_guid` = '" ..creature_guid.. "';")
		player:SendBroadcastMessage("[Property System]: You have updated your property name to " ..property_name.. ".")
		return false
	end
end

function PropertyHandlers.Property_Lease_Confirm(player, lease_gold, lease_silver, lease_copper)
	local target = player:GetSelection()
	if target == nil then
		player:SendBroadcastMessage("huh?")
		return false
	end
	
	creature_guid = target:GetDBTableGUIDLow()
	if tonumber(lease_gold) == nil or tonumber(lease_silver) == nil or tonumber(lease_copper) == nil then
		player:SendBroadcastMessage("your lease amounts are nil.")
		return false
	end
	
	local Property_Query5 = WorldDBQuery("SELECT `character_guid`,`property_lease`,`for_sale` FROM `eluna_property_owner` WHERE `owner_current` = 1 AND `character_guid` = " ..player:GetGUIDLow().. " AND `creature_guid` = '" ..creature_guid.. "';")
	if Property_Query5 == nil then
		player:SendBroadcastMessage("[Property System]: You are not the owner of this property.")
		return false
	end
	
	local auto_string, money = TranslateCurrency(nil, lease_gold, lease_silver, lease_copper)
	property_lease = Property_Query5:GetInt32(1)
--	if money < property_lease then
--		player:SendBroadcastMessage("[Property System]: You cannot make the lease lower.")
--		return false
--	end
	
	local player_currency = GetCurrency(player)
--	local difference = money - property_lease
--	if player_currency < (difference) then
--		player:SendBroadcastMessage("[Property System]: You do not have enough to deposit into the lease.")
--		return false
--	end
	
	if Property_Query5:GetInt32(2) == 1 then
		WorldDBExecute("UPDATE eluna_property_owner SET `for_sale` = 0 WHERE `creature_guid` = '" ..creature_guid.. "' AND `character_guid` = '" ..player:GetGUIDLow().. "';")
		state = "FOR SALE"
	else
		WorldDBExecute("UPDATE eluna_property_owner SET `for_sale` = 1 WHERE `creature_guid` = '" ..creature_guid.. "' AND `character_guid` = '" ..player:GetGUIDLow().. "';") 
		state = "NOT FOR SALE"
	end
	
--	ChangeCurrency(player, -1 * difference)
	local auto_string2 = TranslateCurrency(difference)
	WorldDBExecute("UPDATE `eluna_property_owner` SET `property_lease` = '" ..money.. "' WHERE `creature_guid` = '" ..creature_guid.. "' AND `character_guid` = '" ..player:GetGUIDLow().. "';")
--	player:SendBroadcastMessage("[Property System]: You have deposited " ..auto_string2.. " into the lease on your property, making the total lease " ..auto_string.. ".")
	player:SendBroadcastMessage("[Property System]: You have set your property price to " ..auto_string.. " and the property is now " ..state.. ".")
	return false
end

function PropertyHandlers.Property_Service_Confirm(player, fee_gold, fee_silver, fee_copper)
	local target = player:GetSelection()
	if target == nil then
		player:SendBroadcastMessage("huh?")
		return false
	end
	
	creature_guid = target:GetDBTableGUIDLow()
	if tonumber(fee_gold) == nil or tonumber(fee_silver) == nil or tonumber(fee_copper) == nil then
		player:SendBroadcastMessage("your lease amounts are nil.")
		return false
	end
	
	local Property_Query5 = WorldDBQuery("SELECT `character_guid`,`property_lease` FROM `eluna_property_owner` WHERE `owner_current` = 1 AND `character_guid` = " ..player:GetGUIDLow().. " AND `creature_guid` = '" ..creature_guid.. "';")
	if Property_Query5 == nil then
		player:SendBroadcastMessage("[Property System]: You are not the owner of this property.")
		return false
	else
		local auto_string, money = TranslateCurrency(nil, fee_gold, fee_silver, fee_copper)
		WorldDBExecute("UPDATE `eluna_property_owner` SET `property_fee` = '" ..money.. "' WHERE `creature_guid` = '" ..creature_guid.. "' AND `character_guid` = '" ..player:GetGUIDLow().. "';")
		player:SendBroadcastMessage("[Property System]: You have updated the service charge on your property to " ..auto_string.. ".")
		return false
	end
end

-- called to close nearby menus on confirm purchase etc
function CloseNearbyMenus(player, target)
	local player_list = player:GetPlayersInRange(25)
	for x=1,#player_list,1 do
		if player_list[x]:GetSelection() == target then
			AIO.Handle(player_list[x], "Properties", "Close_Menus")
		end
	end
end

-- apply 2 stacks of training buff
TRAINING_DUMMY_BUFF = 2000043
local function TrainingBuff(event, player, spell, skipCheck)
	if spell:GetEntry() ~= TRAINING_DUMMY_BUFF then
		return false
	else
		player:AddAura(TRAINING_DUMMY_BUFF, player)
		return false
	end
end

EXPERIMENT_NPC = 1000205
RegisterCreatureGossipEvent(EXPERIMENT_NPC, 1, Property_Hello)
RegisterPlayerEvent(5, TrainingBuff)

-- experimental stuff done




-- how often do you want to flush properties and give them items?
-- TIME_TO_FLUSH = 86400
TIME_TO_FLUSH = 86400

-- every 15mins this function is ran. it gets the gametime and puts it in a table if it doesnt exist. if it does, and its compared to an old timestamp, and that timestamp is 24+ hours old, do stuff.
local function Static_Property_Flush(eventId, delay, repeats)
	local Played_Query3 = WorldDBQuery("SELECT `time` FROM timestamps WHERE `type` = 3;") -- type 3 = server gametime, saved every "CreateLuaEvent". we use this instead of type 2 because type2 is exclusive to wagecuck system.
	if (Played_Query3 == nil) then
		WorldDBExecute("INSERT INTO `elunaworld`.`timestamps` (`type`, `time`) VALUES ('3', '" ..tostring(GetGameTime()).. "');") -- type 2 = server gametime, saved every "CreateLuaEvent".
	elseif ((GetGameTime() - Played_Query3:GetInt32(0)) >= TIME_TO_FLUSH) then -- if (Current servertime - saved servertime) is more than 7 days (604800 seconds)
		local Static_Property_Query5 = WorldDBQuery("SELECT eluna_property_owner.creature_guid,eluna_property_owner.character_guid,eluna_property_static.item_entries,eluna_property_static.item_quantities FROM eluna_property_static INNER JOIN eluna_property_owner ON eluna_property_owner.creature_guid WHERE eluna_property_owner.owner_current = 1 AND eluna_property_owner.creature_guid = eluna_property_static.creature_guid;")
		if Static_Property_Query5 == nil then
			PrintInfo("[Property System]: No active properties detected.")
			return
		end
		
		PrintInfo("[Property System]: Flushing properties...")
		for x=1,Static_Property_Query5:GetRowCount(),1 do
			item_entries = {}
			item_entries = getCommandParameters(Static_Property_Query5:GetString(2))
			item_quantities = {}
			item_quantities = getCommandParameters(Static_Property_Query5:GetString(3))
			char_guid_flush = Static_Property_Query5:GetInt32(1)
			for m=1,#item_entries,1 do
				WorldDBExecute("UPDATE `eluna_property_inventory` SET item_quantity = item_quantity + " ..item_quantities[m].. " WHERE item_entry = " ..item_entries[m].. " AND `char_guid` = " ..char_guid_flush.. ";")
			end
			Static_Property_Query5:NextRow()
		end
		
		WorldDBExecute("UPDATE timestamps SET `time` = " ..tostring(GetGameTime()).. " WHERE `type` = 3;")
		PrintInfo("[Property System]: Flushing properties done.")
		SendWorldMessage("[Property System]: Flushing properties...")
	end
end
-- CreateLuaEvent(Static_Property_Flush, 900000, 0) -- 900,000 milliseconds is 15 minutes. That's the save interval in worldserver config.
CreateLuaEvent(Static_Property_Flush, 15000, 0)


-- RegisterCreatureGossipEvent(PROPERTY_NPC, 1, Static_Property_Hello)
-- RegisterCreatureGossipEvent(PROPERTY_NPC, 2, Static_Property_Select)