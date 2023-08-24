local NPC_ID = 90005
local GOSSIP_ICON = 0
local MAX_DIFFICULTY_LEVEL = 10 
local REFRESH_INTERVAL = 1000 

-- Add your custom stack amounts for specific map IDs and level brackets here. These are low level multipliers for creatures in lower level dungeons.
local customStackAmounts = {
    [36] = { --Deadmines
        {min = 20, max = 40, stacks = 10},
        {min = 41, max = 50, stacks = 15},
        {min = 51, max = 59, stacks = 20},
        {min = 60, max = 69, stacks = 35},
        {min = 70, max = 79, stacks = 55},
        {min = 80, max = 80, stacks = 80},
    },
    [245] = { --Fake  Map ID 
        {min = 20, max = 40, stacks = 15},
        {min = 41, max = 50, stacks = 30},
        {min = 51, max = 59, stacks = 45},
        {min = 60, max = 69, stacks = 90},
        {min = 70, max = 79, stacks = 120},
        {min = 80, max = 80, stacks = 180},
    },
    -- Add more map IDs and level brackets as needed
}

-- Function to get the custom stack amount based on the player's level and map ID
local function GetCustomStackAmount(playerLevel, mapId)
    local levelBracket = customStackAmounts[mapId]
    if not levelBracket then
        return nil
    end

    for _, bracket in ipairs(levelBracket) do
        if playerLevel >= bracket.min and playerLevel <= bracket.max then
            return bracket.stacks
        end
    end

    return nil
end

local playerEvents = {}
local creatureAuraStacks = {}

local function IsCreatureInDungeon(creature, player)
    return creature:GetInstanceId() == player:GetInstanceId() and (creature:GetEntry() < 70000 or creature:GetEntry() > 82000)
end

local function ApplyAndRefreshDifficultyAura(player, auraSpellId, stacks, shouldApply)
    local range = 100000
    local creaturesInRange = player:GetCreaturesInRange(range)
    local playerLevel = player:GetLevel()
    local mapId = player:GetMapId()
    local selectedDifficulty = player:GetData("SelectedDifficulty") or 0
    local difficultyMultiplier = 1.08 ^ selectedDifficulty

    for _, creature in ipairs(creaturesInRange) do
        if IsCreatureInDungeon(creature, player) then
            local initialCreatureLevel = creature:GetLevel()
            local initialLevelDifference = math.abs(initialCreatureLevel - playerLevel)

            local stackAmount = 0
            creature:SetLevel(playerLevel + 3)

            if auraSpellId == 107077 then
                stackAmount = math.min(stacks, 255)
            elseif auraSpellId == 107078 or auraSpellId == 107079 then
                local customStacks = GetCustomStackAmount(playerLevel, mapId)
                if customStacks then
                    stackAmount = customStacks * difficultyMultiplier
                    if stackAmount % 1 > 0 then
                        -- round up if uneven number
                        stackAmount = math.ceil(stackAmount)
                    end
                end
            end

            local aura = creature:GetAura(auraSpellId)
            if stackAmount > 0 then
                if not aura then
                    aura = creature:AddAura(auraSpellId, creature)
                end
                aura:SetStackAmount(stackAmount)
            elseif aura then
                creature:RemoveAura(auraSpellId)
            end
        end
    end
end

local function RefreshDifficultyAura(eventId, delay, repeats, player)
    local selectedDifficulty = player:GetData("SelectedDifficulty")
    if selectedDifficulty then
        ApplyAndRefreshDifficultyAura(player, 107077, selectedDifficulty, false)
        ApplyAndRefreshDifficultyAura(player, 107078, 0, false)
        ApplyAndRefreshDifficultyAura(player, 107079, 0, false)
    end
end

local function OnGossipHello(event, player, object)
    player:GossipClearMenu()
    player:GossipMenuAddItem(GOSSIP_ICON, "Select Difficulty Level", 1, 1)
    player:GossipSendMenu(1, object)
end

local function OnGossipSelect(event, player, object, sender, intid, code)
    if intid == 1 then
        player:GossipClearMenu()
        for i = 1, MAX_DIFFICULTY_LEVEL do
            local buttonText = "Select Difficulty Level " .. tostring(i)
            player:GossipMenuAddItem(GOSSIP_ICON, buttonText, 1, i + 1)
        end
        player:GossipSendMenu(2, object)
    elseif intid >= 2 and intid <= 1 + MAX_DIFFICULTY_LEVEL then
        local selectedDifficulty = intid - 1
        player:SetData("SelectedDifficulty", selectedDifficulty)
        player:SetData("TargetMapId", player:GetMapId())

        local eventId = player:RegisterEvent(RefreshDifficultyAura, REFRESH_INTERVAL, 0, player)
        playerEvents[player:GetGUID()] = eventId

        ApplyAndRefreshDifficultyAura(player, 107077, selectedDifficulty, true)

        player:AddAura(107080, player)

        player:GossipComplete()
    end
end

local function OnPlayerLeave(event, player)
   if player:HasAura(107080) then 
        local instanceId = player:GetData("TargetMapId")
        player:RemoveEvents()
        player:UnbindInstance(instanceId)
        player:SetData("SelectedDifficulty", nil)
        creatureAuraStacks = {}
        player:RemoveAura(107080)
        player:SendBroadcastMessage("|cffff0000Leaving the Mythic Plus Dungeon has reset your progression!|r")
    end
end



local function OnPlayerDeath(event, killer, player)
    local selectedDifficulty = player:GetData("SelectedDifficulty")
    if selectedDifficulty then
        ApplyAndRefreshDifficultyAura(player, 107077, selectedDifficulty, true)
        ApplyAndRefreshDifficultyAura(player, 107078, 0, true)
        ApplyAndRefreshDifficultyAura(player, 107079, 0, true)
    end
end

local function OnPlayerResurrect(event, player)
    local selectedDifficulty = player:GetData("SelectedDifficulty")
    if selectedDifficulty and selectedDifficulty > 0 then
        ApplyAndRefreshDifficultyAura(player, 107077, selectedDifficulty, true)
        ApplyAndRefreshDifficultyAura(player, 107078, 0, true)
        ApplyAndRefreshDifficultyAura(player, 107079, 0, true)
        local eventId = player:RegisterEvent(RefreshDifficultyAura, REFRESH_INTERVAL, 0, player)
        playerEvents[player:GetGUID()] = eventId
    end
end


local function OnPlayerEnterCombat(event, player, enemy)
    local selectedDifficulty = player:GetData("SelectedDifficulty")
    if selectedDifficulty then
        ApplyAndRefreshDifficultyAura(player, 107077, selectedDifficulty, true)
        ApplyAndRefreshDifficultyAura(player, 107078, 0, true)
        ApplyAndRefreshDifficultyAura(player, 107079, 0, true)
    end
end

RegisterPlayerEvent(28, OnPlayerLeave)
RegisterPlayerEvent(8, OnPlayerDeath)
RegisterPlayerEvent(36, OnPlayerResurrect)
RegisterPlayerEvent(33, OnPlayerEnterCombat)
RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)



