local NPC_IDS = {400104, 400106, 400108, 400105, 400107, 400109}
local ITEM_ID = 60124

local mainHandItems = {6905, 10756, 11087}

local destinations = {
    {x = -482, y = -2710, z = 94.303, o = 4.2},
    {x = -353, y = -2681, z = 95.88, o = 0.0929},
    {x = -579, y = -2650, z = 95.633, o = 3.12},
    {x = -348, y = -2507, z = 95.563, o = 1.49},
}

local messages = {
    "Lok'tar Ogar! For the Horde!",
    "No mercy for our enemies!",
    "Let's show these Scourge dogs what it means to mess with the Horde!",
}

local function OnGossipHello(event, player, creature)
    if player:HasItem(ITEM_ID) then
        player:GossipClearMenu()
        player:GossipMenuAddItem(8, "|TInterface\\icons\\inv_sword_39:40:40:-35|t|cff610B0BGive Weapon|r", 1, 0)
        player:GossipMenuAddItem(9, "2-Handed Axe", 1, 1001)
        player:GossipMenuAddItem(9, "2-Handed Mace", 1, 1002)
        player:GossipMenuAddItem(9, "2-Handed Sword", 1, 1003)

        if creature:GetData("equipmentSet") then
            player:GossipMenuAddItem(8, "|TInterface\\icons\\ability_warrior_battleshout:40:40:-35|t|cffC41F3BSend to Location|r", 2, 0)
            player:GossipMenuAddItem(0, "Reinforce the East Entrance", 2, 2001)
            player:GossipMenuAddItem(0, "Reinforce the North Entrance", 2, 2002)
            player:GossipMenuAddItem(0, "Reinforce the South Entrance", 2, 2003)
            player:GossipMenuAddItem(0, "Reinforce the West Entrance", 2, 2004)
            player:GossipMenuAddItem(2, "|t|cff0101DFFollow me into battle!|r", 2, 2005) -- Add the new option
        end

        player:GossipSendMenu(1, creature)
    else
        player:SendBroadcastMessage("You need Horde Armaments!")
    end
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == 0 then
        OnGossipHello(event, player, creature)
    elseif intid >= 1001 and intid <= 1003 then
        local index = intid - 1000
        local selectedMainHand = mainHandItems[index]
        creature:SetEquipmentSlots(selectedMainHand, 0, 0)
        creature:SetData("equipmentSet", true)
        creature:PerformEmote(66) 
        OnGossipHello(event, player, creature)
    end

    if intid >= 2001 and intid <= 2004 then
        local index = intid - 2000
        local destination = destinations[index]
        local finalX = destination.x + math.random(-10, 10)
        local finalY = destination.y + math.random(-10, 10)
        local finalZ = destination.z
        local finalO = destination.o
        creature:MoveTo(0, finalX, finalY, finalZ, true)
        local battlecryIndex = math.random(1, #messages)
        creature:SendUnitYell(messages[battlecryIndex], 0)
        creature:EmoteState(375)
        creature:SetHomePosition(finalX, finalY, finalZ, finalO)
        creature:SetNPCFlags(0)
        player:RemoveItem(ITEM_ID, 1)
        player:KilledMonsterCredit(creature:GetEntry())
        player:GossipComplete()
    end

    if intid == 2005 then
        local randomAngle = math.random() * 2 * math.pi
        creature:MoveFollow(player, 5, randomAngle) -- Follow the player with a distance of 5 yards and random angle
        local battlecryIndex = math.random(1, #messages)
        creature:SendUnitYell(messages[battlecryIndex], 0)

        creature:SetNPCFlags(0)
        player:RemoveItem(ITEM_ID, 1)
        player:GossipComplete()
    end
end

local function OnCreatureDied(event, creature, killer)
    creature:SetEquipmentSlots(0, 0, 0)
    creature:SetData("equipmentSet", false)
    creature:RemoveEvents()
end

for _, npcId in ipairs(NPC_IDS) do
    RegisterCreatureGossipEvent(npcId, 1, OnGossipHello)
    RegisterCreatureGossipEvent(npcId, 2, OnGossipSelect)
    RegisterCreatureEvent(npcId, 4, OnCreatureDied)
end
