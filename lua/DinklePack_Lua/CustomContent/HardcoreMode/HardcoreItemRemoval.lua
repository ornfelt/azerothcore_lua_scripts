local HardcoreMode = {}

HardcoreMode.ITEMS = {
    CUSTOM_STARTER_1 = 60002,
    CUSTOM_STARTER_2 = 10594,
    CUSTOM_STARTER_3 = 65000,
    ITEM_90000 = 90000
}

HardcoreMode.SPELLS = {
    MURKY_1 = 24939,
    MURKY_2 = 100117,
    MURKY_3 = 100118,
    MURKY_4 = 100105
}

function HardcoreMode.hasItem90000(player)
    return player:GetItemCount(HardcoreMode.ITEMS.ITEM_90000) > 0
end

function HardcoreMode.removeItems(player)
    local removed = false
    for _, entry in pairs(HardcoreMode.ITEMS) do
        local itemCount = player:GetItemCount(entry)
        if itemCount > 0 then
            for i = 0, itemCount - 1 do
                player:RemoveItem(entry, 1)
            end
            removed = true
        end
    end
    return removed
end

function HardcoreMode.removeSpell(player)
    for _, spellId in pairs(HardcoreMode.SPELLS) do
        player:RemoveSpell(spellId)
    end
end

function HardcoreMode.onLogin(event, player)
    player:RegisterEvent(HardcoreMode.delayedLogin, 3500, 1)  -- the function is executed after a delay of 3.5 seconds
end

function HardcoreMode.delayedLogin(eventId, delay, repeats, player)
    if HardcoreMode.hasItem90000(player) then
        if HardcoreMode.removeItems(player) then
            player:SendBroadcastMessage("Welcome to Hardcore Mode. Please watch your step!")
        end
        HardcoreMode.removeSpell(player)
    end
end

RegisterPlayerEvent(3, HardcoreMode.onLogin)
