-- Owner: grimreapaa

-- What does this script do?
-- When a Search! request comes from the client, it does a formatted query string. These query strings are based on many of the arrays below within the ShopQuery function. 
-- It then replies back with a list of query results and the client populates frames based on the reply.
-- Also does a purchase check query, checking the price tag of item_add. Only sends a query result if the item exists in item_add and item_template.


local AIO = AIO or require("AIO")
local ShopHandlers = AIO.AddHandlers("Shop", {})
local ToolBarHandlers = AIO.AddHandlers("ToolBar", {})

item_name_array = {
["Gear Token"] = 1999996,
["Copper"] = 1999997,
["Gold"] = 1999998,
["Silver"] = 1999999,
["Starter Token"] = 1999940,
["Blacksmith Token"] = 1999945,
["Leatherwork Token"] = 1999944,
["Tailor Token"] = 1999949,
["Alchemy Token"] = 1999951,
["Inscription Token"] = 1999954,
["Mystic Token"] = 1999926,
["First Aid Token"] = 1999941,
["Cooking Token"] = 1999943,
["Carpenter Token"] = 1999947,
}

-- currency for currency functions
SILVER_COIN = 1999999
GOLD_COIN = 1999998
COPPER_COIN = 1999997

function ShopHandlers.ShopQuery(player, editbox, item_type, min_cost, max_cost, item_name)

	--EDITBOX VARIABLE
	--edit box isnt blank = input.
	if (editbox ~= "") or (editbox ~= nil) then
		-- we do not need to format editbox to an sql query because the default sql query begins by looking for editbox string. everything afterwards is considered AND.
		editbox = sterilize.generic(editbox)
	else
		editbox = ""
	end
--	print("'" ..editbox.. "'")
	
	--END EDITBOX VARIABLE
	
	---MIN/MAX VARIALBES
	-- not "..." = not default, meaning input.
	if min_cost ~= "..." then
		-- check if that input is a number or not.
		if (tonumber(min_cost) ~= nil) then
			min_string = " AND `cost` >= '" ..min_cost.. "'"
		else
			player:SendBroadcastMessage("You must input a numb - Wait a minute, HACKER!")
			return false
		end
	else
		min_string = ""
	end
	
	if max_cost ~= "..." then
		if (tonumber(max_cost) ~= nil) then
			max_string = " AND `cost` <= '" ..max_cost.. "'"
		else
			player:SendBroadcastMessage("You must input a numb - Wait a minute, HACKER!")
			return false
		end
	else
		max_string = ""
	end
	
	-- check if min_cost and max_cost are not defaults or empty strings, which means they have input and have been checked for number. 
	if max_string ~= "" and max_string ~= "..." and min_string ~= "" and min_string ~= "..." then
		min_cost = tonumber(min_cost)
		max_cost = tonumber(max_cost)
	--	print(min_cost.. ":" ..max_cost)
		if min_cost > max_cost then
			player:SendBroadcastMessage("Your minimum is greater than your maximum.")
			return false
		end
	end
	-- END MIN/MAX VARIALBES
	
	--ITEM_NAME (cost_name) VARIABLE
	--does not = "item cost" = not default. which means input.
	if item_name ~= "Item Cost" and item_name ~= "None" then
		if item_name_array[item_name] ~= nil then
			item_name = item_name -- just to clarify that if it exists in the array, we still keep item_name
			cost_name_string = " AND `cost_name` = '" ..item_name.. "'"
		else
			-- should never not have an array entry
			player:SendBroadcastMessage("You must have a valid currency. Inform the system administrator to view the [Shop] logs.")
			PrintInfo("[Shop]: Player " ..player:GetName().. " tried to use an invalid currency to search. Is it in the item_name_array?")
		end
	else
		item_name = nil
		item_name_entry = nil
		link2 = nil
		cost_name_string = ""
	end
	--END ITEM_NAME VARIABLE
	

item_type_subclass = {
["Warrior"] = 4,
["Paladin"] = 4,
["Hunter"] = 3,
["Rogue"] = 2,
["Priest"] = 1,
["Shaman"] = 3,
["Mage"] = 1,
["Warlock"] = 1,
["Druid"] = 2
}

