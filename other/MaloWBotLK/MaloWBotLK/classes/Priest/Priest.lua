--TODO
-- Nevermelting Ice trinket code

function mb_Priest_OnLoad()
    if mb_GetMySpecName() == "Discipline" then
        mb_classSpecificRunFunction = mb_Priest_Discipline_OnUpdate
        mb_Priest_Discipline_OnLoad()
    elseif mb_GetMySpecName() == "Holy" then
        mb_classSpecificRunFunction = mb_Priest_Holy_OnUpdate
        mb_Priest_Holy_OnLoad()
    else
        mb_classSpecificRunFunction = mb_Priest_Shadow_OnUpdate
        mb_Priest_Shadow_OnLoad()
        mb_SpecNotSupported("Shadow Priests are not yet supported")
    end

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)

    if mb_myClassOrderIndex == 1 then
        mb_RegisterMessageHandler(BUFF_FORT.requestType, mb_Priest_FortHandler)
        mb_RegisterMessageHandler(BUFF_SPIRIT.requestType, mb_Priest_SpiritHandler)
        mb_RegisterMessageHandler(BUFF_SHADOW_PROT.requestType, mb_Priest_ShadowHandler)
    end

    mb_CheckReagentAmount("Devout Candle", 200)
    mb_RegisterExclusiveRequestHandler("healcd", mb_Priest_HealCdAcceptor, mb_Priest_HealCdExecutor)
end

mb_Priest_useCooldownsCommandTime = 0

function mb_Priest_HandlePrayer(targetPlayerName, greaterSpell, singleSpell)
    if not mb_ShouldBuff() then
        return
    end

    if mb_CastSpellWithoutTarget(greaterSpell) then
        return
    end
    mb_CastSpellOnUnit(singleSpell, mb_GetUnitForPlayerName(targetPlayerName))
end

function mb_Priest_FortHandler(msg, from)
    mb_Priest_HandlePrayer(from, "Prayer of Fortitude", "Power Word: Fortitude")
end

function mb_Priest_SpiritHandler(msg, from)
    mb_Priest_HandlePrayer(from, "Prayer of Spirit", "Divine Spirit")
end

function mb_Priest_ShadowHandler(msg, from)
    mb_Priest_HandlePrayer(from, "Prayer of Shadow Protection", "Shadow Protection")
end

function mb_Priest_HealCdAcceptor(message, from)
    if not mb_CanCastSpell("Divine Hymn") then
        return false
    end
    if mb_UnitPowerPercentage("player") < 15 then
        return false
    end
    return true
end

function mb_Priest_HealCdExecutor(message, from)
    mb_SayRaid("Using Divine Hymn!")
    mb_Say("Do not falter my brave Heroes! Let my music heal your hearts!")
    if mb_CastSpellWithoutTarget("Divine Hymn") then
        mb_Priest_Holy_useCooldownsCommandTime = mb_time
        return true
    end

    return false
end

function mb_Priest_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Inner Fire") < 540 then
        CancelUnitBuff("player", "Inner Fire")
        ready = false
    end
    return ready
end