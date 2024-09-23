--
--
-- Created by IntelliJ IDEA.
-- User: Silvia
-- Date: 06/09/2021
-- Time: 20:17
-- To change this template use File | Settings | File Templates.
-- Originally created by Honey for Azerothcore
-- requires ElunaLua module


-- This module debuffs players when they enter a map or login into a map specified in Config_Maps.

------------------------------------------------------------------------------------------------
-- ADMIN GUIDE:  -  compile the core with ElunaLua module
--               -  adjust config in this file
--               -  add this script to ../lua_scripts/
------------------------------------------------------------------------------------------------
-- GM GUIDE:     -  nothing to do. Just watch them suffer.
------------------------------------------------------------------------------------------------
local Config = {}
local ConfigMap_baseStatModifier = {}
local ConfigMap_meleeAPModifier = {}
local ConfigMap_rangedAPModifier = {}
local ConfigMap_DamageTaken = {}
local ConfigMap_DamageDoneModifier = {}
local ConfigMap_hpModifier = {}
local ConfigMap_RageFromDamageModifier = {}
local ConfigMap_AbsorbModifier = {}
local ConfigMap_HealingDoneModifier = {}
local ConfigMap_PhysicalDamageTakenModifier = {}
local ConfigDungeon = {}
local Config_Maps = {}         -- maps where to debuff players always for PvE
local Config_DungeonMaps = {}      -- maps where to debuff players when no rdf
local Config_NoWorldBuffMaps = {}  -- maps where to remove world buffs
local Config_WorldBuff = {}        -- spell IDs of world buffs to be removed

-- on/off switch (0/1)
Config.MapsActive = 1
Config.DungeonActive = 0
Config.NoWorldBuffMaps = 1

Config.HpAuraSpell = 89501
Config.DamageDoneTakenSpell = 89502
Config.BaseStatAPSpell = 89503
Config.RageFromDamageSpell = 89504
Config.AbsorbSpell = 89505
Config.HealingDoneSpell = 89506
Config.PhysicalDamageTakenSpell = 89507

--set to nil to prevent visual
Config.VisualSpellRaid = nil -- 71367 = Fire Prison
Config.VisualSpellDungeon = nil

Config.DebuffMessageRaid = 'Chromies time-travelling spell impacts your powers. You feel weakened.'
Config.DebuffMessageDungeon = 'Chromies time-travelling spell impacts your powers. You feel weakened.'

-- Modifiers per map:
-- all modifiers are in %
-- UBRS [229]
-- ConfigMap_baseStatModifier[229] = 0
-- ConfigMap_meleeAPModifier[229] = 0
-- ConfigMap_rangedAPModifier[229] = 0
-- ConfigMap_DamageTaken[229] = 100
-- ConfigMap_DamageDoneModifier[229] = 0
-- ConfigMap_hpModifier[229] = 0
-- ConfigMap_RageFromDamageModifier[229] = 0
-- ConfigMap_AbsorbModifier[229] = 0
-- ConfigMap_HealingDoneModifier[229] = 0
-- ConfigMap_PhysicalDamageTakenModifier[229] = 0

-- MC [409]
ConfigMap_baseStatModifier[409] = 0
ConfigMap_meleeAPModifier[409] = 0
ConfigMap_rangedAPModifier[409] = 0
ConfigMap_DamageTaken[409] = 50
ConfigMap_DamageDoneModifier[409] = 0
ConfigMap_hpModifier[409] = 0
ConfigMap_RageFromDamageModifier[409] = 0
ConfigMap_AbsorbModifier[409] = -50
ConfigMap_HealingDoneModifier[409] = -50
ConfigMap_PhysicalDamageTakenModifier[409] = 0

-- Onyxia's Lair [249]
ConfigMap_baseStatModifier[249] = 0
ConfigMap_meleeAPModifier[249] = 0
ConfigMap_rangedAPModifier[249] = 0
ConfigMap_DamageTaken[249] = 40
ConfigMap_DamageDoneModifier[249] = 0
ConfigMap_hpModifier[249] = 0
ConfigMap_RageFromDamageModifier[249] = 0
ConfigMap_AbsorbModifier[249] = -50
ConfigMap_HealingDoneModifier[249] = -50
ConfigMap_PhysicalDamageTakenModifier[249] = 0

