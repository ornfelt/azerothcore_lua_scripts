function mb_GetClass(unit)
    local _, class = UnitClass(unit)
    return class
end

function mb_GetNumPartyOrRaidMembers()
    if UnitInRaid("player") then
        return GetNumRaidMembers()
    else
        return GetNumPartyMembers()
    end
    return 1
end

function mb_GetNumOnlinePartyOrRaidMembers()
    local members = mb_GetNumPartyOrRaidMembers()
    local count = members
    for i = 1, members do
        local unit = mb_GetUnitFromPartyOrRaidIndex(i)
        if not UnitIsConnected(unit) then
            count = count - 1
        end
    end
    return count
end

-- Returns the unit that has specified raidIndex
function mb_GetUnitFromPartyOrRaidIndex(index)
    if index ~= 0 then
        if UnitInRaid("player") then
            return "raid" .. index
        else
            return "party" .. index
        end
    end
    return "player"
end

-- Turns a playerName into a unit-reference, nil if not found
function mb_GetUnitForPlayerName(playerName)
    if UnitName("player") == playerName then
        return "player"
    end
    local members = mb_GetNumPartyOrRaidMembers()
    for i = 1, members do
        local unit = mb_GetUnitFromPartyOrRaidIndex(i)
        if UnitName(unit) == playerName then
            return unit
        end
    end
    return nil
end

-- Returns a bool, and the substring of the remaining string
function mb_StringStartsWith(fullString, startString)
    if string.sub(fullString, 1, string.len(startString)) == startString then
        return true, string.sub(fullString, string.len(startString) + 2)
    end
    return false, nil
end

-- Prints message in raid-chat
function mb_SayRaid(message)
    SendChatMessage(message, "RAID")
end

-- Player speaks the message in /s
function mb_Say(message)
	SendChatMessage(message, "SAY", "Common")
end

function mb_IsCasting()
    return UnitCastingInfo("player") ~= nil or UnitChannelInfo("player") ~= nil
end

function mb_CreateMacro(name, body, actionSlot)
    local macroId = GetMacroIndexByName(name)
    if macroId > 0 then
        EditMacro(macroId, name, 12, body, 1, 1)
    else
        macroId = CreateMacro(name, 12, body, 1, 1)
    end

    if actionSlot == nil then
        return
    end
    PickupMacro(macroId)
    PlaceAction(actionSlot)
    ClearCursor()
end

function mb_IsValidOffensiveUnit(unit, requireCombat)
    if not UnitExists(unit) then
        return false
    end
    if UnitIsDeadOrGhost(unit) then
        return false
    end
    if UnitCanAttack("player", unit) == nil then
        return false
    end
    if requireCombat then
        if not UnitAffectingCombat(unit) then
            return false
        end
    end
    return true
end

function mb_GetMissingHealth(unit)
    return UnitHealthMax(unit) - UnitHealth(unit)
end

-- Runs IsSpellInRange and converts to bool
function mb_IsSpellInRange(spell, unit)
    return IsSpellInRange(spell, unit) == 1
end

-- Checks if target exists, is friendly and if it's dead or ghost, and if the spell is in range if provided
function mb_IsUnitValidFriendlyTarget(unit, spell)
	if UnitIsDeadOrGhost(unit) then
		return false
	end
    if UnitCanAttack("player", unit) == 1 then
        return false
    end
    if spell ~= nil and not mb_IsSpellInRange(spell, unit) then
        return false
    end
    if UnitBuff(unit, "Spirit of Redemption") then
        return false
    end
    return true
end

-- Scans through the raid or party for the unit missing the most health. If "spell" is provided it will make sure the spell is within range of the target
function mb_GetMostDamagedFriendly(spell)
	local healTarget = 0
	local missingHealthOfTarget = mb_GetMissingHealth("player")
	local members = mb_GetNumPartyOrRaidMembers()
	for i = 1, members do
		local unit = mb_GetUnitFromPartyOrRaidIndex(i)
		local missingHealth = mb_GetMissingHealth(unit)
		if missingHealth > missingHealthOfTarget then
			if mb_IsUnitValidFriendlyTarget(unit, spell) then
                if mb_Paladin_Holy_beaconUnit == nil or mb_Paladin_Holy_beaconUnit ~= unit then
                    -- Used for Holy paladins to make them never heal their beacon
                    missingHealthOfTarget = missingHealth
                    healTarget = i
                end
			end
		end
	end
    if UnitExists("focus") then
        local missingHealth = mb_GetMissingHealth("focus")
        if missingHealth > missingHealthOfTarget and mb_IsUnitValidFriendlyTarget("focus", spell) then
            return "focus", missingHealth
        end
    end
	if healTarget == 0 then
		return "player", missingHealthOfTarget
	else
		return mb_GetUnitFromPartyOrRaidIndex(healTarget), missingHealthOfTarget
	end
