local AIO = AIO or require("AIO")

local racialHandler = AIO.AddHandlers("RACIAL_SERVER", {})

-- Unified cost configuration
local useUnifiedCost = false -- Set to true to use a single cost for all resets
local unifiedCostType = "gold" -- Can be "gold", "item", or "spell"
local unifiedCostAmount = 100000 -- For gold: amount in copper (10g = 100000), For item/spell: entry ID

local IsNpc = true --  set to true if you want to use an npc to open UI at
local npcEntry = 45001 --  npc entry to open UI at

----------------------------------------------------------
-----------------[Npc Interaction]------------------------
----------------------------------------------------------
if IsNpc then
	local function creatureOnSpawn(event, creature)
		creature:SetNPCFlags(3)
	end

	local CREATURE_EVENT_ON_MOVE_IN_LOS = 27

	local GOSSIP_EVENT_ON_HELLO = 1
	local GOSSIP_EVENT_ON_SELECT = 2
	local CREATURE_EVENT_ON_SPAWN = 5
	local menuId = 0x7FFFFFFF

	local isWindowOpen = false -- add this global variable

	local function creatureOnMoveInLos(event, creature, object)
		if object:GetObjectType() == "Player" then
			if object:GetDistance(creature) < 2 then
				-- dismount player if mounted
				if object:IsMounted() then
					object:Dismount()
				end
				return false
			end
			if object:GetDistance(creature) > 2 then
				if isWindowOpen then -- add this check to only close the window when it's open
					AIO.Handle(object, "RACIAL_CLIENT", "racialCloseUI")
					isWindowOpen = false -- set the global variable to false when the window is closed
				end
				return false
			elseif isWindowOpen then -- add this check to only execute the rest of the function when the window is open
				return false
			end
		end
	end

	local function helloOnVendor(event, player, object)
		if player:IsInCombat() and player:InBattleground() == true then
			player:SendBroadcastMessage("|cff00ff00[World]|r |cffff0000You can't use racial while in combat !")
			return false
		end

		AIO.Handle(player, "RACIAL_CLIENT", "racialOpenUI")
		isWindowOpen = true -- set the global variable to true when the window is opened

		-- player:GossipSendMenu(menuId, object)
	end

	-- local function vendorOnSelection(event, player, object, sender, intid, code)
	--     if (intid == 1) then
	--         -- send menu for racial change

	--         AIO.Handle(player, "RACIAL_CLIENT", "racialOpenUI")
	--         player:GossipComplete()
	--     elseif (intid == 2) then -- add this line to handle the new option
	--         -- AIO.Handle(player, "RACIAL_SERVER", "racialOpenUI")
	--         player:GossipComplete()
	--     elseif (intid == 999) then
	--         player:GossipComplete()
	--     end
	-- end

	RegisterCreatureEvent(npcEntry, CREATURE_EVENT_ON_MOVE_IN_LOS, creatureOnMoveInLos)
	RegisterCreatureEvent(npcEntry, CREATURE_EVENT_ON_SPAWN, creatureOnSpawn)
	RegisterCreatureGossipEvent(npcEntry, GOSSIP_EVENT_ON_HELLO, helloOnVendor)
	-- RegisterCreatureGossipEvent(npcEntry, GOSSIP_EVENT_ON_SELECT, vendorOnSelection)
end
----------------------------------------------------------
-----------------[End of Interaction]---------------------
----------------------------------------------------------

-- Initialize tables structure if not exists
local function InitializeTables()
	local tabsExist = WorldDBQuery("SHOW TABLES LIKE 'custom_racial_tabs'")
	local spellsExist = WorldDBQuery("SHOW TABLES LIKE 'custom_racial_spells'")

	if not tabsExist or not spellsExist then
		print("Tables not found. Please run racial_tables.sql first!")
	end
end

InitializeTables()

