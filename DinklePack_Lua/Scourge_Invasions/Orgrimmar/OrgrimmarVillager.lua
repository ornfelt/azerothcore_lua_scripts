local SafetyTeleporter = {}

SafetyTeleporter.NPC_IDS = {400068, 400067}
SafetyTeleporter.GOSSIP_TEXT = "It's not safe here. I can teleport you to safety."
SafetyTeleporter.ITEM_ID = 65002 -- Teleporter
SafetyTeleporter.SPELL_ID = 100182

local function OnGossipHello(event, player, creature)
    if (player:HasItem(SafetyTeleporter.ITEM_ID)) then
        player:GossipMenuAddItem(0, SafetyTeleporter.GOSSIP_TEXT, 0, 1)
        player:GossipSendMenu(1, creature)
    else
        player:SendBroadcastMessage("You should go speak to Putress for help in the Grommash Hold.")
        creature:MoveWaypoint()
    end
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        creature:RemoveAllAuras()
        player:CastSpell(creature, SafetyTeleporter.SPELL_ID, false)
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

for i, npcid in ipairs(SafetyTeleporter.NPC_IDS) do
    RegisterCreatureGossipEvent(npcid, 1, OnGossipHello)
    RegisterCreatureGossipEvent(npcid, 2, OnGossipSelect)
end