end

function mb_GetLowestHealthFriendly(spell, filterFunc)
	local healTarget = 0
	local lowestHealthTarget = 9999999999
	local members = mb_GetNumPartyOrRaidMembers()
	for i = 1, members do
		local unit = mb_GetUnitFromPartyOrRaidIndex(i)
		local lowestHealth = UnitHealth(unit)
		if filterFunc == nil or not filterFunc(unit) then
			if lowestHealth < lowestHealthTarget then
				if mb_IsUnitValidFriendlyTarget(unit, spell) then
					if mb_Paladin_Holy_beaconUnit == nil or mb_Paladin_Holy_beaconUnit ~= unit then -- Used for Holy paladins to make them never heal their beacon
						lowestHealthTarget = lowestHealth
						healTarget = i
					end
				end
			end
		end
	end
	if UnitExists("focus") then
		local lowestHealth = UnitHealth("focus")
		if filterFunc == nil or not filterFunc("focus") then
			if lowestHealth < lowestHealthTarget and mb_IsUnitValidFriendlyTarget("focus", spell) then
				return "focus", lowestHealth
			end
		end
	end
	if healTarget == 0 then
		if filterFunc == nil or not filterFunc("player") then
			return "player", lowestHealthTarget
		end

		return nil
	else
		return mb_GetUnitFromPartyOrRaidIndex(healTarget), lowestHealthTarget
	end
end

function mb_UnitHealthPercentage(unit)
    return (UnitHealth(unit) * 100) / UnitHealthMax(unit)
end

function mb_UnitPowerPercentage(unit)
    return (UnitPower(unit) * 100) / UnitPowerMax(unit)
end

-- Unit is optional, if provided it will check that the spell can be cast on the unit (that it's a valid target and is in range)
function mb_IsUsableSpell(spell, unit)
    local usable, nomana = IsUsableSpell(spell)
    if usable == nil then
        return false
    end
    if unit == nil then
        return true
    end
    if UnitCanAttack("player", unit) == 1 then
        return mb_IsValidOffensiveUnit(unit) and mb_IsSpellInRange(spell, unit)
    else
        return mb_IsUnitValidFriendlyTarget(unit, spell)
    end
end

mb_finisherMoves = {
	"Eviscerate",
	"Rupture",
	"Kidney Shot",
	"Slice and Dice",
	"Expose Armor",
	"Envenom",
	"Rip",
	"Maim",
	"Ferocious Bite",
	"Savage Roar"
}
-- Checks if there's no cooldown and if the spell use usable (have mana to cast it), and that if we're moving that it doesn't have a cast time
-- Unit is optional, if provided it will check that the spell can be cast on the unit (that it's a valid target and is in range)
function mb_CanCastSpell(spell, unit, withinNextGlobal)
    if not mb_IsUsableSpell(spell, unit) then
        return false
    end
    local cd = 0
    if withinNextGlobal then
        cd = 1.5
    end
    if mb_GetRemainingSpellCooldown(spell) > cd then
        return false
    end
    if mb_IsMoving() then
        local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spell)
        if castTime > 0 then
            return false
        end
    end
    return true
end

-- Returns true on success, false if not possible
function mb_CastSpellOnUnit(spell, unit)
    if not mb_CanCastSpell(spell, unit) then
        return false
    end
    -- Make casters on lenient break follow to cast a spell with cast-time if they're close to their commander
    local castTime = mb_GetCastTime(spell)
    if not mb_disabledAutomaticMovement then
        mb_HandleOnCastMovement(castTime)
    end
    if mb_IsMoving() and castTime > 0 then
        return false
    end
    CastSpellByName(spell, unit)
    return true
end

function mb_CastSpellOnTarget(spell)
    return mb_CastSpellOnUnit(spell, "target")
end

function mb_CastSpellWithoutTarget(spell)
    return mb_CastSpellOnUnit(spell, nil)
end

function mb_CastSpellOnSelf(spell)
    return mb_CastSpellOnUnit(spell, "player")
end

-- Returns true/false depending on if the unit is capable of resurrecting other players
function mb_IsUnitResurrector(unit)
    local unitClass = mb_GetClass(unit)
    return unitClass == "PALADIN" or unitClass == "PRIEST" or unitClass == "SHAMAN" or unitClass == "DRUID"
end

-- Checks if any friendly unit is resurrecting another raid-member
function mb_IsSomeoneResurrectingUnit(resurrectUnit)
	local members = mb_GetNumPartyOrRaidMembers()
	for i = 1, members do
		local unit = mb_GetUnitFromPartyOrRaidIndex(i)
        if UnitName(unit .. "target") == UnitName(resurrectUnit) then
            return true
        end
    end
    return false
end

function mb_GetResurrectionTarget(resurrectionSpell)
    local members = mb_GetNumPartyOrRaidMembers()
    local resUnit = nil
    for i = 1, members do
        local unit = mb_GetUnitFromPartyOrRaidIndex(i)
        if UnitIsDead(unit) and not mb_IsSomeoneResurrectingUnit(unit) and mb_IsSpellInRange(resurrectionSpell, unit) then
            if mb_IsUnitResurrector(unit) then
                return unit
            end
            resUnit = unit
        end
    end
    return resUnit
end

-- Will try to resurrect a dead raid member
function mb_ResurrectRaid(resurrectionSpell)
    if UnitIsDead("target") then
        if UnitCastingInfo("player") == resurrectionSpell then
            return true
        end
        if UnitInRaid("target") then
            ClearTarget()
        end
    end

    if UnitAffectingCombat("player") or mb_IsDrinking() or mb_IsMoving() then
        return false
    end
    if not mb_CanCastSpell(resurrectionSpell) then
        return false
    end
    local resUnit = mb_GetResurrectionTarget(resurrectionSpell)
    if resUnit == nil then
        return false
    end
    TargetUnit(resUnit)
    CastSpellByName(resurrectionSpell)
    mb_SayRaid("I'm resurrecting " .. UnitName(resUnit))
    return true
end

function mb_GetCastTime(spell)
    local _, _, _, _, _, _, castTime = GetSpellInfo(spell)
    return castTime / 1000.0
end

-- Checks if unit has a buff from the spell specified that specifically you have cast
function mb_UnitHasMyBuff(unit, spell)
    local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, spell, nil, "PLAYER|HELPFUL")
    return name ~= nil
