local QUEST_ID = 30017
local GOSSIP_ITEM_REQUEST = "Lorekeeper Talandria sent me, she needs the Crusader's Tome to cleanse the skull of an undead warlord."
local GOSSIP_ITEM_RIDDLE = "Alive without breath, as cold as death. Endlessly roaming, the skies I'm combing. What am I?"
local GOSSIP_ITEM_ANSWER1 = "Is it a Death Knight?"
local GOSSIP_ITEM_ANSWER2 = "Is it a Frost Wyrm?"
local GOSSIP_ITEM_ANSWER3 = "Is it a Banshee?"

local NPC_ID = 400098
local ITEM_ID = 65007
local SPELL_ID = 29522

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, GOSSIP_ITEM_RIDDLE, 1, 2) 
        player:GossipSendMenu(1, creature)
		creature:SendUnitSay("She did, did she? Very well then. Answer me this riddle correctly and I will give you the tome.", 0)
		creature:PlayDistanceSound(20445)
    elseif (intid == 2) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, GOSSIP_ITEM_ANSWER1, 1, 3) 
        player:GossipMenuAddItem(0, GOSSIP_ITEM_ANSWER2, 1, 4) 
        player:GossipMenuAddItem(0, GOSSIP_ITEM_ANSWER3, 1, 5) 
        player:GossipSendMenu(1, creature)
    elseif (intid == 3) then
		creature:SetFaction(85)
        creature:CastSpell(player, SPELL_ID, true)
        creature:SendUnitYell("Incorrect!", 0)
		creature:PlayDistanceSound(20447)
        creature:DespawnOrUnsummon(5000)
        player:GossipComplete()
    elseif (intid == 4) then
        player:AddItem(ITEM_ID, 1)
        creature:SendUnitSay("You are correct! Here is your tome.", 0)
		creature:PlayDistanceSound(20448)
        creature:DespawnOrUnsummon(5000)
        player:GossipComplete()
    elseif (intid == 5) then
		creature:SetFaction(85)
        creature:CastSpell(player, SPELL_ID, true)
        creature:SendUnitYell("Incorrect!", 0)
		creature:PlayDistanceSound(20447)
        creature:DespawnOrUnsummon(5000)
        player:GossipComplete()
    end
end

local function OnGossipHello(event, player, creature)
    if player:HasQuest(QUEST_ID) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, GOSSIP_ITEM_REQUEST, 1, 1) 
        player:GossipSendMenu(1, creature)
    else
        player:SendBroadcastMessage("This man seems to be unresponsive.")
    end
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)
