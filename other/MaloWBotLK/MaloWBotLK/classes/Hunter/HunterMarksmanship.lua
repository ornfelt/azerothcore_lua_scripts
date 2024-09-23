function mb_Hunter_Marksmanship_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Hunter_ReadyCheck)
    mb_EnableIWTDistanceClosing("Arcane Shot")
end

function mb_Hunter_Marksmanship_OnUpdate()
    mb_Hunter_HandleReposition()

    if not mb_IsReadyForNewCast() then
        return
    end

    mb_Hunter_HandlePet()

    if UnitExists("playerpet") then
        PetPassiveMode()
    end

    mb_Hunter_HandleAspect()

    if not UnitBuff("player", "Trueshot Aura") then
        if mb_CastSpellWithoutTarget("Trueshot Aura") then
            return
        end
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if UnitExists("playerpet") and mb_petAttack then
        PetAttack()
    end

    if mb_ShouldUseDpsCooldowns("Arcane Shot") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()
        mb_CastSpellWithoutTarget("Rapid Fire")
    end

    if mb_CastSpellOnTarget("Kill Shot") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Serpent Sting") == 0 then
        if mb_CastSpellOnTarget("Serpent Sting") then
            return
        end
    end

    if mb_CastSpellOnTarget("Chimera Shot") then
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