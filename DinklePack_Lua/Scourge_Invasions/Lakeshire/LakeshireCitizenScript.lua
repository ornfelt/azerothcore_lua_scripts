local NPC_ENTRY1 = 400080
local REQUIRED_QUEST_ID = 30011

local function OnGossipHello(event, player, creature)
    local questStatus = player:GetQuestStatus(REQUIRED_QUEST_ID)
    if not player:HasQuest(REQUIRED_QUEST_ID) then
        if questStatus == 4 then
            player:SendBroadcastMessage("Your time ran out, and you have failed this quest...")
        else
            player:SendBroadcastMessage("You must be on a certain quest to interact with this person.")
        end
        return
    end

    player:GossipMenuAddItem(0, "The scourge are coming! Please head to the inn!", 0, 1)
    player:GossipSendMenu(1, creature)
end


local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        creature:MoveWaypoint()
        player:GossipComplete()
        player:KilledMonsterCredit(NPC_ENTRY1)
        local random = math.random(0, 4)
        if random == 0 then
            creature:SendUnitSay("How could this be happening? We've always been safe here.", 0)
        elseif random == 1 then
            creature:SendUnitSay("Why would they attack us? We've never done anything to them.", 0)
        elseif random == 2 then
            creature:SendUnitSay("What are we going to do? We're not prepared for this kind of violence.", 0)
        elseif random == 3 then
            creature:SendUnitSay("This can't be real. It must be a terrible dream.", 0)
        else
            creature:SendUnitSay("I'm so scared. I don't know what the future holds for us now.", 0)
        end
    end
end


local function OnSpawn(event, creature)
creature:MoveStop()
creature:MoveIdle()
end

local function OnDeath(event, creature, killer)
creature:RemoveEvents()
creature:MoveStop()
creature:MoveIdle()
end

RegisterCreatureGossipEvent(NPC_ENTRY1, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY1, 2, OnGossipSelect)
RegisterCreatureEvent(NPC_ENTRY1, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY1, 3, OnDeath)

------------------------------------------------------------------------------------

local NPC_ENTRY2 = 400082
local REQUIRED_QUEST_ID = 30011

local function OnGossipHello(event, player, creature)
    local questStatus = player:GetQuestStatus(REQUIRED_QUEST_ID)
    if not player:HasQuest(REQUIRED_QUEST_ID) then
        if questStatus == 4 then
            player:SendBroadcastMessage("Your time ran out, and you have failed this quest...")
        else
            player:SendBroadcastMessage("You must be on a certain quest to interact with this person.")
        end
        return
    end

    player:GossipMenuAddItem(0, "The scourge are coming! Please head to the inn!", 0, 1)
    player:GossipSendMenu(1, creature)
end


local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        creature:MoveWaypoint()
        player:GossipComplete()
        player:KilledMonsterCredit(NPC_ENTRY1)
        local random = math.random(0, 4)
        if random == 0 then
            creature:SendUnitSay("How could this be happening? We've always been safe here.", 0)
        elseif random == 1 then
            creature:SendUnitSay("What do we do now? We can't just sit here and wait to be slaughtered.", 0)
        elseif random == 2 then
            creature:SendUnitSay("What are we going to do? We're not prepared for this kind of violence.", 0)
        elseif random == 3 then
            creature:SendUnitSay("This can't be real. It must be a terrible dream.", 0)
        else
            creature:SendUnitSay("I'm so scared. I don't know what the future holds for us now.", 0)
        end
    end
end

local function OnSpawn(event, creature)
creature:MoveStop()
creature:MoveIdle()
end

local function OnDeath(event, creature, killer)
creature:RemoveEvents()
creature:MoveStop()
creature:MoveIdle()
end

RegisterCreatureGossipEvent(NPC_ENTRY2, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY2, 2, OnGossipSelect)
RegisterCreatureEvent(NPC_ENTRY2, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY2, 3, OnDeath)

------------------------------------------------------------------------------------

local NPC_ENTRY3 = 400083
local REQUIRED_QUEST_ID = 30011

