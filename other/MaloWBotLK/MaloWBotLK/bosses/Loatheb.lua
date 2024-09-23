function mb_BossModule_Loatheb_GetMissingHealth_Override(unit)
    if mb_GetDebuffTimeRemaining(unit, "Necrotic Aura") > 0 then
        return 0
    end
    return UnitHealthMax(unit) - UnitHealth(unit)
end

function mb_BossModule_Loatheb_PreOnUpdate()
    if mb_GetDebuffTimeRemaining("player", "Necrotic Aura") < 3 then
        mb_Shaman_Enhancement_saveProcsForHeals = true
        mb_Paladin_Retribution_saveProcsForHeals = true
    else
        mb_Shaman_Enhancement_saveProcsForHeals = false
        mb_Paladin_Retribution_saveProcsForHeals = false
    end
    return false
end

mb_BossModule_Loatheb_originalGetMissingHealthFunction = nil
function mb_BossModule_Loatheb_Unload()
    mb_GetMissingHealth = mb_BossModule_Loatheb_originalGetMissingHealthFunction
end

function mb_BossModule_Loatheb_OnLoad()
    mb_BossModule_Loatheb_originalGetMissingHealthFunction = mb_GetMissingHealth
    mb_GetMissingHealth = mb_BossModule_Loatheb_GetMissingHealth_Override
    mb_BossModule_PreOnUpdate = mb_BossModule_Loatheb_PreOnUpdate
    mb_BossModule_unloadFunction = mb_BossModule_Loatheb_Unload
end

mb_BossModule_RegisterModule("loatheb", mb_BossModule_Loatheb_OnLoad, "Loatheb")