item_type_subclass_weapon_1h = {
["Warrior"] = "(0, 4, 7, 15, 13)",
["Paladin"] = "(0, 4, 7)",
["Hunter"] = "(0, 15, 7, 13)",
["Rogue"] = "(15, 0, 4, 7, 13)",
["Priest"] = "(15, 4)",
["Shaman"] = "(0, 15, 4, 13)",
["Mage"] = "(15, 7)",
["Warlock"] = "(15, 7)",
["Druid"] = "(13, 15, 4)"
}

item_type_subclass_weapon_2h = {
["Warrior"] = "(1, 5, 8, 10, 6)",
["Paladin"] = "(1, 5, 8, 6)",
["Hunter"] = "(1, 8, 10, 6)",
-- rogue is -1 because they cannot wield any 2h
["Rogue"] = "(-1)",
["Priest"] = "(10)",
["Shaman"] = "(10, 1, 5)",
["Mage"] = "(10)",
["Warlock"] = "(10)",
["Druid"] = "(10, 5, 6)"
}

item_type_subclass_weapon_ranged = {
["Warrior"] = "(2, 3, 16, 18)",
["Paladin"] = "(-1)",
["Hunter"] = "(2, 3, 16, 18)",
["Rogue"] = "(2, 3, 16, 18)",
["Priest"] = "(19)",
["Shaman"] = "(-1)",
["Mage"] = "(19)",
["Warlock"] = "(19)",
["Druid"] = "(-1)"
}

	-- here we define subclass based on class so we show armor only available to that class.
	item_type_subclass_selection = item_type_subclass[player:GetClassAsString(0)]
	item_type_subclass_weapon_1h_selection = item_type_subclass_weapon_1h[player:GetClassAsString(0)]
	item_type_subclass_weapon_2h_selection = item_type_subclass_weapon_2h[player:GetClassAsString(0)]
	item_type_subclass_weapon_ranged_selection = item_type_subclass_weapon_ranged[player:GetClassAsString(0)]
	if item_type_subclass_selection == nil or item_type_subclass_weapon_1h_selection == nil or item_type_subclass_weapon_2h_selection == nil or item_type_subclass_weapon_ranged_selection == nil then
		PrintInfo("[Shop]: Tried searching subclass for an unsupported player class!")
		return false
	end
	
	-- here we preload APTs from item_add template for better modular support in the query
	
	
