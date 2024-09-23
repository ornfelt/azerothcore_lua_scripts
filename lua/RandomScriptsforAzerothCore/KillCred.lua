local function OnKillCredit(event, killer, killed)
    -- Check if the killed unit is a creature
    if killed:IsCreature() then
        -- Loop through all players in the world
        for _, player in pairs(GetPlayersInWorld()) do
            -- Check if the player has attacked the creature
            if player:GetUnitByGUID(killed):HasAura(2) then
                -- Give the player kill credit for the creature
                player:KilledMonsterCredit(killed:GetEntry())
            end
        end
    end
end

-- Register the event handler
RegisterPlayerEvent(7, OnKillCredit)
