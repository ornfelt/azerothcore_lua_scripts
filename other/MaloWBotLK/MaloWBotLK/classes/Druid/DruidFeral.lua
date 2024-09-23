function mb_Druid_Feral_OnLoad()
    mb_RegisterDesiredBuff(BUFF_THORNS)
    mb_RegisterClassSpecificReadyCheckFunction(mb_Druid_ReadyCheck)
    mb_RegisterExclusiveRequestHandler("taunt", mb_Druid_Feral_TauntAcceptor, mb_Druid_Feral_TauntExecutor)
end

function mb_Druid_Feral_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    local nStance = GetShapeshiftForm();

    if nStance == 1 then
        mb_IWTDistanceClosingRangeCheckSpell = nil
        mb_Druid_Bear_OnUpdate()
        return
    end

    if nStance == 3 then
        mb_EnableIWTDistanceClosing("Claw")
        mb_Druid_Cat_OnUpdate()
        return
    end
end

function mb_Druid_Cat_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    mb_AcquireOffensiveTarget()

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if (mb_commanderUnit == nil or CheckInteractDistance(mb_commanderUnit, 1)) and CheckInteractDistance("target", 4) then
        if mb_CastSpellOnTarget("Feral Charge - Cat") then
            return
        end
    end

    if UnitAffectingCombat("player") and UnitPower("player") <= 65 then
        if mb_CanCastSpell("Tiger's Fury") then
            CastSpellByName("Tiger's Fury")
            return
        end
    end

    if mb_ShouldUseDpsCooldowns("Claw") then
        if mb_CastSpellWithoutTarget("Berserk") then
            return
        end
    end

    if mb_Druid_Feral_HandleFinisher() then
        return
    end

    if mb_GetDebuffTimeRemaining("target", "Trauma") == 0 and mb_GetDebuffTimeRemaining("target", "Mangle (Cat)") == 0 then
        if mb_GetDebuffTimeRemaining("target", "Mangle (Bear)") == 0 then
            if mb_CastSpellOnTarget("Mangle (Cat)()") then
                return
            end
        end
    end

    if mb_Druid_Feral_GenerateCombo() then
        return
    end
end

function mb_Druid_Bear_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_UnitHealthPercentage("player") < 30 then
        if mb_CastSpellWithoutTarget("Survival Instincts") then
            return
        end
    end

    if mb_UnitHealthPercentage("player") < 60 then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Barkskin") then
            return
        end
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if UnitPower("player") > 60 then
        mb_CastSpellWithoutTarget("Maul")
    end

    if mb_CastSpellOnTarget("Mangle (Bear)()") then
        return
    end

    if mb_GetDebuffTimeRemaining("target", "Demoralizing Shout") < 3 and mb_GetDebuffTimeRemaining("target", "Demoralizing Roar") < 3 then
        if mb_CastSpellWithoutTarget("Demoralizing Roar") then
            return
        end
    end

    if mb_CastSpellOnTarget("Lacerate") then
        return
    end

    if mb_CastSpellOnTarget("Swipe (Bear)()") then
        CastSpellByName("Swipe (Bear)()")
        return
    end
end

function mb_Druid_Feral_HandleFinisher()
    if not mb_IsReadyForNewCast() then
        return
    end

    if GetComboPoints("player", "target") == 0 then
        return false
    end

    if mb_GetBuffTimeRemaining("player", "Savage Roar") < 2.0 then
        if mb_GetBuffTimeRemaining("player", "Savage Roar") == 0 then
            if mb_CastSpellWithoutTarget("Savage Roar") then
                return true
            end
        end

        return true
    end

    if mb_GetMyDebuffTimeRemaining("target", "Rip") < 1.5 then
        if mb_GetMyDebuffTimeRemaining("target", "Rip") == 0 and GetComboPoints("player", "target") >= 4 then
            if mb_CastSpellOnTarget("Rip") then
                return true
            end
        end

        return false
    end

    if mb_GetMyDebuffTimeRemaining("target", "Rip") > 10 and mb_GetBuffTimeRemaining("player", "Savage Roar") > 10 and mb_UnitPowerPercentage("player") > 90 then
        if mb_CastSpellOnTarget("Ferocious Bite") then
            return true
        end
    end

    return false
end

function mb_Druid_Feral_GenerateCombo()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_UnitPowerPercentage("player") < 90 and GetComboPoints("player", "target") == 5 and mb_GetBuffTimeRemaining("player", "Berserk") == 0 then
        return true
    end

    if mb_GetMyDebuffTimeRemaining("target", "Rake") < 2.0 then
        if mb_GetMyDebuffTimeRemaining("target", "Rake") == 0 then
            if mb_CastSpellOnTarget("Rake") then
                return true
            end
        end

        return true
    end

    if mb_GetBuffTimeRemaining("player", "Clearcasting") > 0 and mb_CastSpellOnTarget("Shred") then
        return
    end

    if mb_UnitPowerPercentage("player") > 42 and mb_CastSpellOnTarget("Shred") then
        return true
    end
    if mb_UnitPowerPercentage("player") > 95 and mb_CastSpellOnTarget("Mangle (Cat)()") then
        return true
    end

    return false
end

function mb_Druid_Feral_TauntAcceptor(message, from)
    if UnitExists("target") and UnitIsUnit("target", mb_GetUnitForPlayerName(from) .. "target") then
        if mb_CanCastSpell("Growl", "target") then
            return true
        end
        return false
    end
end

function mb_Druid_Feral_TauntExecutor(message, from)
    if UnitExists("target") and UnitIsUnit("target", mb_GetUnitForPlayerName(from) .. "target") then
        if mb_CastSpellOnTarget("Growl") then
            mb_SayRaid("Im Taunting!")
            return true
        end
    end
    return false
end