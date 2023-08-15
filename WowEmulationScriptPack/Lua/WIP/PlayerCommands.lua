-- ranks above this will not be detected
ADMIN_RANK = 2

local function Census(event, player, command)
	if (command:find("census") ~= 1) then
		return
	else
		people = GetPlayersInWorld(2)
		player_zone = player:GetZoneId()
		player_amount = 0
		total_players = 0
		total_gms = 0
		zone_list = {}
		for x=1,#people,1 do
			if people == nil then
				player_amount = 0
				break
			end
			
			-- this RBAC and lower will be counted in the census
			local people_peasants = people[x]:GetGMRank()
			
			if people_peasants >= ADMIN_RANK then
				total_gms = total_gms + 1
			else
				total_players = total_players + 1
			end
			
			local people_zone = people[x]:GetZoneId()
			
			if player_zone == people_zone and people_peasants < ADMIN_RANK then
				player_amount = player_amount + 1
			end
			
			if people_zone == 0 then
				zone_name = "Unknown"
			else
				zone_name = GetAreaName(people_zone)
			end
			
			if people_peasants < ADMIN_RANK then
				if zone_list[zone_name] == nil then
					zone_list[zone_name] = 1
				else
					zone_list[zone_name] = zone_list[zone_name] + 1
				end
			end

		end
		
		local biggest_zone_count = 0
		local biggest_zone_name = ""
		
		for name, line in pairsByKeys(zone_list) do
			if line > biggest_zone_count then
				biggest_zone_count = line
				biggest_zone_name = name
			end
		end
		
		-- name can still be nil/nothing when staff are online but players arent
		if biggest_zone_name == "" or biggest_zone_name == nil then
			biggest_zone_name = "Unknown"
		end
		
		player:SendBroadcastMessage("|cffCCFF66[Census]:|r There are " ..total_players.. " players and " ..total_gms.. " staff online.")
		player:SendBroadcastMessage("|cffCCFF66[Census]:|r " ..player_amount.. " players are in your zone. " ..biggest_zone_name.. " is the most populated zone with " ..biggest_zone_count.. " players.")
		
		return false
	end
end

-- toggles a flag visual based on race
local function Toggle_Flag(event, player, command)
	local race = player:GetRace()
	local flag_array = {
		["1"] = 66367, -- human
		["2"] = 66369, -- orc
		["3"] = 66363, -- dwarf
		["4"] = 66368, -- night elf
		["5"] = 66365, -- undead
		["6"] = 66370, -- tauren
		["7"] = 66366, -- gnome
		["8"] = 66371, -- troll
--		["9"] = , -- goblin
		["10"] = 66360, -- blood elf
		["11"] = 66362, -- draenei
	}
	
	if (command:find("toggle flag") ~= 1) then
		return
	elseif player:HasAura(32609) == true or player:HasAura(32610) == true or player:HasAura(flag_array[tostring(player:GetRace())]) then
		player:RemoveAura(32609)
		player:RemoveAura(32610)
		player:RemoveAura(flag_array[tostring(player:GetRace())])
		state = "OFF"
	elseif (command:find("toggle flag faction") == 1) then
		if player:IsAlliance() then
			player:AddAura(32609, player)
			state = "ON"
		elseif player:IsHorde() then
			player:AddAura(32610, player)
			state = "ON"
		end
	else
		if player:HasAura(flag_array[tostring(player:GetRace())]) == true then
			player:RemoveAura(flag_array[tostring(player:GetRace())])
			state = "OFF"
		else
			player:AddAura(flag_array[tostring(player:GetRace())], player)
			state = "ON"
		end
	end
	player:SendBroadcastMessage("Your flag has been toggled " ..state.. ".")
	return false
end

local function ResetPhase(event, player, command)
	if (command:find("reset phase") ~= 1) then
		return
	else
		player:SetPhaseMask(1, true)
		return false
	end
end