end

-- Returns number of debuff stacks
function mb_GetDebuffStackCount(unit, spell)
    local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, spell, nil, "HARMFUL")
    if count == nil then
        return 0
    end
    return count
end

-- Returns the time remaining of a debuff, 0 if it doesn't exist
function mb_GetDebuffTimeRemaining(unit, spell)
    local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, spell, nil, "HARMFUL")
    if name == nil then
        return 0
    end
    return expirationTime - mb_time
end

-- Returns the time remaining of a debuff that you have cast, 0 if it doesn't exist
function mb_GetMyDebuffTimeRemaining(unit, spell)
    local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, spell, nil, "PLAYER|HARMFUL")
    if name == nil then
        return 0
    end
    return expirationTime - mb_time
end

-- Returns the time remaining of a buff
function mb_GetBuffTimeRemaining(unit, spell)
    local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, spell, nil, "HELPFUL")
    if name == nil then
        return 0
    end
    return expirationTime - mb_time
end

-- Returns number of buff stacks
function mb_GetBuffStackCount(unit, spell)
    local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId = UnitAura(unit, spell, nil, "HELPFUL")
    if count == nil then
        return 0
    end
    return count
end

--
function mb_CleanseRaid(spell, debuffType1, debuffType2, debuffType3)
    for i = 1, mb_GetNumPartyOrRaidMembers() do
        local unit = mb_GetUnitFromPartyOrRaidIndex(i)
        if mb_UnitHasDebuffOfType(unit, debuffType1, debuffType2, debuffType3) and mb_IsUnitValidFriendlyTarget(unit, spell) then
            return mb_CastSpellOnUnit(spell, unit)
        end
    end
    return false
end

--
function mb_UnitHasDebuffOfType(unit, debuffType1, debuffType2, debuffType3)
    for i = 1, 40 do
        local name, _, _, _, type = UnitDebuff(unit, i)
        if name == nil then
            return false
        end
        if debuffType1 ~= nil and debuffType1 == type then
            return true
        end
        if debuffType2 ~= nil and debuffType2 == type then
            return true
        end
        if debuffType3 ~= nil and debuffType3 == type then
            return true
        end
    end
    return false
end

-- Returns true if you're on Global Cooldown
function mb_IsOnGCD()
	if GetSpellCooldown(mb_GCDSpell) ~= 0 then
		return true
	end
	return false
end

-- Returns how many seconds you have left of your current cast. 0 if you're not casting
function mb_GetCastTimeRemaining()
    local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo("player")
    if spell == nil then
        return 0
    end
    return (endTime / 1000) - mb_time
end

