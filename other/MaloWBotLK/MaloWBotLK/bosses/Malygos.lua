function mb_BossModule_Malygos_PreOnUpdate()
    if not UnitInVehicle("player") then
        return false
    end
    TargetUnit("Malygos")
    mb_IWTDistanceClosingRangeCheckSpell = nil
    if mb_IsHealer() or mb_IsTank() then
        if GetComboPoints("playerpet", "playerpet") == 5 then
            CastSpellByName("Life Burst", "playerpet")
            return true
        end
        CastSpellByName("Revivify", "playerpet")
        return true
    end

    if GetComboPoints("playerpet", "target") == 0 and mb_GetBuffTimeRemaining("playerpet", "Revivify") < 3 then
        CastSpellByName("Revivify", "playerpet")
        return true
    end
    if GetComboPoints("playerpet", "target") > 1 then
        CastSpellByName("Engulf in Flames")
        return true
    end
    CastSpellByName("Flame Spike")
    return true
end

function mb_BossModule_Malygos_OnLoad()
    mb_BossModule_PreOnUpdate = mb_BossModule_Malygos_PreOnUpdate
end

mb_BossModule_RegisterModule("malygos", mb_BossModule_Malygos_OnLoad, "Malygos")

