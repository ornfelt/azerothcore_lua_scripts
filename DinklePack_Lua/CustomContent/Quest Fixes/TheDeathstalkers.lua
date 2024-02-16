local DeathstalkersNPCInteraction = {}

DeathstalkersNPCInteraction.NPC_ID = 6497
DeathstalkersNPCInteraction.QUEST_ID = 1886
DeathstalkersNPCInteraction.FACTION_HOSTILE = 1630

function DeathstalkersNPCInteraction.OnGossipHello(event, player, object)
    if player:HasQuest(DeathstalkersNPCInteraction.QUEST_ID) then
        object:SendUnitYell("The Deathstalkers will not be getting their way today!", 0)
        object:SetFaction(DeathstalkersNPCInteraction.FACTION_HOSTILE)
        object:AttackStart(player)
    else
        return false -- This will allow the default gossip menu to be displayed
    end
end

RegisterCreatureGossipEvent(DeathstalkersNPCInteraction.NPC_ID, 1, DeathstalkersNPCInteraction.OnGossipHello)
