function mb_Priest_Discipline_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Priest_ReadyCheck)
    mb_RegisterExclusiveRequestHandler("external", mb_Priest_Discipline_ExternalRequestAcceptor, mb_Priest_Discipline_ExternalRequestExecutor)
    mb_RegisterExclusiveRequestHandler("power_infusion", mb_Priest_Discipline_PowerInfusionRequestAcceptor, mb_Priest_Discipline_PowerInfusionRequestExecutor)
end

mb_lastRaptureTime = 0
function mb_Priest_Discipline_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Resurrection") then
        return
    end

    if not UnitBuff("player", "Inner Fire") then
        CastSpellByName("Inner Fire")
        return
    end

    if mb_Priest_useCooldownsCommandTime + 20 > mb_time then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Divine Hymn") then
            return
        end
    end

	if mb_UnitPowerPercentage("player") < 50 and UnitAffectingCombat("player") then
        AssistUnit(mb_commanderUnit)
        if mb_CastSpellOnTarget("Shadowfiend") then
            return
        end
    end

    local tanks = mb_GetTanks("Flash Heal")
    if tanks[1] ~= nil and UnitAffectingCombat(tanks[1]) and mb_GetDebuffTimeRemaining(tanks[1], "Weakened Soul") == 0 then
        if mb_CastSpellOnUnit("Power Word: Shield", tanks[1]) then
            return
        end
    end

    if tanks[2] ~= nil and UnitAffectingCombat(tanks[2]) and mb_GetDebuffTimeRemaining(tanks[2], "Weakened Soul") == 0 then
        if mb_CastSpellOnUnit("Power Word: Shield", tanks[2]) then
            return
        end
    end

     if not mb_UnitHasMyBuff(tanks[1], "Prayer of Mending") and UnitAffectingCombat(tanks[1]) then
        if mb_CastSpellOnUnit("Prayer of Mending", tanks[1]) then
            return
        end
    end

    if tanks[1] ~= nil and mb_GetMissingHealth(tanks[1]) > mb_GetSpellEffect("Penance") then
        if mb_CastSpellOnUnit("Penance", tanks[1]) then
            return
        end
    end

    local unit = mb_GetLowestHealthFriendly("Power Word: Shield", mb_Priest_WeakenedSoulFilter)
    if unit ~= nil and UnitAffectingCombat(unit) then
        if mb_CastSpellOnUnit("Power Word: Shield", unit) then
            return
        end
    end

    local healUnit, missingHealth = mb_GetMostDamagedFriendly("Flash Heal")
    if missingHealth > 4000 and not UnitDebuff(healUnit, "Necrotic Aura") then
        if mb_CastSpellOnUnit("Flash Heal", healUnit) then
            return
        end
    end
end

function mb_Priest_StackRapture()
    if mb_GetDebuffTimeRemaining(tanks[1], "Weakened Soul") < 1.5 then
        return false
    end

    if mb_lastRaptureTime + 8 < mb_time then
        return false
    end

    local healUnit = mb_GetMostDamagedFriendly("Power Word: Shield")
    if not UnitDebuff(healUnit, "Weakened Soul") then
        if mb_CastSpellOnUnit("Power Word: Shield", healUnit) then
            return
        end
    end
end

function mb_Priest_WeakenedSoulFilter(unit)
    if UnitDebuff(unit, "Weakened Soul") or mb_UnitHasMyBuff(unit, "Power Word: Shield") then
        return true
    end

    return false
end


-- Pain Suppression
function mb_Priest_Discipline_ExternalRequestAcceptor(message, from)
    if mb_IsUsableSpell("Pain Suppression") and mb_GetRemainingSpellCooldown("Pain Suppression") < 1.5 then
        if mb_IsUnitValidFriendlyTarget(from, "Pain Suppression") then
            return true
        end
    end

    return false
end

function mb_Priest_Discipline_ExternalRequestExecutor(message, from)
    if not mb_IsReadyForNewCast() then
        return false
    end

    local targetUnit = mb_GetUnitForPlayerName(from)
    if mb_CastSpellOnUnit("Pain Suppression", targetUnit) then
        mb_SayRaid("Casting Pain Suppression on " .. from)
        return true
    end

    return false
end


-- Power Infusion
function mb_Priest_Discipline_PowerInfusionRequestAcceptor(message, from)

    if mb_CanCastSpell("Power Infusion", from, true) then
        return true
    end

    return false
end

function mb_Priest_Discipline_PowerInfusionRequestExecutor(message, from)
    if not mb_IsReadyForNewCast() then
        return false
    end

    local targetUnit = mb_GetUnitForPlayerName(from)
    if mb_CastSpellOnUnit("Power Infusion", targetUnit) then
        mb_SayRaid("Casting Power Infusion on " .. from)
        return true
    end

    return false
end

