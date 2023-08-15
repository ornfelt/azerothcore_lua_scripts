--  ___ ___ _ __      _____   ___  ___    ___ ___ ___  _   ___ _  __
-- | __| __| |\ \    / / _ \ / _ \|   \  | _ \ __| _ \/_\ / __| |/ /
-- | _|| _|| |_\ \/\/ / (_) | (_) | |) | |   / _||  _/ _ \ (__| ' < 
-- |_| |___|____\_/\_/ \___/ \___/|___/  |_|_\___|_|/_/ \_\___|_|\_\


local AIO = AIO or require("AIO")

local MyHandlers = AIO.AddHandlers("Kaev", {})
local AttributesAuraIds = { 7464, 7471, 7477, 7468, 7474 } -- Strength, Agility, Stamina, Intellect, Spirit

local function GetStatTable(player)
    local strength, agility, stamina, intellect, spirit = player:GetStatPoints()
    return {strength, agility, stamina, intellect, spirit}
end

local function GetFreeStats(player)
    local stats = GetStatTable(player)

    local count = 0
    for k, v in pairs(stats) do
        --print("Count: "..tostring(count).." Free: "..v.."K "..k)
        count = count + v
    end

    return player:GetLevel() - count
end

local function BuildModifierTable(statId, amount)
    local modifier = {0, 0, 0, 0, 0}
    modifier[statId] = amount
    return modifier
end

local function AddAuras(player)
    local stats = GetStatTable(player)

    for k, v in pairs(stats) do 
        if v >= 1 then 
            player:AddAura(AttributesAuraIds[k], player)

            if v > 1 then 
                local aura = player:GetAura(AttributesAuraIds[k])
                aura:SetStackAmount(v)
            end
        end
    end
end

local function AddPlayerStats(msg, player)
    local guid = player:GetGUIDLow()
    local spend = GetStatTable(player)
    local left = GetFreeStats(player)
    return msg:Add("Kaev", "SetStats", left, AIO.unpack(spend))
end

AIO.AddOnInit(AddPlayerStats)

local function UpdatePlayerStats(player)
    AddPlayerStats(AIO.Msg(), player):Send(player)
end

local function OnLogin(event, player)
    player:UpdateStatPoints()
    AddAuras(player)
end

RegisterPlayerEvent(3, OnLogin)

for k,v in ipairs(GetPlayersInWorld()) do
    OnLogin(3, v)
end

function MyHandlers.AttributesIncrease(player, statId)
    if (player:IsInCombat()) then
        player:SendBroadcastMessage("You can't modify your attributes while in combat.")
        return
    end

    local guid = player:GetGUIDLow()
    local stats = GetStatTable(player)
    local left = GetFreeStats(player)

    if not stats or not left then
        --print("StatAllocationSystem#Server: "..player:GetName().." does not have any stats or points left")
        return
    end

    if not statId or not stats[statId] then
        --print("StatAllocationSystem#Server: "..player:GetName().." tried to modify invalid statId")
        return
    end

    if left <= 0 then
        player:SendBroadcastMessage("You don't have any points left to spend.")
        return
    end

    local t = BuildModifierTable(statId, 1)
    --print("Modifiers 1: "..tostring(t[1]).." 2: "..tostring(t[2]).." 3: "..tostring(t[3]).."  4: "..tostring(t[4]).." 5: "..tostring(t[5]))
    player:ModifyStatPoints(t[1], t[2], t[3], t[4], t[5])

    local aura = player:GetAura(AttributesAuraIds[statId])

    if (aura) then
        aura:SetStackAmount(stats[statId])
    else
        player:AddAura(AttributesAuraIds[statId], player)
    end

    UpdatePlayerStats(player)
    player:SaveStatPoints()
end

function MyHandlers.AttributesDecrease(player, statId)
    if (player:IsInCombat()) then
        player:SendBroadcastMessage("You can't modify your attributes while in combat.")
        return
    end

    local guid = player:GetGUIDLow()
    local stats = GetStatTable(player)
    local left = GetFreeStats(player)

    if not stats or not left then
        --print("StatAllocationSystem#Server: "..player:GetName().." does not have any stats or points to remove")
        return
    end

    if not statId or not stats[statId] then
        --print("StatAllocationSystem#Server: "..player:GetName().." tried to modify invalid statId")
        return
    end

    if stats[statId] <= 0 then
        player:SendBroadcastMessage("You don't have any points left to remove.")
        return
    end

    local t = BuildModifierTable(statId, -1)
    --print("Modifiers 1: "..tostring(t[1]).." 2: "..tostring(t[2]).." 3: "..tostring(t[3]).."  4: "..tostring(t[4]).." 5: "..tostring(t[5]))
    player:ModifyStatPoints(t[1], t[2], t[3], t[4], t[5])

    local aura = player:GetAura(AttributesAuraIds[statId])
    if (aura) then
        --print("New amount: "..tostring(stats[statId]-1))
        aura:SetStackAmount(stats[statId]-1)
    else
        player:AddAura(AttributesAuraIds[statId], player)
    end

    UpdatePlayerStats(player)
    player:SaveStatPoints()
end

local function AttributesOnCommand(event, player, command)
    if(command == "stats") then
        AIO.Handle(player, "Kaev", "ShowAttributes")
        return false
    end
end

RegisterPlayerEvent(42, AttributesOnCommand)

local function OnLevelChange(event, player, oldLevel)
    UpdatePlayerStats(player)
    player:RemoveAura(7464)
    player:RemoveAura(7471)
    player:RemoveAura(7477)
    player:RemoveAura(7468)
    player:RemoveAura(7474)
end

RegisterPlayerEvent(13, OnLevelChange)