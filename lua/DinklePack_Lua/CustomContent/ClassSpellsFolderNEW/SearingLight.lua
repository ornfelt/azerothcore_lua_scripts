local function SEARING_LIGHT_onCast(event, player, spell, skipCheck)
    if spell:GetEntry() == 190030 then
        player:PerformEmote(51)
    end
end

RegisterPlayerEvent(5, SEARING_LIGHT_onCast)