local function OnGossipHello(event, player, creature)
    local questStatus = player:GetQuestStatus(REQUIRED_QUEST_ID)
    if not player:HasQuest(REQUIRED_QUEST_ID) then
        if questStatus == 4 then
            player:SendBroadcastMessage("Your time ran out, and you have failed this quest...")
        else
            player:SendBroadcastMessage("You must be on a certain quest to interact with this person.")
        end
        return
    end

    player:GossipMenuAddItem(0, "The scourge are coming! Please head to the inn!", 0, 1)
    player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        creature:MoveWaypoint()
        player:GossipComplete()
        player:KilledMonsterCredit(NPC_ENTRY1)
        local random = math.random(0, 4)
        if random == 0 then
            creature:SendUnitSay("How could this be happening? We've always been safe here.", 0)
        elseif random == 1 then
            creature:SendUnitSay("Why would they attack us? We've never done anything to them.", 0)
        elseif random == 2 then
            creature:SendUnitSay("This is a nightmare. Please tell me it's not real.", 0)
        elseif random == 3 then
            creature:SendUnitSay("Why did we ever leave Ironforge? We were safe there.", 0)
        else
            creature:SendUnitSay("I'm so scared. I don't know what the future holds for us now.", 0)
        end
    end
end

local function OnSpawn(event, creature)
creature:MoveStop()
creature:MoveIdle()
end

local function OnDeath(event, creature, killer)
creature:RemoveEvents()
creature:MoveStop()
creature:MoveIdle()
end

RegisterCreatureGossipEvent(NPC_ENTRY3, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY3, 2, OnGossipSelect)
RegisterCreatureEvent(NPC_ENTRY3, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY3, 3, OnDeath)

------------------------------------------------------------------------------------

local NPC_ENTRY4 = 400084
local REQUIRED_QUEST_ID = 30011

local function OnGossipHello(event, player, creature)
    local questStatus = player:GetQuestStatus(REQUIRED_QUEST_ID)
    if not player:HasQuest(REQUIRED_QUEST_ID) then
        if questStatus == 4 then
            player:SendBroadcastMessage("Your time ran out, and you have failed this quest...")
        else
            player:SendBroadcastMessage("You must be on a certain quest to interact with this person.")
        end
        return
    end

    player:GossipMenuAddItem(0, "The scourge are coming! Please head to the inn!", 0, 1)
    player:GossipSendMenu(1, creature)
end


local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        creature:MoveWaypoint()
        player:GossipComplete()
        player:KilledMonsterCredit(NPC_ENTRY1)
        local random = math.random(0, 4)
        if random == 0 then
            creature:SendUnitSay("How could this be happening? We've always been safe here.", 0)
        elseif random == 1 then
            creature:SendUnitSay("I always knew this day would come. We should have been better prepared.", 0)
        elseif random == 2 then
            creature:SendUnitSay("What are we going to do? We're not prepared for this kind of violence.", 0)
        elseif random == 3 then
            creature:SendUnitSay("This can't be real. It must be a terrible dream.", 0)
        else
            creature:SendUnitSay("I hope the guards can hold them off.", 0)
        end
    end
end

local function OnSpawn(event, creature)
creature:MoveStop()
creature:MoveIdle()
end

local function OnDeath(event, creature, killer)
creature:RemoveEvents()
creature:MoveStop()
creature:MoveIdle()
end

RegisterCreatureGossipEvent(NPC_ENTRY4, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY4, 2, OnGossipSelect)
RegisterCreatureEvent(NPC_ENTRY4, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY4, 3, OnDeath)

------------------------------------------------------------------------------------

local NPC_ENTRY5 = 400085
local REQUIRED_QUEST_ID = 30011

local function OnGossipHello(event, player, creature)
    local questStatus = player:GetQuestStatus(REQUIRED_QUEST_ID)
    if not player:HasQuest(REQUIRED_QUEST_ID) then
        if questStatus == 4 then
            player:SendBroadcastMessage("Your time ran out, and you have failed this quest...")
        else
            player:SendBroadcastMessage("You must be on a certain quest to interact with this person.")
        end
        return
    end

    player:GossipMenuAddItem(0, "The scourge are coming! Please head to the inn!", 0, 1)
    player:GossipSendMenu(1, creature)