-- Returns true if you're not on GCD and not currently casting
-- Also returns true if you're within 150ms away from being ready to cast in order to be able to queue up next cast
function mb_IsReadyForNewCast()
    if mb_IsCasting() then
        return false
    end
    if mb_IsOnGCD() then
        return false
    end
    return true
end

-- Returns the name of your spec
function mb_GetMySpecName()
	if mb_cache_specName ~= nil then
		return mb_cache_specName
	end
	local name, _, points = GetTalentTabInfo(1)
	for i = 2, 3 do
		local n, _, p = GetTalentTabInfo(i)
		if p > points then
			points = p
			name = n
		end
	end
	mb_cache_specName = name
	return name
end

--
function mb_UnitHasDebuffOfType(unit, debuffType1, debuffType2, debuffType3)
	for i = 1, 40 do
		local name, _, _, _, type = UnitDebuff(unit, i)
		if name == nil then
			return false
		end
		if debuffType1 ~= nil and debuffType1 == type then
			return true
		end
		if debuffType2 ~= nil and debuffType2 == type then
			return true
		end
		if debuffType3 ~= nil and debuffType3 == type then
			return true
		end
	end
	return false
end

-- Returns true if using CDs is a good idea
function mb_ShouldUseDpsCooldowns(rangeCheckSpell)
    if mb_forceBlockDpsCooldowns then
        return false
    end
    if not mb_IsValidOffensiveUnit("target", true) then
        return false
    end
    if not mb_IsSpellInRange(rangeCheckSpell, "target") then
        return false
    end

    local targetStrength = mb_GetTargetStrength()
    if targetStrength == 3 then
        return true
    end
    if targetStrength == 2 and mb_UnitHealthPercentage("target") > 50 then
        return true
    end

    return false
end

-- Returns a spell-id for a spell-name
function mb_GetSpellIdForName(spellName)
	local link = GetSpellLink(spellName)
	link = string.sub(link, string.find(link, "spell:") + 6)
	local spellId = string.sub(link, 1, string.find(link, "|") - 1)
	return tonumber(spellId)
end

function mb_SetPetAutocast(spell, desiredState)
    local _, autoCastState = GetSpellAutocast(spell, "pet")
    autoCastState = autoCastState == 1
    if autoCastState == desiredState then
        return
    end
    ToggleSpellAutocast(spell, "pet")
end

-- Converts an ItemLink to an ItemString
function mb_GetItemStringFromItemLink(itemLink)
	local found, _, itemString = string.find(itemLink, "^|%x+|H(.+)|h%[.+%]")
	return itemString
end

-- Uses item in bag by name
function mb_UseItem(itemName)
	local bag, slot = mb_GetItemLocation(itemName)
	if bag ~= nil then
		UseContainerItem(bag, slot)
		return true
	end
	return false
end

-- Returns the count of item with specified name
function mb_GetItemCount(itemName)
	local totalItemCount = 0
	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local itemLink = GetContainerItemLink(bag, slot)
			if itemLink ~= nil then
				local name = GetItemInfo(itemLink)
				if name == itemName then
					local _, itemCount = GetContainerItemInfo(bag, slot);
					totalItemCount = totalItemCount + itemCount
				end
			end
		end
	end
	return totalItemCount
end

function mb_CheckReagentAmount(itemName, desiredItemCount)
    local currentItemCount = mb_GetItemCount(itemName)
    if currentItemCount < desiredItemCount then
        mb_SayRaid("I'm low on " .. itemName .. ". " .. tostring(currentItemCount) .. "/" .. tostring(desiredItemCount))
    end
end

-- Makes the character say in raid if durability of any item is lower than 30%
function mb_CheckDurability()
    local lowestDurability = 1.0
    for i = 1, 18 do
        local current, maximum = GetInventoryItemDurability(i)
        if current ~= nil and maximum ~= nil then
            lowestDurability = min(lowestDurability, current / maximum)
        end
    end

    if lowestDurability < 0.3 then
        mb_SayRaid("I'm low on durability and could use a repair, my lowest item is at " .. tostring(lowestDurability * 100) .. "%")
    end
end

-- Returns true/false depending on if the item is in the table
function mb_TableContains(table, item)
    for _, v in pairs(table) do
        if v == item then
            return true
        end
    end
    return false
end

-- Finds the most damaged member in the raid and casts the spell on that target as long as it doesn't over-heal
function mb_RaidHeal(spell, acceptedOverheal)
    if acceptedOverheal == nil then
        acceptedOverheal = 1
    end
    local healUnit, missingHealth = mb_GetMostDamagedFriendly(spell)
    if missingHealth * (acceptedOverheal) > mb_GetSpellEffect(spell) then
        return mb_CastSpellOnUnit(spell, healUnit)
    end
    return false
