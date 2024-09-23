mb_Rogue_Assassination_hungerFailedCount = 0
mb_Rogue_Assassination_lastFailedCast = 0
mb_Rogue_Assassination_allowRupture = false

function mb_Rogue_Assassination_OnUpdate()


    if mb_IsSpellInRange("Sinister Strike", "target") and mb_IsValidOffensiveUnit("target", true) then
        if mb_Rogue_HandleTricksOfTheTrade() then
            return
        end
    end

    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Rogue_ApplyPoisons() then
        return
    end

    if UnitAffectingCombat("player") and mb_UnitHealthPercentage("player") < 30 then
        if mb_CastSpellWithoutTarget("Evasion") then
            return
        end
        if mb_CastSpellWithoutTarget("Cloak of Shadows") then
            return
        end
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    if not UnitAffectingCombat("player") then
        mb_Rogue_Assassination_allowRupture = false
        return
    end

    mb_HandleAutomaticSalvationRequesting()

    local comboPoints = mb_GetComboPoints()

    if mb_Rogue_Assassination_allowRupture == true and comboPoints > 0 then
        if mb_CastSpellOnTarget("Rupture") then
            mb_Rogue_Assassination_allowRupture = false
            return
        end
    end

    if mb_Rogue_Assassination_HandleHfB() then
        return
    end

    if comboPoints > 0 and mb_Rogue_Assassination_allowRupture then
        if mb_CastSpellOnTarget("Rupture") then
            mb_Rogue_Assassination_allowRupture = false
            return
        end
    end
    -- Ensure we never drop SnD
    if mb_GetBuffTimeRemaining("player", "Slice and Dice") == 0 then
        if comboPoints > 0 then
            if mb_CastSpellWithoutTarget("Slice and Dice") then
                return
            end
        end
    elseif mb_GetBuffTimeRemaining("player", "Slice and Dice") < 3 then
        if comboPoints == 0 then
            if mb_CastSpellOnTarget("Mutilate") then
                return
        elseif mb_CastSpellOnTarget("Envenom") then
                return
            end
        end
    end

    if comboPoints >= 4 and mb_CastSpellOnTarget("Envenom") then
        return
    end

    if mb_CastSpellOnTarget("Mutilate") then
        return
    end
end

function mb_Rogue_Assassination_HandleHfB()
    if mb_GetBuffTimeRemaining("player", "Hunger For Blood") > 0 then
        return false
    end
    if mb_GetBuffTimeRemaining("player", "Hunger For Blood") == 0 and mb_CastSpellWithoutTarget("Hunger For Blood") then
        mb_Rogue_Assassination_hungerFailedCount = 0
        return true
    end

    if mb_Rogue_Assassination_lastFailedCast + 2 > mb_time then
        return
    end

    mb_Rogue_Assassination_hungerFailedCount = mb_Rogue_Assassination_hungerFailedCount + 1
    mb_Rogue_Assassination_lastFailedCast = mb_time

    if mb_Rogue_Assassination_hungerFailedCount >= 3 then
        mb_Rogue_Assassination_allowRupture = true
        return false
    end
end

