local PLAYER_EVENT_ON_SPELL_CAST = 5
local TRIGGER_SPELL_ID = 312411
local SPELL_IDS = {54071, 100244, 100245, 100247}

local function Bags_Of_Tricks_OnPlayerCastSpell(event, player, spell, skipCheck)
    if spell:GetEntry() == TRIGGER_SPELL_ID then
        local spellId = SPELL_IDS[math.random(1, #SPELL_IDS)]
        local target = player:GetSelection()
        if target then
            player:CastSpell(target, spellId, true)
        else
            player:SendBroadcastMessage("No target selected.")
        end
    end
end

RegisterPlayerEvent(PLAYER_EVENT_ON_SPELL_CAST, Bags_Of_Tricks_OnPlayerCastSpell)
