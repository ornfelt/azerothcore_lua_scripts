mb_LootHandler_queuedLootCouncilMsg = nil
mb_LootHandler_queryRetries = 0

function mb_LootHandler_OnUpdate()
    if mb_LootHandler_queryRetries > 25 then
        mb_SayRaid("Timed out for LC request trying to get link for " .. tostring(mb_LootHandler_queuedLootCouncilMsg))
        mb_LootHandler_queuedLootCouncilMsg = nil
        mb_LootHandler_queryRetries = 0
        return
    end
    if mb_LootHandler_queuedLootCouncilMsg ~= nil then
        mb_LootHandler_HandleLootCouncilRequest(mb_LootHandler_queuedLootCouncilMsg)
        return
    end
    mb_LootHandler_queryRetries = 0
end

function mb_LootHandler_HandleLootCouncilRequest(msg)
    if msg == nil or msg == ""or msg == " " then
        return
    end
    local itemName, itemLink, _, itemLevel, _, itemType, itemSubType, _, itemEquipLoc = GetItemInfo(msg)
    if itemName == nil then
        mb_LootHandler_queuedLootCouncilMsg = msg
        mb_LootHandler_queryRetries = mb_LootHandler_queryRetries + 1
        GameTooltip:SetHyperlink(msg)
        return
    end
    mb_LootHandler_queuedLootCouncilMsg = nil
    if not mb_LootHandler_CanEquipItem(itemSubType, itemEquipLoc) then
        return
    end
    local usableSlots = mb_LootHandler_GetUsableSlotsForItemEquipLoc(itemEquipLoc)
    local output = ""
    local currentItemsValues = {}
    local newItemValue = mb_LootHandler_GetNormalizedValueForItem(itemLink)
    local isUpgrade = false
    for _, v in pairs(usableSlots) do
        local currentItemLink = GetInventoryItemLink("player", v)
        if currentItemLink == nil then
            table.insert(currentItemsValues, 0)
            isUpgrade = true
        else
            local currentItemName, _, _, currentItemLevel = GetItemInfo(currentItemLink)
            if currentItemName == itemName and currentItemLevel == itemLevel then
                return
            end
            if output ~= "" then
                output = output .. "/"
            end
            output = output .. currentItemLink
            local currentItemValue = mb_LootHandler_GetNormalizedValueForItem(currentItemLink)
            table.insert(currentItemsValues, currentItemValue)
            if currentItemValue < newItemValue then
                isUpgrade = true
            end
        end
    end
    if isUpgrade then
        local s = ""
        for _, currentItemValue in pairs(currentItemsValues) do
            if s ~= "" then
                s = s .. "/"
            end
            local valueIncrease = newItemValue - currentItemValue
            s = s .. tostring(floor(valueIncrease))
        end
        mb_SayRaid(s .. " score increase over " .. output)
    end
end

function mb_LootHandler_GetNormalizedValueForItem(itemLink)
	local stats = {}
	GetItemStats(itemLink, stats)

	if mb_config.statWeights[UnitClass("player")] == nil or mb_config.statWeights[UnitClass("player")][mb_GetMySpecName()] == nil then
		mb_SayRaid("I don't have stat-weights set up for my class/spec")
		return 0
	end

	local itemValue = 0
	for badStatName, statAmount in pairs(stats) do
		local goodStatName = mb_LootHandler_GetGoodStatName(badStatName)
		if goodStatName == nil then
			mb_SayRaid("I didn't have a good-name translation for stat: " .. badStatName)
		else
			local statWeight = mb_config.statWeights[UnitClass("player")][mb_GetMySpecName()][goodStatName]
			if statWeight == nil then
				mb_SayRaid("I didn't have a stat-weight defined for the stat: " .. goodStatName)
			else
				itemValue = itemValue + statAmount * statWeight
			end
		end
	end
	return itemValue
end



