--[[


]]

-- Settings
local config = require ('!config')-- Need Don't Remove
local belt = require ('!Belts')-- Need Don't Remove

local luaName = "Belt Menu"
local luaNameShort = "Belt_"

local debugON = config.get(luaNameShort.."debugOn")
local enabled = config.get(luaNameShort.."enabled", debugON)
local GossipID = config.get(luaNameShort.."GossipID", debugON)
local ChatCommand = config.get(luaNameShort.."ChatCommand", debugON)
local beltList = belt.get("list", debugON)
local player_currentPage = {}
local player_currentLookUp = {}
local itemsPerPage = 10 -- Number of items to display per page
local totalPages = math.ceil(#beltList / itemsPerPage) -- Total number of pages
local function searchTable(table_Looking, searchString)
  local matches = {}
  for _, row in ipairs(table_Looking) do
    if string.find(string.lower(row[1]), string.lower(searchString)) or string.find(string.lower(row[2]), string.lower(searchString)) then
      table.insert(matches, row)
    end
  end
  return matches
end
local function BeltMenuGossip(event, player)
	local playerID = player:GetGUIDLow()
	local currentPage = player_currentPage[playerID]
	local startIndex = (currentPage - 1) * itemsPerPage + 1
	local endIndex = math.min(startIndex + itemsPerPage - 1, #beltList)

	player:GossipClearMenu()
	player:GossipMenuAddItem(3, "Belts - Look Up", 0, 1, true, "Look UP")
	player:GossipMenuAddItem(0, "Page: "..currentPage, 0, 4, true, "What page? \n 1 to "..totalPages)
	player:GossipMenuAddItem(0, "|TInterface\\Icons\\Spell_chargepositive:22|t Next", 0, 2)
	player:GossipMenuAddItem(0, "|TInterface\\Icons\\Spell_chargenegative:22|t Back", 0, 3)
	for i = startIndex, endIndex do
		local v = beltList[i]
		hasAura = player:HasAura(v[1])
		if hasAura then 
			--player:GossipMenuAddItem(0, "|cff3cba54[ON]|r " .. v[2], 0, v[1])
			player:GossipMenuAddItem(0, "|TInterface\\Icons\\inv_belt_cloth_pvppriest_f_01:22|t|r " .. v[2], 0, v[1])
		else
			--player:GossipMenuAddItem(0, "|cffff3347[OFF]|r " .. v[2], 0, v[1])
			player:GossipMenuAddItem(0, "|r " .. v[2], 0, v[1])
		end
	end
	--player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:34|t [Back]", 0, 98)
	player:GossipSendMenu(1, player, GossipID)
end
local function BeltMenuSearchGossip(event, player, matchingRows)
	local playerID = player:GetGUIDLow()
	local matchingRows = player_currentLookUp[playerID]		
	local currentPage = player_currentPage[playerID]
	local startIndex = (currentPage - 1) * itemsPerPage + 1
	local endIndex = math.min(startIndex + itemsPerPage - 1, #matchingRows)
	local totalPages = math.ceil(#matchingRows / itemsPerPage)

	if #matchingRows > 0 then
		player:GossipClearMenu()
		player:GossipMenuAddItem(3, "Belts - Look Up", 0, 1, true, "Look UP")
		player:GossipMenuAddItem(0, "Page: "..currentPage, 0, 4, true, "What page? \n 1 to "..totalPages)
		player:GossipMenuAddItem(0, "|TInterface\\Icons\\Spell_chargepositive:22|t Next", 0, 2)
		player:GossipMenuAddItem(0, "|TInterface\\Icons\\Spell_chargenegative:22|t Back", 0, 3)
		for i = startIndex, endIndex do
			local v = matchingRows[i]	
			hasAura = player:HasAura(v[1])
			if hasAura then 
				--player:GossipMenuAddItem(0, "|cff3cba54[ON]|r " .. v[2], 0, v[1])
				player:GossipMenuAddItem(0, "|TInterface\\Icons\\inv_belt_cloth_pvppriest_f_01:22|t|r " .. v[2], 0, v[1])
			else
				--player:GossipMenuAddItem(0, "|cffff3347[OFF]|r " .. v[2], 0, v[1])
				player:GossipMenuAddItem(0, "|r " .. v[2], 0, v[1])
			end
		end
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 98)
		player:GossipSendMenu(1, player, GossipID)
	else			
		player:GossipMenuAddItem(3, "Nothing was found.", 0, 1)
		player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 98)
		player:GossipSendMenu(1, player, GossipID)
	end
end

--
local function Aura(player, id)
	local hasAura = player:HasAura(id)
	if hasAura then
		player:RemoveAura(id)
	else 
		for k , v in pairs(beltList) do
			local hasAura = player:HasAura(v[1])
			if hasAura then
				player:RemoveAura(v[1])
			end
		end
		player:AddAura(id, player)
	end
end
--(Start)
local function BeltOnSelect(event, player, _, sender, intid, code)
	local playerID = player:GetGUIDLow()	
	local currentPage = player_currentPage[playerID]

	if currentPage == nil or currentPage <= 0 then
		player_currentPage[playerID] = 1 -- Current page number
		currentPage = 1
	elseif currentPage >= totalPages then
		player_currentPage[playerID] = totalPages - 1 -- Current page number
		currentPage = totalPages - 1
	end
	
	if(intid == 1) then
		local lookup = tostring(code)
		local matchingRows = searchTable(beltList, lookup)
		local playerID = player:GetGUIDLow()
		player_currentPage[playerID] = 1
		player_currentLookUp[playerID] = matchingRows		
		BeltMenuSearchGossip(event, player)		
	end

	
	if(intid == 2) then
		if player_currentPage[playerID] < totalPages then
			player_currentPage[playerID] = currentPage + 1	
		end
		if player_currentLookUp[playerID] == nil then
			BeltMenuGossip(event, player)
		else
			BeltMenuSearchGossip(event, player)
		end
	end
	if(intid == 3) then
		if player_currentPage[playerID] ~= 1 then
			player_currentPage[playerID] = currentPage - 1	
		end
		if player_currentLookUp[playerID] == nil then
			BeltMenuGossip(event, player)
		else
			BeltMenuSearchGossip(event, player)
		end
	end
	if(intid == 4) then
		if tonumber(code) <= totalPages then
			player_currentPage[playerID] = tonumber(code)
			BeltMenuGossip(event, player)
		elseif tonumber(code) >= totalPages then
			player_currentPage[playerID] = totalPages
			BeltMenuGossip(event, player)
		end
	end


	for k , v in pairs(beltList) do
		if(intid == v[1]) then --No time limit Buffs
			Aura(player, v[1])
			if player_currentLookUp[playerID] == nil then
				BeltMenuGossip(event, player)
			else
				BeltMenuSearchGossip(event, player)
			end
		end
	end
	
--[[
	local startIndex = (currentPage - 1) * itemsPerPage + 1
	local endIndex = math.min(startIndex + itemsPerPage - 1, #beltList)
	for i = startIndex, endIndex do
		local v = beltList[i]
		if(intid == v[1]) then --No time limit Buffs
			Aura(player, v[1])
			if player_currentLookUp[playerID] == nil then
				BeltMenuGossip(event, player)
			else
				BeltMenuSearchGossip(event, player)
			end
		end
	end
]]
	if(intid == 98) then --Back	
		local playerID = player:GetGUIDLow()	
		player_currentLookUp[playerID] = nil
		BeltMenuGossip(event, player)
	end
	if(intid == 99) then --Close
		player:SendAreaTriggerMessage("Good Bye!")
		player:GossipComplete()
	end
		
end
--(End)
--(Start) Command: Check
local function beltMenuCommand(event, player, command)
	if command == ChatCommand then
		local playerID = player:GetGUIDLow()
		local currentPage = player_currentPage[playerID]
		if currentPage == nil or currentPage <= 1 then
			player_currentPage[playerID] = 1 -- Current page number
			currentPage = 1
		elseif currentPage >= totalPages then
			player_currentPage[playerID] = totalPages - 1 -- Current page number
			currentPage = totalPages - 1
		end
		if player_currentLookUp[playerID] then
			player_currentLookUp[playerID] = nil
			player_currentPage[playerID] = 1
		end
		
		
		BeltMenuGossip(event, player)
		return false
	end
end
--(end)
RegisterPlayerGossipEvent(GossipID, 2, BeltOnSelect)
RegisterPlayerEvent(42, beltMenuCommand)
