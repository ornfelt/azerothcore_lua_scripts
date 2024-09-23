--
--
-- Created by IntelliJ IDEA.
-- User: Silvia
-- Date: 16/06/2021
-- Time: 20:38
-- To change this template use File | Settings | File Templates.
-- Originally created by Honey for Azerothcore
-- requires ElunaLua module


-- This module kicks players when they enter or login a zone specified in Config_Zones
------------------------------------------------------------------------------------------------
-- ADMIN GUIDE:  -  compile the core with ElunaLua module
--               -  adjust config in this file
--               -  add this script to ../lua_scripts/
------------------------------------------------------------------------------------------------
-- GM GUIDE:     -  summon the pitiful cheaters back to a legal map when they complain about kicks. Or don't
------------------------------------------------------------------------------------------------

local Config = {}

-- on/off switch (0/1)
Config.TeleportZone = 0                 -- Teleports players to home when entering forbidden zone
Config.KickZone     = 1                 -- Kicks players when entering forbidden zone

local Config_Zones = {}                 -- forbidden zones

table.insert(Config_Zones, 3537) -- Borean Tundra
table.insert(Config_Zones, 3711) -- Sholazar Basin
table.insert(Config_Zones, 4197) -- Wintergrasp
table.insert(Config_Zones, 210)  -- Icecrown
table.insert(Config_Zones, 2817) -- Crystalsong Forest
table.insert(Config_Zones, 4395) -- Dalaran
table.insert(Config_Zones, 65)   -- Dragonblight
table.insert(Config_Zones, 66)   -- Zul'Drak
table.insert(Config_Zones, 67)   -- Storm Peaks
table.insert(Config_Zones, 394)  -- Grizzly Hills
table.insert(Config_Zones, 495)  -- Howling Fjord
table.insert(Config_Zones, 4742) -- Hrothgar's Landing
table.insert(Config_Zones, 876)  -- GM Island

Config.TeleportArea = 1                -- Teleports players to home when entering forbidden area
Config.KickArea     = 0                -- Kicks players when entering forbidden area

local Config_Areas = {}                -- forbidden areas

table.insert(Config_Areas, 4080) -- Quel'Danas
table.insert(Config_Areas, 4085) -- Shattered Sun Staging Area
table.insert(Config_Areas, 4086) -- Sun's Reach Sanctum
table.insert(Config_Areas, 4087) -- Sun's Reach Harbor
table.insert(Config_Areas, 4088) -- Sun's Reach Armory
table.insert(Config_Areas, 4089) -- Dawnstar Village
table.insert(Config_Areas, 4090) -- Dawning Square
table.insert(Config_Areas, 4091) -- Greengill Coast
table.insert(Config_Areas, 4092) -- The Dead Scar
table.insert(Config_Areas, 4094) -- Sunwell Plateau
table.insert(Config_Areas, 4095) -- Magisters' Terrace
------------------------------------------------------------------------------------------------
-- CONFIG END
------------------------------------------------------------------------------------------------

local FILE_NAME = string.match(debug.getinfo(1,'S').source, "[^/\\]*.lua$")

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local function shouldKickZone(player,newZone)
    if player:GetGMRank() >= 1 then
        return false
    end

    if has_value(Config_Zones, newZone) then
        return true
    end

    return false
end

local function shouldKickArea(player,newArea)
    if player:GetGMRank() >= 1 then
        return false
    end

    if has_value(Config_Areas, newArea) then
        return true
    end

    return false
end

local function performKick(player)
    PrintError("["..FILE_NAME.."] Kicking player " .. player:GetName())
    player:KickPlayer()
end

local function performTeleport(player)
    PrintError(string.format("[%s] Teleporting player %s to home", FILE_NAME, player:GetName()))
    player:CastSpell(player, 8690, true) -- 8690 = Hearthstone spell
end

local function checkPlayerZone(player,newZone)
    if shouldKickZone(player,newZone) then
        PrintInfo("["..FILE_NAME.."] Player " .. player:GetName() .. " entered restricted zone " .. newZone .. " (characterId: " .. player:GetGUIDLow() .. ", accountName: " .. player:GetAccountName() .. ", accountId: " .. player:GetAccountId() .. ")")
        if Config.TeleportZone == 1 then
            performTeleport(player)
        end
        if Config.KickZone == 1 then
            performKick(player)
        end
    end
end

local function checkPlayerArea(player,newArea)
    if player:IsFlying() then
        return
    end
    if shouldKickArea(player,newArea) then
        PrintInfo("["..FILE_NAME.."] Player " .. player:GetName() .. " entered restricted zone " .. newArea .. " (characterId: " .. player:GetGUIDLow() .. ", accountName: " .. player:GetAccountName() .. ", accountId: " .. player:GetAccountId() .. ")")
        if Config.TeleportArea == 1 then
            performTeleport(player)
        end
        if Config.KickArea == 1 then
            performKick(player)
        end
    end
end

local function checkZoneLogin(event, player)
    checkPlayerZone(player,player:GetZoneId())
    checkPlayerArea(player,player:GetAreaId())
end

local function checkZoneUpdate(event, player, newZone, newArea)
    checkPlayerZone(player,newZone)
end

local function checkAreaUpdate(event, player, oldArea, newArea)
    checkPlayerArea(player,newArea)
end

local PLAYER_EVENT_ON_LOGIN = 3               -- (event, player)
local PLAYER_EVENT_ON_UPDATE_ZONE = 27        -- (event, player, newZone, newArea)
local PLAYER_EVENT_ON_UPDATE_AREA = 47        -- (event, player, oldArea, newArea)

RegisterPlayerEvent( PLAYER_EVENT_ON_LOGIN, checkZoneLogin )
if ( Config.TeleportZone == 1 or Config.KickZone == 1 ) and Config_Zones ~= {} then
    RegisterPlayerEvent( PLAYER_EVENT_ON_UPDATE_ZONE, checkZoneUpdate )
end

if ( Config.TeleportArea == 1 or Config.KickArea == 1 ) and Config_Areas ~= {} then
    RegisterPlayerEvent( PLAYER_EVENT_ON_UPDATE_AREA, checkAreaUpdate )
end

do
    local zones = ""
    for _, val in ipairs(Config_Zones) do
        zones = zones .. val .. ", "
    end
    PrintInfo("["..FILE_NAME.."] ZoneCheck loaded. Settings: Kick=" .. (Config.KickZone==1 and "yes" or "no") .. " Teleport=" .. (Config.TeleportZone==1 and "yes" or "no") .. " Zones={ " .. zones .. "}")

    local areas = ""
    for _, val in ipairs(Config_Areas) do
        areas = areas .. val .. ", "
    end
    PrintInfo("["..FILE_NAME.."] ZoneCheck loaded. Settings: Kick=" .. (Config.KickArea==1 and "yes" or "no") .. " Teleport=" .. (Config.TeleportArea==1 and "yes" or "no") .. " Areas={ " .. areas .. "}")
end
