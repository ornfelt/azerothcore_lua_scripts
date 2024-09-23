-- TODO:
--    Change TotT to allow for multiple rogues with it someone, maybe use unique Ids for the requests

function mb_Rogue_OnLoad()
    mb_RegisterDesiredBuff(BUFF_KINGS)
    mb_RegisterDesiredBuff(BUFF_SANCTUARY)
    mb_RegisterDesiredBuff(BUFF_FORT)
    mb_RegisterDesiredBuff(BUFF_SHADOW_PROT)
    mb_RegisterDesiredBuff(BUFF_MOTW)
    mb_RegisterDesiredBuff(BUFF_MIGHT)

    mb_EnableIWTDistanceClosing("Sinister Strike")
    mb_RegisterInterruptSpell("Kick")
    mb_RegisterClassSpecificReadyCheckFunction(mb_Rogue_ReadyCheck)

    mb_CheckReagentAmount("Deadly Poison IX", 20)
    mb_CheckReagentAmount("Instant Poison IX", 20)

    if mb_GetMySpecName() == "Assassination" then
        mb_classSpecificRunFunction = mb_Rogue_Assassination_OnUpdate
        mb_SpecNotSupported("Assassination Rogues are not yet supported")
    elseif mb_GetMySpecName() == "Combat" then
        mb_classSpecificRunFunction = mb_Rogue_Combat_OnUpdate
    else
        mb_classSpecificRunFunction = mb_Rogue_Subtlety_OnUpdate
        mb_SpecNotSupported("Subtlety Rogues are not yet supported")
    end

    mb_RegisterMessageHandler("tricksResponse", mb_Rogue_TricksOfTheTradeResponseHandler)

    if mb_config.enableConsumablesWatch then
        mb_CheckReagentAmount("Flask of Endless Rage", 3)
        mb_CheckReagentAmount("Potion of Speed", 15)
    end
end

mb_Rogue_lastNoPoisonWarning = 0
function mb_Rogue_ApplyPoisons()
    local hasMainHandEnchant, mainHandExpiration, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
    if not hasMainHandEnchant then
        if mb_UseItem("Instant Poison IX") then
            PickupInventoryItem(16)
            return true
        else
            if mb_Rogue_lastNoPoisonWarning + 600 < mb_time then
                mb_SayRaid("I'm out of poisons")
                mb_Rogue_lastNoPoisonWarning = mb_time
            end
        end
    end
    if not hasOffHandEnchant then
        if mb_UseItem("Deadly Poison IX") then
            PickupInventoryItem(17)
            return true
        else
            if mb_Rogue_lastNoPoisonWarning + 600 < mb_time then
                mb_SayRaid("I'm out of poisons")
                mb_Rogue_lastNoPoisonWarning = mb_time
            end
        end
    end
    return false
end

function mb_Rogue_ReadyCheck()
    local ready = true
    local hasMainHandEnchant, mainHandExpiration, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
    if not hasMainHandEnchant or not hasOffHandEnchant then
        ready = false
    end
    if hasMainHandEnchant and mainHandExpiration / 1000 < 540 then
        CancelItemTempEnchantment(1)
        ready = false
    end
    if hasOffHandEnchant and offHandExpiration / 1000 < 540 then
        CancelItemTempEnchantment(2)
        ready = false
    end
    return ready
end

function mb_Rogue_GetPredictedEnergyIn(time)
    local energy = UnitPower("player")
    energy = energy + time * 10
    if mb_GetMySpecName() == "Combat" then
        local adrenalineRushDuration = mb_GetBuffTimeRemaining("player", "Adrenaline Rush")
        if adrenalineRushDuration > 0 then
            if adrenalineRushDuration > time then
                energy = energy + time * 10
            else
                energy = energy + adrenalineRushDuration * 20
            end
        end
        local _, offSpeed = UnitAttackSpeed("player")
        local hits = time / offSpeed + 0.5 -- On average we're half-way to the next hit
        energy = energy + hits * 0.2 * 15 -- 20% chance per hit to give 15 energy
    end
    return energy
end

mb_Rogue_tricksOfTheTradeResponses = {}
function mb_Rogue_TricksOfTheTradeResponseHandler(msg, from)
    local unit = mb_GetUnitForPlayerName(from)
    if unit == nil then
        return
    end
    local score = tonumber(msg)
    mb_Rogue_tricksOfTheTradeResponses[unit] = score
end

mb_Rogue_tricksOfTheTradeTarget = nil
mb_Rogue_hasPendingTricksOfTheTradeAuction = false
mb_Rogue_lastTricksOfTheTradeAuction = 0
function mb_Rogue_HandleTricksOfTheTrade()
    if UnitIsDeadOrGhost("player") then
        return false
    end
    if mb_GetRemainingSpellCooldown("Tricks of the Trade") > 1.5 or UnitBuff("player", "Tricks of the Trade") then
        mb_Rogue_tricksOfTheTradeTarget = nil
        return false
    end
    if mb_Rogue_tricksOfTheTradeTarget ~= nil then
        mb_CastSpellOnUnit("Tricks of the Trade", mb_Rogue_tricksOfTheTradeTarget)
        return true
    end
    if mb_Rogue_hasPendingTricksOfTheTradeAuction then
        -- Auction lasts 1 second
        if mb_Rogue_lastTricksOfTheTradeAuction + 1 > mb_time then
            return true
        end
        local winnerUnit = nil
        local winnerScore = 0
        for unit, score in pairs(mb_Rogue_tricksOfTheTradeResponses) do
            if score > winnerScore and mb_IsUnitValidFriendlyTarget(unit, "Tricks of the Trade") then
                winnerUnit = unit
                winnerScore = score
            end
        end
        if winnerUnit ~= nil then
            mb_SayRaid("Casting Tricks of the Trade on " .. UnitName(winnerUnit) .. ", score: " .. winnerScore)
            mb_Rogue_tricksOfTheTradeTarget = winnerUnit
        end
        mb_Rogue_hasPendingTricksOfTheTradeAuction = false
        -- return, block casting other things while auction is pending so that GCD and energy is available when auction ends
        return true
    end
    if mb_Rogue_lastTricksOfTheTradeAuction + 10 > mb_time then
        return false
    end
    mb_Rogue_tricksOfTheTradeResponses = {}
    mb_Rogue_lastTricksOfTheTradeAuction = mb_time
    mb_Rogue_hasPendingTricksOfTheTradeAuction = true
    mb_SendMessage("tricksAuction")
    return false
end

TRICKS_OF_THE_TRADE_PRIORITY =
{
    TANKING = 1,
    TANKING_NEED_THREAT = 99,

    MAX_PRIORITY = 100
}
