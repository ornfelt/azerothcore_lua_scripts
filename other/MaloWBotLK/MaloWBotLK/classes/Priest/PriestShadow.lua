mb_Priest_lastVampiricTouchTime = 0

function mb_Priest_Shadow_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Priest_Shadow_ReadyCheck)
    mb_EnableIWTDistanceClosing("Mind Blast")
end

function mb_Priest_Shadow_OnUpdate()
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
            if mb_CastSpellWithoutTarget("Inner Fire") then
                return
    elseif not UnitBuff("player", "Vampiric Embrace") then
            if mb_CastSpellWithoutTarget("Vampiric Embrace") then
                return
            end
    elseif not UnitBuff("player", "Shadowform") then
            if mb_CastSpellWithoutTarget("Shadowform") then
                return
            end
         end
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if mb_UnitPowerPercentage("player") < 65 and UnitAffectingCombat("player") and mb_CanCastSpell("Shadowfiend") then
        if mb_CastSpellOnTarget("Shadowfiend") then
            return
        end
    end

    if mb_UnitPowerPercentage("player") < 25 and mb_CastSpellWithoutTarget("Dispersion") then
        return
    end

    if mb_cleaveMode == 2 and mb_GetDebuffStackCount("target", "Mind Sear") == 0 and mb_CastSpellOnTarget("Mind Sear") then
        return
    end

    if UnitThreatSituation("player", "target") ~= nil then -- Fade if High Aggro
        if UnitThreatSituation("player", "target") >= 1 and mb_CastSpellWithoutTarget("Fade") then
            return
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Vampiric Touch") < 1.2 and mb_Priest_lastVampiricTouchTime + 1.8 < mb_time and mb_CastSpellOnTarget("Vampiric Touch") then
        mb_Priest_lastVampiricTouchTime = mb_time
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Devouring Plague") == 0 and mb_CastSpellOnTarget("Devouring Plague") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Shadow Word: Pain") == 0 and mb_CastSpellOnTarget("Shadow Word: Pain") then
        return
    end

    if mb_CastSpellOnTarget("Mind Blast") then
        return
    end

    if mb_UnitHealthPercentage("player") > 70 and mb_CastSpellOnTarget("Shadow Word: Death") then
        return
    end

    if mb_CastSpellOnTarget("Mind Flay") then
        return
    end
end

function mb_Priest_Shadow_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Inner Fire") < 540 then
        CancelUnitBuff("player", "Inner Fire")
        ready = false
    end
    if mb_GetBuffTimeRemaining("player", "Vampiric Embrace") < 540 then
        CancelUnitBuff("player", "Vampiric Embrace")
        ready = false
    end
    return ready
end