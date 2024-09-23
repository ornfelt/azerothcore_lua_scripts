local npcs = {400068, 400067} 
local gossipText = "It's not safe here. I can teleport you to safety."
local itemId = 65002 -- Teleporter
local spellId = 100182

local function OnGossipHello(event, player, creature)
if (player:HasItem(itemId)) then
player:GossipMenuAddItem(0, gossipText, 0, 1)
player:GossipSendMenu(1, creature)
else
player:SendBroadcastMessage("You should go speak to Putress for help in the Grommash Hold.")
creature:MoveWaypoint()
end
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
if (intid == 1) then
creature:RemoveAllAuras()
player:CastSpell(creature, spellId, false)
local randomDialogue = math.random(1, 3)
if randomDialogue == 1 then
creature:SendUnitSay("Thank you for helping me adventurer. Your kindness will not be forgotten.", 0)
elseif randomDialogue == 2 then
creature:SendUnitSay("Very well then...Thank you for your help.", 0)
else
creature:SendUnitSay("Anywhere is better than here right now...please go ahead.", 0)
end
player:GossipComplete()
player:KilledMonsterCredit(400067)
creature:DespawnOrUnsummon(4650)
end
end

for i, npcid in ipairs(npcs) do
RegisterCreatureGossipEvent(npcid, 1, OnGossipHello)
RegisterCreatureGossipEvent(npcid, 2, OnGossipSelect)
end
