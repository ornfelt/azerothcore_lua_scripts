--[[
    GameMaster UI - Player Spell Management Handlers Sub-Module
    
    This module handles spell management for specific players:
    - Get player spells from database
    - Submit spellbook data
    - Learn/unlearn spells for players
    - Cast operations on specific players
]]--

local PlayerSpellManagementHandlers = {}

-- Module dependencies (will be injected)
local GameMasterSystem, Config, Utils, Database, DatabaseHelper

function PlayerSpellManagementHandlers.RegisterHandlers(gms, config, utils, database, dbHelper)
    GameMasterSystem = gms
    Config = config
    Utils = utils
    Database = database
    DatabaseHelper = dbHelper
    
    -- Register player spell management handlers
    GameMasterSystem.getPlayerSpells = PlayerSpellManagementHandlers.getPlayerSpells
    GameMasterSystem.submitPlayerSpellbook = PlayerSpellManagementHandlers.submitPlayerSpellbook
    GameMasterSystem.playerSpellCastOnSelf = PlayerSpellManagementHandlers.playerSpellCastOnSelf
    GameMasterSystem.playerSpellCastOnTarget = PlayerSpellManagementHandlers.playerSpellCastOnTarget
    GameMasterSystem.playerSpellCastFromPlayer = PlayerSpellManagementHandlers.playerSpellCastFromPlayer
    GameMasterSystem.playerSpellUnlearn = PlayerSpellManagementHandlers.playerSpellUnlearn
    GameMasterSystem.playerSpellLearn = PlayerSpellManagementHandlers.playerSpellLearn
end

-- Player spell management functions (managing spells for other players)
function PlayerSpellManagementHandlers.getPlayerSpells(player, targetName)
    -- Validate GM permissions
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    -- Always use database approach for consistency
    -- First, get the character GUID
    local guidQuery = CharDBQuery(string.format(
        "SELECT guid FROM characters WHERE name = '%s'",
        targetName
    ))
    
    if not guidQuery then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found in database.")
        AIO.Handle(player, "GameMasterSystem", "receiveSpellString", "")
        return
    end
    
    local characterGuid = guidQuery:GetUInt32(0)
    
    -- Query both character_spell and character_talent tables
    local spellQuery = string.format([[
        SELECT 
            cs.spell as spell_id,
            cs.active,
            cs.disabled,
            'spell' as spell_type
        FROM character_spell cs
        WHERE cs.guid = %d
        
        UNION ALL
        
        SELECT 
            ct.spell as spell_id,
            1 as active,
            0 as disabled,
            'talent' as spell_type
        FROM character_talent ct
        WHERE ct.guid = %d
        
        ORDER BY spell_id ASC
    ]], characterGuid, characterGuid)
    
    local result = CharDBQuery(spellQuery)
    local spellStrings = {}
    local spellCount = 0
    local spellIds = {} -- Track spell IDs to avoid duplicates
    
    if result then
        repeat
            local spellId = result:GetUInt32(0)
            local active = result:GetUInt32(1)
            local disabled = result:GetUInt32(2)
            local spellType = result:GetString(3)
            
            -- Skip if we've already processed this spell ID (avoid duplicates)
            if not spellIds[spellId] then
                spellIds[spellId] = true
                
                -- Get spell name and rank from world database
                local spellInfoQuery = WorldDBQuery(string.format(
                    "SELECT spellName0 FROM spell WHERE id = %d",
                    spellId
                ))
                
                local spellName = "Unknown"
                local spellRank = ""
                
                if spellInfoQuery then
                    spellName = spellInfoQuery:GetString(0) or "Unknown"
                    spellRank = ""
                    -- Clean up the strings to avoid delimiter issues
                    spellName = spellName:gsub("[|;]", " ")
                    spellRank = spellRank:gsub("[|;]", " ")
                end
                
                -- Format: id|name|rank|type|active|disabled
                local spellString = string.format("%d|%s|%s|%s|%d|%d", 
                    spellId,
                    spellName,
                    spellRank,
                    spellType,
                    active,
                    disabled
                )
                
                table.insert(spellStrings, spellString)
                spellCount = spellCount + 1
            end
            
        until not result:NextRow()
    end
    
    -- Send spell data to client
    if #spellStrings > 0 then
        local spellDataString = table.concat(spellStrings, ";")
        AIO.Handle(player, "GameMasterSystem", "receiveSpellString", spellDataString)
        Utils.sendMessage(player, "success", string.format("Loaded %d spells for %s", spellCount, targetName))
    else
        AIO.Handle(player, "GameMasterSystem", "receiveSpellString", "")
        Utils.sendMessage(player, "info", string.format("No spells found for %s", targetName))
    end
end

