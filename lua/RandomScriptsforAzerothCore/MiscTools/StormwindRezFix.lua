local Area1 = 5390
local Area2 = 1519
local Area3 = 5148
local Area4 = 5150
local Area5 = 5314
local Area6 = 5346
local Area7 = 5428
local Area8 = 4921
local Area9 = 5157
local TargetMap = 0
local TargetX = -8357.38
local TargetY = 956.383
local TargetZ = 96.329971
local TargetO = 4.262

local function TeleportAndRevive(eventId, delay, repeats, player)
    player:Teleport(TargetMap, TargetX, TargetY, TargetZ, TargetO)
    player:ResurrectPlayer(100, false)
end

local function PlayerReleasesSpirit(event, player)
    local playerArea = player:GetAreaId()
    if playerArea == Area1 or playerArea == Area2 or playerArea == Area3 or playerArea == Area4 or playerArea == Area5 or playerArea == Area6 or playerArea == Area7 or playerArea == Area8 or playerArea == Area9 then
        player:RegisterEvent(TeleportAndRevive, 2000, 1)
    end
end

RegisterPlayerEvent(35, PlayerReleasesSpirit)