local function GetTabInfo()
	local tabs = {}
	local results = WorldDBQuery("SELECT id, name, maxActiveSpells, icon, reset FROM custom_racial_tabs ORDER BY id")

	if results then
		repeat
			local tab = {
				id = results:GetUInt32(0),
				name = results:GetString(1),
				maxActiveSpells = results:GetUInt32(2),
				icon = results:GetString(3),
				reset = results:GetString(4) == "true", -- Convert ENUM string to Lua boolean
			}
			table.insert(tabs, tab)
		until not results:NextRow()
	end

	return tabs
end

local function GetRacialSpellsFromDatabase()
	local racialSpells = {}
	-- First, get all categories to ensure proper indexing
	local categoryQuery = WorldDBQuery("SELECT DISTINCT category FROM custom_racial_spells ORDER BY category")

	if categoryQuery then
		repeat
			local category = categoryQuery:GetUInt32(0)
			racialSpells[category] = {}
		until not categoryQuery:NextRow()
	end

	local results = WorldDBQuery("SELECT * FROM custom_racial_spells ORDER BY category, id")

	if results then
		repeat
			local id = results:GetUInt32(0)
			local category = results:GetUInt32(1)
			local name = results:GetString(2)
			local itemType = results:GetString(3)
			local costType = results:GetString(4)
			local cost = results:GetUInt32(5)

			-- Add spell info to the appropriate category
			table.insert(racialSpells[category], {
				id = id,
				name = name or "Unknown Spell",
				itemType = itemType or "Unknown Type",
				costType = costType,
				cost = cost,
			})

		-- Debug print each spell as it's added
		-- print(
		-- 	string.format(
		-- 		"Added to category %d: ID: %d, name: %s, itemType: %s",
		-- 		category,
		-- 		id,
		-- 		name or "Unknown",
		-- 		itemType or "Unknown"
		-- 	)
		-- )

		until not results:NextRow()
	else
		print("No racial spells found in the database.")
	end

	-- Convert to array with sequential indices while preserving category order
	local orderedSpells = {}
	for category, spells in pairs(racialSpells) do
		orderedSpells[category] = spells
	end

	return orderedSpells
end

