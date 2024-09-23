local ACCOUNT_LEVEL = 3
local PLAYER_EVENT_ON_UPDATE_ZONE = 27
local DISALLOWED_AREAS = {
    [2338]=true, -- South Seas (STV)
--    [1581]=true, -- darkmines outside spark
}

-- Shark 23928

local function SummonSharkOnPlayer(eventId, delay, repeats, player)
        if DISALLOWED_AREAS[player:GetAreaId()] ~= nil then
                 player:SendAreaTriggerMessage("Something in the water shuffles beneath your feet...")
                 player:SendBroadcastMessage("Something in the water shuffles beneath your feet...")
                 local sharkNPC = player:SpawnCreature(23928, player:GetX(), player:GetY(), player:GetZ()-30, 0, 4, 180000)
                 sharkNPC:SetSpeed(0, 2)
                 sharkNPC:SetSpeed(3, 2)
                 sharkNPC:SetSpeed(6, 2)
                 sharkNPC:AttackStart(player)
        end
end


local function KillSwimmers(event, player, newZone, newArea)
        -- do not care about GMs
        if (player:GetGMRank() >= ACCOUNT_LEVEL) then
                --print("This guy is a GM and won't be eaten! " .. player:GetName())
                return false
        elseif DISALLOWED_AREAS[newArea] ~= nil then
                 player:SendAreaTriggerMessage("This water is too deep! Who knows what waits below...")
                 player:SendBroadcastMessage("This water is too deep! Who knows what waits below...")
                 player:RegisterEvent(SummonSharkOnPlayer, {10000, 30000}, 20)
        end
end


RegisterPlayerEvent(PLAYER_EVENT_ON_UPDATE_ZONE, KillSwimmers)