-- Handler for receiving spellbook data from client
function PlayerSpellManagementHandlers.submitPlayerSpellbook(player, playerName, spellData)
    -- Validate that the player is submitting their own spellbook
    if player:GetName() ~= playerName then
        Utils.sendMessage(player, "error", "You can only submit your own spellbook.")
        return
    end
    
    -- Process and send the spellbook data
    if type(spellData) == "table" and #spellData > 0 then
        -- Build a simple string with spell IDs and names separated by delimiters
        local spellStrings = {}
        for i, spell in ipairs(spellData) do
            if type(spell) == "table" and spell.id then
                -- Format: id|name|rank
                local spellString = string.format("%d|%s|%s", 
                    tonumber(spell.id) or 0,
                    (spell.name or "Unknown"):gsub("|", "-"),  -- Replace pipes in names
                    (spell.rank or ""):gsub("|", "-"))
                table.insert(spellStrings, spellString)
            end
        end
        
        Utils.sendMessage(player, "success", string.format("Received %d spells from your spellbook.", #spellStrings))
        
        -- Send as a single delimited string
        if #spellStrings > 0 then
            local combinedString = table.concat(spellStrings, ";")
            AIO.Handle(player, "GameMasterSystem", "receiveSpellString", combinedString)
        else
            Utils.sendMessage(player, "error", "Failed to process spell data.")
        end
    else
        Utils.sendMessage(player, "error", "Failed to read spellbook data.")
    end
end

-- Cast spell on player (makes player cast on themselves)
function PlayerSpellManagementHandlers.playerSpellCastOnSelf(player, targetName, spellId)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    targetPlayer:CastSpell(targetPlayer, spellId, true)
    Utils.sendMessage(player, "success", string.format("Made %s cast spell %d on themselves.", targetName, spellId))
end

-- Cast spell on target (makes player cast on their target)
function PlayerSpellManagementHandlers.playerSpellCastOnTarget(player, targetName, spellId)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    local target = targetPlayer:GetSelection()
    if target then
        targetPlayer:CastSpell(target, spellId, true)
        Utils.sendMessage(player, "success", string.format("Made %s cast spell %d on their target.", targetName, spellId))
    else
        Utils.sendMessage(player, "warning", string.format("%s has no target selected.", targetName))
    end
end

-- Cast from player (player casts on GM)
function PlayerSpellManagementHandlers.playerSpellCastFromPlayer(player, targetName, spellId)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    targetPlayer:CastSpell(player, spellId, true)
    Utils.sendMessage(player, "success", string.format("Made %s cast spell %d on you.", targetName, spellId))
end

-- Unlearn spell from player
function PlayerSpellManagementHandlers.playerSpellUnlearn(player, targetName, spellId)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    if targetPlayer:HasSpell(spellId) then
        targetPlayer:RemoveSpell(spellId)
        Utils.sendMessage(player, "success", string.format("Removed spell %d from %s.", spellId, targetName))
        targetPlayer:SendBroadcastMessage(string.format("Staff %s removed a spell from you.", player:GetName()))
        
        -- Force save to database and send updated spell list
        targetPlayer:SaveToDB()
        
        -- Add a small delay to ensure database is updated, then send refreshed spell list
        local function sendUpdatedSpells()
            PlayerSpellManagementHandlers.getPlayerSpells(player, targetName)
        end
        
        -- Create a delayed call (0.1 seconds should be enough for DB update)
        CreateLuaEvent(sendUpdatedSpells, 100, 1)
    else
        Utils.sendMessage(player, "warning", string.format("%s doesn't know spell %d.", targetName, spellId))
    end
end

-- Make player learn a spell
function PlayerSpellManagementHandlers.playerSpellLearn(player, targetName, spellId)
    if player:GetGMRank() < 2 then
        Utils.sendMessage(player, "error", "You do not have permission to use this command.")
        return
    end
    
    local targetPlayer = GetPlayerByName(targetName)
    if not targetPlayer then
        Utils.sendMessage(player, "error", "Player '" .. targetName .. "' not found or offline.")
        return
    end
    
    if targetPlayer:HasSpell(spellId) then
        Utils.sendMessage(player, "warning", string.format("%s already knows spell %d.", targetName, spellId))
    else
        targetPlayer:LearnSpell(spellId)
        Utils.sendMessage(player, "success", string.format("Taught spell %d to %s.", spellId, targetName))
        targetPlayer:SendBroadcastMessage(string.format("Staff %s taught you a new spell.", player:GetName()))
        
        -- Force save to database and send updated spell list
        targetPlayer:SaveToDB()
        
        -- Add a small delay to ensure database is updated, then send refreshed spell list
        local function sendUpdatedSpells()
            PlayerSpellManagementHandlers.getPlayerSpells(player, targetName)
        end
        
        -- Create a delayed call (0.1 seconds should be enough for DB update)
        CreateLuaEvent(sendUpdatedSpells, 100, 1)
    end
end

return PlayerSpellManagementHandlers