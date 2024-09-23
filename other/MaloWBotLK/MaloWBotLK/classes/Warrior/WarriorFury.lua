function mb_Warrior_Fury_OnLoad()
    mb_EnableIWTDistanceClosing("Bloodthirst")
    mb_RegisterClassSpecificReadyCheckFunction(mb_Warrior_Fury_ReadyCheck)

    if mb_config.enableConsumablesWatch then
        mb_CheckReagentAmount("Flask of Endless Rage", 3)
        mb_CheckReagentAmount("Potion of Speed", 15)
    end
end

function mb_Warrior_Fury_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if GetShapeshiftForm() ~= 3 then
        mb_CastSpellWithoutTarget("Berserker Stance")
    end

    if mb_Warrior_CommandingShout() then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    mb_HandleAutomaticSalvationRequesting()

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if mb_commanderUnit == nil and mb_followMode ~= "strict" and mb_IsUnitWithinRange("target", 2) then
        if mb_CastSpellOnTarget("Intercept") then
            return
        end
    end

    if not UnitAffectingCombat("player") then
        return
    end

    mb_CastSpellWithoutTarget("Bloodrage")

    if UnitPower("player") >= 37 then
        if mb_cleaveMode > 0 then
            mb_CastSpellOnTarget("Cleave")
        else
            mb_CastSpellOnTarget("Heroic Strike")
        end
    end

    if mb_GetDebuffStackCount("target", "Sunder Armor") < 5 or mb_GetDebuffTimeRemaining("target", "Sunder Armor") < 5 then
        mb_CastSpellOnTarget("Sunder Armor")
        return
    end

    if mb_ShouldUseDpsCooldowns("Bloodthirst") then
        mb_UseItemCooldowns()
        if UnitPower("player") >= 25 then
            if mb_IsSpellInRange("Bloodthirst", "target") then
                if mb_CastSpellWithoutTarget("Recklessness") then
                    return
                elseif mb_CastSpellWithoutTarget("Death Wish") then
                    return
                end
            end
        end
    end

    if mb_CastSpellOnTarget("Bloodthirst") then
        return
    end

    if mb_CastSpellWithoutTarget("Whirlwind") then
        return
    end

    if UnitBuff("player", "Slam!") then
        if mb_CastSpellOnTarget("Slam") then
            return
        end
    end

    if mb_GetDebuffTimeRemaining("target", "Rend") == 0 and mb_UnitHealthPercentage("target") > 75 then
        if mb_UnitPowerPercentage("player") >= 10 and mb_UnitPowerPercentage("player") < 15 then
            mb_CastSpellWithoutTarget("Battle Stance")
            if mb_CastSpellOnTarget("Rend") then
                return
            end
        end
    end

    if mb_GetRemainingSpellCooldown("Whirlwind") > 1.5 and mb_GetRemainingSpellCooldown("Bloodthirst") > 1.5 then
        if mb_CastSpellOnTarget("Heroic Throw") then
            return
        end
    end
end