end

-- Tries to acquire an offensive target. Will assist the commander unit if it exists.
-- Returns true/false depending on if a valid offensive target was acquired.
function mb_AcquireOffensiveTarget()
    if mb_commanderUnit == nil then
        return mb_IsValidOffensiveUnit("target", true)
    end
    if not UnitExists(mb_commanderUnit .. "target") then
        ClearTarget()
        return false
    end
    AssistUnit(mb_commanderUnit)
    return mb_IsValidOffensiveUnit("target", true)
end

-- Checks whether it's a good time to buff, returns true/false
function mb_ShouldBuff()
    if UnitAffectingCombat("player") or mb_IsDrinking() or mb_UnitPowerPercentage("player") < 30 then
        return false
    end
    local members = mb_GetNumPartyOrRaidMembers()
    for i = 1, members do
        local unit = mb_GetUnitFromPartyOrRaidIndex(i)
        if UnitIsConnected(unit) then
            if not mb_IsUnitValidFriendlyTarget(unit) or not mb_IsUnitWithinRange(unit, 4) then
                return false
            end
            if mb_GetClass(unit) == "WARLOCK" or mb_GetClass(unit) == "HUNTER" then
                if not UnitExists(unit .. "pet") then
                    return false
                end
            end
        end
    end
    return true
end

-- Returns the bag and slot indexes for where an item is located
function mb_GetItemLocation(itemName)
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            local itemLink = GetContainerItemLink(bag, slot)
            if itemLink ~= nil then
                local name = GetItemInfo(itemLink)
                if itemName == name then
                    return bag, slot
                end
            end
        end
    end
    return nil
end

function mb_HasItem(itemName)
    return GetItemCount(itemName) ~= 0
end

-- Tries to use an item in the bags, returns true/false depending on if successful
function mb_UseItem(itemName)
    if GetItemCount(itemName) == 0 then
        return false
    end
    UseItemByName(itemName)
    return true
end

function mb_IsDrinking()
    return UnitBuff("player", "Drink") ~= nil
end

-- Starts drinking if possible and if good to do so. Returns true if drinking
mb_lastWaterWarningTime = 0
function mb_Drink(force)
    if UnitAffectingCombat("player") or UnitIsDeadOrGhost("player") then
        return false
    end
	if mb_IsDrinking() then
		if mb_UnitPowerPercentage("player") < 99 then
			return true
		else
			SitStandOrDescendStart()
			return false
		end
	end
    local waterName = nil
    for _, water in pairs(mb_config.waters) do
        if mb_HasItem(water) then
            waterName = water
            break
        end
    end
    if waterName == nil then
        if mb_lastWaterWarningTime + 60 < mb_time then
            mb_SayRaid("I don't have any water")
            mb_lastWaterWarningTime = mb_time
        end
        return false
    end

    if force then
        return mb_UseItem(waterName)
    end
    if mb_UnitPowerPercentage("player") > 60 then
        return false
    end
    if mb_lastMovementTime + 2 > mb_time then
        return false
    end
    --if mb_isFollowing and mb_followMode == "lenient" then
    --	mb_BreakFollow()
    --	return true
    --end
    return mb_UseItem(waterName)
end

function mb_StopCast()
    SpellStopCasting()
end

function mb_SplitString(str, char)
	local strings = {}
	while string.find(str, char) do
		table.insert(strings, string.sub(str, 1, string.find(str, char) - 1))
		str = string.sub(str, string.find(str, char) + 1)
	end
	table.insert(strings, str)
	return strings
end

function mb_GetRemainingSpellCooldown(spell)
    local start, duration, enabled = GetSpellCooldown(spell)
    if duration == 0 then
        return 0
    end
    return (start + duration) - mb_time
end

-- Uses trinkets and engineering gloves
mb_itemCooldownSlots = {}
table.insert(mb_itemCooldownSlots, 10) -- Gloves (Engineering enchant)
table.insert(mb_itemCooldownSlots, 13) -- Trinket 1
table.insert(mb_itemCooldownSlots, 14) -- Trinket 2
function mb_UseItemCooldowns()
    for _, slot in pairs(mb_itemCooldownSlots) do
        local start, duration, enable = GetInventoryItemCooldown("player", slot)
        if enable == 1 and start == 0 then
            UseInventoryItem(slot)
            return true
        end
    end
    return false
end

function mb_IsMoving()
    return GetUnitSpeed("player") ~= 0
end

function mb_SpecNotSupported(msg)
    if not mb_isCommanding then
        mb_SayRaid(msg)
    end
end