local function ItemAdd(event, player, command)
	-- is the sterilized parameter a number, does the select query exist, and does the player have X amount of cost_item compared to query cost
	if (command:find("aitem") ~= 1) then
		return
	end

	if (command == "aitem") then -- ugly, please fix me.
			player:SendBroadcastMessage("To add items with .aitem, type: '.aitem |cff66ffccitemID|r', but replace |cff66ffccitemID|r with the ID that you found through '.aitem list'")
			player:SendBroadcastMessage("To list items with .aitem, type: '.aitem list |cff66ffccitemName|r', but replace |cff66ffccitemName|r with what you want to search for.")
			return false
	end

	local parameters = {}
	local parameters = getCommandParameters(command)
	parameters[2] = sterilize.generic(parameters[2])
	if (isNumber(parameters[2]) == false) and (parameters[2] ~= "list") then
		player:SendBroadcastMessage("You must input a valid number.")
		return false
	-- aitem list functionality
	-- .aitem list <name>
	elseif (parameters[2] == "list") and (parameters[3] == nil) then
		player:SendBroadcastMessage("You must add an input after list for an item to be searched.")
		return false
	elseif (parameters[2] == "list") and (parameters[3] ~= nil) then
		parameters[3] = sterilize.onlyLettersAndSpaces(parameters[3]) -- Only allow A-Z and spacebar in item name.
		local ItemAdd_Query2 = WorldDBQuery("SELECT item, item_name FROM item_add WHERE item_name LIKE '%" ..parameters[3].. "%' LIMIT 100;") -- Added limit so we don't crash the users client.
		if (ItemAdd_Query2 == nil) then
			player:SendBroadcastMessage("No items exist with that name.")
			return false
		else
			for x=1,ItemAdd_Query2:GetRowCount(),1 do
				player:SendBroadcastMessage(ItemAdd_Query2:GetInt32(0).. " - " ..GetItemLink(ItemAdd_Query2:GetInt32(0)))
				ItemAdd_Query2:NextRow()
			end
			return false
		end
	end
	
	if (isNumber(parameters[2]) == true) then
		local ItemAdd_Query1 = WorldDBQuery("SELECT item, cost, cost_item, cost_name, item_name FROM item_add WHERE item = " ..parameters[2].. ";")
		if (ItemAdd_Query1 == nil) then
			player:SendBroadcastMessage("That item entry is not in our allowed list of items. You can only redeem common, uncommon, and rare items.")
			return false
		elseif (player:GetItemCount(ItemAdd_Query1:GetInt32(2)) < ItemAdd_Query1:GetInt32(1)) then
			player:SendBroadcastMessage("You do not have enough to redeem this item. The cost is " ..ItemAdd_Query1:GetInt32(1).. " " ..ItemAdd_Query1:GetString(3).. ".")
			return false
		else
			player:AddItem(ItemAdd_Query1:GetInt32(0), 1)
			player:RemoveItem(ItemAdd_Query1:GetInt32(2), ItemAdd_Query1:GetInt32(1))
			player:SendBroadcastMessage("You have added " ..GetItemLink(ItemAdd_Query1:GetInt32(0)).. " to your inventory at the cost of " ..ItemAdd_Query1:GetInt32(1).. " " ..GetItemLink(ItemAdd_Query1:GetInt32(2)).. ".")
			AwardAchievement(player, 65497)
			return false
		end
	else 
		player:SendBroadcastMessage("You're inputting an invalid item GUID or something broke.")
		return false
	end
end

-- get distance ability
local function DistanceSpell(event, player, spell, skipCheck)
	if spell:GetEntry() ~= 2000038 then
		return
	end
	
	target = player:GetSelection()
	if target == nil then
		player:SendBroadcastMessage("This ability requires a target.")
	end
	
    distanceYards = player:GetExactDistance(target)
    distanceYards = string.format("%0.2f", distanceYards)
    distanceFeet = (tonumber(distanceYards) * 3)
    distanceFeet = string.format("%0.2f", distanceFeet)
    distanceMeters = (tonumber(distanceYards) * 0.9144)
    distanceMeters = string.format("%0.2f", distanceMeters)
    player:SendBroadcastMessage("The distance between you and your target is " .. distanceYards .. " yards / " .. distanceFeet .. " feet / " .. distanceMeters .. " meters.")
    return false
end

RegisterPlayerEvent(42, ResetPhase)
RegisterPlayerEvent(42, Census)
RegisterPlayerEvent(42, Toggle_Flag)
RegisterPlayerEvent(42, ItemAdd)
RegisterPlayerEvent(5, DistanceSpell)