item_type_array = {
["PvP Stats:Head"] = " AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND stat_type1 = 35 AND inventorytype = 1 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 1 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 1 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 1 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 1 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 1 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 1 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 1 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 1 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 1 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  ",
["PvP Stats:Necklace"] = " AND item_template.entry <= 1000000 AND stat_type1 = 35 AND inventorytype = 2 AND class = 4 AND subclass = 0 AND itemlevel >= 200 OR stat_type2 = 35 AND item_template.entry <= 1000000 AND inventorytype = 2 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type3 = 35 AND item_template.entry <= 1000000 AND inventorytype = 2 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type4 = 35 AND item_template.entry <= 1000000 AND inventorytype = 2 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type5 = 35 AND item_template.entry <= 1000000 AND inventorytype = 2 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type6 = 35 AND item_template.entry <= 1000000 AND inventorytype = 2 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type7 = 35 AND item_template.entry <= 1000000 AND inventorytype = 2 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type8 = 35 AND item_template.entry <= 1000000 AND inventorytype = 2 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type9 = 35 AND item_template.entry <= 1000000 AND inventorytype = 2 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type10 = 35 AND item_template.entry <= 1000000 AND inventorytype = 2 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  ",
["PvP Stats:Shoulders"] = " AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND stat_type1 = 35 AND inventorytype = 3 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 3 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 3 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 3 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 3 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 3 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 3 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 3 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 3 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 3 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  ",
["PvP Stats:Back"] = " AND stat_type1 = 35 AND item_template.entry >= 1000000 AND inventorytype = 16 AND class = 4 AND subclass = 1 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type2 = 35 AND item_template.entry >= 1000000 AND inventorytype = 16 AND class = 4 AND subclass = 1 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%' OR stat_type3 = 35 AND item_template.entry >= 1000000 AND inventorytype = 16 AND class = 4 AND subclass = 1 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%' OR stat_type4 = 35 AND item_template.entry >= 1000000 AND inventorytype = 16 AND class = 4 AND subclass = 1 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%' OR stat_type5 = 35 AND item_template.entry >= 1000000 AND inventorytype = 16 AND class = 4 AND subclass = 1 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%' OR stat_type6 = 35 AND item_template.entry >= 1000000 AND inventorytype = 16 AND class = 4 AND subclass = 1 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%' OR stat_type7 = 35 AND item_template.entry >= 1000000 AND inventorytype = 16 AND class = 4 AND subclass = 1 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%' OR stat_type8 = 35 AND item_template.entry >= 1000000 AND inventorytype = 16 AND class = 4 AND subclass = 1 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%' OR stat_type9 = 35 AND item_template.entry >= 1000000 AND inventorytype = 16 AND class = 4 AND subclass = 1 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%' OR stat_type10 = 35 AND item_template.entry >= 1000000 AND inventorytype = 16 AND class = 4 AND subclass = 1 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%' ",
["PvP Stats:Chest"] = " AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND stat_type1 = 35 AND inventorytype IN (5, 20) AND class = 4 AND subclass = " ..item_type_subclass_selection.. " OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype IN (5, 20) AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype IN (5, 20) AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype IN (5, 20) AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype IN (5, 20) AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype IN (5, 20) AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype IN (5, 20) AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype IN (5, 20) AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype IN (5, 20) AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype IN (5, 20) AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  ",
["PvP Stats:Wrist"] = " AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND stat_type1 = 35 AND inventorytype = 9 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 9 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 9 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 9 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 9 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 9 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 9 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 9 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 9 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 9 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  ",
["PvP Stats:Hands"] = " AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND stat_type1 = 35 AND inventorytype = 10 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 10 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 10 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 10 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 10 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 10 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 10 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 10 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 10 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 10 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  ",
["PvP Stats:Waist"] = " AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND stat_type1 = 35 AND inventorytype = 6 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 6 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 6 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 6 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 6 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 6 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 6 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 6 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 6 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 6 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  ",
["PvP Stats:Legs"] = " AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND stat_type1 = 35 AND inventorytype = 7 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 7 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 7 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 7 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 7 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 7 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 7 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 7 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 7 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 7 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  ",
["PvP Stats:Feet"] = " AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND stat_type1 = 35 AND inventorytype = 8 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 8 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 8 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 8 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 8 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 8 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 8 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 8 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 8 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "   OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.displayid = 0 AND item_template.entry <= 2000000 AND inventorytype = 8 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = " ..item_type_subclass_selection.. " " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  ",
["PvP Stats:Finger"] = " AND item_template.entry <= 1000000 AND stat_type1 = 35 AND inventorytype = 11 AND class = 4 AND subclass = 0 AND itemlevel >= 200 OR stat_type2 = 35 AND item_template.entry <= 1000000 AND inventorytype = 11 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type3 = 35 AND item_template.entry <= 1000000 AND inventorytype = 11 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type4 = 35 AND item_template.entry <= 1000000 AND inventorytype = 11 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type5 = 35 AND item_template.entry <= 1000000 AND inventorytype = 11 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type6 = 35 AND item_template.entry <= 1000000 AND inventorytype = 11 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type7 = 35 AND item_template.entry <= 1000000 AND inventorytype = 11 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type8 = 35 AND item_template.entry <= 1000000 AND inventorytype = 11 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type9 = 35 AND item_template.entry <= 1000000 AND inventorytype = 11 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type10 = 35 AND item_template.entry <= 1000000 AND inventorytype = 11 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  ",
["PvP Stats:Trinket"] = " AND item_template.entry <= 1000000 AND stat_type1 = 35 AND inventorytype = 12 AND class = 4 AND subclass = 0 AND itemlevel >= 200 OR stat_type2 = 35 AND item_template.entry <= 1000000 AND inventorytype = 12 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type3 = 35 AND item_template.entry <= 1000000 AND inventorytype = 12 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type4 = 35 AND item_template.entry <= 1000000 AND inventorytype = 12 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type5 = 35 AND item_template.entry <= 1000000 AND inventorytype = 12 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type6 = 35 AND item_template.entry <= 1000000 AND inventorytype = 12 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type7 = 35 AND item_template.entry <= 1000000 AND inventorytype = 12 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type8 = 35 AND item_template.entry <= 1000000 AND inventorytype = 12 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type9 = 35 AND item_template.entry <= 1000000 AND inventorytype = 12 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0  AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  OR stat_type10 = 35 AND item_template.entry <= 1000000 AND inventorytype = 12 AND item_template.`name` LIKE '%" ..editbox.. "%' AND class = 4 AND subclass = 0 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  ",
["PvP Stats:One-handed Weapon"] = " AND stat_type1 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_1h_selection.. " AND itemlevel >= 200 AND item_template.displayid = 0 OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_1h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_1h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_1h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_1h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_1h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_1h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_1h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_1h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_1h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0",
["PvP Stats:Two-handed Weapon"] = " AND stat_type1 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_2h_selection.. " AND itemlevel >= 200 AND item_template.displayid = 0 OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_2h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_2h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_2h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_2h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_2h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_2h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_2h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_2h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_2h_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0",
["PvP Stats:Shield"] = " AND stat_type1 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 4 AND subclass = 6 AND itemlevel >= 200 AND item_template.displayid = 0 OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 4 AND subclass = 6 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 4 AND subclass = 6 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 4 AND subclass = 6 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 4 AND subclass = 6 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 4 AND subclass = 6 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 4 AND subclass = 6 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 4 AND subclass = 6 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0  OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 4 AND subclass = 6 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0  OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 4 AND subclass = 6 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0",
["PvP Stats:Off-hand"] = " AND stat_type1 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND inventorytype = 23 AND itemlevel >= 200 AND item_template.displayid = 0 OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND inventorytype = 23 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND inventorytype = 23 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND inventorytype = 23 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND inventorytype = 23 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND inventorytype = 23 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND inventorytype = 23 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND inventorytype = 23 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0  OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND inventorytype = 23 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0  OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND inventorytype = 23 AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0",
["PvP Stats:Ranged"] = " AND stat_type1 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_ranged_selection.. " AND itemlevel >= 200 AND item_template.displayid = 0 OR stat_type2 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_ranged_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type3 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_ranged_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type4 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_ranged_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type5 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_ranged_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type6 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_ranged_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type7 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_ranged_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type8 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_ranged_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type9 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_ranged_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0 OR stat_type10 = 35 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_ranged_selection.. " AND itemlevel >= 200 " ..min_string.. "" ..max_string.. "" ..cost_name_string.. "  AND item_template.`name` LIKE '%" ..editbox.. "%'  AND item_template.displayid = 0",
["PvP Stats:Relic/Totem/Libram"] = " AND item_template.entry <= 1000000 AND inventorytype = 28 AND class = 4 AND item_template.`name` LIKE '%Gladiator''s%' AND subclass IN (7, 8, 9, 10) AND itemlevel >= 200 ",
["PvE Stats:Head"] = " AND inventorytype = 1 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " ",
["PvE Stats:Necklace"] = " AND inventorytype = 2 AND item_template.entry <= 1000000 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = 0 AND itemlevel >= 200 ",
["PvE Stats:Shoulders"] = " AND inventorytype = 3 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " ",
["PvE Stats:Back"] = " AND inventorytype = 16 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = 1 AND itemlevel >= 200 AND item_template.displayid = 0 ",
["PvE Stats:Chest"] = " AND inventorytype IN (5, 20) AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " ",
["PvE Stats:Wrist"] = " AND inventorytype = 9 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " ",
["PvE Stats:Hands"] = " AND inventorytype = 10 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " ",
["PvE Stats:Waist"] = " AND inventorytype = 6 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " ",
["PvE Stats:Legs"] = " AND inventorytype = 7 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " ",
["PvE Stats:Feet"] = " AND inventorytype = 8 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = " ..item_type_subclass_selection.. " ",
["PvE Stats:Finger"] = " AND inventorytype = 11 AND item_template.entry <= 1000000 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = 0 AND itemlevel >= 200 ",
["PvE Stats:Trinket"] = " AND inventorytype = 12 AND item_template.entry <= 1000000 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = 0 AND itemlevel >= 200 ",
["PvE Stats:One-handed Weapon"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_1h_selection.. " ",
["PvE Stats:Two-handed Weapon"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_2h_selection.. " ",
["PvE Stats:Shield"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass = 6 ",
["PvE Stats:Off-hand"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND inventorytype = 23 ",
["PvE Stats:Ranged"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid = 0 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 2 AND subclass IN " ..item_type_subclass_weapon_ranged_selection.. " ",
["PvE Stats:Relic/Totem/Libram"] = " AND inventorytype = 28 AND item_template.`name` NOT LIKE '%Gladiator''s%' AND item_template.entry <= 1000000 AND stat_type1 != 35 AND stat_type2 != 35 AND stat_type3 != 35 AND stat_type4 != 35 AND stat_type5 != 35 AND stat_type6 != 35 AND stat_type7 != 35 AND stat_type8 != 35 AND stat_type9 != 35 AND stat_type10 != 35 AND class = 4 AND subclass IN (7, 8, 9, 10) AND itemlevel >= 200 ",
["Head"] = " AND inventorytype = 1 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0",
["Head:Cloth"] = " AND inventorytype = 1 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 1",
["Head:Leather"] = " AND inventorytype = 1 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 2",
["Head:Mail"] = " AND inventorytype = 1 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 3",
["Head:Plate"] = " AND inventorytype = 1 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 4",
["Shoulders"] = " AND inventorytype = 3 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0",
["Shoulders:Cloth"] = " AND inventorytype = 3 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 1",
["Shoulders:Leather"] = " AND inventorytype = 3 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 2",
["Shoulders:Mail"] = " AND inventorytype = 3 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 3",
["Shoulders:Plate"] = " AND inventorytype = 3 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 4",
["Back"] = " AND inventorytype = 16 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0",
["Chest"] = " AND inventorytype IN (5, 20) AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0",
["Shirt"] = " AND inventorytype IN (4) AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0",
["Tabard"] = " AND inventorytype IN (19) AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0",
["Chest:Cloth"] = " AND inventorytype IN (5, 20) AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 1",
["Chest:Leather"] = " AND inventorytype IN (5, 20) AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 2",
["Chest:Mail"] = " AND inventorytype IN (5, 20) AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 3",
["Chest:Plate"] = " AND inventorytype IN (5, 20) AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 4",
["Wrist"] = " AND inventorytype = 9 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0",
["Wrist:Cloth"] = " AND inventorytype = 9 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 1",
["Wrist:Leather"] = " AND inventorytype = 9 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 2",
["Wrist:Mail"] = " AND inventorytype = 9 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 3",
["Wrist:Plate"] = " AND inventorytype = 9 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 4",
["Hands"] = " AND inventorytype = 10 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0",
["Hands:Cloth"] = " AND inventorytype = 10 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 1",
["Hands:Leather"] = " AND inventorytype = 10 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 2",
["Hands:Mail"] = " AND inventorytype = 10 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 3",
["Hands:Plate"] = " AND inventorytype = 10 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 4",
["Waist"] = " AND inventorytype = 6 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0",
["Waist:Cloth"] = " AND inventorytype = 6 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 1",
["Waist:Leather"] = " AND inventorytype = 6 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 2",
["Waist:Mail"] = " AND inventorytype = 6 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 3",
["Waist:Plate"] = " AND inventorytype = 6 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 4",
["Legs"] = " AND inventorytype = 7 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0",
["Legs:Cloth"] = " AND inventorytype = 7 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 1",
["Legs:Leather"] = " AND inventorytype = 7 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 2",
["Legs:Mail"] = " AND inventorytype = 7 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 3",
["Legs:Plate"] = " AND inventorytype = 7 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 4",
["Feet"] = " AND inventorytype = 8 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0",
["Feet:Cloth"] = " AND inventorytype = 8 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 1",
["Feet:Leather"] = " AND inventorytype = 8 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 2",
["Feet:Mail"] = " AND inventorytype = 8 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 3",
["Feet:Plate"] = " AND inventorytype = 8 AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 4 AND subclass = 4",
["One-handed Weapon"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (0, 4, 7, 15, 13)",
["One-handed Weapon:Axe"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (0)",
["One-handed Weapon:Sword"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (7)",
["One-handed Weapon:Mace"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (4)",
["One-handed Weapon:Dagger"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (15)",
["One-handed Weapon:Fist"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (13)",
["Two-handed Weapon"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (1, 5, 8, 10, 6)",
["Two-handed Weapon:Axe"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (1)",
["Two-handed Weapon:Sword"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (8)",
["Two-handed Weapon:Mace"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (5)",
["Two-handed Weapon:Staff"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (10)",
["Two-handed Weapon:Polearm"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (6)",
["Off-hand"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND inventorytype IN (22, 23)",
["Off-hand:Shield"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND inventorytype IN (14)",
["Off-hand:Other"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND inventorytype IN (23)",
["Ranged"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass IN (2, 3, 16, 18, 19)",
["Ranged:Bow"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass = 2",
["Ranged:Crossbow"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass = 18",
["Ranged:Gun"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass = 3",
["Ranged:Wand"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass = 19",
["Ranged:Thrown"] = " AND item_template.entry >= 1000000 AND item_template.entry <= 2000000 AND item_template.displayid != 0 AND class = 2 AND subclass = 16",
["Mounts"] = " AND class = 15 and subclass = 5",
["Mounts:Horde"] = " AND class = 15 and subclass = 5 and allowablerace = 690",
["Mounts:Alliance"] = " AND class = 15 and subclass = 5 and allowablerace = 1101",
["Mounts:Other"] = " AND class = 15 and subclass = 5 and allowablerace NOT IN (690, 1101)",
["Enchants"] = " AND item_template.`name` LIKE '%visual%'",
-- because APTs have a fuck ton of results, we make an IN statement to prevent breaking the server from having to parse through so many rows.
["APT"] = " AND item_template.displayid IN (20220, 20984) AND class = 15 and subclass = 0 ",
-- AND item_template.entry IN ('2007088','2007220','2007290','2007495','2008036','2008450','2008495','2008497','2008502','2008522','2008705','2008714','2009062','2009505','2009513','2008044','2027720','2013968','2013974')",
-- items not necessarily cosmetic but still crafted by the profession
["Crafted"] = " AND item_template.displayid != 0 AND inventorytype = 0 AND item_template.entry <= 1999999"
}
	
	-- ITEM_TYPE VARIABLE
	-- "item type" = default. if not true, there is input
	if item_type ~= "Item Type" then
		item_type_string = item_type_array[item_type]
		if item_type_string == nil then
			player:SendBroadcastMessage("You did not input an option supported by the drop down.")
			return false
		end
	else
		item_type_string = ""
	end
	--END ITEM_TYPE VARIABLE
	
	-- COOLDOWN CHECK
	-- uses global function in internal.ext to compare timestamp.
	if player:GetLuaCooldown(1337) == 0 then
		player:SetLuaCooldown(2, 1337)
--		player:SendBroadcastMessage("Cooldown set.")
--		player:SendBroadcastMessage("True: " ..player:GetLuaCooldown(1337))
	else
		player:SendBroadcastMessage("You must wait 2 seconds before searching again.")
--		player:SendBroadcastMessage("False: " .. player:GetLuaCooldown(1337))
		return false
	end
	-- END COOLDOWN CHECK
	
--	local new_string = "SELECT item_template.entry, item_template.name, item_template.displayid, cost, cost_item, cost_name,REPLACE(ModelName, '\\\\', '\\\\\\\\') AS ModelName FROM `item_template` INNER JOIN apt_template ON apt_template.item_id = item_template.entry INNER JOIN gameobject_template ON apt_template.gobject = gameobject_template.entry INNER JOIN db_GameObjectDisplayInfo_12340 ON gameobject_template.displayid = db_GameObjectDisplayInfo_12340.ID INNER JOIN item_add ON item_template.entry = item_add.item WHERE item_template.`name` LIKE '%" ..editbox.. "%'" ..min_string.. "" ..max_string.. "" ..cost_name_string.. " " ..item_type_string.. " LIMIT 350;"
	local new_string = "SELECT item_template.entry, item_template.name, item_template.displayid, cost, cost_item, cost_name, ModelName FROM `item_template` LEFT JOIN apt_template ON apt_template.item_id = item_template.entry LEFT JOIN gameobject_template ON apt_template.gobject = gameobject_template.entry LEFT JOIN db_GameObjectDisplayInfo_12340 ON gameobject_template.displayid = db_GameObjectDisplayInfo_12340.ID INNER JOIN item_add ON item_template.entry = item_add.item WHERE item_template.`name` LIKE '%" ..editbox.. "%'" ..min_string.. "" ..max_string.. "" ..cost_name_string.. " " ..item_type_string.. " LIMIT 350;"
--	local new_string = "SELECT entry, name, displayid, cost, cost_item, cost_name FROM `item_template` INNER JOIN item_add ON item_template.entry = item_add.item WHERE `name` LIKE '%" ..editbox.. "%'" ..min_string.. "" ..max_string.. "" ..cost_name_string.. " " ..item_type_string.. " LIMIT 350;"
	print(new_string)
	local Query = WorldDBQuery(new_string)
	
	-- a maximum of 100 frames are made and hard-coded in the client via FuckTonOfFrames()
	-- commented out now until the error print below is investigated more?
	--[[
	if Query == nil then
		return false
	elseif Query:GetRowCount() > 100 then
		RowCount = 100
	else
		RowCount = Query:GetRowCount()
	end
	]]
	
	-- debug print to print amount of results from the item_type_array queries
--	print(Query:GetRowCount().. " results.")
	i = 1
	for z=1,Query:GetRowCount(),1 do
		-- we create i to successfully iterate each frame up to 100. this is because the client hard-codes a max of 100 frames.
		if i < 101 then
			name = Query:GetString(1)
			entry = Query:GetInt32(0)
			link = tostring(GetItemLink(Query:GetInt32(0)))
			link2 = tostring(GetItemLink(Query:GetInt32(4)))
			item_name_entry = Query:GetInt32(4)
			cost_quantity = tostring(Query:GetInt32(3))
			model_name = Query:GetString(6)
			if model_name == nil then
				model_name = "Interface\\Buttons\\TalkToMeQuestion_Grey.mdx"
			end
			AIO.Handle(player, "Shop", "ListResults", i, link, name, entry, item_name_entry, link2, cost_quantity, model_name)
			i = i + 1
			Query:NextRow()
		else
			return false
		end
	end
end

function ShopHandlers.ShopPurchase(player, entry, cost_name)
	if tonumber(entry) == nil then
		player:SendBroadcastMessage("Something went horribly wrong.")
		return false
	end

	local Query3 = WorldDBQuery("SELECT `cost`, `cost_item`, `cost_name`, `item_name`, `maxcount` FROM `item_add` INNER JOIN item_template ON item_add.item = item_template.entry WHERE item = " ..entry.. " AND `cost_name` = '" ..cost_name.. "';")
	-- check if player has X amount of Y item, if yes, remove and add requested item.
	local cost_item = Query3:GetInt32(1)
	local cost_amount = Query3:GetInt32(0)
	local cost_name = Query3:GetString(2)
	local item_name = Query3:GetString(3)
	local item_maxcount = Query3:GetInt32(4)
	currency_change = false
	shop_money = 0
	if cost_item == SILVER_COIN or cost_item == GOLD_COIN or cost_item == COPPER_COIN then 
		currency_change = true
		player_money = GetCurrency(player)
		print("currency detected :o")
		if cost_item == GOLD_COIN then
			auto_string, shop_money = TranslateCurrency(nil, cost_amount, 0, 0)
		elseif cost_item == COPPER_COIN then
			auto_string, shop_money = TranslateCurrency(nil, 0, 0, cost_amount)
		elseif cost_item == SILVER_COIN then
			auto_string, shop_money = TranslateCurrency(nil, 0, cost_amount, 0)
		end
		
		print(cost_item, shop_money)
		if player_money < shop_money then
			player:SendBroadcastMessage("[Shop]: You do not have enough to buy this.")
			return false
		end
		
		print(player_money, currency_change, shop_money)
	end
	
	if (player:HasItem(cost_item, cost_amount) == false) and (cost_amount ~= 0) and currency_change == false then
		player:SendBroadcastMessage("You must have " ..cost_amount.. " " ..cost_name.. " to purchase " ..item_name.. ".")
		return false
	elseif item_maxcount ~= 0 and player:GetItemCount(entry) >= item_maxcount then
		player:SendBroadcastMessage("You can only have " ..item_maxcount.. " of those items.")
		return false
	else
		PrintInfo(player:GetName() .. " (Account: " .. player:GetAccountId() .. ") has spent " ..cost_amount.. " " ..cost_name.. " on " ..item_name.. " (" ..entry.. ").")
		if currency_change == true then
			ChangeCurrency(player, -1 * shop_money)
			player:SendBroadcastMessage("You have spent " ..auto_string.. " on " ..item_name.. ".")
		else
			player:RemoveItem(cost_item, cost_amount)
			player:SendBroadcastMessage("You have spent " ..cost_amount.. " " ..cost_name.. " on " ..item_name.. ".")
		end
		player:AddItem(entry)
		AwardAchievement(player, 65497)
		return
	end
end


-- show shop from toolbar
function ToolBarHandlers.ShowShopUI(player)
	AIO.Handle(player, "Shop", "ShowUI")
end

-- command to open shop
local function ShowShop(event, player, command)
	if command:find("shop") ~= 1 then
		return
	else
		AIO.Handle(player, "Shop", "ShowUI")
		return false
	end
end

RegisterPlayerEvent(42, ShowShop)