end


local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        creature:MoveWaypoint()
        player:GossipComplete()
        player:KilledMonsterCredit(NPC_ENTRY1)
        local random = math.random(0, 4)
        if random == 0 then
            creature:SendUnitSay("How could this be happening? We've always been safe here.", 0)
        elseif random == 1 then
            creature:SendUnitSay("Why would they attack us? We've never done anything to them.", 0)
        elseif random == 2 then
            creature:SendUnitSay("The Scourge are unstoppable. What chance do we have?", 0)
        elseif random == 3 then
            creature:SendUnitSay("This can't be real. It must be a terrible dream.", 0)
        else
            creature:SendUnitSay("I'm so scared. I don't know what the future holds for us now.", 0)
        end
    end
end

local function OnSpawn(event, creature)
creature:MoveStop()
creature:MoveIdle()
end

local function OnDeath(event, creature, killer)
creature:RemoveEvents()
creature:MoveStop()
creature:MoveIdle()
end

RegisterCreatureGossipEvent(NPC_ENTRY5, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY5, 2, OnGossipSelect)
RegisterCreatureEvent(NPC_ENTRY5, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY5, 3, OnDeath)

------------------------------------------------------------------------------------

local NPC_ENTRY6 = 400086
local REQUIRED_QUEST_ID = 30011

local function OnGossipHello(event, player, creature)
    local questStatus = player:GetQuestStatus(REQUIRED_QUEST_ID)
    if not player:HasQuest(REQUIRED_QUEST_ID) then
        if questStatus == 4 then
            player:SendBroadcastMessage("Your time ran out, and you have failed this quest...")
        else
            player:SendBroadcastMessage("You must be on a certain quest to interact with this person.")
        end
        return
    end

    player:GossipMenuAddItem(0, "The scourge are coming! Please head to the inn!", 0, 1)
    player:GossipSendMenu(1, creature)
end


local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        creature:MoveWaypoint()
        player:GossipComplete()
        player:KilledMonsterCredit(NPC_ENTRY1)
        local random = math.random(0, 4)
        if random == 0 then
            creature:SendUnitSay("How could this be happening? We've always been safe here.", 0)
        elseif random == 1 then
            creature:SendUnitSay("Why us? Why did they have to pick on our town?", 0)
        elseif random == 2 then
            creature:SendUnitSay("What are we going to do? We're not prepared for this kind of violence.", 0)
        elseif random == 3 then
            creature:SendUnitSay("This can't be real. It must be a terrible dream.", 0)
        else
            creature:SendUnitSay("I'm so scared. I don't know what the future holds for us now.", 0)
        end
    end
end

local function OnSpawn(event, creature)
creature:MoveStop()
creature:MoveIdle()
end

local function OnDeath(event, creature, killer)
creature:RemoveEvents()
creature:MoveStop()
creature:MoveIdle()
end

RegisterCreatureGossipEvent(NPC_ENTRY6, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY6, 2, OnGossipSelect)
RegisterCreatureEvent(NPC_ENTRY6, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY6, 3, OnDeath)

------------------------------------------------------------------------------------

local NPC_ENTRY7 = 400087
local REQUIRED_QUEST_ID = 30011

local function OnGossipHello(event, player, creature)
    local questStatus = player:GetQuestStatus(REQUIRED_QUEST_ID)
    if not player:HasQuest(REQUIRED_QUEST_ID) then
        if questStatus == 4 then
            player:SendBroadcastMessage("Your time ran out, and you have failed this quest...")
        else
            player:SendBroadcastMessage("You must be on a certain quest to interact with this person.")
        end
        return
    end

    player:GossipMenuAddItem(0, "The scourge are coming! Please head to the inn!", 0, 1)
    player:GossipSendMenu(1, creature)
end


