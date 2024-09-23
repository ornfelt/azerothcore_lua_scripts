-- TODO:
-- Every man for himself on loss of control
-- LayOnHand low friendly
-- Divine Shield + Taunt into click away if low and all those CDs are ready
-- BoP friendly who has aggro

function mb_Paladin_Protection_OnLoad()
    mb_RegisterDesiredBuff(BUFF_MIGHT)
    mb_RegisterDesiredBuff(BUFF_THORNS)
    mb_RegisterClassSpecificReadyCheckFunction(mb_Paladin_Protection_ReadyCheck)
    mb_RegisterExclusiveRequestHandler("taunt", mb_Paladin_Protection_TauntAcceptor, mb_Paladin_Protection_TauntExecutor)
    mb_RegisterMessageHandler("tricksAuction", mb_Paladin_Protection_TricksOfTheTradeAuctionHandler)

    if mb_config.enableConsumablesWatch then
        mb_CheckReagentAmount("Flask of Stoneblood", 3)
        mb_CheckReagentAmount("Indestructible Potion", 15)
        mb_CheckReagentAmount("Blackened Dragonfin", 15)
    end
end

mb_Paladin_Protection_currentTargetAge = 0
mb_Paladin_Protection_wasTankingTarget = false

function mb_Paladin_Protection_OnUpdate()
    if not mb_IsReadyForNewCast() then
        return
    end

    if mb_Drink() then
        return
    end

    if mb_ResurrectRaid("Redemption") then
        return
    end

    if mb_Paladin_CastAura() then
        return
    end

    if not UnitBuff("player", "Righteous Fury") and mb_CastSpellWithoutTarget("Righteous Fury") then
        return
    end

    if not UnitBuff("player", "Seal of Vengeance") and mb_CastSpellWithoutTarget("Seal of Vengeance") then
        return
    end

    if not UnitBuff("player", "Sacred Shield") and mb_CastSpellOnSelf("Sacred Shield") then
        return
    end

    if not mb_AcquireOffensiveTarget() then
        return
    end

    if not mb_isAutoAttacking then
        InteractUnit("target")
    end

    local isTanking = mb_IsTanking("player")
    if isTanking then
        mb_Paladin_Protection_wasTankingTarget = true
        mb_Paladin_Protection_currentTargetAge = mb_lastTargetChange
    elseif mb_Paladin_Protection_currentTargetAge == mb_lastTargetChange and mb_Paladin_Protection_wasTankingTarget and not mb_IsTank("targettarget") then
        -- We haven't changed target, and we were tanking the target last frame, and its current target isn't a tank, taunt
        if mb_CastSpellOnTarget("Hand of Reckoning") then
            return
        end
        if mb_CastSpellOnTarget("Righteous Defense") then
            return
        end
    end

    if mb_IsSpellInRange("Judgement of Light", "target") then
        if isTanking and not UnitBuff("player", "Holy Shield") and mb_CastSpellWithoutTarget("Holy Shield") then
            return
        end
        if not UnitBuff("player", "Divine Plea") then
            if mb_CastSpellWithoutTarget("Divine Plea") then
                return
            end
        end
        if mb_UnitPowerPercentage("player") > 20 then
            if mb_CastSpellWithoutTarget("Consecration") then
                return
            end
        end
    else
        if mb_CastSpellOnTarget("Exorcism") then
            return
        end
    end

    if mb_cleaveMode > 0 then
        if UnitCreatureType("target") == "Undead" and mb_IsSpellInRange("Judgement of Light", "target") then
            if mb_CastSpellWithoutTarget("Holy Wrath") then
                return
            end
        end
    end

    if mb_UnitPowerPercentage("player") > 30 then
        if mb_CastSpellOnTarget("Avenger's Shield") then
            return
        end
    end

    if mb_CastSpellOnTarget("Judgement of Light") then
        return
    end

    if mb_CastSpellOnTarget("Hammer of the Righteous") then
        return
    end

    if mb_CastSpellOnTarget("Shield of Righteousness") then
        return
    end

    if mb_UnitPowerPercentage("player") > 25 then
        if mb_CastSpellOnTarget("Hammer of Wrath") then
            return
        end
    end

    if UnitCreatureType("target") == "Undead" and mb_IsSpellInRange("Judgement of Light", "target") then
        if mb_UnitPowerPercentage("player") > 30 then
            if mb_CastSpellWithoutTarget("Holy Wrath") then
                return
            end
        end
    end
end

function mb_Paladin_Protection_ReadyCheck()
    local ready = true
    if mb_GetBuffTimeRemaining("player", "Seal of Vengeance") < 540 then
        CancelUnitBuff("player", "Seal of Vengeance")
        ready = false
    end
    return ready
end

function mb_Paladin_Protection_TauntAcceptor(message, from)
    if UnitExists("target") and UnitIsUnit("target", mb_GetUnitForPlayerName(from) .. "target") then
        if mb_CanCastSpell("Hand of Reckoning", "target") or mb_CanCastSpell("Righteous Defense", "target") then
            return true
        end
        return false
    end
end

function mb_Paladin_Protection_TauntExecutor(message, from)
    if UnitExists("target") and UnitIsUnit("target", mb_GetUnitForPlayerName(from) .. "target") then
        if mb_CastSpellOnTarget("Hand of Reckoning") then
            mb_SayRaid("Im Taunting!")
            return true
        end
        if mb_CastSpellOnTarget("Righteous Defense") then
            mb_SayRaid("Im Taunting!")
            return true
        end
    end
    return false
end

function mb_Paladin_Protection_TricksOfTheTradeAuctionHandler(msg, from)
    local caster = mb_GetUnitForPlayerName(from)
    if caster == nil then
        return
    end
    local isTanking, tankingStatus = mb_IsTanking("player", caster .. "target")
    if not isTanking then
        return
    end
    local priority = TRICKS_OF_THE_TRADE_PRIORITY.TANKING
    if tankingStatus == 2 then
        priority = TRICKS_OF_THE_TRADE_PRIORITY.TANKING_NEED_THREAT
    end
    mb_SendMessage("tricksResponse", priority)
end
