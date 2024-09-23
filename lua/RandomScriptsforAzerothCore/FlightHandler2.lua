-- Don't touch without consulting me first. Don't want you to screw up your game.

local AURA_ID = 100225
local TRIGGER_SPELLS = {100211, 100213, 100214}
local CAST_SPELLS = {100210, 100218, 100219, 100220}
local CAST_SPELL_ID = 69669

local function tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

local function CheckAuraStacksAndCast(player, auraId, triggerSpells, castSpellId)
    if player:HasAura(auraId) then
        local aura = player:GetAura(auraId)
        local stacks = aura:GetStackAmount()
        if stacks >= 3 then
            player:CastSpell(player, castSpellId, true)
        end
    end
end

local function OnSpellCast(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()
    if tableContains(TRIGGER_SPELLS, spellId) then
        CheckAuraStacksAndCast(player, AURA_ID, TRIGGER_SPELLS, CAST_SPELL_ID)
    elseif tableContains(CAST_SPELLS, spellId) then
        if player:HasAura(AURA_ID) then
            player:RemoveAura(AURA_ID)
        end
    end
end

RegisterPlayerEvent(5, OnSpellCast)
