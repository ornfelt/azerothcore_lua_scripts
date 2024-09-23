function mb_Hunter_Survival_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Hunter_ReadyCheck)
    mb_EnableIWTDistanceClosing("Explosive Shot")
end

function mb_Hunter_Survival_OnUpdate()
    mb_Hunter_HandleReposition()

    if not mb_IsReadyForNewCast() then
        return
    end

    mb_Hunter_HandlePet()

    if UnitExists("playerpet") then
        PetPassiveMode()
    end

    mb_Hunter_HandleAspect()

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if UnitExists("playerpet") and mb_petAttack then
        PetAttack()
    end

    if mb_CastSpellOnTarget("Kill Shot") then
        return
    end

    if mb_Hunter_Survival_HandleLockAndLoad() then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Serpent Sting") == 0 then
        if mb_CastSpellOnTarget("Serpent Sting") then
            return
        end
    end

    if mb_GetMyDebuffTimeRemaining("target","Black Arrow") == 0 then
        if mb_CastSpellOnTarget("Black Arrow") then
            return
        end
    end

    if not UnitBuff("player", "Lock and Load") and mb_CastSpellOnTarget("Explosive Shot") then
        return
    end

    if mb_CastSpellOnTarget("Aimed Shot") then
        return
    end

    if mb_CastSpellOnTarget("Steady Shot") then
        return
    end

    if mb_Hunter_HandleMelee() then
        return
    end
end

function mb_Hunter_Survival_HandleLockAndLoad()
    if not UnitBuff("player", "Lock and Load") then
        return false
    end

    if mb_GetMyDebuffTimeRemaining("target", "Explosive Shot") == 0 then
        if mb_CastSpellOnTarget("Explosive Shot") then
            return true
        end
    elseif mb_CastSpellOnTarget("Black Arrow") then
        return true
    elseif mb_GetMyDebuffTimeRemaining("target", "Serpent Sting") < 1.5 then
        if mb_CastSpellOnTarget("Serpent Sting") then
            return true
        end
    elseif mb_CastSpellOnTarget("Aimed Shot") then
        return true
    end

    return false
end