-- ----------------------------------
-- Hardcoded translation functions --
-- ----------------------------------
function mb_LootHandler_GetUsableSlotsForItemEquipLoc(itemEquipLoc)
    if itemEquipLoc == "INVTYPE_HEAD" then
        return { 1 }
    end
    if itemEquipLoc == "INVTYPE_NECK" then
        return { 2 }
    end
    if itemEquipLoc == "INVTYPE_SHOULDER" then
        return { 3 }
    end
    if itemEquipLoc == "INVTYPE_CHEST" or itemEquipLoc == "INVTYPE_ROBE" then
        return { 5 }
    end
    if itemEquipLoc == "INVTYPE_WAIST" then
        return { 6 }
    end
    if itemEquipLoc == "INVTYPE_LEGS" then
        return { 7 }
    end
    if itemEquipLoc == "INVTYPE_FEET" then
        return { 8 }
    end
    if itemEquipLoc == "INVTYPE_WRIST" then
        return { 9 }
    end
    if itemEquipLoc == "INVTYPE_HAND" then
        return { 10 }
    end
    if itemEquipLoc == "INVTYPE_FINGER" then
        return { 11, 12 }
    end
    if itemEquipLoc == "INVTYPE_TRINKET" then
        return { 13, 14 }
    end
    if itemEquipLoc == "INVTYPE_CLOAK" then
        return { 15 }
    end
    if itemEquipLoc == "INVTYPE_WEAPON" then
        return { 16, 17 }
    end
    if itemEquipLoc == "INVTYPE_2HWEAPON" or itemEquipLoc == "INVTYPE_WEAPONMAINHAND" then
        return { 16 }
    end
    if itemEquipLoc == "INVTYPE_SHIELD" or itemEquipLoc == "INVTYPE_WEAPONOFFHAND" or itemEquipLoc == "INVTYPE_HOLDABLE" then
        return { 17 }
    end
    if itemEquipLoc == "INVTYPE_RANGED" or itemEquipLoc == "INVTYPE_RANGEDRIGHT" or itemEquipLoc == "INVTYPE_THROWN" or itemEquipLoc == "INVTYPE_RELIC" then
        return { 18 }
    end
end

function mb_LootHandler_GetGoodStatName(badStatName)
    -- Base stats
    if badStatName == "ITEM_MOD_AGILITY_SHORT" then
        return "agility"
    end
    if badStatName == "ITEM_MOD_INTELLECT_SHORT" then
        return "intellect"
    end
    if badStatName == "ITEM_MOD_SPIRIT_SHORT" then
        return "spirit"
    end
    if badStatName == "ITEM_MOD_STRENGTH_SHORT" then
        return "strength"
    end
    if badStatName == "ITEM_MOD_STAMINA_SHORT" then
        return "stamina"
    end

    -- Ratings
    if badStatName == "ITEM_MOD_CRIT_RATING_SHORT" then
        return "critRating"
    end
    if badStatName == "ITEM_MOD_RESILIENCE_RATING_SHORT" then
        return "resilienceRating"
    end
    if badStatName == "ITEM_MOD_DEFENSE_SKILL_RATING_SHORT" then
        return "defenseRating"
    end
    if badStatName == "ITEM_MOD_EXPERTISE_RATING_SHORT" then
        return "expertiseRating"
    end
    if badStatName == "ITEM_MOD_DODGE_RATING_SHORT" then
        return "dodgeRating"
    end
    if badStatName == "ITEM_MOD_PARRY_RATING_SHORT" then
        return "parryRating"
    end
    if badStatName == "ITEM_MOD_BLOCK_RATING_SHORT" then
        return "blockRating"
    end
    if badStatName == "ITEM_MOD_ARMOR_PENETRATION_RATING_SHORT" then
        return "armorPenetrationRating"
    end
    if badStatName == "ITEM_MOD_HIT_RATING_SHORT" then
        return "hitRating"
    end
    if badStatName == "ITEM_MOD_HASTE_RATING_SHORT" then
        return "hasteRating"
    end

    -- Others
    if badStatName == "ITEM_MOD_ATTACK_POWER_SHORT" then
        return "attackPower"
    end
    if badStatName == "RESISTANCE0_NAME" then
        return "armor"
    end
    if badStatName == "ITEM_MOD_BLOCK_VALUE_SHORT" then
        return "blockValue"
    end
    if badStatName == "ITEM_MOD_SPELL_POWER_SHORT" then
        return "spellPower"
    end
    if badStatName == "ITEM_MOD_MANA_REGENERATION_SHORT" then
        return "mp5"
    end
    if badStatName == "ITEM_MOD_POWER_REGEN0_SHORT" then
        return "mp5"
    end
    if badStatName == "ITEM_MOD_DAMAGE_PER_SECOND_SHORT" then
        return "dps"
    end
    if badStatName == "ITEM_MOD_FERAL_ATTACK_POWER_SHORT" then
        return "attackPower"
    end

    -- Sockets
    if badStatName == "EMPTY_SOCKET_META" then
        return "socketMeta"
    end
    if badStatName == "EMPTY_SOCKET_RED" then
        return "socketColored"
    end
    if badStatName == "EMPTY_SOCKET_BLUE" then
        return "socketColored"
    end
    if badStatName == "EMPTY_SOCKET_YELLOW" then
        return "socketColored"
    end

	return nil
