function mb_Paladin_OnLoad()
    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_WISDOM)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SPIRIT)
    mb_RegisterDesiredBuff(BUFF_INTELLECT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)
    mb_RegisterDesiredBuff(BUFF_MOTW)

    mb_CheckReagentAmount("Symbol of Kings", 300)

    if mb_GetMySpecName() == "Holy" then
        mb_classSpecificRunFunction = mb_Paladin_Holy_OnUpdate
        mb_Paladin_Holy_OnLoad()
    elseif mb_GetMySpecName() == "Protection" then
        mb_classSpecificRunFunction = mb_Paladin_Protection_OnUpdate
        mb_Paladin_Protection_OnLoad()
    else
        mb_classSpecificRunFunction = mb_Paladin_Retribution_OnUpdate
        mb_Paladin_Retribution_OnLoad()
    end

    if GetTrackingTexture() ~= "Interface\\Icons\\Spell_Holy_SenseUndead" then
        mb_CastSpellWithoutTarget("Sense Undead")
    end

    if mb_myClassOrderIndex == mb_config.classOrder.mightBlesser then
        mb_RegisterMessageHandler(BUFF_MIGHT.requestType, mb_Paladin_MightHandler)
    elseif mb_myClassOrderIndex == mb_config.classOrder.wisdomBlesser then
        mb_RegisterMessageHandler(BUFF_WISDOM.requestType, mb_Paladin_WisdomHandler)
    elseif mb_myClassOrderIndex == mb_config.classOrder.kingsBlesser then
        mb_RegisterMessageHandler(BUFF_KINGS.requestType, mb_Paladin_KingsHandler)
    elseif mb_myClassOrderIndex == mb_config.classOrder.sancBlesser then
        mb_RegisterMessageHandler(BUFF_SANCTUARY.requestType, mb_Paladin_SanctuaryHandler)
    end

    if not mb_isCommanding then
        mb_RegisterExclusiveRequestHandler("external", mb_Paladin_ExternalRequestAcceptor, mb_Paladin_ExternalRequestExecutor)
        mb_RegisterExclusiveRequestHandler("salvation", mb_Paladin_SalvationRequestAcceptor, mb_Paladin_SalvationRequestExecutor)
        local _, _, _, _, improvedDivineSacrifice = GetTalentInfo(2, 9)
        if improvedDivineSacrifice == 2 then
            mb_RegisterExclusiveRequestHandler("impdivinesac", mb_Paladin_ImpDivineSacRequestAcceptor, mb_Paladin_ImpDivineSacRequestExecutor)
        end
    end
end

function mb_Paladin_MightHandler(msg, from)
    mb_Paladin_HandleBless(from, "Greater Blessing of Might", "Blessing of Might")
end

function mb_Paladin_WisdomHandler(msg, from)
    mb_Paladin_HandleBless(from, "Greater Blessing of Wisdom", "Blessing of Wisdom")
end

function mb_Paladin_KingsHandler(msg, from)
    mb_Paladin_HandleBless(from, "Greater Blessing of Kings", "Blessing of Kings")
end

function mb_Paladin_SanctuaryHandler(msg, from)
    mb_Paladin_HandleBless(from, "Greater Blessing of Sanctuary", "Blessing of Sanctuary")
end

function mb_Paladin_HandleBless(targetPlayerName, greaterSpell, singleSpell)
    if not mb_ShouldBuff() then
        return
    end
    if mb_CastSpellOnUnit(greaterSpell, mb_GetUnitForPlayerName(targetPlayerName)) then
        return
    end
    mb_CastSpellOnUnit(singleSpell, mb_GetUnitForPlayerName(targetPlayerName))
end

function mb_Paladin_CastAura()
    local myAura = ""
    if mb_GetMySpecName() == "Protection" then
        -- Override class-order auras for prot-palas since they have improved
        myAura = "Devotion Aura"
    elseif mb_myClassOrderIndex == mb_config.classOrder.retriAura then
        myAura = "Retribution Aura"
    elseif mb_myClassOrderIndex == mb_config.classOrder.concentrationAura then
        myAura = "Concentration Aura"
    elseif mb_myClassOrderIndex == mb_config.classOrder.frostAura then
        myAura = "Frost Resistance Aura"
    elseif mb_myClassOrderIndex == mb_config.classOrder.devoAura then
        myAura = "Devotion Aura"
    elseif mb_myClassOrderIndex == mb_config.classOrder.fireAura then
        myAura = "Fire Resistance Aura"
    elseif mb_myClassOrderIndex == mb_config.classOrder.crusaderAura then
        myAura = "Crusader Aura"
    elseif mb_myClassOrderIndex == mb_config.classOrder.shadowAura then
        myAura = "Shadow Resistance Aura"
    end
    if UnitBuff("player", myAura) then
        return false
    end
    return mb_CastSpellWithoutTarget(myAura)
end

function mb_Paladin_ExternalRequestAcceptor(message, from)
    if mb_CanCastSpell("Hand of Sacrifice", from, true) then
        return true
    end
    if mb_CanCastSpell("Divine Sacrifice", nil, true) and UnitInParty(mb_GetUnitForPlayerName(from)) then
        if mb_IsUnitWithinRange(from, 3) then
            return true
        end
    end
    return false
end

function mb_Paladin_ExternalRequestExecutor(message, from)
    if not mb_IsReadyForNewCast() then
        return false
    end

    local targetUnit = mb_GetUnitForPlayerName(from)
    if mb_CastSpellOnUnit("Hand of Sacrifice", targetUnit) then
        mb_SayRaid("Casting Hand of Sacrifice on " .. from)
        return true
    end
    if UnitInParty(targetUnit) and mb_CastSpellWithoutTarget("Divine Sacrifice") then
        mb_SayRaid("Casting Divine Sacrifice on " .. from)
        return true
    end
    return false
end

function mb_Paladin_SalvationRequestAcceptor(message, from)
    return mb_CanCastSpell("Hand of Salvation", from, true)
end

function mb_Paladin_SalvationRequestExecutor(message, from)
    if not mb_IsReadyForNewCast() then
        return false
    end

    local targetUnit = mb_GetUnitForPlayerName(from)
    if mb_CastSpellOnUnit("Hand of Salvation", targetUnit) then
        mb_SayRaid("Casting Hand of Salvation on " .. from)
        return true
    end

    return false
end

function mb_Paladin_ImpDivineSacRequestAcceptor(message, from)
    return mb_CanCastSpell("Divine Sacrifice", nil, true) and mb_IsUnitWithinRange(from, 3)
end

function mb_Paladin_ImpDivineSacRequestExecutor(message, from)
    if not mb_IsReadyForNewCast() then
        return false
    end
    if mb_CastSpellWithoutTarget("Divine Sacrifice") then
        mb_SayRaid("Casting Divine Sacrifice for the raid")
        return true
    end
    return false
end



