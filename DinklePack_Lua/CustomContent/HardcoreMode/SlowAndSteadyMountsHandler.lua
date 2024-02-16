local RestrictedRiding = {}

RestrictedRiding.ITEM_ID = 800048
RestrictedRiding.SPELL_IDS = {
    33388, 33389, 33391, 33392, 34090, 34091, 34092, 34093
}

function RestrictedRiding.OnPlayerLearnSpell(event, player, spellId)
    if player:HasItem(RestrictedRiding.ITEM_ID) then
        for _, restrictedSpell in ipairs(RestrictedRiding.SPELL_IDS) do
            if spellId == restrictedSpell then
                player:RemoveSpell(spellId)
                player:CastSpell(player, 12158, true)
                player:SendBroadcastMessage("|cffff0000Riding unlearned. You can't learn that spell while Slow and Steady mode is active.|r")
                break
            end
        end
    end
end

RegisterPlayerEvent(44, RestrictedRiding.OnPlayerLearnSpell)
