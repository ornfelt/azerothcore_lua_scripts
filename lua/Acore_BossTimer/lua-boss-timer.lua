--
--
-- Created by IntelliJ IDEA.
-- User: Silvia
-- Date: 31/05/2022
-- Time: 08:50
-- To change this template use File | Settings | File Templates.
-- Originally created by Honey for Azerothcore
-- requires ElunaLua module


-- This script serves to log player performance for future use, e.g. website display.
------------------------------------------------------------------------------------------------
-- ADMIN GUIDE:  -  compile the core with ElunaLua module
--               -  adjust config in this file
--               -  add this script to ../lua_scripts/
--               -  adjust the IDs and config flags in case of conflicts and run the associated SQL to add the required NPCs
------------------------------------------------------------------------------------------------
-- GM GUIDE:     -  nothing to do
------------------------------------------------------------------------------------------------
local function newAutotable(dim)
    local MT = {};
    for i=1, dim do
        MT[i] = {__index = function(t, k)
            if i < dim then
                t[k] = setmetatable({}, MT[i+1])
                return t[k];
            end
        end}
    end

    return setmetatable({}, MT[1]);
end

local BossArray = newAutotable(2)   -- What entries should be checked for. Limited to 20 bosses per map
local MaxPlayers = {}               -- Max amount of players logged per instance id. May not be higher than the amount of columns in the db table
local Config = {}

Config.customDbName = 'ac_eluna'
Config.DummyEntry = 1126001         -- Dummy which must be spawned via creature table in every map which should be checked
Config.DifferentCheck = {12018}		-- These Entries require different checks than default death to determine the encounter completition

-- Molten Core
BossArray[409] = {12118,11982,12259,12057,12056,12264,11988,12098,12018,11502}
MaxPlayers[409] = 25

------------------------------------------
-- NO ADJUSTMENTS REQUIRED BELOW THIS LINE
------------------------------------------
local CREATURE_EVENT_ON_ADD = 36            -- (event, creature)

