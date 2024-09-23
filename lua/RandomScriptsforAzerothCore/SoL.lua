-- AzerothCore Eluna script by Dinkledork
local SPELL_SURGE_OF_LIGHT_1 = 33151
local SPELL_CUSTOM = 100205

local function OnSpellCast(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()
    if spellId == SPELL_SURGE_OF_LIGHT_1 then
        player:CastSpell(player, SPELL_CUSTOM, true)
    end
end

RegisterPlayerEvent(5, OnSpellCast)