local function SendRacialSpellsToClient(player)
	local tabs = GetTabInfo()
	local spells = GetRacialSpellsFromDatabase()

	-- Debug print tab info
	-- print("\nTab Information:")
	-- for i, tab in ipairs(tabs) do
	-- 	print(string.format("Tab %d: %s (Max Active: %d, Icon: %s)", i, tab.name, tab.maxActiveSpells, tab.icon))
	-- end

	-- Debug print spell categories
	-- print("\nSpell Categories:")
	-- for category, spellList in pairs(spells) do
	-- 	print(string.format("Category %d has %d spells", category, #spellList))
	-- end

	AIO.Handle(player, "RACIAL_CLIENT", "ReceiveTabInfo", tabs)
	AIO.Handle(player, "RACIAL_CLIENT", "ReceiveRacialSpells", spells)
end



function racialHandler.learnFeature(player, spellId, itemType)
	if player:IsInCombat() and player:InBattleground() == true then
		player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000You can't use this while in combat!")
		return false
	end

	if itemType == "spell" then
		if player:HasSpell(spellId) then
			player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000You already have this spell!")
			return false
		end
		player:LearnSpell(spellId)
	elseif itemType == "profession" then
		if player:HasSpell(spellId) then
			player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000You already have this profession!")
			return false
		end
		player:LearnSpell(spellId)
		player:AdvanceAllSkills(999)
		if ProfessionSpellIds[spellId] then
			local spellCount = #ProfessionSpellIds[spellId]
			for _, spellToLearn in pairs(ProfessionSpellIds[spellId]) do
				player:LearnSpell(spellToLearn)
			end
			player:SendBroadcastMessage(
				string.format("|cff00ff00[System]|r Learned profession and %d related spells successfully!", spellCount)
			)
		else
			player:SendBroadcastMessage("|cff00ff00[System]|r Learned profession successfully!")
		end
	elseif itemType == "item" then
		if player:HasItem(spellId) then
			player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000You already have this item!")
			return false
		end
		player:AddItem(spellId, 1)
	end
	player:SaveToDB()
end

-- Utility function to check if player has an item, including in the bank
local function PlayerHasItemIncludingBank(player, itemId, count)
    count = count or 1 -- Default count to 1 if not provided
    return player:HasItem(itemId, count, true)
end

function racialHandler.unlearnFeature(player, spellId, itemType)
    if player:IsInCombat() and player:InBattleground() == true then
        player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000You can't use this while in combat!")
        return false
    end

    -- Get cost information from database
    local query = WorldDBQuery(string.format("SELECT costType, cost FROM custom_racial_spells WHERE id = %d", spellId))
    if not query then
        player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000Error: Cost information not found!")
        return false
    end

    local costType = query:GetString(0)
    local cost = query:GetUInt32(1)

    -- Check if player can afford the cost
    if costType == "gold" then
        if player:GetCoinage() < cost then
            player:SendBroadcastMessage(
                string.format(
                    "|cff00ff00[System]|r |cffff0000You need %dg %ds %dc to unlearn this!",
                    math.floor(cost / 10000),
                    math.floor((cost % 10000) / 100),
                    cost % 100
                )
            )
            return false
        end
        player:ModifyMoney(-cost)
    elseif costType == "item" then
        -- Use the utility function to check bank as well
        if not PlayerHasItemIncludingBank(player, cost, 1) then
            local itemName = GetItemLink(cost) or ("Item #" .. cost)
            player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000You need " .. itemName .. " to unlearn this!")
            return false
        end
        -- RemoveItem checks bank automatically if the item isn't found in bags first
        player:RemoveItem(cost, 1)
    elseif costType == "spell" then
        if not player:HasSpell(cost) then
            local spellName = GetSpellLink(cost) or ("Spell #" .. cost)
            player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000You need " .. spellName .. " to unlearn this!")
            return false
        end
        player:RemoveSpell(cost)
    end

    -- Now proceed with unlearning
    if itemType == "spell" then
        if not player:HasSpell(spellId) then
            player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000You don't have this spell to unlearn!")
            return false
        end
        player:RemoveSpell(spellId)
    elseif itemType == "profession" then
        -- Assuming ProfessionSpellIds is defined elsewhere
        local professionSpells = ProfessionSpellIds and ProfessionSpellIds[spellId] or {}
        if spellId == 50300 then -- Special case for Herbalism?
            if not player:HasSpell(2383) then -- Check for a specific related spell
                player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000You don't have this profession to unlearn!")
                return false
            end
            player:RemoveSpell(50300)
            player:RemoveSpell(2383) -- Remove the Herbalism spell
            player:AbandonSkill(GetSpellInfo(50300)) -- Abandon skill by name
        else
            if not player:HasSpell(spellId) then
                player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000You don't have this profession to unlearn!")
                return false
            end
            player:RemoveSpell(spellId)
            -- Remove related profession spells if any exist
            for _, relatedSpellId in ipairs(professionSpells) do
                player:RemoveSpell(relatedSpellId)
            end
            player:AbandonSkill(GetSpellInfo(spellId)) -- Abandon skill by name
            player:SendBroadcastMessage(
                "|cff00ff00[System]|r Successfully unlearned the profession and its related spells."
            )
        end
    elseif itemType == "item" then
        -- Use the utility function to check bank as well before attempting removal
        if not PlayerHasItemIncludingBank(player, spellId, 1) then
            player:SendBroadcastMessage("|cff00ff00[System]|r |cffff0000You don't have this item to remove!")
            return false
        end
        -- RemoveItem checks bank automatically if the item isn't found in bags first
        player:RemoveItem(spellId, 1)
    end
    player:SaveToDB()
end

local function SendUnifiedCostSettings(player)
	-- Send unified cost settings to client
	local settings = {
		enabled = useUnifiedCost,
		costType = unifiedCostType,
		amount = unifiedCostAmount,
	}

	AIO.Handle(player, "RACIAL_CLIENT", "ReceiveUnifiedCostSettings", settings)
end

-- ...existing code...

-- Function to check if a player can afford the reset cost
function racialHandler.canAffordReset(player)
	if useUnifiedCost then
		-- Handle unified cost check (remains the same)
		if unifiedCostType == "gold" then
			if player:GetCoinage() < unifiedCostAmount then
				return false, "Not enough gold", unifiedCostAmount, {}, {}, true
			end
		elseif unifiedCostType == "item" then
			-- Check if player has the specific item required for unified cost
			if not player:HasItem(unifiedCostAmount) then
				local itemName = GetItemLink(unifiedCostAmount) or ("Item #" .. unifiedCostAmount)
				return false, "Missing required item: " .. itemName, 0, { [unifiedCostAmount] = 1 }, {}, true
			end
		elseif unifiedCostType == "spell" then
			-- Check if player has the specific spell required for unified cost
			if not player:HasSpell(unifiedCostAmount) then
				local spellName = GetSpellLink(unifiedCostAmount) or ("Spell #" .. unifiedCostAmount)
				return false, "Missing required spell: " .. spellName, 0, {}, { [unifiedCostAmount] = true }, true
			end
		end
		-- If all checks pass for unified cost
		return true, nil, unifiedCostAmount, {}, {}, true
	end

	-- Calculate individual costs for active spells/items in resettable tabs only
	local totalGoldCost = 0
	local requiredItems = {}
	local requiredSpells = {}

	-- Get resettable tabs
	local tabsToReset = {}
	local tabResults = WorldDBQuery("SELECT id FROM custom_racial_tabs WHERE reset = 'true'")
	if tabResults then
		repeat
			tabsToReset[tabResults:GetUInt32(0)] = true
		until not tabResults:NextRow()
	else
		-- No resettable tabs found, cost is effectively zero
		return true, nil, 0, {}, {}, false
	end

	-- Build a string of resettable tab IDs for the SQL query
	local resettableTabIds = {}
	for id in pairs(tabsToReset) do
		table.insert(resettableTabIds, tostring(id))
	end

	if #resettableTabIds == 0 then
		-- No resettable tabs found after processing, cost is effectively zero
		return true, nil, 0, {}, {}, false
	end

	local tabIdString = table.concat(resettableTabIds, ",")

	-- Query all potential racials (spells and items) within the resettable tabs
	local query = string.format(
		[[
        SELECT id, itemType, costType, cost
        FROM custom_racial_spells
        WHERE category IN (%s)
    ]],
		tabIdString
	)

	local results = WorldDBQuery(query)
	if results then
		repeat
			local racialId = results:GetUInt32(0)
			local itemType = results:GetString(1)
			local costType = results:GetString(2)
			local cost = results:GetUInt32(3)

			local playerHasRacial = false
			-- Check if the player actually has this racial ability
			if (itemType == "spell" or itemType == "profession") and player:HasSpell(racialId) then
				playerHasRacial = true
			elseif itemType == "item" and player:HasItem(racialId) then
				playerHasRacial = true
			end

			-- If the player has the racial, add its cost to the totals
			if playerHasRacial then
				if costType == "gold" then
					totalGoldCost = totalGoldCost + cost
				elseif costType == "item" then
					-- 'cost' here is the item ID required
					requiredItems[cost] = (requiredItems[cost] or 0) + 1
				elseif costType == "spell" then
					-- 'cost' here is the spell ID required
					requiredSpells[cost] = true
				end
			end
		until not results:NextRow()
	end

	-- Check if player can afford everything
	if player:GetCoinage() < totalGoldCost then
		local gold = math.floor(totalGoldCost / 10000)
		local silver = math.floor((totalGoldCost % 10000) / 100)
		local copper = totalGoldCost % 100
		return false,
			string.format("Not enough gold (requires %dg %ds %dc)", gold, silver, copper),
			totalGoldCost,
			requiredItems,
			requiredSpells,
			false
	end

	for itemId, count in pairs(requiredItems) do
		if not player:HasItem(itemId, count) then
			local itemName = GetItemLink(itemId) or ("Item #" .. itemId)
			return false,
				string.format("Missing required item: %s (x%d)", itemName, count),
				totalGoldCost,
				requiredItems,
				requiredSpells,
				false
		end
	end

	for spellId in pairs(requiredSpells) do
		if not player:HasSpell(spellId) then
			local spellName = GetSpellLink(spellId) or ("Spell #" .. spellId)
			return false, "Missing required spell: " .. spellName, totalGoldCost, requiredItems, requiredSpells, false
		end
	end

	-- If all checks pass for individual costs
	return true, nil, totalGoldCost, requiredItems, requiredSpells, false
end

-- ...existing code...

-- Helper functions for racial reset functionality
local RacialReset = {
	-- Check if the tab should be reset
	getResettableTabs = function()
		local tabs = {}
		local results = WorldDBQuery("SELECT id FROM custom_racial_tabs WHERE reset = 'true'")
		if results then
			repeat
				tabs[results:GetUInt32(0)] = true
			until not results:NextRow()
		end
		return tabs
	end,

	-- Get all racial spells that can be reset
	getRacialsToRemove = function(player, tabsToReset)
		local racialsToRemove = {}
		local hasRacials = false

		-- Build a string of resettable tab IDs for the SQL query
		local resettableTabIds = {}
		for id in pairs(tabsToReset) do
			table.insert(resettableTabIds, tostring(id))
		end

		if #resettableTabIds == 0 then
			return {}, false -- No resettable tabs, nothing to remove
		end

		local tabIdString = table.concat(resettableTabIds, ",")

		local query = string.format(
			[[
            SELECT rs.id, rs.itemType, rs.name, rs.category
            FROM custom_racial_spells rs
            WHERE rs.category IN (%s)
        ]],
			tabIdString
		)

		local results = WorldDBQuery(query)
		if results then
			repeat
				local id = results:GetUInt32(0)
				local itemType = results:GetString(1)
				local name = results:GetString(2)
				local category = results:GetUInt32(3) -- Category is already confirmed to be resettable by the WHERE clause

				local hasThis = false
				local racialData = {
					id = id,
					itemType = itemType,
					name = name,
					category = category,
				}

				if (itemType == "spell" or itemType == "profession") and player:HasSpell(id) then
					hasThis = true
					if itemType == "profession" and id == 50300 then -- Special handling for Herbalism ID if needed
						racialData.special = 2383
					end
				elseif itemType == "item" and player:HasItem(id) then
					hasThis = true
				end

				if hasThis then
					table.insert(racialsToRemove, racialData)
					hasRacials = true -- Set flag if at least one removable racial is found
				end
			until not results:NextRow()
		end
		return racialsToRemove, hasRacials
	end,

	-- Remove racials from player (minor optimization: check skill name directly)
	removeRacials = function(player, racials)
		for _, racial in pairs(racials) do
			if racial.itemType == "spell" then
				player:RemoveSpell(racial.id)
			elseif racial.itemType == "profession" then
				local skillName = GetSpellInfo(racial.id) -- Get profession name from spell ID
				player:RemoveSpell(racial.id)
				if racial.special then
					player:RemoveSpell(racial.special)
				end
				-- Remove profession skills more reliably by name
				if skillName then
					player:AbandonSkill(skillName)
				end
			elseif racial.itemType == "item" then
				-- Ensure we only remove one item, as racials typically grant one
				player:RemoveItem(racial.id, 1)
			end
		end
	end,

	-- Handle cost deduction (remains the same logic, relies on correct data from canAffordReset)
	deductCost = function(player, canResetData)
		-- Unpack all return values from canAffordReset
		local _, _, costValue, requiredItems, requiredSpells, isUnified = unpack(canResetData)

		if isUnified then
			-- Use the global unified cost variables
			if unifiedCostType == "gold" then
				player:ModifyMoney(-unifiedCostAmount)
			elseif unifiedCostType == "item" then
				player:RemoveItem(unifiedCostAmount, 1)
			elseif unifiedCostType == "spell" then
				player:RemoveSpell(unifiedCostAmount)
			end
		else
			-- Use the calculated costs passed in canResetData
			local goldCost = costValue -- When not unified, costValue is the total gold cost
			if goldCost > 0 then
				player:ModifyMoney(-goldCost)
			end
			for itemId, count in pairs(requiredItems) do
				player:RemoveItem(itemId, count)
			end
			for spellId in pairs(requiredSpells) do
				player:RemoveSpell(spellId)
			end
		end
	end,
}

-- Main reset function (minor adjustments for clarity)
function racialHandler.resetAllRacials(player)
	if player:IsInCombat() then
		player:SendBroadcastMessage("|cff00ff00[Racial]|r |cffff0000You can't reset racials while in combat!")
		return false
	end

	-- Call canAffordReset and store all return values
	local canResetData = { racialHandler.canAffordReset(player) }
	local canReset, reason = canResetData[1], canResetData[2] -- Extract first two values

	if not canReset then
		-- Use the reason provided by canAffordReset
		player:SendBroadcastMessage(
			string.format("|cff00ff00[Racial]|r |cffff0000Cannot reset: %s", reason or "Unknown reason")
		)
		return false
	end

	local tabsToReset = RacialReset.getResettableTabs()
	if not next(tabsToReset) then -- Check if the table is empty
		player:SendBroadcastMessage("|cff00ff00[Racial]|r No tabs are currently marked as resettable!")
		return false
	end

	local racialsToRemove, hasRacials = RacialReset.getRacialsToRemove(player, tabsToReset)
	if not hasRacials then
		player:SendBroadcastMessage(
			"|cff00ff00[Racial]|r You don't have any racials from resettable categories to remove!"
		)
		return false
	end

	-- Pass the full canResetData table to deductCost
	RacialReset.deductCost(player, canResetData)
	RacialReset.removeRacials(player, racialsToRemove) -- Remove racials after deducting cost

	player:SaveToDB()
	player:SendBroadcastMessage("|cff00ff00[Racial]|r Selected racials have been reset successfully!")
	-- Optionally, resend data to client to update UI state after reset
	SendRacialSpellsToClient(player)
	SendUnifiedCostSettings(player)
	return true
end

local function OnElunaReload(event)
	local players = GetPlayersInWorld() -- get all connected players
	for i, player in ipairs(players) do
		SendRacialSpellsToClient(player) -- send the racial spells data to each player
	end
end

RegisterServerEvent(33, OnElunaReload) -- register the Eluna reload handler

-- setup so that on login it send the data to the player
local function OnPlayerLogin(event, player)
	SendRacialSpellsToClient(player) -- send the racial spells data to the player
	SendUnifiedCostSettings(player) -- send unified cost settings to the player
end

RegisterPlayerEvent(3, OnPlayerLogin) -- register the player login handler

-- Add a function to handle the admin command for updating all players
local function updateAllPlayers(event, player, command)
	-- Convert command to lowercase for case-insensitive comparison
	command = string.lower(command)

	-- Check if the command matches and player has GM rights
	if command == "rui update" or command == "racialui update" then
		-- Check if player has GM rights (adjust rank requirement as needed)
		if player:GetGMRank() < 1 then
			player:SendBroadcastMessage(
				"|cff00ff00[Racial]|r |cffff0000You don't have permission to use this command.|r"
			)
			return false
		end

		-- Get all online players
		local players = GetPlayersInWorld()
		local count = #players

		-- Send updated data to all online players
		for i, onlinePlayer in ipairs(players) do
			SendRacialSpellsToClient(onlinePlayer)
			SendUnifiedCostSettings(onlinePlayer)
		end

		-- Notify the admin about the update
		player:SendBroadcastMessage(
			string.format("|cff00ff00[Racial]|r Updated racial data for %d online players.", count)
		)

		-- Return false to prevent the command from showing in chat
		return false
	end

	-- Continue with other command processing
	return
end

-- Register the command handler
RegisterPlayerEvent(42, updateAllPlayers)

local function showWindowPls(event, player, command)
	command = string.lower(command)
	if command == "rui" or command == "racialui" then
		if player:GetGMRank() < 1 then
			player:SendBroadcastMessage(
				"|cff00ff00[Racial]|r |cffff0000You don't have permission to use this command.|r"
			)
			return false
		end

		SendRacialSpellsToClient(player)
		AIO.Handle(player, "RACIAL_CLIENT", "racialOpenUI")
		return false
	end
end

RegisterPlayerEvent(42, showWindowPls) -- Register for the chat command event
