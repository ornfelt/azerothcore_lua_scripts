local SurgeOfLight = {}

SurgeOfLight.SPELL_IDS = {
    SURGE_OF_LIGHT_1 = 33151,
    CUSTOM = 100205
}

function SurgeOfLight.OnSpellCast(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()
    if spellId == SurgeOfLight.SPELL_IDS.SURGE_OF_LIGHT_1 then
        player:CastSpell(player, SurgeOfLight.SPELL_IDS.CUSTOM, true)
    end
end

RegisterPlayerEvent(5, SurgeOfLight.OnSpellCast)
