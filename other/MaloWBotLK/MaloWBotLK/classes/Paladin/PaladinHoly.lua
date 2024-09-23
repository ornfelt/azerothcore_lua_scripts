-- TODO:
-- Lay on Hands, is an external CD due to talent
-- Divine Protection pre-taking damage, probably through a "use personals" macro
-- If low on mana, and if next auto-hit on target is less than like 0.3 seconds away, delay healing until after auto-hit to proc Seal of Wisdom and Judgement of Wisdom
-- On use healCDs, if good on mana, use a potion of speed

function mb_Paladin_Holy_OnLoad()
    mb_preCastFinishCallback = mb_Paladin_Holy_PreCastFinishCallback
    mb_RegisterExclusiveRequestHandler("healcd", mb_Paladin_Holy_HealCdAcceptor, mb_Paladin_Holy_HealCdExecutor)
    mb_RegisterClassSpecificReadyCheckFunction(mb_Paladin_Holy_ReadyCheck)
    mb_EnableIWTDistanceClosing("Judgement of Justice")
    mb_shouldPauseIWTCrawlForCasts = true

    if mb_config.enableConsumablesWatch then
        mb_CheckReagentAmount("Flask of the Frost Wyrm", 3)
        mb_CheckReagentAmount("Runic Mana Potion", 15)
        mb_CheckReagentAmount("Potion of Speed", 15)
    end
end

mb_Paladin_Holy_beaconUnit = nil
mb_Paladin_Holy_useCooldownsCommandTime = 0
function mb_Paladin_Holy_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Redemption") then
        return
    end

    if mb_Paladin_Holy_beaconUnit ~= nil and not UnitBuff(mb_Paladin_Holy_beaconUnit, "Beacon of Light") then
        mb_Paladin_Holy_beaconUnit = nil
    end

    if UnitAffectingCombat("player") then
        if mb_UnitHealthPercentage("player") < 30 and mb_CastSpellWithoutTarget("Divine Shield") then
            return
        end
    end

    if mb_Paladin_CastAura() then
        return
    end

    if not UnitBuff("player", "Seal of Wisdom") then
        if mb_CastSpellWithoutTarget("Seal of Wisdom") then
            return
        end
    end

    if mb_UnitPowerPercentage("player") < 70 and mb_Paladin_Holy_useCooldownsCommandTime + 20 < mb_time then
        if mb_CastSpellWithoutTarget("Divine Plea") then
            return
        end
    end

    local tanks = mb_GetTanks("Flash of Light")
    if mb_Paladin_Holy_beaconUnit == nil and tanks[1] ~= nil then
        if mb_CastSpellOnUnit("Beacon of Light", tanks[1]) then
            mb_Paladin_Holy_beaconUnit = tanks[1]
            return
        end
    end
    for _, tank in pairs(tanks) do
        if mb_GetClass(tank) ~= "PALADIN" then
            if UnitBuff(tank, "Sacred Shield") then
                break
            elseif mb_CastSpellOnUnit("Sacred Shield", tank) then
                return
            end
        end
    end

    if mb_Paladin_Holy_useCooldownsCommandTime + 20 > mb_time then
        mb_UseItemCooldowns()
        mb_CastSpellWithoutTarget("Avenging Wrath")
        mb_CastSpellWithoutTarget("Divine Illumination")
        mb_CastSpellWithoutTarget("Divine Favor")
    end

    if mb_RaidHeal("Holy Shock") then
        return
    end

    if UnitBuff("player", "Infusion of Light") then
        if mb_IsMoving() and mb_RaidHeal("Flash of Light") then
            return
        end
    end

    local hasValidEnemyTarget = false
    if mb_AcquireOffensiveTarget() then
        hasValidEnemyTarget = true
        if not mb_isAutoAttacking then
            InteractUnit("target")
        end

        if mb_GetBuffTimeRemaining("player", "Judgements of the Pure") < 5 and mb_CastSpellOnTarget("Judgement of Light") then
            return
        end
    end

    if mb_RaidHeal("Holy Light", 1.2) then
        return
    end

    if mb_RaidHeal("Flash of Light") then
        return
    end

    if mb_CleanseRaid("Cleanse", "Magic", "Poison", "Disease") then
        return
    end

    if mb_Paladin_Holy_beaconUnit ~= nil and mb_GetBuffTimeRemaining(mb_Paladin_Holy_beaconUnit, "Beacon of Light") < 10 then
        if tanks[1] ~= nil and mb_CastSpellOnUnit("Beacon of Light", tanks[1]) then
            mb_Paladin_Holy_beaconUnit = tanks[1]
            return
        end
    end

    if hasValidEnemyTarget and mb_UnitPowerPercentage("player") > 90 then
        if mb_UnitHealthPercentage("target") < 20 then
            if mb_CastSpellOnTarget("Hammer of Wrath") then
                return
            end
        end
        if mb_CastSpellOnTarget("Judgement of Light") then
            return
        end
        if mb_CastSpellOnTarget("Exorcism") then
            return
        end
        if UnitCreatureType("target") == "Undead" and mb_IsSpellInRange("Judgement of Justice", "target") then
            if mb_CastSpellWithoutTarget("Holy Wrath") then
                return
            end
        end
    end

    if UnitAffectingCombat("player") then
        for _, tank in pairs(tanks) do
            if tank ~= mb_Paladin_Holy_beaconUnit and mb_CastSpellOnUnit("Holy Light", tank) then
                return
            end
        end
        if mb_CastSpellOnSelf("Holy Light") then
            return
        end
    end
end

function mb_Paladin_Holy_PreCastFinishCallback(spell, unit)
    if spell ~= "Holy Light" and spell ~= "Flash of Light" then
        return
    end
    if unit == nil then
        return
    end
    if spell == "Holy Light" and mb_GetBuffTimeRemaining("player", "Light's Grace") <= mb_GetCastTime("Holy Light") + 0.25 then
        return
    end
    local spellTargetUnitMissingHealth = mb_GetMissingHealth(unit)
    local beaconUnitMissingHealth = 0
    if mb_Paladin_Holy_beaconUnit ~= nil then
        beaconUnitMissingHealth = mb_GetMissingHealth(mb_Paladin_Holy_beaconUnit)
    end
    local healAmount = mb_GetSpellEffect(spell)
    local effectiveHealAmount = 0
    if healAmount > spellTargetUnitMissingHealth then
        effectiveHealAmount = effectiveHealAmount + spellTargetUnitMissingHealth
    else
        effectiveHealAmount = effectiveHealAmount + healAmount
    end
    if healAmount > beaconUnitMissingHealth then
        effectiveHealAmount = effectiveHealAmount + beaconUnitMissingHealth
    else
        effectiveHealAmount = effectiveHealAmount + healAmount
    end
    if effectiveHealAmount < healAmount * 0.9 then
        mb_StopCast()
    end
end

function mb_Paladin_Holy_HealCdAcceptor(message, from)
    if mb_GetBuffTimeRemaining("player", "Divine Plea") > 1 then
        return false
    end
    if not mb_CanCastSpell("Avenging Wrath") then
        return false
    end
    if mb_UnitPowerPercentage("player") < 20 then
        return false
    end
    return true
end

function mb_Paladin_Holy_HealCdExecutor(message, from)
    mb_SayRaid("I'm popping my cooldowns!")
    mb_Paladin_Holy_useCooldownsCommandTime = mb_time
    return true
end

function mb_Paladin_Holy_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Seal of Wisdom") < 540 then
        CancelUnitBuff("player", "Seal of Wisdom")
        ready = false
    end
    return ready
end
