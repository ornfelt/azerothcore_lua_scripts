function mb_Mage_OnLoad()
    if mb_GetMySpecName() == "Arcane" then
        mb_classSpecificRunFunction = mb_Mage_Arcane_OnUpdate
        mb_Mage_Arcane_OnLoad()
    elseif mb_GetMySpecName() == "Fire" then
        mb_classSpecificRunFunction = mb_Mage_Fire_OnUpdate
    else
        mb_classSpecificRunFunction = mb_Mage_Frost_OnUpdate
        mb_SpecNotSupported("Frost Mages are not yet supported")
    end

    if mb_myClassOrderIndex == 1 then
        mb_RegisterMessageHandler(BUFF_INTELLECT.requestType, mb_Mage_IntellectHandler)
    end

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_MIGHT)    -- Warlock pets count as mages, they need might
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)

    mb_CheckReagentAmount("Arcane Powder", 200)
end

function mb_Mage_HandleIntellect(targetPlayerName, greaterSpell, singleSpell)
    if not mb_ShouldBuff() then
        return
    end

    if mb_CastSpellWithoutTarget(greaterSpell) then
        return
    end

    mb_CastSpellOnUnit(singleSpell, mb_GetUnitForPlayerName(targetPlayerName))
end

function mb_Mage_IntellectHandler(msg, from)
    mb_Mage_HandleIntellect(from, "Arcane Brilliance", "Arcane Intellect")
end

function mb_Mage_HandleManaGem(itemName)
    if UnitAffectingCombat("player") then
        return false
    end

    if mb_GetItemLocation(itemName) == nil then
        mb_CastSpellWithoutTarget("Conjure Mana Gem")
        return true
    end

    local count = GetItemCount("Mana Sapphire", nil, true)
    if count < 3 then
        mb_CastSpellWithoutTarget("Conjure Mana Gem")
        return true
    end

    return false
end

-- Focus Magic on the player names specified in Config.lua according to the mages class order index
-- See Config.lua -> mb_config.focusMagicTargets to set the list of players you wish to have Focus Magic
-- You can expand the list below further if you have additional mages
function mb_Mage_HandleFocusMagic()
    local tarUnit = ""
    local known = IsSpellKnown(54646) -- Focus Magic id
    if not known then
        return false
    elseif mb_myClassOrderIndex == 1 then
        tarUnit = mb_GetUnitForPlayerName(mb_config.focusMagicTargets.first)
    elseif mb_myClassOrderIndex == 2 then
        tarUnit = mb_GetUnitForPlayerName((mb_config.focusMagicTargets.second))
    end

    if tarUnit == nil or UnitBuff(tarUnit, "Focus Magic") then
        return false
    end

    return mb_CastSpellOnUnit("Focus Magic", tarUnit)
end

function mb_Mage_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Molten Armor") < 540 then
        CancelUnitBuff("player", "Molten Armor")
        ready = false
    end

    return ready
end