local AuraRemovalEX = {}

AuraRemovalEX.AURAS_TO_REMOVE = {
    22667,
    23153,
    23154,
    23155,
    23168,
    23169,
    23170,
    23393,
    23310,
    23312
}

AuraRemovalEX.SPELL_ID = 80026

function AuraRemovalEX.RemoveAuras(eventId, delay, repeats, player)
    if not player:GetAura(AuraRemovalEX.SPELL_ID) then
        player:RemoveEventById(eventId)
        return
    end

    for _, auraIdToRemove in pairs(AuraRemovalEX.AURAS_TO_REMOVE) do
        if player:GetAura(auraIdToRemove) then
            player:RemoveAura(auraIdToRemove)
        end
    end
end

function AuraRemovalEX.OnSpellCast(event, player, spell, skipCheck)
    if spell:GetEntry() ~= AuraRemovalEX.SPELL_ID then
        return
    end

    local eventId = player:RegisterEvent(AuraRemovalEX.RemoveAuras, 2000, 0)
    player:SetData("AuraRemovalEXEventId", eventId)
end

function AuraRemovalEX.OnPlayerLogout(event, player)
    local eventId = player:GetData("AuraRemovalEXEventId")
    if eventId then
        player:RemoveEventById(eventId)
    end
end

function AuraRemovalEX.OnPlayerLogin(event, player)
    if player:GetAura(AuraRemovalEX.SPELL_ID) then
        local eventId = player:RegisterEvent(AuraRemovalEX.RemoveAuras, 2000, 0)
        player:SetData("AuraRemovalEXEventId", eventId)
    end
end

RegisterPlayerEvent(5, AuraRemovalEX.OnSpellCast)
RegisterPlayerEvent(4, AuraRemovalEX.OnPlayerLogout)
RegisterPlayerEvent(3, AuraRemovalEX.OnPlayerLogin)
