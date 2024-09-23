local NPC_ID_KARA = 90008
local GOSSIP_ICON = 0
local REFRESH_INTERVAL = 3000 
local MAP_ID = 532
local MINIMUM_LEVEL = 61
local MAXIMUM_LEVEL = 80
local CREATURE_SPELL_ID = 108000
local PLAYER_SPELL_ID = 108001
local SPELL_TO_CAST = 19484

local playerEvents = {}

local function ApplyTimewalkingBuff(player, apply)
    local range = 100
    local creaturesInRange = player:GetCreaturesInRange(range)
    local playerLevel = player:GetLevel()

    for _, creature in ipairs(creaturesInRange) do
        local creatureID = creature:GetEntry()

        if creature:GetInstanceId() == player:GetInstanceId() and ((creatureID < 70000 or creatureID > 82000) and (creatureID < 84000 or creatureID > 88999)) then
            if apply then
                if not creature:HasAura(CREATURE_SPELL_ID) then
                    creature:SetData("OriginalLevel", creature:GetLevel())
                    creature:AddAura(CREATURE_SPELL_ID, creature)
                    creature:SetLevel(playerLevel + 2)
                end
            else
                local originalLevel = creature:GetData("OriginalLevel")
                if originalLevel == nil then
                    originalLevel = creature:GetLevel()
                end
                creature:RemoveAura(CREATURE_SPELL_ID)
                creature:SetLevel(originalLevel)
            end
        end
    end

    if apply then
        if not player:HasAura(PLAYER_SPELL_ID) then
            player:AddAura(PLAYER_SPELL_ID, player)
        end
    else
        player:RemoveAura(PLAYER_SPELL_ID)
    end
end

local function RefreshTimewalkingBuff(eventId, delay, repeats, player)
    print("Refresh Karazhan Auras")

    if player:GetMapId() ~= MAP_ID then
        local playerEventId = playerEvents[player:GetGUID()]
        if playerEventId then
            player:RemoveEvents(playerEventId)
            playerEvents[player:GetGUID()] = nil
            ApplyTimewalkingBuff(player, false)
            player:SendBroadcastMessage("You have abandonded your Level 60 Karazhan event.")
        end
        return
    end

    if player:HasAura(PLAYER_SPELL_ID) then
        local aura = player:GetAura(CREATURE_SPELL_ID)
        if aura then
            aura:SetStackAmount(1)
        end

        local range = 100
        local creaturesInRange = player:GetCreaturesInRange(range)

     for _, creature in ipairs(creaturesInRange) do
        local creatureID = creature:GetEntry()
        if creature:GetInstanceId() == player:GetInstanceId() and ((creatureID < 70000 or creatureID > 82000) and (creatureID < 84000 or creatureID > 88999)) then
            creature:SetLevel(62)
        end
    end
    end

    ApplyTimewalkingBuff(player, true)
end

local function Kara_OnGossipHello(event, player, object)
    local playerLevel = player:GetLevel()
    if playerLevel >= MINIMUM_LEVEL and playerLevel <= MAXIMUM_LEVEL then
        player:SendBroadcastMessage("Your level is too high to interact with this event.")
        return
    end
    if not player:HasAura(PLAYER_SPELL_ID) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(GOSSIP_ICON, "Level 60 Karazhan", 1, 1)
        player:GossipSendMenu(1, object, 1)

        local mapId = player:GetMapId()
        local x, y, z, o = player:GetLocation()

        local group = player:GetGroup()
        if group then
            local members = group:GetMembers()
            for i, member in ipairs(members) do
                member:Teleport(mapId, x, y, z, o)
                member:CastSpell(member, SPELL_TO_CAST, true)
            end
        end
    end
end

local function Kara_OnGossipSelect(event, player, object, sender, intid, code)
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
        else
            local eventId = player:RegisterEvent(RefreshTimewalkingBuff, REFRESH_INTERVAL, 0, player)
            playerEvents[player:GetGUID()] = eventId
            ApplyTimewalkingBuff(player, true)
        end
        player:GossipComplete()
    end
end

local function Kara_OnPlayerResurrect(event, player)
    if player:HasAura(PLAYER_SPELL_ID) and player:GetMapId() == MAP_ID then
        ApplyTimewalkingBuff(player, true)
    end
end

local function Kara_OnPlayerLeaveMap(event, player)
    if player:GetMapId() ~= MAP_ID and player:HasAura(PLAYER_SPELL_ID) then
        player:RemoveEvents(true)
        playerEvents[player:GetGUID()] = nil
        ApplyTimewalkingBuff(player, false)
        player:SendBroadcastMessage("You have left the dungeon. Timewalking has been reset.")
    end
end


RegisterPlayerEvent(28, Kara_OnPlayerLeaveMap)
RegisterPlayerEvent(36, Kara_OnPlayerResurrect)
RegisterCreatureGossipEvent(NPC_ID_KARA, 1, Kara_OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID_KARA, 2, Kara_OnGossipSelect)
