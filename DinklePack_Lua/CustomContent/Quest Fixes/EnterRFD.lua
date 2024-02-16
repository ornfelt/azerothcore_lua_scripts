local RFDPortal = {}

RFDPortal.GO_ID = 900001
RFDPortal.CLOSE_DISTANCE = 5 

function RFDPortal.OnEnter(event, go, player)
    go:RegisterEvent(RFDPortal.CheckForPlayersEntrance, 1000, 0)
end

function RFDPortal.CheckForPlayersEntrance(event, delay, repeat_times, go)
    local playersInRange = go:GetPlayersInRange(RFDPortal.CLOSE_DISTANCE)
    for _, player in pairs(playersInRange) do
        if player:GetLevel() >= 25 then
            player:Teleport(129, 2593.040, 1106.7067, 51.36396, 4.7)
        else
            player:SendBroadcastMessage("You must be at least level 25 to enter.")
        end
    end
end

RegisterGameObjectEvent(RFDPortal.GO_ID, 2, RFDPortal.OnEnter)
