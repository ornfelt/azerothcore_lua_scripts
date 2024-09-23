local DKHealthCheck = {}

DKHealthCheck.ITEM_IDS = {60202, 800024}
DKHealthCheck.AURA_ID = 80012
DKHealthCheck.NEW_SPELL_ID = 80018
DKHealthCheck.DK_CLASS_ID = 6
DKHealthCheck.HEALTH_THRESHOLD_HIGH = 80
DKHealthCheck.HEALTH_THRESHOLD_LOW = 60

DKHealthCheck.DKHealthCheckEventRegistered = {}

function DKHealthCheck.IsInTable(value, table)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

function DKHealthCheck.CastSpellIfHealthAbove80(player, playerClass)
    if playerClass ~= DKHealthCheck.DK_CLASS_ID or not player:HasAura(DKHealthCheck.AURA_ID) then
        return
    end

    local healthPercent = player:GetHealthPct()
    local hasNewSpellAura = player:HasAura(DKHealthCheck.NEW_SPELL_ID)

    if healthPercent > DKHealthCheck.HEALTH_THRESHOLD_HIGH and not hasNewSpellAura then
        player:CastSpell(player, DKHealthCheck.NEW_SPELL_ID, true)
    elseif healthPercent < DKHealthCheck.HEALTH_THRESHOLD_LOW and hasNewSpellAura then
        player:RemoveAura(DKHealthCheck.NEW_SPELL_ID)
    end
end

function DKHealthCheck.CheckPlayerHealth(eventId, delay, repeats, player)
    if not player:HasAura(DKHealthCheck.AURA_ID) then
        player:RemoveEvents(DKHealthCheck.CheckPlayerHealth)
        DKHealthCheck.DKHealthCheckEventRegistered[player:GetGUID()] = false
        return
    end

    local playerClass = player:GetClass()
    DKHealthCheck.CastSpellIfHealthAbove80(player, playerClass)
end

function DKHealthCheck.OnEquip(event, player, item, bag, slot)
    local playerClass = player:GetClass()

    if playerClass ~= DKHealthCheck.DK_CLASS_ID then
        return
    end

    if item:IsEquipped() and DKHealthCheck.IsInTable(item:GetEntry(), DKHealthCheck.ITEM_IDS) and player:HasAura(DKHealthCheck.AURA_ID) then
        if not DKHealthCheck.DKHealthCheckEventRegistered[player:GetGUID()] then
            player:RegisterEvent(DKHealthCheck.CheckPlayerHealth, 2000, 0, player)
            DKHealthCheck.DKHealthCheckEventRegistered[player:GetGUID()] = true
        end
    elseif player:HasAura(DKHealthCheck.NEW_SPELL_ID) then
        player:RemoveAura(DKHealthCheck.NEW_SPELL_ID)
    end
end

function DKHealthCheck.OnLogout(event, player)
    player:RemoveEvents(DKHealthCheck.CheckPlayerHealth)
    DKHealthCheck.DKHealthCheckEventRegistered[player:GetGUID()] = false
end

function DKHealthCheck.OnLogin(event, player)
    local playerClass = player:GetClass()

    if playerClass == DKHealthCheck.DK_CLASS_ID then
        for _, itemId in ipairs(DKHealthCheck.ITEM_IDS) do
            local item = player:GetItemByEntry(itemId)
            if item and item:IsEquipped() then
                DKHealthCheck.OnEquip(nil, player, item, 0, 8)
                break
            end
        end
    end
end

RegisterPlayerEvent(29, DKHealthCheck.OnEquip)
RegisterPlayerEvent(4, DKHealthCheck.OnLogout)
RegisterPlayerEvent(3, DKHealthCheck.OnLogin)
