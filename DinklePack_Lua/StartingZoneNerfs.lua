--[[

-- Addresses one of the issues with my server, which is high hp mobs at low levels. If you're running auto balance, this will not work.
-- A bit buggy. May encounter mobs with an unexpectedly high amount of health.

local ZoneSet1 = {12, 14114, 85, 6454, 1, 3524, 3430, 215} -- Zone IDs for the first set of affected zones
local ZoneSet2 = {130, 17, 3525, 3433, 38, 148, 40} -- Zone IDs for the second set of affected zones
local HPModifier1 = 0.7 -- HP percentage for the first set of zones
local HPModifier2 = 0.8 -- HP percentage for the second set of zones
local Enabled = false -- Set to true to enable the functionality, false to disable
local mobOrigHealth = {} -- Table to store original HP values

local function UpdateMobHealth(mob, HPModifier)
    local entry = mob:GetEntry()
    if entry >= 68000 and entry <= 90000 then
        return
    end

    local guid = mob:GetGUIDLow()
    if not mobOrigHealth[guid] then
        mobOrigHealth[guid] = mob:GetMaxHealth()
    end

    local newMaxHealth = math.floor(mobOrigHealth[guid] * HPModifier)
    mob:SetMaxHealth(newMaxHealth)
end

local function CheckAndUpdateMobs(player)
    if not Enabled then
        return
    end

    local currentZone = player:GetZoneId()
    local HPModifier = nil

    for _, zone in ipairs(ZoneSet1) do
        if currentZone == zone then
            HPModifier = HPModifier1
            break
        end
    end

    for _, zone in ipairs(ZoneSet2) do
        if currentZone == zone then
            HPModifier = HPModifier2
            break
        end
    end

    if HPModifier then
        local range = 500 -- Change the radius value as needed
        local entryId = 0 -- Set to 0 to include all creature entries
        local hostile = 0 -- 0 both, 1 hostile, 2 friendly
        local dead = 0 -- 0 both, 1 alive, 2 dead

        local mobs = player:GetCreaturesInRange(range, entryId, hostile, dead)

        for _, mob in ipairs(mobs) do
            UpdateMobHealth(mob, HPModifier)
        end
    end
end

local function OnUpdateZone(event, player, newZone, newArea)
    CheckAndUpdateMobs(player)
end

local function OnMapChange(event, player)
    CheckAndUpdateMobs(player)
end

RegisterPlayerEvent(27, OnUpdateZone)
RegisterPlayerEvent(28, OnMapChange)
]]