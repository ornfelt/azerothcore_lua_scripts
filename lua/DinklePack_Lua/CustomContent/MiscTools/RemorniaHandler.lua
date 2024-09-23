local AuraSpellHeal = {}

AuraSpellHeal.AURA_ID = 80006
AuraSpellHeal.CAST_SPELL_ID = 72313
AuraSpellHeal.HEAL_PERCENT = 5
AuraSpellHeal.EMOTE_ID = 53

function AuraSpellHeal.OnSpellCast(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()

    -- Cast spell 72313 and play emote 53 when the player casts spell 80006
    if spellId == AuraSpellHeal.AURA_ID then
        player:CastSpell(player, AuraSpellHeal.CAST_SPELL_ID, true)
        player:PerformEmote(AuraSpellHeal.EMOTE_ID)
    end

    -- Check if the player has the specified aura active
    if player:HasAura(AuraSpellHeal.AURA_ID) then
        -- Calculate the healing amount
        local healAmount = player:GetMaxHealth() * (AuraSpellHeal.HEAL_PERCENT / 100)

        -- Apply the healing effect
        player:DealHeal(player, spellId, healAmount)
    end
end

RegisterPlayerEvent(5, AuraSpellHeal.OnSpellCast)
