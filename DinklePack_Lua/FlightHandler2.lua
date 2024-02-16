FM_TWO = {}

-- Don't touch without consulting me first. Don't want you to screw up your game.
FM_TWO.AURA_ID = 100225
FM_TWO.TRIGGER_SPELLS = {100211, 100213, 100214}
FM_TWO.CAST_SPELLS = {100210, 100218, 100219, 100220}
FM_TWO.CAST_SPELL_ID = 69669

function FM_TWO.tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function FM_TWO.CheckAuraStacksAndCast(player, auraId, triggerSpells, castSpellId)
    if player:HasAura(auraId) then
        local aura = player:GetAura(auraId)
        local stacks = aura:GetStackAmount()
        if stacks >= 3 then
            player:CastSpell(player, castSpellId, true)
        end
    end
end

function FM_TWO.OnSpellCast(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()
    if FM_TWO.tableContains(FM_TWO.TRIGGER_SPELLS, spellId) then
        FM_TWO.CheckAuraStacksAndCast(player, FM_TWO.AURA_ID, FM_TWO.TRIGGER_SPELLS, FM_TWO.CAST_SPELL_ID)
    elseif FM_TWO.tableContains(FM_TWO.CAST_SPELLS, spellId) then
        if player:HasAura(FM_TWO.AURA_ID) then
            player:RemoveAura(FM_TWO.AURA_ID)
        end
    end
end

RegisterPlayerEvent(5, FM_TWO.OnSpellCast)
