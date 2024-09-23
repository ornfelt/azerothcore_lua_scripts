local GrimBatol = {}

GrimBatol.GO_ID = 900003
GrimBatol.CLOSE_DISTANCE = 5

function GrimBatol.OnExit(event, go, player)
    go:RegisterEvent(GrimBatol.CheckForPlayersExit, 1000, 0)
end

function GrimBatol.CheckForPlayersExit(event, delay, repeat_times, go, player)
    local players_in_range = go:GetPlayersInRange(GrimBatol.CLOSE_DISTANCE)
    for _, player in pairs(players_in_range) do
        player:Teleport(0, -4076.992188, -3458.102539, 281.254150, 3.58)
    end
end

RegisterGameObjectEvent(GrimBatol.GO_ID, 2, GrimBatol.OnExit)
