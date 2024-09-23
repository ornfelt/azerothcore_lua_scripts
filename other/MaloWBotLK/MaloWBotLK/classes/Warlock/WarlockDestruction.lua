function mb_Warlock_Destruction_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Warlock_ReadyCheck())
    mb_EnableIWTDistanceClosing("Shadow Bolt")
end

function mb_Warlock_Destruction_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end
    mb_Warlock_HandlePetSummon("Summon Imp")

    mb_Warlock_HandleImpAutoCasts("Fire Shield","Blood Pact", "Firebolt", "Phase Shift")

    if not mb_Warlock_HandleStones("Grand Firestone") then
        return
    end

    if UnitExists("playerpet") then
        PetPassiveMode()
    end

    local _, _, text = UnitChannelInfo("player")
    if text == "Channeling" then
        return
    end

    mb_Warlock_HandleLifeTap()

    if not UnitBuff("player", "Fel Armor") then
        if mb_CastSpellWithoutTarget("Fel Armor") then
            return
        end
    end

    if mb_GetBuffTimeRemaining("player", "Blood Pact") == 0 and mb_CastSpellWithoutTarget("Blood Pact") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if UnitExists("playerpet") and mb_petAttack then
        PetAttack()
    end

    if mb_UnitPowerPercentage("player") < 50 and mb_UnitHealthPercentage("player") > 60 then
        mb_CastSpellWithoutTarget("Life Tap")
        return
    end

    if mb_ShouldUseDpsCooldowns("Shadow Bolt") and UnitAffectingCombat("player") then
        mb_UseItemCooldowns()
        if UnitHealth("target") > 350000 and mb_CastSpellOnTarget("Curse of Doom") then
            return
        end
    end

    if mb_cleaveMode > 1 then
        local range = CheckInteractDistance("target", 2)
        if range then
            if mb_CastSpellWithoutTarget("Shadowflame") then
                return
            end
        end

        if mb_GetMyDebuffTimeRemaining("target", "Seed of Corruption") == 0 and mb_CastSpellOnTarget("Seed of Corruption") then
            return
        end

        if mb_GetMyDebuffTimeRemaining("target", "Seed of Corruption") ~= 0 then
            TargetNearestEnemy()
            if UnitAffectingCombat("target") and mb_CastSpellOnTarget("Seed of Corruption") then
                return
            end
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Corruption") == 0 and mb_CastSpellOnTarget("Corruption") then
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Immolate") < 1.2 and mb_Warlock_lastImmolateTime + 1.5 < mb_time and mb_CastSpellOnTarget("Immolate") then
        mb_Warlock_lastImmolateTime = mb_time
        return
    end

    if mb_GetMyDebuffTimeRemaining("target", "Curse of Agony") == 0 and mb_GetMyDebuffTimeRemaining("target", "Curse of Doom") == 0 and mb_CastSpellOnTarget("Curse of Agony") then
        return
    end

    if mb_CastSpellOnTarget("Conflagrate") then
        return
    end

    if mb_CastSpellOnTarget("Chaos Bolt") then
        return
    end
end