-- Blackwing Lair [469]
ConfigMap_baseStatModifier[469] = 0
ConfigMap_meleeAPModifier[469] = 0
ConfigMap_rangedAPModifier[469] = 0
ConfigMap_DamageTaken[469] = 50
ConfigMap_DamageDoneModifier[469] = 0
ConfigMap_hpModifier[469] = 0
ConfigMap_RageFromDamageModifier[469] = 0
ConfigMap_AbsorbModifier[469] = -50
ConfigMap_HealingDoneModifier[469] = -50
ConfigMap_PhysicalDamageTakenModifier[469] = 0

-- Zul Gurub [309]
ConfigMap_baseStatModifier[309] = 0
ConfigMap_meleeAPModifier[309] = 0
ConfigMap_rangedAPModifier[309] = 0
ConfigMap_DamageTaken[309] = 10
ConfigMap_DamageDoneModifier[309] = 0
ConfigMap_hpModifier[309] = 0
ConfigMap_RageFromDamageModifier[309] = 0
ConfigMap_AbsorbModifier[309] = -50
ConfigMap_HealingDoneModifier[309] = -50
ConfigMap_PhysicalDamageTakenModifier[309] = 40

-- Ruins of Ahn'Qiraj [509]
ConfigMap_baseStatModifier[509] = 0
ConfigMap_meleeAPModifier[509] = 0
ConfigMap_rangedAPModifier[509] = 0
ConfigMap_DamageTaken[509] = 30
ConfigMap_DamageDoneModifier[509] = 0
ConfigMap_hpModifier[509] = 0
ConfigMap_RageFromDamageModifier[509] = 0
ConfigMap_AbsorbModifier[509] = -50
ConfigMap_HealingDoneModifier[509] = -50
ConfigMap_PhysicalDamageTakenModifier[509] = 30

-- Temple of Ahn'Qiraj [531]
ConfigMap_baseStatModifier[531] = 0
ConfigMap_meleeAPModifier[531] = 0
ConfigMap_rangedAPModifier[531] = 0
ConfigMap_DamageTaken[531] = 30
ConfigMap_DamageDoneModifier[531] = 0
ConfigMap_hpModifier[531] = 0
ConfigMap_RageFromDamageModifier[531] = 0
ConfigMap_AbsorbModifier[531] = -50
ConfigMap_HealingDoneModifier[531] = -50
ConfigMap_PhysicalDamageTakenModifier[531] = 20

-- Alterac Valley [30]
ConfigMap_baseStatModifier[30] = 0
ConfigMap_meleeAPModifier[30] = 0
ConfigMap_rangedAPModifier[30] = 0
ConfigMap_DamageTaken[30] = -30
ConfigMap_DamageDoneModifier[30] = 0
ConfigMap_hpModifier[30] = 0
ConfigMap_RageFromDamageModifier[30] = 0
ConfigMap_AbsorbModifier[30] = -20
ConfigMap_HealingDoneModifier[30] = -20
ConfigMap_PhysicalDamageTakenModifier[30] = 0

-- Warsong Gulch [489]
ConfigMap_baseStatModifier[489] = 0
ConfigMap_meleeAPModifier[489] = 0
ConfigMap_rangedAPModifier[489] = 0
ConfigMap_DamageTaken[489] = -30
ConfigMap_DamageDoneModifier[489] = 0
ConfigMap_hpModifier[489] = 0
ConfigMap_RageFromDamageModifier[489] = 0
ConfigMap_AbsorbModifier[489] = -20
ConfigMap_HealingDoneModifier[489] = -20
ConfigMap_PhysicalDamageTakenModifier[489] = 0

