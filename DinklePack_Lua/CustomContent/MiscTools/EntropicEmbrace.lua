local RoarCaster = {}

RoarCaster.SPELL_IDS = {
    CAST_100234 = 100234,
    CAST_72313 = 72313
}

RoarCaster.EMOTE_ROAR = 53

function RoarCaster.OnCastEntropicEmbrace(event, player, spell)
    if spell:GetEntry() == RoarCaster.SPELL_IDS.CAST_100234 then
        player:CastSpell(player, RoarCaster.SPELL_IDS.CAST_72313, true)
        player:PerformEmote(RoarCaster.EMOTE_ROAR)
    end
end

RegisterPlayerEvent(5, RoarCaster.OnCastEntropicEmbrace)
