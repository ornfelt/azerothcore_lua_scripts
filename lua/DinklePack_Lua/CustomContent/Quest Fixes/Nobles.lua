local NobelInterrogation = {}

NobelInterrogation.SUSPECT_IDS = {110000, 110001} 

NobelInterrogation.PLAYER_INTERROGATION_PHRASES = {
    "We know you're in cahoots with the Defias Brotherhood. Submit yourself quietly to arrest.",
    "You can't hide your allegiance to the Defias. Surrender now!",
    "Your association with the Defias Brotherhood is known. Give up peacefully.",
    "Your ties to the Defias are no longer a secret. Surrender or face justice!"
}

NobelInterrogation.SUSPECT_REVEAL_PHRASES = {
    "Never! Vancleef was this city's hero!",
    "The Stonemasons deserve restitution!",
    "You'll never take me alive!",
    "For the Defias Brotherhood!"
}

function NobelInterrogation.SuspectSpawn(event, unit)
    unit:SetFaction(11)
end

function NobelInterrogation.SuspectResponse(eventId, delay, repeats, unit)
    unit:SendUnitSay(NobelInterrogation.SUSPECT_REVEAL_PHRASES[math.random(#NobelInterrogation.SUSPECT_REVEAL_PHRASES)], 0)
    unit:SetFaction(1630)
    local playersInRange = unit:GetPlayersInRange(10) -- Adjust the range as needed
    if #playersInRange > 0 then
        local playerUnit = playersInRange[1] -- Get the first player in range
        unit:AttackStart(playerUnit)
    end
end

function NobelInterrogation.SuspectGossip(event, player, unit)
    player:SendUnitSay(NobelInterrogation.PLAYER_INTERROGATION_PHRASES[math.random(#NobelInterrogation.PLAYER_INTERROGATION_PHRASES)], 0)
    unit:RegisterEvent(NobelInterrogation.SuspectResponse, 4000, 1)
    return false 
end

for i = 1, #NobelInterrogation.SUSPECT_IDS do
    RegisterCreatureEvent(NobelInterrogation.SUSPECT_IDS[i], 5, NobelInterrogation.SuspectSpawn)
    RegisterCreatureGossipEvent(NobelInterrogation.SUSPECT_IDS[i], 1, NobelInterrogation.SuspectGossip)
end
