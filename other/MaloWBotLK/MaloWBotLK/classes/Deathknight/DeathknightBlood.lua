function mb_Deathknight_Blood_OnLoad()
    mb_RegisterClassSpecificReadyCheckFunction(mb_Deathknight_ReadyCheck)
    mb_EnableIWTDistanceClosing("Blood Strike")
    mb_RegisterExclusiveRequestHandler("taunt", mb_Deathknight_Blood_TauntAcceptor, mb_Deathknight_Blood_TauntExecutor)

    local nStance = GetShapeshiftForm()
    if nStance ~= 2 then
        mb_CastSpellWithoutTarget("Frost Presence")
    end
    mb_LastPestilenceTime = 0
    local _, _, _, _, Hysteria = GetTalentInfo(1, 19)
    if Hysteria > 0 then
        mb_Deathknight_HasHysteria = true
    end
end

function mb_Deathknight_Blood_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_GetBuffTimeRemaining("player", "Horn of Winter") == 0 then
        if mb_CastSpellWithoutTarget("Horn of Winter") then
            return
        end
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if UnitExists("playerpet") and mb_petAttack then
        PetAttack()
    end

    if mb_GetMyDebuffTimeRemaining("target", "Frost Fever") == 0 and mb_IsSpellInRange("Icy Touch") then -- Icy touch if frost fever not on target. Any Rune.
        if mb_FrostRuneCD() >= 1 or mb_DeathRuneCD() >= 1 then
            if mb_CastSpellOnTarget("Icy Touch") then
                mb_LastPestilenceTime = 0
                return
            end
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Blood Plague") == 0 then -- Apply Blood plague. Any Rune.
        if mb_UnholyRuneCD() >= 1 or mb_DeathRuneCD() >= 1 then
            if mb_CastSpellOnTarget("Plague Strike") then
                mb_LastPestilenceTime = 0
                return
            end
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Frost Fever") > 0 and mb_GetMyDebuffTimeRemaining("target", "Blood Plague") > 0 then -- do one Pestilence when combat starts if cleaveMode isn't single
        if mb_LastPestilenceTime + 20 < mb_time and mb_cleaveMode > 0 and mb_CastSpellOnTarget("Pestilence") then
            mb_LastPestilenceTime = mb_time
            return
        end
    end

    if mb_GetMyDebuffTimeRemaining("target", "Frost Fever") < 3 or mb_GetMyDebuffTimeRemaining("target", "Blood Plague") < 3 then -- do a pestilence if dot timers are < 3 seconds
        if mb_GetMyDebuffTimeRemaining("target", "Frost Fever") > 0 and mb_GetMyDebuffTimeRemaining("target", "Blood Plague") > 0 then
            if mb_CastSpellOnTarget("Pestilence") then
                mb_LastPestilenceTime = mb_time
                return
            end
        end
    end

    if mb_ShouldUseDpsCooldowns("Raise Dead") then
        mb_UseItemCooldowns()
        if mb_CastSpellWithoutTarget("Raise Dead") then
            return
        end
        if mb_CastSpellWithoutTarget("Dancing Rune Weapon") then
            return
        end
        if mb_HasHysteria and mb_GetBuffTimeRemaining(mb_Config.HysteriaTarget) == 0 then
            if mb_CastSpellOnFriendly(mb_Config.HysteriaTarget, "Hysteria") then
                return
            end
        end
    end

    if mb_cleaveMode > 0 then -- Use Blood runes for Cleave and AoE mode
        if mb_BloodRuneCD() >= 1 and mb_CastSpellOnTarget("Blood Boil") and mb_IsSpellInRange("Plague Strike") then
            return
        end
    end

    if mb_cleaveMode > 1 then -- Use Death runes for AoE mode only
        if mb_DeathRuneCD() >= 1 and mb_CastSpellOnTarget("Blood Boil") and mb_IsSpellInRange("Plague Strike") then
            return
        end
    end

    if mb_UnitHealthPercentage("player") < 95 and mb_CastSpellOnTarget("Death Strike") then
        return
    end

    if mb_FrostRuneCD() >= 1 and mb_Deathknight_NextFrostRune() <= mb_GetMyDebuffTimeRemaining("target", "Frost Fever") then
        if mb_CastSpellOnTarget("Icy Touch") then
            return
        end
    end

    if mb_FrostRuneCD() == 2 and mb_CastSpellOnTarget("Icy Touch") then
        return
    end

    if mb_BloodRuneCD() >= 1 and mb_Deathknight_NextBloodRune() <= mb_GetMyDebuffTimeRemaining("target", "Frost Fever") then
        if mb_Deathknight_NextBloodRune() <= mb_GetMyDebuffTimeRemaining("target", "Blood Plague") and mb_CastSpellOnTarget("Heart Strike") then
            return
        end
    end

    if mb_BloodRuneCD() == 2 and mb_CastSpellOnTarget("Heart Strike") then
        return
    end

    if mb_UnitPowerPercentage("player") < 80 and mb_CastSpellWithoutTarget("Horn of Winter") then	 -- keep buff up, use on CD
        return
    end

    if mb_CastSpellOnTarget("Rune Strike") then
        return
    end
end

function mb_Deathknight_Blood_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Horn of Winter") < 60 then
        CancelUnitBuff("player", "Horn of Winter")
        ready = false
    end
    return ready
end

function mb_Deathknight_Blood_TauntAcceptor(message, from)
    if UnitExists("target") and UnitIsUnit("target", mb_GetUnitForPlayerName(from) .. "target") then
        if mb_CanCastSpell("Dark Command", "target") then
            return true
        end
        return false
    end
end

function mb_Deathknight_Blood_TauntExecutor(message, from)
    if UnitExists("target") and UnitIsUnit("target", mb_GetUnitForPlayerName(from) .. "target") then
        if mb_CastSpellOnTarget("Dark Command") then
            mb_SayRaid("Im Taunting!")
            return true
        end
    end
    return false
end