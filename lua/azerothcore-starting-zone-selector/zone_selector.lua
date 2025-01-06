local AIO = AIO or require("AIO")

-- Define the NPC ID
local npcId = 750002

local STARTING_ZONES = {
    Alliance = {
        {name = "Northshire Valley", map = 0, x = -8944.69, y = -125.51, z = 83.37, o = 5.31, image = "Interface/Buttons/Northshire_Valley"},
        {name = "Coldridge Valley", map = 0, x = -6230.69, y = 327.82, z = 382.91, o = 0.71, image = "Interface/Buttons/Coldridge_Valley"},
        {name = "Shadowglen", map = 1, x = 10310.54, y = 832.44, z = 1326.42, o = 5.29, image = "Interface/Buttons/Shadowglen"},
        {name = "Ammen Vale", map = 530, x = -3962.51, y = -13931.58, z = 100.48, o = 1.86, image = "Interface/Buttons/Ammen_Vale"},
    },
    Horde = {
        {name = "Valley of Trials", map = 1, x = -618.49, y = -4253.93, z = 38.66, o = 0.05, image = "Interface/Buttons/Valley_of_Trials"},
        {name = "Deathknell", map = 0, x = 1676.71, y = 1678.31, z = 121.67, o = 2.70, image = "Interface/Buttons/Deathknell"},
        {name = "Red Cloud Mesa", map = 1, x = -2919.59, y = -257.46, z = 52.94, o = 0, image = "Interface/Buttons/Red_Cloud_Mesa"},
        {name = "Sunstrider Isle", map = 530, x = 10349.60, y = -6357.29, z = 33.40, o = 5.46, image = "Interface/Buttons/Sunstrider_Isle"},
    }
}

local ZoneSelectorHandlers = {
    SelectZone = function(player, zoneIndex)
        local faction = player:GetTeam() == 0 and "Alliance" or "Horde"
        local zones = STARTING_ZONES[faction]

        if zones[zoneIndex] then
            local zoneData = zones[zoneIndex]
            player:Teleport(zoneData.map, zoneData.x, zoneData.y, zoneData.z, zoneData.o)
        end
    end
}

AIO.AddHandlers("ZoneSelector", ZoneSelectorHandlers)

local function OnGossipHello(event, player, creature)
    -- Determine player's faction in order to populate the correct starting zones
    local faction = player:GetTeam() == 0 and "Alliance" or "Horde"
    local zones = STARTING_ZONES[faction]

    -- Send the UI to the player
    AIO.Handle(player, "ZoneSelector", "ShowUI", zones)
end

RegisterCreatureGossipEvent(npcId, 1, OnGossipHello)