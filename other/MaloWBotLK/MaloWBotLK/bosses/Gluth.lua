mb_BossModule_Gluth_lastExternalRequest = 0
function mb_BossModule_Gluth_PreOnUpdate()
    if mb_IsTank() and UnitName("target") == "Gluth" then
        return mb_BossModule_Gluth_Tank_OnUpdate()
    end
    if mb_GetClass("player") == "WARLOCK" then
        return mb_BossModule_Gluth_Warlock_OnUpdate()
    end
    if mb_GetClass("player") == "DRUID" and mb_GetMySpecName() == "Balance" then
        return mb_BossModule_Gluth_BalanceDruid_OnUpdate()
    end
    if mb_GetClass("player") == "PALADIN" and mb_GetMySpecName() == "Retribution" then
        return mb_BossModule_Gluth_RetributionPaladin_OnUpdate()
    end
    if mb_GetClass("player") == "SHAMAN" and mb_GetMySpecName() == "Enhancement" then
        return mb_BossModule_Gluth_EnhanceShaman_OnUpdate()
    end
    if mb_GetClass("player") == "WARRIOR" and mb_GetMySpecName() == "Arms" then
        return mb_BossModule_Gluth_ArmsWarrior_OnUpdate()
    end
    return false
end

function mb_BossModule_Gluth_Tank_OnUpdate()
    if UnitName("target") ~= "Gluth" then
        return false
    end
    if not UnitIsUnit("player", "targettarget") then
        if not UnitDebuff("player", "Mortal Wound") then
            if mb_GetClass("player") == "PALADIN" then
                if mb_CastSpellOnTarget("Hand of Reckoning") then
                    return true
                end
            elseif mb_GetClass("player") == "DRUID" then
                if mb_CastSpellOnTarget("Growl") then
                    return true
                end
            end
        end
    elseif UnitBuff("target", "Enrage") then
        if mb_BossModule_Gluth_lastExternalRequest + 10 < mb_time then
            mb_BossModule_Gluth_lastExternalRequest = mb_time
            mb_SendExclusiveRequest("external")
        end
        mb_UseItemCooldowns()
        if mb_GetClass("player") == "PALADIN" then
            if mb_CastSpellWithoutTarget("Divine Protection") then
                return true
            end
        elseif mb_GetClass("player") == "DRUID" then
            if mb_CastSpellWithoutTarget("Barkskin") then
                return true
            end
            if mb_CastSpellWithoutTarget("Survival Instincts") then
                return true
            end
        end
    end
    if mb_GetClass("player") == "WARLOCK" then
        TargetUnit("Zombie Chow")
        if UnitName("target") == "Zombie Chow" and mb_UnitHealthPercentage("target") < 20 then
            mb_CastSpellOnTarget("Seed of Corruption")
            return true
        end
        TargetUnit("Gluth")
    end
    if mb_GetClass("player") == "DRUID" and mb_GetMySpecName() == "Balance" then
        TargetUnit("Zombie Chow")
        if UnitName("target") == "Zombie Chow" and mb_UnitHealthPercentage("target") < 20 then
            if mb_GetRemainingSpellCooldown("Starfall") then
                mb_CastSpellWithoutTarget("Starfall")
                return true
            end
        end
        TargetUnit("Gluth")
    end
    return false
end

function mb_BossModule_Gluth_ArmsWarrior_OnUpdate()
    if UnitAffectingCombat("player") then
        mb_commanderUnit = nil
    end
    TargetUnit("Zombie Chow")
    if UnitName("target") == "Zombie Chow" and mb_UnitHealthPercentage("target") < 20 then
        mb_cleaveMode = 2
        if not mb_IsUnitSlowed("target") then
            mb_CastSpellOnTarget("Hamstring")
            return true
        end
        return false
    end
    mb_cleaveMode = 0
    TargetUnit("Gluth")
    return false
end

function mb_BossModule_Gluth_RetributionPaladin_OnUpdate()
    if UnitAffectingCombat("player") then
        mb_commanderUnit = nil
    end
    TargetUnit("Zombie Chow")
    if UnitName("target") == "Zombie Chow" and mb_UnitHealthPercentage("target") < 20 then
        mb_cleaveMode = 2
        if not mb_IsUnitStunned("target") then
            if mb_CastSpellOnTarget("Hammer of Justice") then
                return true
            end
            if mb_IsSpellInRange("Crusader Strike", "target") and mb_CastSpellWithoutTarget("Holy Wrath") then
                return true
            end
        end
        return false
    end
    mb_cleaveMode = 0
    TargetUnit("Gluth")
    return false
end

function mb_BossModule_Gluth_EnhanceShaman_OnUpdate()
    if UnitAffectingCombat("player") then
        mb_commanderUnit = nil
    end
    TargetUnit("Zombie Chow")
    if UnitName("target") == "Zombie Chow" and mb_UnitHealthPercentage("target") < 20 then
        mb_cleaveMode = 2
        if not mb_IsUnitSlowed("target") then
            if mb_IsSpellInRange("Stormstrike", "target") and mb_CastSpellWithoutTarget("Earthbind Totem") then
                return true
            end
            if mb_CastSpellOnTarget("Frost Shock") then
                return true
            end
        end
        return false
    end
    mb_cleaveMode = 0
    TargetUnit("Gluth")
    return false
end

function mb_BossModule_Gluth_Warlock_OnUpdate()
    TargetUnit("Zombie Chow")
    if UnitName("target") == "Zombie Chow" and mb_UnitHealthPercentage("target") < 20 then
        mb_CastSpellOnTarget("Seed of Corruption")
        return true
    end
    TargetUnit("Gluth")
    return false
end

function mb_BossModule_Gluth_BalanceDruid_OnUpdate()
    TargetUnit("Zombie Chow")
    if UnitName("target") == "Zombie Chow" and mb_UnitHealthPercentage("target") < 20 then
        if mb_GetRemainingSpellCooldown("Starfall") < 1.5 then
            mb_CastSpellWithoutTarget("Starfall")
            return true
        end
    end
    TargetUnit("Gluth")
    return false
end

function mb_BossModule_Gluth_OnLoad()
    mb_BossModule_PreOnUpdate = mb_BossModule_Gluth_PreOnUpdate
end

mb_BossModule_RegisterModule("gluth", mb_BossModule_Gluth_OnLoad, "Gluth")