local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        creature:MoveWaypoint()
        player:GossipComplete()
        player:KilledMonsterCredit(NPC_ENTRY1)
        local random = math.random(0, 4)
        if random == 0 then
            creature:SendUnitSay("How could this be happening? We've always been safe here.", 0)
        elseif random == 1 then
            creature:SendUnitSay("I have family here. I won't let anything happen to them.", 0)
        elseif random == 2 then
            creature:SendUnitSay("What are we going to do? We're not prepared for this kind of violence.", 0)
        elseif random == 3 then
            creature:SendUnitSay("This can't be real. It must be a terrible dream.", 0)
        else
            creature:SendUnitSay("I'm so scared. I don't know what the future holds for us now.", 0)
        end
    end
end

local function OnSpawn(event, creature)
creature:MoveStop()
creature:MoveIdle()
end

local function OnDeath(event, creature, killer)
creature:RemoveEvents()
creature:MoveStop()
creature:MoveIdle()
end

RegisterCreatureGossipEvent(NPC_ENTRY7, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY7, 2, OnGossipSelect)
RegisterCreatureEvent(NPC_ENTRY7, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY7, 3, OnDeath)

------------------------------------------------------------------------------------

local NPC_ENTRY8 = 400088
local REQUIRED_QUEST_ID = 30011

local function OnGossipHello(event, player, creature)
    local questStatus = player:GetQuestStatus(REQUIRED_QUEST_ID)
    if not player:HasQuest(REQUIRED_QUEST_ID) then
        if questStatus == 4 then
            player:SendBroadcastMessage("Your time ran out, and you have failed this quest...")
        else
            player:SendBroadcastMessage("You must be on a certain quest to interact with this person.")
        end
        return
    end

    player:GossipMenuAddItem(0, "The scourge are coming! Please head to the inn!", 0, 1)
    player:GossipSendMenu(1, creature)
end


local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        creature:MoveWaypoint()
        player:GossipComplete()
        player:KilledMonsterCredit(NPC_ENTRY1)
        local random = math.random(0, 4)
        if random == 0 then
            creature:SendUnitSay("How could this be happening? We've always been safe here.", 0)
        elseif random == 1 then
            creature:SendUnitSay("Why would they attack us? We've never done anything to them.", 0)
        elseif random == 2 then
            creature:SendUnitSay("What are we going to do? We're not prepared for this kind of violence.", 0)
        elseif random == 3 then
            creature:SendUnitSay("This can't be real. It must be a terrible dream.", 0)
        else
            creature:SendUnitSay("I'm so scared. I don't know what the future holds for us now.", 0)
        end
    end
end

local function OnSpawn(event, creature)
creature:MoveStop()
creature:MoveIdle()
end

local function OnDeath(event, creature, killer)
creature:RemoveEvents()
creature:MoveStop()
creature:MoveIdle()
end

RegisterCreatureGossipEvent(NPC_ENTRY8, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY8, 2, OnGossipSelect)
RegisterCreatureEvent(NPC_ENTRY8, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY8, 3, OnDeath)

------------------------------------------------------------------------------------

local NPC_ENTRY9 = 400089
local REQUIRED_QUEST_ID = 30011

local function OnGossipHello(event, player, creature)
    local questStatus = player:GetQuestStatus(REQUIRED_QUEST_ID)
    if not player:HasQuest(REQUIRED_QUEST_ID) then
        if questStatus == 4 then
            player:SendBroadcastMessage("Your time ran out, and you have failed this quest...")
        else
            player:SendBroadcastMessage("You must be on a certain quest to interact with this person.")
        end
        return
    end

    player:GossipMenuAddItem(0, "The scourge are coming! Please head to the inn!", 0, 1)
    player:GossipSendMenu(1, creature)
end


