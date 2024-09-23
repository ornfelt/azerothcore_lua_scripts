local SpellCastBonus = {}

SpellCastBonus.AURAS = {
    AURA_1 = 80043,
    AURA_2 = 80044,
    HAS_AURA = 59327
}

SpellCastBonus.SPELLS = {
    SPELL_1 = 48982,
    SPELL_2 = 48707
}

SpellCastBonus.BONUS_SPELLS = {
    BONUS_SPELL_1 = 80042,
    BONUS_SPELL_2 = 80046,
    EXTRA_SPELL = 80027
}

local function DKTT_OnPlayerCastSpell(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()

    -- If player has aura 80043 and casts 48982, also cast 80042
    if spellId == SpellCastBonus.SPELLS.SPELL_1 and player:HasAura(SpellCastBonus.AURAS.AURA_1) then
        player:CastSpell(player, SpellCastBonus.BONUS_SPELLS.BONUS_SPELL_1, true)
    end

    -- If player has aura 80044 and casts 48707, also cast 80046
    if spellId == SpellCastBonus.SPELLS.SPELL_2 and player:HasAura(SpellCastBonus.AURAS.AURA_2) then
        player:CastSpell(player, SpellCastBonus.BONUS_SPELLS.BONUS_SPELL_2, true)
    end
    
    -- If player has aura 59327 and casts 48982, also cast 80027
    if spellId == SpellCastBonus.SPELLS.SPELL_1 and player:HasAura(SpellCastBonus.AURAS.HAS_AURA) then
        player:CastSpell(player, SpellCastBonus.BONUS_SPELLS.EXTRA_SPELL, true)
    end
end

RegisterPlayerEvent(5, DKTT_OnPlayerCastSpell)