-- Parameter is optional, if omitted it defaults to player
function mb_IsTank(unit)
    if unit == nil or unit == "player" then
        return mb_GetMySpecName() == "Protection" or mb_GetMySpecName() == "Feral Combat" or mb_GetMySpecName() == "Frost"
    end
    for _, tank in pairs(mb_config.tanks) do
        if UnitName(unit) == tank then
            return true
        end
    end
    return false
end

-- Returns true if the unit's target has the unit as the highest threat target.
-- Second parameter is optional and instead checks if that specific unit is being tanked by the first unit
-- Returns a second value for tanking status:
--      3 = securely tanking, 2 = insecurely tanking, 1 = not tanking but higher threat than tank, 0 = not tanking and lower threat than tank
function mb_IsTanking(unit, creatureUnit)
    if creatureUnit == nil then
        creatureUnit = unit .. "target"
    end
    local isTanking, tankingStatus = UnitDetailedThreatSituation(unit, creatureUnit)
    return isTanking == 1, tankingStatus
end

function mb_IsHealer()
	return mb_GetMySpecName() == "Holy" or mb_GetMySpecName() == "Restoration" or mb_GetMySpecName() == "Discipline"
end

function mb_IsRanged()
    for _, spec in pairs(mb_config.rangedList) do
        if spec == mb_GetMySpecName("player") then
            return spec
        end
    end
end

function mb_IsUnitStunned(unit)
    if mb_GetBuffTimeRemaining(unit, "Hammer of Justice") > 0 then
        return true
    end
    if mb_GetBuffTimeRemaining(unit, "Holy Wrath") > 0 then
        return true
    end
    return false
end

function mb_IsUnitSlowed(unit)
    if mb_GetBuffTimeRemaining(unit, "Frost Shock") > 0 then
        return true
    end
    if mb_GetBuffTimeRemaining(unit, "Earthbind") > 0 then
        return true
    end
    if mb_GetBuffTimeRemaining(unit, "Hamstring") > 0 then
        return true
    end
    return false
end

function mb_GetMapPosition(unit)
    local x, y = GetPlayerMapPosition(unit)
    if x == 0 and y == 0 then
        SetMapToCurrentZone()
        x, y = GetPlayerMapPosition(unit)
    end
    return x, y
end

mb_GoToPosition_destination = nil
-- Called once to initiate a movement to a specific x/y map coordinate. The character will continue to try to stay close to that place until mb_GoToPosition_Reset is called
function mb_GoToPosition_SetDestination(x, y, acceptedDistance, preventAutomaticMovementDisabling)
    if mb_GoToPosition_destination ~= nil then
        if mb_GoToPosition_destination.x == x and mb_GoToPosition_destination.y == y and mb_GoToPosition_destination.acceptedDistance == acceptedDistance then
            return
        end
    end
    mb_GoToPosition_destination = {}
    mb_GoToPosition_destination.x = x
    mb_GoToPosition_destination.y = y
    mb_GoToPosition_destination.acceptedDistance = acceptedDistance
    mb_GoToPosition_hasReachedDestination = false
    if not preventAutomaticMovementDisabling then
        mb_DisableAutomaticMovement()
    end
end

-- Stops movement, if the condition for GoToPosition changes before it has reached it destination characters can get stuck moving / turning otherwise.
function mb_GoToPosition_Reset()
    if mb_GoToPosition_destination == nil then
        return
    end
    mb_GoToPosition_hasReachedDestination = false
    mb_GoToPosition_destination = nil
    mb_StopMoving()
    mb_EnableAutomaticMovement()
end

mb_GoToPosition_hasReachedDestination = false
-- Returns false while the character is running towards the point. Returns true once the character reaches it.
function mb_GoToPosition_Update()
    if mb_GoToPosition_destination == nil then
        return true
    end

    local curX, curY = mb_GetMapPosition("player")
    local dX, dY = mb_GoToPosition_destination.x - curX, mb_GoToPosition_destination.y - curY
    local distance = math.sqrt(dX * dX + dY * dY)
    if mb_GoToPosition_hasReachedDestination and distance < mb_GoToPosition_destination.acceptedDistance * 1.5 then
        -- Allow 50% leeway if you reached the destination previously.
        return true
    end
    if distance < mb_GoToPosition_destination.acceptedDistance then
        mb_StopMoving()
        mb_GoToPosition_hasReachedDestination = true
        return true
    end
    mb_GoToPosition_hasReachedDestination = false

    local currentFacing = GetPlayerFacing()
    local desiredFacing = math.atan2(dX, dY) + math.pi
    local diff = desiredFacing - currentFacing
    if diff > 0 then
        if (currentFacing + 2 * math.pi) - desiredFacing < diff then
            diff = (currentFacing + 2 * math.pi) - desiredFacing
            TurnLeftStop()
            TurnRightStop()
            TurnRightStart()
        else
            TurnRightStop()
            TurnLeftStop()
            TurnLeftStart()
        end
    else
        if (currentFacing - 2 * math.pi) - desiredFacing > diff then
            diff = (currentFacing - 2 * math.pi) - desiredFacing
            TurnRightStop()
            TurnLeftStop()
            TurnLeftStart()
        else
            TurnLeftStop()
            TurnRightStop()
            TurnRightStart()
        end
    end
    if math.abs(diff) < math.pi / 2 then
        MoveForwardStart()
    else
        MoveForwardStop()
    end
    return false