-- Arathi Basin [529]
ConfigMap_baseStatModifier[529] = 0
ConfigMap_meleeAPModifier[529] = 0
ConfigMap_rangedAPModifier[529] = 0
ConfigMap_DamageTaken[529] = -30
ConfigMap_DamageDoneModifier[529] = 0
ConfigMap_hpModifier[529] = 0
ConfigMap_RageFromDamageModifier[529] = 0
ConfigMap_AbsorbModifier[529] = -20
ConfigMap_HealingDoneModifier[529] = -20
ConfigMap_PhysicalDamageTakenModifier[529] = 0

-- Ring of Trials [559]
ConfigMap_baseStatModifier[559] = 0
ConfigMap_meleeAPModifier[559] = 0
ConfigMap_rangedAPModifier[559] = 0
ConfigMap_DamageTaken[559] = -30
ConfigMap_DamageDoneModifier[559] = 0
ConfigMap_hpModifier[559] = 0
ConfigMap_RageFromDamageModifier[559] = 0
ConfigMap_AbsorbModifier[559] = -20
ConfigMap_HealingDoneModifier[559] = -20
ConfigMap_PhysicalDamageTakenModifier[559] = 0

-- Blade's Edge Arena [562]
ConfigMap_baseStatModifier[562] = 0
ConfigMap_meleeAPModifier[562] = 0
ConfigMap_rangedAPModifier[562] = 0
ConfigMap_DamageTaken[562] = -30
ConfigMap_DamageDoneModifier[562] = 0
ConfigMap_hpModifier[562] = 0
ConfigMap_RageFromDamageModifier[562] = 0
ConfigMap_AbsorbModifier[562] = -20
ConfigMap_HealingDoneModifier[562] = -20
ConfigMap_PhysicalDamageTakenModifier[562] = 0

-- Ruins of Lordaeron [572]
ConfigMap_baseStatModifier[572] = 0
ConfigMap_meleeAPModifier[572] = 0
ConfigMap_rangedAPModifier[572] = 0
ConfigMap_DamageTaken[572] = -30
ConfigMap_DamageDoneModifier[572] = 0
ConfigMap_hpModifier[572] = 0
ConfigMap_RageFromDamageModifier[572] = 0
ConfigMap_AbsorbModifier[572] = -20
ConfigMap_HealingDoneModifier[572] = -20
ConfigMap_PhysicalDamageTakenModifier[572] = 0

-- Dalaran Arena [617]
ConfigMap_baseStatModifier[617] = 0
ConfigMap_meleeAPModifier[617] = 0
ConfigMap_rangedAPModifier[617] = 0
ConfigMap_DamageTaken[617] = -20
ConfigMap_DamageDoneModifier[617] = -30
ConfigMap_hpModifier[617] = 0
ConfigMap_RageFromDamageModifier[617] = 0
ConfigMap_AbsorbModifier[617] = -20
ConfigMap_HealingDoneModifier[617] = -20
ConfigMap_PhysicalDamageTakenModifier[617] = 0

-- Ring of Valor [618]
ConfigMap_baseStatModifier[618] = 0
ConfigMap_meleeAPModifier[618] = 0
ConfigMap_rangedAPModifier[618] = 0
ConfigMap_DamageTaken[618] = -30
ConfigMap_DamageDoneModifier[618] = 0
ConfigMap_hpModifier[618] = 0
ConfigMap_RageFromDamageModifier[618] = 0
ConfigMap_AbsorbModifier[618] = -20
ConfigMap_HealingDoneModifier[618] = -20
ConfigMap_PhysicalDamageTakenModifier[618] = 0

-- These values apply to all maps in Config_DungeonMaps
-- all modifiers are in %
ConfigDungeon.baseStatModifier = 0
ConfigDungeon.meleeAPModifier = -10
ConfigDungeon.rangedAPModifier = -20
ConfigDungeon.DamageTaken = 50
ConfigDungeon.DamageDone = -60
ConfigDungeon.hpModifier = -30
ConfigDungeon.RageFromDamage = 10
ConfigDungeon.Absorb = 0
ConfigDungeon.HealingDone = 0
ConfigDungeon.PhysicalDamageTakenModifier = 0

