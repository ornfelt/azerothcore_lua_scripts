local SpellTrigger = {}

SpellTrigger.SPELL_ID = 100207
SpellTrigger.SOUND_ID = 53774
SpellTrigger.ADDITIONAL_SPELL_ID = 200181

function SpellTrigger.OnSpellCast(event, player, spell)
    if spell:GetEntry() == SpellTrigger.SPELL_ID then
        player:PlayDirectSound(SpellTrigger.SOUND_ID, player)
        player:CastSpell(player, SpellTrigger.ADDITIONAL_SPELL_ID, true)
    end
end

RegisterPlayerEvent(5, SpellTrigger.OnSpellCast)
