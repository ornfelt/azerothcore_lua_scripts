local TreeCutter = {}

TreeCutter.TREE_CREATURE_ID = 400091 
TreeCutter.GOSSIP_OPTION_CUT_TREE = 1
TreeCutter.LOG_ITEM_ID = 60116
TreeCutter.BARRIERS_BUILT_QUEST_ID = 30012
TreeCutter.SECOND_PERMITTED_QUEST_ID = 30020

function TreeCutter.OnCreatureSpawn(event, creature)
    creature:SetReactState(0)
    creature:SetRooted(true) -- Roots the tree on spawn
end

function TreeCutter.OnGossipHello(event, player, creature)
    if creature == nil or creature:GetEntry() ~= TreeCutter.TREE_CREATURE_ID then return end
    if player:IsMounted() then
        player:SendBroadcastMessage("You must dismount first!")
        return
    end

    if not player:HasItem(1311) then
        player:SendBroadcastMessage("You need the Wood Cutter Axe in order to chop down this tree!")
        return
    end

    if not (player:HasQuest(TreeCutter.BARRIERS_BUILT_QUEST_ID) or player:HasQuest(TreeCutter.SECOND_PERMITTED_QUEST_ID)) then
        player:SendBroadcastMessage("You must be on a certain quest before you can chop down this tree!")
        return
    end

    if player:HasItem(TreeCutter.LOG_ITEM_ID, 20) then
        player:SendBroadcastMessage("You have the maximum amount of logs already!")
        return
    end

    creature:SetReactState(0)
    player:GossipMenuAddItem(8, "Cut down this tree", 1, TreeCutter.GOSSIP_OPTION_CUT_TREE)
    player:GossipSendMenu(8, creature)
end

function TreeCutter.OnGossipSelect(event, player, creature, sender, intid)
    if intid == TreeCutter.GOSSIP_OPTION_CUT_TREE then
        player:CastSpell(creature, 62990, false)
        player:Kill(creature)
        player:KilledMonsterCredit(TreeCutter.TREE_CREATURE_ID)
        player:GossipComplete()
    end
end

function TreeCutter.OnCreatureDeath(event, creature, killer)
    creature:DespawnOrUnsummon(12000)
    creature:RemoveEvents()

    -- Give the player 1-3 logs upon death
    if killer ~= nil and killer:IsPlayer() then
        local logs = math.random(1, 3)
        killer:AddItem(TreeCutter.LOG_ITEM_ID, logs)
    end
end

RegisterCreatureEvent(TreeCutter.TREE_CREATURE_ID, 5, TreeCutter.OnCreatureSpawn)
RegisterCreatureGossipEvent(TreeCutter.TREE_CREATURE_ID, 1, TreeCutter.OnGossipHello)
RegisterCreatureGossipEvent(TreeCutter.TREE_CREATURE_ID, 2, TreeCutter.OnGossipSelect)
RegisterCreatureEvent(TreeCutter.TREE_CREATURE_ID, 4, TreeCutter.OnCreatureDeath)
