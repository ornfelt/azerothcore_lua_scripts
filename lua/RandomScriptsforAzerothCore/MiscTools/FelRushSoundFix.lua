local SPELL_ID = 100207
local SOUND_ID = 53774
local ADDITIONAL_SPELL_ID = 200181

function OnSpellCast(event, player, spell)
    if spell:GetEntry() == SPELL_ID then
        player:PlayDirectSound(SOUND_ID, player)
        player:CastSpell(player, ADDITIONAL_SPELL_ID, true)
    end
end

RegisterPlayerEvent(5, OnSpellCast)