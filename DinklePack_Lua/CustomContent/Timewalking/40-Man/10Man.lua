local NPC_ID_TEN = 90010
local GOSSIP_ICON = 0
local REFRESH_INTERVAL = 3000 
local MAP_IDs = {409, 249, 533, 37, 531}  -- Add all your map IDs here
local MINIMUM_LEVEL = 61
local MAXIMUM_LEVEL = 80
local CREATURE_SPELL_ID = 80022
local PLAYER_SPELL_ID = 108001
local ALL_PLAYER_SPELL_ID = 108002  -- New aura for all players in the dungeon
local SPELL_TO_CAST = 19484

local MAX_GROUP_MEMBERS = 10  -- Maximum allowed group members

local NUM_MAP_IDS = #MAP_IDs
local MAXIMUM_LEVEL_PLUS_ONE = MAXIMUM_LEVEL + 1

local function playerInCorrectMap(player)
    local playerMapId = player:GetMapId()
    for i = 1, NUM_MAP_IDS do
        if playerMapId == MAP_IDs[i] then
            return true
        end
    end
    return false
end

local playerEvents = {}

local function IsEventActive()
    for _, eventActive in pairs(playerEvents) do
        if eventActive then
            return true
        end
    end
    return false
end

local function ApplyAllPlayerBuff(player, apply)
    local range = 70
    local playersInRange = player:GetPlayersInRange(range)

    for _, playerInRange in ipairs(playersInRange) do
        if playerInCorrectMap(playerInRange) then
            if apply then
                if not playerInRange:HasAura(ALL_PLAYER_SPELL_ID) then
                    playerInRange:AddAura(ALL_PLAYER_SPELL_ID, playerInRange)
                end
            else
                playerInRange:RemoveAura(ALL_PLAYER_SPELL_ID)
            end
        end
    end
end

local function RemoveHighLevelPlayersFromGroup(player)
    local group = player:GetGroup()
    if group then
        local members = group:GetMembers()
        for i, member in ipairs(members) do
            if member:GetLevel() >= MINIMUM_LEVEL then
                member:RemoveFromGroup()
                member:SendBroadcastMessage("You have been removed from the group due to your level.")
            end
        end
    end
end

local function ApplyTimewalkingBuff(player, apply)
    local range = 200
    local creaturesInRange = player:GetCreaturesInRange(range)

    for _, creature in ipairs(creaturesInRange) do
        local creatureID = creature:GetEntry()

        if creature:GetInstanceId() == player:GetInstanceId() and ((creatureID < 70000 or creatureID > 82000) and (creatureID < 84000 or creatureID > 88999)) then
            if apply then
                if not creature:HasAura(CREATURE_SPELL_ID) then
                    creature:AddAura(CREATURE_SPELL_ID, creature)
                end
            else
                creature:RemoveAura(CREATURE_SPELL_ID)
            end
        end
    end

    if apply then
        if not player:HasAura(PLAYER_SPELL_ID) then
            player:AddAura(PLAYER_SPELL_ID, player)
            player:AddAura(ALL_PLAYER_SPELL_ID, player)
        end
    else
        player:RemoveAura(PLAYER_SPELL_ID)
        player:RemoveAura(ALL_PLAYER_SPELL_ID)
    end
end

local function RefreshTimewalkingBuff(eventId, delay, repeats, player)
    print("Refresh 10-man Auras")  

    if not playerInCorrectMap(player) then
        local playerEventId = playerEvents[player:GetGUID()]
        if playerEventId then
            player:RemoveEvents(playerEventId)
            playerEvents[player:GetGUID()] = nil
            ApplyTimewalkingBuff(player, false)
            ApplyAllPlayerBuff(player, false)
            player:SendBroadcastMessage("You have abandonded your 10-man event.")
        end
        return
    end

    if player:HasAura(PLAYER_SPELL_ID) then
        local aura = player:GetAura(CREATURE_SPELL_ID)
        if aura then
            aura:SetStackAmount(1)
        end
    end

    RemoveHighLevelPlayersFromGroup(player)

    ApplyTimewalkingBuff(player, true)
end

local function OnGossipHelloTen(event, player, object)
    local playerLevel = player:GetLevel()
    if playerLevel >= MINIMUM_LEVEL and playerLevel <= MAXIMUM_LEVEL_PLUS_ONE then
        player:SendBroadcastMessage("Your level is too high to interact with this event.")
        return
    end
    if not player:HasAura(ALL_PLAYER_SPELL_ID) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON, "10-man Scaled Raid", 1, 1)
        player:GossipSendMenu(1, object, 1)
    end
end

local function OnGossipSelectTen(event, player, object, sender, intid, code)
    if intid == 1 then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON, "Please ensure all raid members are present prior to starting the event. As raid leader, should you leave the raid at any point, the event will cease to continue and scaling will no longer persist.\n\nProceed to speak with me again if you are prepared and wish to activate this event.", 1, 2)
        player:GossipSendMenu(1, object, 2)
    elseif intid == 2 then
        if player:HasAura(PLAYER_SPELL_ID) then
            local playerEventId = playerEvents[player:GetGUID()]
            if playerEventId then
                player:RemoveEvents(playerEventId)
                playerEvents[player:GetGUID()] = nil
            end
            ApplyTimewalkingBuff(player, false)
            ApplyAllPlayerBuff(player, false)
        else
            local eventId = player:RegisterEvent(RefreshTimewalkingBuff, REFRESH_INTERVAL, 0, player)
            playerEvents[player:GetGUID()] = eventId
            ApplyTimewalkingBuff(player, true)
            ApplyAllPlayerBuff(player, true)
        end
        player:GossipComplete()
    end
end

local function OnPlayerResurrectTen(event, player)
    if player:HasAura(108002) and playerInCorrectMap(player) then
        ApplyTimewalkingBuff(player, true)
    end
end

local function OnPlayerLeaveMapTen(event, player)
    if not playerInCorrectMap(player) and player:HasAura(108002) then
        player:RemoveEvents(true)
        playerEvents[player:GetGUID()] = nil
        ApplyTimewalkingBuff(player, false)
        ApplyAllPlayerBuff(player, false)

        player:SendBroadcastMessage("You have left the dungeon. Timewalking has been reset.")
    end
end

RegisterPlayerEvent(28, OnPlayerLeaveMapTen)
RegisterPlayerEvent(36, OnPlayerResurrectTen)
RegisterCreatureGossipEvent(NPC_ID_TEN, 1, OnGossipHelloTen)
RegisterCreatureGossipEvent(NPC_ID_TEN, 2, OnGossipSelectTen)
