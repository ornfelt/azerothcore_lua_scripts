dofile("lua_scripts/prestige_and_spell_choice_config.lua")
-- Configurable Chromie location messages
local CHROMIE_LOCATION_HORDE = CONFIG.CHROMIE_LOCATION_HORDE
local CHROMIE_LOCATION_ALLIANCE = CONFIG.CHROMIE_LOCATION_ALLIANCE
-- Check if the player is in draft state
local function IsPlayerInDraft(player)
    local guid = player:GetGUIDLow()
    local query = CharDBQuery("SELECT draft_state FROM prestige_stats WHERE player_id = " .. guid)
    return query and query:GetUInt32(0) == 1
end

-- Apply custom power values
local function ApplyDraftPowerTypes(player)
    if not player or not player:IsInWorld() then return end

    player:SetMaxPower(1, 100)  -- Rage
    player:SetPower(100, 1)
    player:SetMaxPower(3, 100)  -- Energy
    player:SetPower(100, 3)
    player:SetPowerType(1)  -- Force Rage display
    player:SetPower(player:GetMaxPower(0), 0)  -- Fill mana

    -- print("[Prestige] Draft power types reapplied for:", player:GetName())
end

-- Track ticking players
local draftTickerGUIDs = {}

local function StartDraftPowerTicker(player)
    local guid = player:GetGUIDLow()
    if draftTickerGUIDs[guid] then return end  -- Already ticking

    local eventId = CreateLuaEvent(function()
        local p = GetPlayerByGUID(guid)
        if not p or not p:IsInWorld() then
            RemoveEventById(draftTickerGUIDs[guid])
            draftTickerGUIDs[guid] = nil
            return
        end

        p:SetPowerType(1)  -- Force Rage display
    end, 2000, 0)

    draftTickerGUIDs[guid] = eventId
end

-- Give title for prestige level
local function GivePrestigeTitle(guid, prestigeLevel)
    local player = GetPlayerByGUID(guid)
end

-- On login: ensure DB row, give title, maybe start ticker
local function EnsurePrestigeEntry(_, player)
    local guid = player:GetGUIDLow()
    local query = CharDBQuery("SELECT prestige_level, draft_state FROM prestige_stats WHERE player_id = " .. guid)

    if query then
        local prestigeLevel = query:GetUInt32(0)
        local draftState = query:GetUInt32(1)
        
    if player then
        local titleId = CONFIG.PrestigeTitles[prestigeLevel]
        if titleId and not player:HasTitle(titleId) then
            player:SetKnownTitle(titleId)
        end
    end
        CreateLuaEvent(function()
            local p = GetPlayerByGUID(guid)
            if not p then return end

            -- Always assign prestige title
            GivePrestigeTitle(guid, prestigeLevel)

            -- Sync draft title 535
            local hasTitle = p:HasTitle(535)
            if draftState == 1 then
                if not hasTitle then
                    p:SetKnownTitle(535)
                end
                ApplyDraftPowerTypes(p)
                StartDraftPowerTicker(p)
            elseif hasTitle then
                p:UnsetKnownTitle(535)
            end
        end, 3000, 1)

    else
        local class = player:GetClass()
        CharDBExecute("INSERT INTO prestige_stats (player_id, prestige_level, draft_state, stored_class) VALUES (" .. guid .. ", 0, 0, " .. class .. ")")
    end
end


-- Apply draft state if needed
local function OnRebuildEvent(_, player)
    if IsPlayerInDraft(player) then
        ApplyDraftPowerTypes(player)
        StartDraftPowerTicker(player)
    end
end
local function OnPlayerLogout(_, player)
    local guid = player:GetGUIDLow()
    if draftTickerGUIDs[guid] then
        RemoveEventById(draftTickerGUIDs[guid])
        draftTickerGUIDs[guid] = nil
    end
    if spellChoicesPerPlayer then
        spellChoicesPerPlayer[guid] = nil
    end

    if draftAddonReady then
        draftAddonReady[guid] = nil
    end

    if justBlockedSpells then
        justBlockedSpells[guid] = nil
    end
end

local function OnLevelUp(event, player, oldLevel)
    if player:GetLevel() == 70 then
        local factionGroup = player:GetTeam()  -- 0 = Alliance, 1 = Horde
        local locationMsg = (factionGroup == 1) and CHROMIE_LOCATION_HORDE or CHROMIE_LOCATION_ALLIANCE

        local fullMessage = "|cffffcc00You have reached level 70!|r You can now access |cffff8800Prestige|r and |cff00ccffPrestige Draft Mode|r. " .. locationMsg
        player:SendAreaTriggerMessage(fullMessage)
    end
end

-- Register only valid events
RegisterPlayerEvent(4, OnPlayerLogout)
RegisterPlayerEvent(13, OnLevelUp)  -- 13 = PLAYER_EVENT_ON_LEVEL_CHANGE
RegisterPlayerEvent(3, EnsurePrestigeEntry)   -- On login
RegisterPlayerEvent(13, OnRebuildEvent)       -- On level change
RegisterPlayerEvent(28, OnRebuildEvent)       -- On map change
RegisterPlayerEvent(35, OnRebuildEvent)       -- On repop
RegisterPlayerEvent(36, OnRebuildEvent)       -- On resurrect
RegisterPlayerEvent(5, OnRebuildEvent)        -- On spell cast (catches form/stealth)
RegisterPlayerEvent(33, OnRebuildEvent)       -- On enter combat
RegisterPlayerEvent(34, OnRebuildEvent)       -- On leave combat


