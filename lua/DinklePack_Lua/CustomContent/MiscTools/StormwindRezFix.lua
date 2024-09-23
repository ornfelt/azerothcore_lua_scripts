local PlayerTeleportRevive = {}

PlayerTeleportRevive.TARGET_AREA = {
    [5390] = true,
    [1519] = true,
    [5148] = true,
    [5150] = true,
    [5314] = true,
    [5346] = true,
    [5428] = true,
    [4921] = true,
    [5157] = true,
    [5151] = true,
    [7486] = true,
}

PlayerTeleportRevive.TARGET_MAP = 0
PlayerTeleportRevive.TARGET_X = -8437.3
PlayerTeleportRevive.TARGET_Y = 942.03
PlayerTeleportRevive.TARGET_Z = 98.6
PlayerTeleportRevive.TARGET_O = 5.4

function PlayerTeleportRevive.TeleportAndRevive(eventId, delay, repeats, player)
    player:Teleport(PlayerTeleportRevive.TARGET_MAP, PlayerTeleportRevive.TARGET_X, PlayerTeleportRevive.TARGET_Y, PlayerTeleportRevive.TARGET_Z, PlayerTeleportRevive.TARGET_O)
    player:ResurrectPlayer(100, false)
end

function PlayerTeleportRevive.PlayerReleasesSpirit(event, player)
    local playerArea = player:GetAreaId()
    if PlayerTeleportRevive.TARGET_AREA[playerArea] then
        player:RegisterEvent(PlayerTeleportRevive.TeleportAndRevive, 3000, 1)
    end
end

RegisterPlayerEvent(35, PlayerTeleportRevive.PlayerReleasesSpirit)