end

function mb_FollowUnit(unit)
    if mb_IsUnitWithinRange(unit, 3) then
        mb_isFollowing = true
        FollowUnit(unit)
        mb_GoToPosition_Reset()
        return true
    end
    mb_isFollowing = false
    return false
end

function mb_BreakFollow()
    if mb_isFollowing then
        mb_isFollowing = false
        TurnLeftStart()
        TurnLeftStop()
    end
end

mb_crowdControlSpells =
{
    "Fear",
    "Polymorph",
    "Death Coil",
    "Hammer of Justice",
    "Hex",
    "Blind",
    "Repentance"
}

function mb_CrowdControl(unit)
    for _, ccSpell in pairs(mb_crowdControlSpells) do
        if mb_GetDebuffTimeRemaining(unit, ccSpell) > 0 then
            if mb_IsCasting() and mb_currentCastTargetUnit == unit then
                mb_StopCast()
            end
            return false
        end
    end

    for _, ccSpell in pairs(mb_crowdControlSpells) do
        if mb_CastSpellOnUnit(ccSpell, unit) then
            return true
        end
    end
    return false
end

mb_lastIWTClickToMove = 0
function mb_IWTClickToMove(unit)
    SetCVar("autoInteract", 1)
    InteractUnit(unit)
    SetCVar("autoInteract", 0)
    mb_lastIWTClickToMove = mb_time
end

-- Returns how close you are to actually pull aggro on your target, returns a value between 0 and 100, ranged over-aggro at 130% is baked in.
function mb_GetMyThreatPercentage(unit)
    local _, _, threatPercentage = UnitDetailedThreatSituation("player", unit)
    if threatPercentage == nil then
        threatPercentage = 0
    end
    return threatPercentage
end

mb_lastSalvationCheck = 0
function mb_HandleAutomaticSalvationRequesting()
    if mb_lastSalvationCheck + 3 > mb_time then
        return
    end
    mb_lastSalvationCheck = mb_time

    if not mb_IsValidOffensiveUnit("target", true) then
        return
    end
    if mb_GetTargetStrength() < 2 then
        return
    end
    if mb_GetBuffTimeRemaining("player", "Hand of Salvation") > 0 then
        return
    end
    if mb_GetMyThreatPercentage("target") > 90 then
        mb_SendExclusiveRequest("salvation")
    end
end

-- Returns a number between 0 and 3 corresponding to how strong the target is. Scales depending on your own max-hp and how many members are in your raid.
function mb_GetTargetStrength()
    local members = mb_GetNumPartyOrRaidMembers()
    if UnitHealthMax("target") > UnitHealthMax("player") * members * 2 then
        return 3
    end
    if UnitHealthMax("target") > UnitHealthMax("player") * members then
        return 2
    end
    if UnitHealthMax("target") > UnitHealthMax("player") then
        return 1
    end
    return 0
end

function mb_StopMoving()
    TurnLeftStop()
    TurnRightStop()
    MoveForwardStop()
    MoveBackwardStop()
    StrafeLeftStop()
    StrafeRightStop()
end

function mb_DisableAutomaticMovement()
    if not mb_disabledAutomaticMovement then
        mb_StopMoving()
        mb_disabledAutomaticMovement = true
    end
end

function mb_EnableAutomaticMovement()
    mb_disabledAutomaticMovement = false
end

-- Hard-coded player -> target
function mb_GetComboPoints()
    return GetComboPoints("player", "target")
end

