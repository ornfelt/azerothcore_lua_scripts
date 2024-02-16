local KindlingFuryHandler = {}

KindlingFuryHandler.SPELL_IDS = {
    TO_LISTEN_FOR = 80040,
    TO_CAST = 920353,
    AURA_TO_CHECK = 80040
}

KindlingFuryHandler.REQUIRED_AURA_STACKS = 14

local function KF_OnCast(event, player, spell, skipCheck)
    if spell:GetEntry() == KindlingFuryHandler.SPELL_IDS.TO_LISTEN_FOR then
        local aura = player:GetAura(KindlingFuryHandler.SPELL_IDS.AURA_TO_CHECK)
        if aura and aura:GetStackAmount() >= KindlingFuryHandler.REQUIRED_AURA_STACKS then
            player:CastSpell(player, KindlingFuryHandler.SPELL_IDS.TO_CAST, true)
            player:RemoveAura(KindlingFuryHandler.SPELL_IDS.AURA_TO_CHECK)
        end
    end
end

RegisterPlayerEvent(5, KF_OnCast) -- PLAYER_EVENT_ON_SPELL_CAST = 5
