local EmeraldDragonGuardP = {}

EmeraldDragonGuardP.CLOSE_DISTANCE = 5 -- Max distance when the player should get teleported
EmeraldDragonGuardP.GUARDING_CREATURES = {14887, 14890, 14889, 14888} -- Creatures guarding the portal
EmeraldDragonGuardP.GO_ID = 900000 -- Game object ID for the portal

-- Function to check if any of the guarding creatures are alive and in range
function EmeraldDragonGuardP.IsGuardingCreatureInRange(go)
    for _, id in pairs(EmeraldDragonGuardP.GUARDING_CREATURES) do
        local creatures = go:GetCreaturesInRange(1000, id)
        for _, creature in pairs(creatures) do
            if creature:IsAlive() then
                return true
            end
        end
    end
    return false
end

function EmeraldDragonGuardP.OnEnter(event, go, player)
    go:RegisterEvent(EmeraldDragonGuardP.CheckForPlayersEntrance, 1000, 0)
end

function EmeraldDragonGuardP.CheckForPlayersEntrance(event, delay, repeat_times, go, player)
    local players_in_range = go:GetPlayersInRange(EmeraldDragonGuardP.CLOSE_DISTANCE)
    if EmeraldDragonGuardP.IsGuardingCreatureInRange(go) then
        for _, player in pairs(players_in_range) do
            player:SendBroadcastMessage("An Emerald Dragon is guarding this portal!")
        end
    else
        for _, player in pairs(players_in_range) do
            player:Teleport(169, 3233, 3040, 23.25, 3.15)
        end
    end
end

RegisterGameObjectEvent(EmeraldDragonGuardP.GO_ID, 2, EmeraldDragonGuardP.OnEnter)