mb_tanksHistoricalData = {}
function mb_GetTanks_UpdateHistoricalData(rangeCheckSpell)
    for _, tank in pairs(mb_config.tanks) do
        local unit = mb_GetUnitForPlayerName(tank)
        if unit ~= nil then
            if mb_tanksHistoricalData[tank] == nil then
                mb_tanksHistoricalData[tank] = {}
                mb_tanksHistoricalData[tank].lastIsTanking = 0
                mb_tanksHistoricalData[tank].lastInvalidUnit = 0
            end
            if mb_IsTanking(unit) then
                mb_tanksHistoricalData[tank].lastIsTanking = mb_time
            end
            if not mb_IsUnitValidFriendlyTarget(unit, rangeCheckSpell) then
                mb_tanksHistoricalData[tank].lastInvalidUnit = mb_time
            end
        end
    end
end

-- Returns a list of unit-references of tanks, filtered by if they're valid targets and actually tanking something
-- Filtered by in-range if rangeCheckSpell is provided
-- They're considered valid tanks if they have tanked something in the past 20 seconds, and they have not been an invalid target in the past 10 seconds
-- If you're out of combat it just returns the list as specified in config, but with unit-references.
-- If no tank is found it will return the first tank defined in the config as long as that tank is a valid target in range.
function mb_GetTanks(rangeCheckSpell)
    mb_GetTanks_UpdateHistoricalData(rangeCheckSpell)
    local tanks = {}
    for _, tank in pairs(mb_config.tanks) do
        local unit = mb_GetUnitForPlayerName(tank)
        if unit == nil then
            break
        end
        if mb_tanksHistoricalData[tank].lastInvalidUnit + 10 > mb_time then
            break
        end
        if not UnitAffectingCombat("player") then
            table.insert(tanks, unit)
        elseif mb_tanksHistoricalData[tank].lastIsTanking + 20 > mb_time then
            table.insert(tanks, unit)
        end
    end
    if #tanks == 0 then
        local unit = mb_GetUnitForPlayerName(mb_config.tanks[1])
        if unit ~= nil and mb_IsUnitValidFriendlyTarget(unit, rangeCheckSpell) then
            table.insert(tanks, unit)
        end
    end
    return tanks
end

mb_critDebuffs =
{
	{name = "Shadow Mastery", value = 5},
	{name = "Improved Scorch", value = 5},
	{name = "Heart of the Crusader", value = 3},
	{name = "Shadow Embrace", value = 1}
}
mb_dmgBuffs =
{
	{name = "Death's Embrace", value = 12},
	{name = "Shadow Embrace", value = 5}
}
function mb_IsTrustedCharacter(charName)
    for _, name in pairs(mb_config.trustedCharacters) do
        if name == charName then
            return true
        end
    end
    return false
end

-- Returns true/false depending on if unit is within range. 1 = 10 yards, 2 = 11 yards, 3 = 28 yards, 4 = ~35 yards
function mb_IsUnitWithinRange(unit, rangeIndex)
    if rangeIndex == 1 then
        return CheckInteractDistance(unit, 3) == 1
    end
    if rangeIndex == 2 then
        return CheckInteractDistance(unit, 2) == 1
    end
    if rangeIndex == 3 then
        return CheckInteractDistance(unit, 4) == 1
    end
    if rangeIndex == 4 then
        return UnitInRange(unit) == 1
    end
end
-- 1: Physical, 2: Holy, 3: Fire, 4: Nature, 5: Frost, 6: Shadow, 7: Arcane
function mb_GetRealSpellCrit(spellSchool, unit)
	local crit = GetSpellCritChance(spellSchool)

	for _, debuff in pairs(mb_critDebuffs) do
		if UnitDebuff(unit, debuff.name) then
			crit = crit + (mb_GetDebuffStackCount(unit, debuff.name) * debuff.value)
		end
	end
	return crit
end

-- Fisher-Yates shuffle
function mb_ShuffleTable(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
end

function mb_EveryManForHimself()
    local race = UnitRace("player")
    if race ~= "Human" then
        return false
    end

    local hasControl = HasFullControl("player")
    if not hasControl then
        if mb_CastSpellWithoutTarget("Every Man for Himself") then
            return true
        end
    end

    return false
end

function mb_SplitRaidRangeMelee()
    if mb_cache_specName ~= nil then
        for _, spec in pairs(mb_config.rangedList) do
            if spec == mb_GetMySpecName() then
                mb_commanderUnit = mb_GetUnitForPlayerName("Odia")
                return true
            end
        end

        mb_commanderUnit = mb_GetUnitForPlayerName("Malowtank")
        return true
    end

    mb_SayRaid("I failed to determine if I am ranged or melee")
    return false
end

-- Trains a batch of spells - one click per rank of all spells, 9-10 uses to fully train.
function mb_TrainSpells()
    SetTrainerServiceTypeFilter("unavailable", 0)
    SetTrainerServiceTypeFilter("used", 0)
    for i = 1, 30 do
        BuyTrainerService(i)
    end
end
