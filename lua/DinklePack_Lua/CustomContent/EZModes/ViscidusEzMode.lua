local NPC_ID = 400157 
local TARGET_CREATURE_ID = 15299 
local FROSTBOLT_SPELL_ID = 116 
local SEARCH_RANGE = 200 
local REWARD_POINTS_ITEM_ID = 37711
local REWARD_POINTS_REQUIRED = 100
local GOLD_REQUIRED = 2000000 

local function CastFrostbolt(eventId, delay, repeats, caster)
    local target = caster:GetVictim()
    if target and target:GetEntry() == TARGET_CREATURE_ID then
        caster:CastSpell(target, FROSTBOLT_SPELL_ID, true)
    end
end

local function OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == 1 then -- Using Reward Points
        if player:GetItemCount(REWARD_POINTS_ITEM_ID) >= REWARD_POINTS_REQUIRED then
            player:GossipMenuAddItem(0, "Yes, use 100 Reward Points.", 0, 2)
            player:GossipMenuAddItem(0, "No, nevermind.", 0, 5)
            player:GossipSendMenu(2, creature)
        else
            creature:SendUnitSay("Sorry, you don't have enough reward points.", 0)
            player:GossipComplete()
        end
    elseif intid == 2 then 
        
        player:RemoveItem(REWARD_POINTS_ITEM_ID, REWARD_POINTS_REQUIRED)
        
        
        local playerFaction = player:GetFaction()
        creature:SetFaction(playerFaction)

        
        local creatures = creature:GetCreaturesInRange(SEARCH_RANGE, TARGET_CREATURE_ID)
        if #creatures > 0 then
            local target = creatures[1]
			
            creature:AttackStart(target) -- Begin attack
			creature:CastSpell(creature, 31745, true)
            
            
            creature:SendUnitYell("Frostbolt spam ftw!", 0)
            
            
            creature:RegisterEvent(CastFrostbolt, 250, 0)
            
           
            creature:DespawnOrUnsummon(180000)
        else
            creature:SendUnitSay("Target not found within range.", 0)
        end

        player:GossipComplete()
    elseif intid == 3 then 
        if player:GetCoinage() >= GOLD_REQUIRED then
            player:GossipMenuAddItem(0, "Yes, use 200 Gold.", 0, 4)
            player:GossipMenuAddItem(0, "No, nevermind.", 0, 5)
            player:GossipSendMenu(3, creature)
        else
            creature:SendUnitSay("Sorry, you don't have enough gold.", 0)
            player:GossipComplete()
        end
    elseif intid == 4 then 
        
        player:ModifyMoney(-GOLD_REQUIRED)
        
        
        local playerFaction = player:GetFaction()
        creature:SetFaction(playerFaction)

        
        local creatures = creature:GetCreaturesInRange(SEARCH_RANGE, TARGET_CREATURE_ID)
        if #creatures > 0 then
            local target = creatures[1]
            creature:AttackStart(target) 
            
            
            creature:SendUnitYell("Frostbolt spam ftw!", 0)
            
            
            creature:RegisterEvent(CastFrostbolt, 250, 0)
            
            
            creature:DespawnOrUnsummon(180000)
        else
            creature:SendUnitSay("Target not found within range.", 0)
        end

        player:GossipComplete()
    elseif intid == 5 then 
        creature:SendUnitSay("Alright, come back if you change your mind.", 0)
        player:GossipComplete()
    end
end

local function OnGossipHello(event, player, creature)
    if player:IsInCombat() then
        player:SendBroadcastMessage("You cannot speak to this NPC while in combat.")
        player:GossipComplete()
    else
        
        creature:SendUnitSay("Would you like me to assist you in battle for 100 Reward Points or 200 Gold?", 0)
        player:GossipMenuAddItem(0, "Use 100 Reward Points.", 1, 1)
        player:GossipMenuAddItem(0, "Use 200 Gold.", 1, 3)
        player:GossipSendMenu(1, creature)
    end
end

RegisterCreatureGossipEvent(NPC_ID, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ID, 2, OnGossipSelect)