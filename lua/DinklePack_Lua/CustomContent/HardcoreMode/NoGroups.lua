local CHALLENGE_ITEMS = {800051} -- items related to the challenges
local CHALLENGE_NAMES = {[800051] = "Pacifist Mode"} -- challenge names

local HasItem = function(player, itemId) return player:HasItem(itemId) end
local GetPlayerByGUID = GetPlayerByGUID

local SPELLS_TO_CAST = {[800051] = 80092} 

local function RemoveItemAndNotify(player)
    for _, item in ipairs(CHALLENGE_ITEMS) do
        if player and HasItem(player, item) then
            local itemCount = player:GetItemCount(item) 
            player:RemoveItem(item, itemCount) 
            local spellToCast = SPELLS_TO_CAST[item]
            player:CastSpell(player, 12158, true) 
            player:PlayDirectSound(183253)
            if spellToCast then
                player:CastSpell(player, spellToCast, true) 
            end
            local message = "|cFFFF0000Player " .. player:GetName() .. " failed the " .. CHALLENGE_NAMES[item] .. " challenge for participating in a group.|r"
            print(message)
            SendWorldMessage(message)
        end
    end
end

local function ChallengeOnGroupMemberAdd(event, group, guid)
    local player = GetPlayerByGUID(guid)
    RemoveItemAndNotify(player)
end

local function ChallengeOnGroupCreate(event, group, leaderGuid, groupType)
    local leader = GetPlayerByGUID(leaderGuid)
    RemoveItemAndNotify(leader)
end

RegisterGroupEvent(1, ChallengeOnGroupMemberAdd)
RegisterGroupEvent(2, ChallengeOnGroupCreate)