local MapArray = {}                     -- mapId of the instance
local PlayerArray = newAutotable(2)	    -- players per instance[InstanceId][Player#] = player GUID (Limit: 40)
local StartTimerArray = newAutotable(2)	-- start timers per [InstanceId][Boss] = Unixtimestamp
local StopTimerArray = newAutotable(2)	-- stop timers per [InstanceId][Boss] = Unixtimestamp

local function GetIndex(tab, val)
    for index, value in pairs(tab) do
        if value == val then
            return index
        end
    end
    return false
end

local function HasValue(tab, val)
    for index, value in pairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local function LoadInstancesFromDb()
    --todo: Load Active Instance Ids from DB. Check character table and load data from Eluna table for every existing instance
end

local function SaveInstanceToDB(instanceId)
    --todo: save stuff in containers to Eluna table
end

local function CheckBosses(eventid, delay, repeats, worldobject)
    local mapId = worldobject:GetMapId()
    for _,bval in pairs(BossArray[mapId]) do
        local boss = worldobject:GetNearestCreature(5000,bval)
        if boss then
            if not boss:IsDead() then
                local bossId = GetIndex(BossArray[mapId],boss:GetEntry())
                if bossId == false then
                    printerror('Unknown boss listed. MapId: '..BossArray[mapId]..' Entry: '..boss:GetEntry())
                end
                instanceId = boss:GetInstanceId()
                if boss:IsInCombat() and not StartTimerArray[instanceId][bossId] then --combat started
                    StartTimerArray[instanceId][bossId] = os.time
                elseif not boss:IsInCombat() and StartTimerArray[instanceId][bossId] then -- reset timer on wipe
                    StartTimerArray[instanceId][bossId] = nil
                end
            elseif StartTimerArray[instanceId][bossId] then
                StopTimerArray[instance][bossId] = os.time

                local player = worldobject:GetNearestPlayer(5000) -- Get closest player
                local group = player:GetGroup()
                local groupPlayers = group:GetMembers()
                for _,pval in pairs(groupPlayers) do
                    local playerGUID = pval:GetGUIDLow()
                    if not HasValue(PlayerArray[instanceId],playerGUID) and #PlayerArray[instanceId] <= MaxPlayers[mapId] then
                        table.insert(PlayerArray[instanceId],playerGUID)
                    end
                end
            end
        end
    end
end

local function DummyAdded(event,creature)
    creature:RegisterEvent( CheckBosses, 950 )
end

local function Init()
    RegisterCreatureEvent(Config.DummyEntry,CREATURE_EVENT_ON_ADD,DummyAdded)
    LoadInstancesFromDb()

    WorldDBQuery('CREATE DATABASE IF NOT EXISTS `'..Config.customDbName..'`;')
    WorldDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.customDbName..'`.`raid_record_players` (`id` INT UNSIGNED NOT NULL, '..
    '`player_1` INT UNSIGNED DEFAULT NULL DEFAULT NULL, `player_2` INT UNSIGNED DEFAULT NULL, `player_3` INT UNSIGNED DEFAULT NULL, `player_4` INT UNSIGNED DEFAULT NULL, `player_5` INT UNSIGNED DEFAULT NULL, '..
    '`player_6` INT UNSIGNED DEFAULT NULL, `player_7` INT UNSIGNED DEFAULT NULL, `player_8` INT UNSIGNED DEFAULT NULL, `player_9` INT UNSIGNED DEFAULT NULL, `player_10` INT UNSIGNED DEFAULT NULL, '..
    '`player_11` INT UNSIGNED DEFAULT NULL, `player_12` INT UNSIGNED DEFAULT NULL, `player_13` INT UNSIGNED DEFAULT NULL, `player_14` INT UNSIGNED DEFAULT NULL, `player_15` INT UNSIGNED DEFAULT NULL, '..
    '`player_16` INT UNSIGNED DEFAULT NULL, `player_17` INT UNSIGNED DEFAULT NULL, `player_18` INT UNSIGNED DEFAULT NULL, `player_19` INT UNSIGNED DEFAULT NULL, `player_20` INT UNSIGNED DEFAULT NULL, '..
    '`player_21` INT UNSIGNED DEFAULT NULL, `player_22` INT UNSIGNED DEFAULT NULL, `player_23` INT UNSIGNED DEFAULT NULL, `player_24` INT UNSIGNED DEFAULT NULL, `player_25` INT UNSIGNED DEFAULT NULL, '..
    '`player_26` INT UNSIGNED DEFAULT NULL, `player_27` INT UNSIGNED DEFAULT NULL, `player_28` INT UNSIGNED DEFAULT NULL, `player_29` INT UNSIGNED DEFAULT NULL, `player_30` INT UNSIGNED DEFAULT NULL, '..
    '`player_31` INT UNSIGNED DEFAULT NULL, `player_32` INT UNSIGNED DEFAULT NULL, `player_33` INT UNSIGNED DEFAULT NULL, `player_34` INT UNSIGNED DEFAULT NULL, `player_35` INT UNSIGNED DEFAULT NULL, '..
    '`player_36` INT UNSIGNED DEFAULT NULL, `player_37` INT UNSIGNED DEFAULT NULL, `player_38` INT UNSIGNED DEFAULT NULL, `player_39` INT UNSIGNED DEFAULT NULL, `player_40` INT UNSIGNED DEFAULT NULL, '..
    'PRIMARY KEY (`id`));')
    WorldDBQuery('CREATE TABLE IF NOT EXISTS `'..Config.customDbName..'`.`raid_record_timers` (`map_id` SMALLINT UNSIGNED NOT NULL, `instance_id` INT UNSIGNED NOT NULL, `id` INT UNSIGNED NOT NULL, '..
    '`boss1_pull` INT UNSIGNED NOT NULL, `boss1_kill` INT UNSIGNED DEFAULT NULL, `boss2_pull` INT UNSIGNED DEFAULT NULL, `boss2_kill` INT UNSIGNED DEFAULT NULL, '..
    '`boss3_pull` INT UNSIGNED DEFAULT NULL, `boss3_kill` INT UNSIGNED DEFAULT NULL, `boss4_pull` INT UNSIGNED DEFAULT NULL, `boss4_kill` INT UNSIGNED DEFAULT NULL, '..
    '`boss5_pull` INT UNSIGNED DEFAULT NULL, `boss5_kill` INT UNSIGNED DEFAULT NULL, `boss6_pull` INT UNSIGNED DEFAULT NULL, `boss6_kill` INT UNSIGNED DEFAULT NULL, '..
    '`boss7_pull` INT UNSIGNED DEFAULT NULL, `boss7_kill` INT UNSIGNED DEFAULT NULL, `boss8_pull` INT UNSIGNED DEFAULT NULL, `boss8_kill` INT UNSIGNED DEFAULT NULL, '..
    '`boss9_pull` INT UNSIGNED DEFAULT NULL, `boss9_kill` INT UNSIGNED DEFAULT NULL, `boss10_pull` INT UNSIGNED DEFAULT NULL, `boss10_kill` INT UNSIGNED DEFAULT NULL, '..
    '`boss11_pull` INT UNSIGNED DEFAULT NULL, `boss11_kill` INT UNSIGNED DEFAULT NULL, `boss12_pull` INT UNSIGNED DEFAULT NULL, `boss12_kill` INT UNSIGNED DEFAULT NULL, '..
    '`boss13_pull` INT UNSIGNED DEFAULT NULL, `boss13_kill` INT UNSIGNED DEFAULT NULL, `boss14_pull` INT UNSIGNED DEFAULT NULL, `boss14_kill` INT UNSIGNED DEFAULT NULL, '..
    '`boss15_pull` INT UNSIGNED DEFAULT NULL, `boss15_kill` INT UNSIGNED DEFAULT NULL, `boss16_pull` INT UNSIGNED DEFAULT NULL, `boss16_kill` INT UNSIGNED DEFAULT NULL, '..
    '`boss17_pull` INT UNSIGNED DEFAULT NULL, `boss17_kill` INT UNSIGNED DEFAULT NULL, `boss18_pull` INT UNSIGNED DEFAULT NULL, `boss18_kill` INT UNSIGNED DEFAULT NULL, '..
    '`boss19_pull` INT UNSIGNED DEFAULT NULL, `boss19_kill` INT UNSIGNED DEFAULT NULL, `boss20_pull` INT UNSIGNED DEFAULT NULL, `boss20_kill` INT UNSIGNED DEFAULT NULL, '..
    'PRIMARY KEY (`map_id`, `instance_id`, `boss1_pull`));')
end

Init()