local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        creature:MoveWaypoint()
        player:GossipComplete()
        player:KilledMonsterCredit(NPC_ENTRY1)
        local random = math.random(0, 4)
        if random == 0 then
            creature:SendUnitSay("How could this be happening? We've always been safe here.", 0)
        elseif random == 1 then
            creature:SendUnitSay("Why would they attack us? We've never done anything to them.", 0)
        elseif random == 2 then
            creature:SendUnitSay("What are we going to do? We're not prepared for this kind of violence.", 0)
        elseif random == 3 then
            creature:SendUnitSay("This can't be real. It must be a terrible dream.", 0)
        else
            creature:SendUnitSay("I'm so scared. I don't know what the future holds for us now.", 0)
        end
    end
end

local function OnSpawn(event, creature)
creature:MoveStop()
creature:MoveIdle()
end

local function OnDeath(event, creature, killer)
creature:RemoveEvents()
creature:MoveStop()
creature:MoveIdle()
end

RegisterCreatureGossipEvent(NPC_ENTRY9, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY9, 2, OnGossipSelect)
RegisterCreatureEvent(NPC_ENTRY9, 5, OnSpawn)
RegisterCreatureEvent(NPC_ENTRY9, 3, OnDeath)

local NPC_ENTRY10 = 849
local REQUIRED_QUEST_ID = 30011

local function OnGossipHello(event, player, creature)
    local questStatus = player:GetQuestStatus(REQUIRED_QUEST_ID)
    if not player:HasQuest(REQUIRED_QUEST_ID) then
        if questStatus == 4 then
            player:SendBroadcastMessage("Your time ran out, and you have failed this quest...")
        else
            player:SendBroadcastMessage("You must be on a certain quest to interact with this person.")
        end
        return
    end

    player:GossipMenuAddItem(0, "The scourge are coming! Please head to the inn!", 0, 1)
    player:GossipSendMenu(1, creature)
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        player:GossipComplete()
        player:KilledMonsterCredit(NPC_ENTRY1)
        local random = math.random(0, 4)
        if random == 0 then
            creature:SendUnitSay("Mommmmy!!!!", 0)
        elseif random == 1 then
            creature:SendUnitSay("But I wanted to go play with Sally...", 0)
        elseif random == 2 then
            creature:SendUnitSay("Really? Stay indoors? How boring...", 0)
        elseif random == 3 then
            creature:SendUnitSay("Darn those yucky Scourge...", 0)
        else
            creature:SendUnitSay("Awww, no fun!", 0)
        end
        creature:DespawnOrUnsummon(1000) -- Despawn after 2 seconds (2000 milliseconds)
    end
end

RegisterCreatureGossipEvent(NPC_ENTRY10, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY10, 2, OnGossipSelect)


local NPC_ENTRY11 = 848
local REQUIRED_QUEST_ID = 30011

local function OnGossipHello(event, player, creature)
    local questStatus = player:GetQuestStatus(REQUIRED_QUEST_ID)
    if not player:HasQuest(REQUIRED_QUEST_ID) then
        if questStatus == 4 then
            player:SendBroadcastMessage("Your time ran out, and you have failed this quest...")
        else
            player:SendBroadcastMessage("You must be on a certain quest to interact with this person.")
        end
        return
    end

    player:GossipMenuAddItem(0, "The scourge are coming! Please head to the inn!", 0, 1)
    player:GossipSendMenu(1, creature)
end


local function OnGossipSelect(event, player, creature, sender, intid, code)
    if (intid == 1) then
        player:GossipComplete()
        player:KilledMonsterCredit(NPC_ENTRY1)
        local random = math.random(0, 4)
        if random == 0 then
            creature:SendUnitSay("Mommmmy!!!!", 0)
        elseif random == 1 then
            creature:SendUnitSay("But I wanted to go play with Sally...", 0)
        elseif random == 2 then
            creature:SendUnitSay("Really? Stay indoors? How boring...", 0)
        elseif random == 3 then
            creature:SendUnitSay("Darn those yucky Scourge...", 0)
        else
            creature:SendUnitSay("Awww, no fun!", 0)
        end
        creature:DespawnOrUnsummon(1000) -- Despawn after 2 seconds (2000 milliseconds)
    end
end

RegisterCreatureGossipEvent(NPC_ENTRY11, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY11, 2, OnGossipSelect)

------------------

