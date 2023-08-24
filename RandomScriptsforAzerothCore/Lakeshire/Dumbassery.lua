--I was being dumb. Don't ask.

local CREATURE_ID = 1069
local ITEM_ID = 65006
local ITEM_COUNT = 1
local REQUIRED_QUEST_ID = 30015

local function OnCreatureKill(event, player, creature)
    if creature:GetEntry() == CREATURE_ID and player:HasQuest(REQUIRED_QUEST_ID) then
        player:AddItem(ITEM_ID, ITEM_COUNT)
    end
end

RegisterPlayerEvent(7, OnCreatureKill)
