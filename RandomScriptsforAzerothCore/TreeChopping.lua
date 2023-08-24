local GOSSIP_OPTION_CUT_TREE = 1
local LOG_ITEM_ID = 60116
local BARRIERS_BUILT_QUEST_ID = 30012

function OnCreatureSpawn(event, creature)
    creature:SetReactState(0)
end

function OnGossipHello(event, player, creature)
    if player:IsMounted() then
        player:SendBroadcastMessage("You must dismount first!")
        return
    end

    if not player:HasItem(1311) then
        player:SendBroadcastMessage("You need the Wood Cutter Axe in order to chop down this tree!")
        return
    end

    if not player:HasQuest(BARRIERS_BUILT_QUEST_ID) then
        player:SendBroadcastMessage("You must have the 'Final Fortification' quest before you can chop down this tree!")
        return
    end

    if player:HasItem(LOG_ITEM_ID, 20) then
        player:SendBroadcastMessage("You have the maximum amount of logs already!")
        return
    end

    creature:SetReactState(0)
    player:GossipMenuAddItem(8, "Cut down this tree", 1, GOSSIP_OPTION_CUT_TREE)
    player:GossipSendMenu(8, creature)
end

function OnGossipSelect(event, player, creature, sender, intid)
    if intid == GOSSIP_OPTION_CUT_TREE then
        player:CastSpell(creature, 62990, false)
        player:Kill(creature)
        player:KilledMonsterCredit(400091)
        player:GossipComplete()
    end
end

function OnCreatureDeath(event, creature, killer)
    creature:DespawnOrUnsummon(12000)
    creature:RemoveEvents()

    -- Give the player 1-3 logs upon death
    if killer ~= nil and killer:IsPlayer() then
        local logs = math.random(1, 3)
        killer:AddItem(LOG_ITEM_ID, logs)
    end
end

RegisterCreatureEvent(400091, 5, OnCreatureSpawn)
RegisterCreatureGossipEvent(400091, 1, OnGossipHello)
RegisterCreatureGossipEvent(400091, 2, OnGossipSelect)
RegisterCreatureEvent(400091, 4, OnCreatureDeath)
