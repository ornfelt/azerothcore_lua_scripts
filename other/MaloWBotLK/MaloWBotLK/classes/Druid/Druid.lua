function mb_Druid_OnLoad()
    if mb_GetMySpecName() == "Balance" then
        mb_classSpecificRunFunction = mb_Druid_Balance_OnUpdate
        mb_Druid_Balance_OnLoad()
    elseif mb_GetMySpecName() == "Feral Combat" then
        mb_classSpecificRunFunction = mb_Druid_Feral_OnUpdate
        mb_Druid_Feral_OnLoad()
    else
        mb_classSpecificRunFunction = mb_Druid_Restoration_OnUpdate
        mb_Druid_Restoration_OnLoad()
    end

    if mb_myClassOrderIndex == 1 then
        mb_RegisterMessageHandler(BUFF_MOTW.requestType, mb_Druid_MotwHandler)
        mb_RegisterMessageHandler(BUFF_THORNS.requestType, mb_Druid_ThornsHandler)
    end

    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_MIGHT)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)

    mb_CheckReagentAmount("Wild Spineleaf", 100)
end

function mb_Druid_HandleMotw(targetPlayerName, greaterSpell, singleSpell)
    if not mb_ShouldBuff() then
        return
    end

    if mb_CastSpellWithoutTarget(greaterSpell) then
        return
    end

    mb_CastSpellOnUnit(singleSpell, mb_GetUnitForPlayerName(targetPlayerName))
end

function mb_Druid_HandleThorns(targetPlayerName, singleSpell)
    if not mb_ShouldBuff() then
        return
    end

    if mb_CastSpellOnUnit(singleSpell, mb_GetUnitForPlayerName(targetPlayerName)) then
        return
    end
end

function mb_Druid_MotwHandler(msg, from)
    mb_Druid_HandleMotw(from, "Gift of the Wild", "Mark of the Wild")
end

function mb_Druid_ThornsHandler(msg, from)
    mb_Druid_HandleThorns(from, "Thorns")
end

function mb_Druid_CombatRessRequestAcceptor(message, from)
    local tanks = mb_GetTanks("Rebirth")
    for _,tank in pairs(tanks) do
        if tank == UnitName("player") then
            return false
        end
    end

    if mb_CanCastSpell("Rebirth") then
        return true
    end

    return false
end

function mb_Druid_CombatRessRequestExecutor(message, from)
    if not mb_IsReadyForNewCast() then
        return false
    end

    local target = mb_GetUnitForPlayerName(message)

    if mb_CastSpellOnUnit(ByName("Rebirth", target)) then
        mb_SayRaid("Combat Ressing " .. message)
        return true
    end
end

function mb_Druid_Innervate(unit)
    if mb_UnitPowerPercentage(unit) < 50 then
        if mb_CastSpellOnFriendly(unit, "Innervate") then
            return true
        end
    end

    return false
end

function mb_Druid_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Omen of Clarity") < 540 then
        CancelUnitBuff("player", "Omen of Clarity")
        ready = false
    end
    return ready
end