-- all players in these maps will become debuffed on login, when entering and resurrecting
table.insert(Config_DungeonMaps, 429) -- Dire Maul
table.insert(Config_DungeonMaps, 289) -- Scholomance
table.insert(Config_DungeonMaps, 329) -- Stratholme

-- table.insert(Config_Maps, 229) -- Blackrock Spire
table.insert(Config_Maps, 409) -- Molten Core
table.insert(Config_Maps, 249) -- Onyxia's Lair
table.insert(Config_Maps, 469) -- Blackwing Lair
table.insert(Config_Maps, 509) -- Ruins of Ahn'Qiraj
table.insert(Config_Maps, 531) -- Temple of Ahn'Qiraj
table.insert(Config_Maps, 309) -- Zul Gurub
table.insert(Config_Maps, 30) -- Alterac Valley
table.insert(Config_Maps, 489) -- Warsong Gulch
table.insert(Config_Maps, 529) -- Arathi Basin
table.insert(Config_Maps, 559) -- Ring of Trials
table.insert(Config_Maps, 562) -- Blade's Edge Arena
table.insert(Config_Maps, 572) -- Ruins of Lordaeron
table.insert(Config_Maps, 617) -- Dalaran Arena
table.insert(Config_Maps, 618) -- Ring of Valor

--table.insert(Config_NoWorldBuffMaps, 229) -- Blackrock Spire
table.insert(Config_NoWorldBuffMaps, 409) -- Molten Core
table.insert(Config_NoWorldBuffMaps, 249) -- Onyxia's Lair
table.insert(Config_NoWorldBuffMaps, 469) -- Blackwing Lair
table.insert(Config_NoWorldBuffMaps, 509) -- Ruins of Ahn'Qiraj
table.insert(Config_NoWorldBuffMaps, 531) -- Temple of Ahn'Qiraj
table.insert(Config_NoWorldBuffMaps, 309) -- Zul Gurub

table.insert(Config_WorldBuff, 15366) -- Songflower Serenade
table.insert(Config_WorldBuff, 16609) -- Warchiefs Blessing
table.insert(Config_WorldBuff, 22888) -- Rallying Cry of the Dragonslayer
table.insert(Config_WorldBuff, 24425) -- Spirit of Zandalar
table.insert(Config_WorldBuff, 22817) -- Fengus' Ferocity
table.insert(Config_WorldBuff, 22818) -- Mol'dar's Moxie
table.insert(Config_WorldBuff, 22820) -- Slip'kik's Savvy
table.insert(Config_WorldBuff, 15123) -- Resist Fire from Scarshield Spellbinder

------------------------------------------
-- NO ADJUSTMENTS REQUIRED BELOW THIS LINE
------------------------------------------

local PLAYER_EVENT_ON_LOGIN = 3               -- (event, player)
local PLAYER_EVENT_ON_MAP_CHANGE = 28         -- (event, player)
local PLAYER_EVENT_ON_RESURRECT = 36          -- (event, player)
local PLAYER_EVENT_ON_PET_SPAWNED = 43        -- (event, player, pet)

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

local function zd_shouldRemoveWorldBuff(unit)
    if Config.NoWorldBuffMaps ~= 1 then
        return false
    else
        local mapId = unit:GetMap():GetMapId()
        return has_value(Config_NoWorldBuffMaps, mapId)
    end
end

local function zd_shouldDebuffRaid(player)
    if Config.MapsActive ~= 1 then
        return false
    else
        local mapId = player:GetMap():GetMapId()
        -- hardcoded check for LBRS RDF
        if player:GetGroup() ~= nil then
            if mapId == 229 and player:GetGroup():IsLFGGroup() == true then
                return false
            end
        end
        return has_value(Config_Maps, mapId)
    end
end

local function zd_shouldDebuffRaidPet(pet)
    if Config.MapsActive ~= 1 then
        return false
    else
        local mapId = pet:GetMap():GetMapId()
        -- hardcoded check for LBRS RDF
        if pet:GetOwner():GetGroup() ~= nil then
            if mapId == 229 and pet:GetOwner():GetGroup():IsLFGGroup() == true then
                return false
            end
        end
        return has_value(Config_Maps, mapId)
    end
