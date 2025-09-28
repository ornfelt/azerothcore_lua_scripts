-- Utility functions
local utils = {
	escapeString = function(str)
		local replacements = {
			["\\"] = "\\\\",
			["'"] = "\\'",
			['"'] = '\\"',
			["%"] = "\\%",
			["_"] = "\\_",
		}
		return str:gsub("[\\'\"%%_]", replacements)
	end,

	debugMessage = function(...)
		if config.debug then
			print("DEBUG:", ...)
		end
	end,

	validatePageSize = function(pageSize)
		local minPageSize = 10
		local maxPageSize = 500
		return math.min(math.max(pageSize, minPageSize), maxPageSize)
	end,

	validateSortOrder = function(order)
		local validOrders = {
			ASC = true,
			DESC = true,
		}
		return validOrders[order:upper()] and order:upper() or "ASC"
	end,

	calculatePosition = function(player, distance)
		local angle = player:GetO()
		local x = player:GetX() + distance * math.cos(angle)
		local y = player:GetY() + distance * math.sin(angle)
		local z = player:GetZ()
		local oppositeAngle = angle + math.pi
		return x, y, z, oppositeAngle
	end,

	-- Enhanced messaging system
	sendMessage = function(player, messageType, message)
		if not player or not message then
			return
		end

		-- Define message types with their prefixes and colors
		local messageTypes = {
			error = { prefix = "Error: ", color = "|cFFFF0000" }, -- Red
			success = { prefix = "Success: ", color = "|cFF00FF00" }, -- Green
			info = { prefix = "Info: ", color = "|cFF00FFFF" }, -- Cyan
			warning = { prefix = "Warning: ", color = "|cFFFFFF00" }, -- Yellow
		}

		local typeInfo = messageTypes[messageType:lower()]
		if not typeInfo then
			-- Default to info if unknown type
			typeInfo = messageTypes.info
		end

		-- Construct the full message with color and prefix
		local fullMessage = string.format("%s%s%s|r", typeInfo.color, typeInfo.prefix, message)

		-- Send the broadcast message to the player
		player:SendBroadcastMessage(fullMessage)

		-- Log the message to the server logs with timestamp
		local timestamp = os.date("%Y-%m-%d %H:%M:%S")
		local logMessage = string.format("[%s] %s: %s", timestamp, messageType:upper(), message)
		print(logMessage) -- Assuming 'print' sends to server console/log
	end,

	-- Pagination utilities
	calculatePaginationInfo = function(totalCount, currentOffset, pageSize)
		-- Ensure valid values
		totalCount = totalCount or 0
		currentOffset = currentOffset or 0
		pageSize = math.max(1, pageSize or 15)
		
		-- Calculate pagination metrics
		local totalPages = math.ceil(totalCount / pageSize)
		local currentPage = math.floor(currentOffset / pageSize) + 1
		local hasNextPage = currentOffset + pageSize < totalCount
		local hasPreviousPage = currentOffset > 0
		
		-- Calculate the actual range of items being displayed
		local startIndex = currentOffset + 1
		local endIndex = math.min(currentOffset + pageSize, totalCount)
		
		-- Return comprehensive pagination info
		return {
			totalCount = totalCount,
			totalPages = totalPages,
			currentPage = currentPage,
			pageSize = pageSize,
			currentOffset = currentOffset,
			hasNextPage = hasNextPage,
			hasPreviousPage = hasPreviousPage,
			startIndex = startIndex,
			endIndex = endIndex,
			isEmpty = totalCount == 0
		}
	end,

	-- Helper to get total count from a query
	getTotalCount = function(dbQueryFunc, countQuery)
		local result = dbQueryFunc(countQuery)
		if result then
			return result:GetUInt32(0) or 0
		end
		return 0
	end,

	-- Helper to build pagination query suffix
	buildPaginationSuffix = function(offset, pageSize, sortColumn, sortOrder)
		sortColumn = sortColumn or "entry"
		sortOrder = sortOrder or "ASC"
		return string.format(" ORDER BY %s %s LIMIT %d OFFSET %d", 
			sortColumn, sortOrder, pageSize, offset)
	end,

	-- WoW 3.3.5 Class Information
	classInfo = {
		[1] = {name = "Warrior", color = "C79C6E"},
		[2] = {name = "Paladin", color = "F58CBA"},
		[3] = {name = "Hunter", color = "ABD473"},
		[4] = {name = "Rogue", color = "FFF569"},
		[5] = {name = "Priest", color = "FFFFFF"},
		[6] = {name = "Death Knight", color = "C41F3B"},
		[7] = {name = "Shaman", color = "0070DE"},
		[8] = {name = "Mage", color = "69CCF0"},
		[9] = {name = "Warlock", color = "9482C9"},
		[11] = {name = "Druid", color = "FF7D0A"}
	},

	-- WoW 3.3.5 Race Information
	raceInfo = {
		[1] = "Human",
		[2] = "Orc",
		[3] = "Dwarf",
		[4] = "Night Elf",
		[5] = "Undead",
		[6] = "Tauren",
		[7] = "Gnome",
		[8] = "Troll",
		[10] = "Blood Elf",
		[11] = "Draenei"
	},

	-- Equipment slot names
	slotNames = {
		[0] = "Head", [1] = "Neck", [2] = "Shoulders", [3] = "Shirt",
		[4] = "Chest", [5] = "Belt", [6] = "Legs", [7] = "Feet",
		[8] = "Wrists", [9] = "Hands", [10] = "Ring1", [11] = "Ring2",
		[12] = "Trinket1", [13] = "Trinket2", [14] = "Back", [15] = "MainHand",
		[16] = "OffHand", [17] = "Ranged", [18] = "Tabard"
	},

	-- Common debuff IDs in WoW 3.3.5
	commonDebuffs = {
		15007, -- Resurrection Sickness
		25771, -- Forbearance
		57723, -- Exhaustion (heroism/bloodlust debuff)
		57724, -- Sated (heroism/bloodlust debuff)
		26013, -- Deserter
	},

	-- Inventory type to equipment slot mapping
	inventoryTypeToSlot = {
		[1] = 0,   -- Head
		[2] = 1,   -- Neck
		[3] = 2,   -- Shoulder
		[4] = 3,   -- Shirt
		[5] = 4,   -- Chest/Vest
		[6] = 5,   -- Belt
		[7] = 6,   -- Legs
		[8] = 7,   -- Feet
		[9] = 8,   -- Wrists
		[10] = 9,  -- Hands
		[11] = 10, -- Ring (slot 1)
		[12] = 12, -- Trinket (slot 1)
		[13] = 15, -- One-Hand weapon
		[14] = 16, -- Shield
		[15] = 17, -- Ranged
		[16] = 14, -- Back/Cloak
		[17] = 15, -- Two-Hand weapon
		[18] = 17, -- Bag (not equipable)
		[19] = 18, -- Tabard
		[20] = 4,  -- Robe (chest slot)
		[21] = 15, -- Main Hand
		[22] = 16, -- Off Hand misc
		[23] = 16, -- Held In Off-hand
		[24] = 17, -- Ammo
		[25] = 17, -- Thrown
		[26] = 17, -- Ranged right (wands)
		[28] = 17  -- Relic
	},
}

return utils