end

function mb_LootHandler_CanEquipItem(itemSubType, itemEquipLoc)
    local myClass = mb_GetClass("player")
    local mySpec = mb_GetMySpecName()
    -- Armors
    if itemSubType == "Plate" then
        if myClass == "PALADIN" or myClass == "WARRIOR" or myClass == "DEATHKNIGHT" then
            return true
        end
        return false
    end
    if itemSubType == "Mail" then
        if myClass == "PALADIN" or myClass == "WARRIOR" or myClass == "DEATHKNIGHT" or myClass == "SHAMAN" or myClass == "HUNTER" then
            return true
        end
        return false
    end
    if itemSubType == "Leather" then
        if myClass == "MAGE" or myClass == "WARLOCK" or myClass == "PRIEST" then
            return false
        end
        return true
    end
    -- Ranged
    if itemSubType == "Bows" or itemSubType == "Guns" or itemSubType == "Crossbows" or itemSubType == "Thrown" then
        if myClass == "WARRIOR" or myClass == "ROGUE" or myClass == "HUNTER" then
            return true
        end
        return false
    end
    -- One-handed weapons
    if itemSubType == "One-Handed Maces" or itemSubType == "One-Handed Axes" or itemSubType == "Daggers" or itemSubType == "Fist Weapons" or itemSubType == "One-Handed Swords" then
        if myClass == "PALADIN" and mySpec == "Retribution" then
            return false
        end
        if myClass == "WARRIOR" and mySpec ~= "Protection" then
            return false
        end
        if myClass == "SHAMAN" and itemSubType == "One-Handed Swords" then
            return false
        end
        return true
    end
    -- Shields
    if itemSubType == "Shields" then
        if mySpec == "Protection" then
            return true
        end
        if myClass == "SHAMAN" and mySpec ~= "Enhancement" then
            return true
        end
        return false
    end
    -- Two-handed weapons
    if itemSubType == "Polearms" or itemSubType == "Staves" or itemSubType == "Two-Handed Maces" or itemSubType == "Two-Handed Swords" or itemSubType == "Two-Handed Axes" then
        if myClass == "ROGUE" then
            return false
        end
        if myClass == "SHAMAN" and mySpec == "Enhancement" then
            return false
        end
        if mySpec == "Protection" then
            return false
        end
        return true
    end
    -- Wands
    if itemSubType == "Wands" then
        if myClass == "MAGE" or myClass == "PRIEST" or myClass == "WARLOCK" then
            return true
        end
        return false
    end
    -- Offhands
    if itemSubType == "Miscellaneous" and itemEquipLoc == "INVTYPE_HOLDABLE" then
        if myClass == "MAGE" or myClass == "PRIEST" or myClass == "WARLOCK" then
            return true
        end
        if myClass == "DRUID" and mySpec ~= "Feral Combat" then
            return true
        end
        if myClass == "PALADIN" and mySpec == "Holy" then
            return true
        end
        if myClass == "SHAMAN" and mySpec ~= "Enhancement" then
            return true
        end
        return false
    end

	return true
end