end

local function zd_shouldDebuffDungeon(player)
    if Config.DungeonActive ~= 1 then
        return false
    else
        --Check for RDF
        if player:GetGroup():IsLFGGroup() == true then
            return false
        end
        local mapId = player:GetMap():GetMapId()
        return has_value(Config_DungeonMaps, mapId)
    end
end

local function zd_shouldDebuffDungeonPet(pet)
    if Config.DungeonActive ~= 1 then
        return false
    else
        --Check for RDF
        if pet:GetOwner():GetGroup():IsLFGGroup() == true then
            return false
        end
        local mapId = pet:GetMap():GetMapId()
        return has_value(Config_DungeonMaps, mapId)
    end
end

local function zd_debuffByMap(player)
    local mapId = player:GetMap():GetMapId()
    if not player:HasAura(Config.BaseStatAPSpell) then
        player:CastCustomSpell(player, Config.BaseStatAPSpell, false, ConfigMap_baseStatModifier[mapId],ConfigMap_meleeAPModifier[mapId],ConfigMap_rangedAPModifier[mapId])
    end
    if not player:HasAura(Config.DamageDoneTakenSpell) then
        player:CastCustomSpell(player, Config.DamageDoneTakenSpell, false, ConfigMap_DamageTaken[mapId],ConfigMap_DamageDoneModifier[mapId])
    end
    if not player:HasAura(Config.HpAuraSpell) then
        player:CastCustomSpell(player, Config.HpAuraSpell, false, ConfigMap_hpModifier[mapId])
    end
    if not player:HasAura(Config.RageFromDamageSpell) then
        player:CastCustomSpell(player, Config.RageFromDamageSpell, false, ConfigMap_RageFromDamageModifier[mapId])
    end
    if not player:HasAura(Config.AbsorbSpell) then
        player:CastCustomSpell(player, Config.AbsorbSpell, false, ConfigMap_AbsorbModifier[mapId])
    end
    if not player:HasAura(Config.HealingDoneSpell) then
        player:CastCustomSpell(player, Config.HealingDoneSpell, false, ConfigMap_HealingDoneModifier[mapId])
    end
    if not player:HasAura(Config.PhysicalDamageTakenSpell) then
        player:CastCustomSpell(player, Config.PhysicalDamageTakenSpell, false, ConfigMap_PhysicalDamageTakenModifier[mapId])
    end
    if Config.VisualSpellRaid ~= nil then
        if not player:HasAura(Config.VisualSpellRaid) then
            player:CastSpell(player, Config.VisualSpellRaid, false)
        end
    end
    player:SendBroadcastMessage(Config.DebuffMessageRaid)
end

local function zd_debuffDungeon(player)
    if not player:HasAura(Config.BaseStatAPSpell) then
        player:CastCustomSpell(player, Config.BaseStatAPSpell, false, ConfigDungeon.baseStatModifier,ConfigDungeon.meleeAPModifier,ConfigDungeon.rangedAPModifier)
    end
    if not player:HasAura(Config.DamageDoneTakenSpell) then
        player:CastCustomSpell(player, Config.DamageDoneTakenSpell, false, ConfigDungeon.DamageTaken,ConfigDungeon.DamageDone)
    end
    if not player:HasAura(Config.HpAuraSpell) then
        player:CastCustomSpell(player, Config.HpAuraSpell, false, ConfigDungeon.hpModifier)
    end
    if not player:HasAura(Config.RageFromDamageSpell) then
        player:CastCustomSpell(player, Config.RageFromDamageSpell, false, ConfigDungeon.RageFromDamage)
    end
    if not player:HasAura(Config.AbsorbSpell) then
        player:CastCustomSpell(player, Config.AbsorbSpell, false, ConfigDungeon.AbsorbModifier)
    end
    if not player:HasAura(Config.HealingDoneSpell) then
        player:CastCustomSpell(player, Config.HealingDoneSpell, false, ConfigDungeon.HealingDoneModifier)
    end
    if not player:HasAura(Config.PhysicalDamageTakenSpell) then
        player:CastCustomSpell(player, Config.PhysicalDamageTakenSpell, false, ConfigDungeon.PhysicalDamageTakenModifier)
    end
    if Config.VisualSpellDungeon ~= nil then
        if not player:HasAura(Config.VisualSpellDungeon) then
            player:CastSpell(player, Config.VisualSpellDungeon, false)
        end
    end
    player:SendBroadcastMessage(Config.DebuffMessageDungeon)
end

local function zd_debuffByMapPet(pet)
    local mapId = pet:GetMap():GetMapId()
    pet:CastCustomSpell(pet, Config.DamageDoneTakenSpell, false, ConfigMap_DamageTaken[mapId],ConfigMap_DamageDoneModifier[mapId])
end

local function zd_debuffPetDungeon(pet)
    pet:CastCustomSpell(pet, Config.DamageDoneTakenSpell, false, ConfigDungeon.DamageTaken,ConfigDungeon.DamageDone)
end

local function zd_removeWorldbuffs(player)
    for index, value in ipairs(Config_WorldBuff) do
        player:RemoveAura(tonumber(value))
    end
end

local function zd_removeWorldbuffsPet(pet)
    for index, value in ipairs(Config_WorldBuff) do
        pet:RemoveAura(tonumber(value))
    end
end

local function zd_removeDebuff(player)
    player:RemoveAura(Config.BaseStatAPSpell)
    player:RemoveAura(Config.DamageDoneTakenSpell)
    player:RemoveAura(Config.HpAuraSpell)
    player:RemoveAura(Config.RageFromDamageSpell)
    player:RemoveAura(Config.AbsorbSpell)
    player:RemoveAura(Config.HealingDoneSpell)
    player:RemoveAura(Config.PhysicalDamageTakenSpell)
    if Config.VisualSpellRaid ~= nil then
        player:RemoveAura(Config.VisualSpellRaid)
    end
    if Config.VisualSpellDungeon ~= nil then
        player:RemoveAura(Config.VisualSpellDungeon)
    end
end

local function zd_removeDebuffPet(pet)
    pet:RemoveAura(Config.DamageDoneTakenSpell)
end

local function zd_checkPlayerMap(player)
    if zd_shouldRemoveWorldBuff(player) then
        zd_removeWorldbuffs(player)
    end
    if zd_shouldDebuffRaid(player) then
        zd_removeDebuff(player)
        zd_debuffByMap(player)
    elseif zd_shouldDebuffDungeon(player) then
        zd_removeDebuff(player)
        zd_debuffDungeon(player)
    else
        zd_removeDebuff(player)
    end
end

local function zd_checkPetMap(pet)
    if zd_shouldRemoveWorldBuff(pet) then
        zd_removeWorldbuffsPet(pet)
    end
    if zd_shouldDebuffRaidPet(pet) then
        zd_removeDebuffPet(pet)
        zd_debuffByMapPet(pet)
    elseif zd_shouldDebuffDungeonPet(pet) then
        zd_removeDebuffPet(pet)
        zd_debuffPetDungeon(pet)
    else
        zd_removeDebuffPet(pet)
    end
end

local function zd_checkMapPetSpawned(event, player, pet)
    zd_checkPetMap(pet)
end

local function zd_checkMapLogin(event, player)
    zd_checkPlayerMap(player)
end

local function zd_checkMapUpdate(event, player, newZone, newArea)
    zd_checkPlayerMap(player)
end

local function zd_checkMapResurrect(event, player)
    zd_checkPlayerMap(player)
end

if Config.MapsActive == 1 or Config.DungeonActive == 1 or Config.NoWorldBuffMaps == 1 then
    RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, zd_checkMapLogin)
    RegisterPlayerEvent(PLAYER_EVENT_ON_MAP_CHANGE, zd_checkMapUpdate)
    RegisterPlayerEvent(PLAYER_EVENT_ON_PET_SPAWNED, zd_checkMapPetSpawned)
    RegisterPlayerEvent(PLAYER_EVENT_ON_RESURRECT,zd_checkMapResurrect)
end
