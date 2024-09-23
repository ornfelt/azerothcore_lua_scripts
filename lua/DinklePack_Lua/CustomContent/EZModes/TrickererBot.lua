local Trickerer = {}

Trickerer.NPC_ID = 400156
Trickerer.REWARD_POINTS_ITEM_ID = 37711
Trickerer.REWARD_POINTS_REQUIRED = 100
Trickerer.GOLD_REQUIRED = 1000000
Trickerer.SPELL_TO_CAST = 80026

function Trickerer.OnGossipSelect(event, player, creature, sender, intid, code)
    if intid == 1 then
        if player:GetItemCount(Trickerer.REWARD_POINTS_ITEM_ID) >= Trickerer.REWARD_POINTS_REQUIRED then
            player:GossipMenuAddItem(0, "Yes, use 100 Reward Points.", 0, 2)
            player:GossipMenuAddItem(0, "No, nevermind.", 0, 4)
            player:GossipSendMenu(2, creature)
        else
            creature:SendUnitSay("Sorry, you don't have enough reward points.", 0)
            player:GossipComplete()
        end
    elseif intid == 2 then
        player:RemoveItem(Trickerer.REWARD_POINTS_ITEM_ID, Trickerer.REWARD_POINTS_REQUIRED)
        player:CastSpell(player, Trickerer.SPELL_TO_CAST)
        creature:SendUnitSay("Here you go! Just don't come whining to me if you still can't kill the boss!", 0)
        player:GossipComplete()
    elseif intid == 3 then
        if player:GetCoinage() >= Trickerer.GOLD_REQUIRED then
            player:GossipMenuAddItem(0, "Yes, use 250 Gold.", 0, 5)
            player:GossipMenuAddItem(0, "No, nevermind.", 0, 4)
            player:GossipSendMenu(3, creature)
        else
            creature:SendUnitSay("Sorry, you don't have enough gold.", 0)
            player:GossipComplete()
        end
    elseif intid == 5 then
        player:ModifyMoney(-Trickerer.GOLD_REQUIRED)
        player:CastSpell(player, Trickerer.SPELL_TO_CAST)
        creature:SendUnitSay("Here you go! Just don't come whining to me if you still can't kill the boss!", 0)
        player:GossipComplete()
    elseif intid == 4 then
        creature:SendUnitSay("Alright, come back if you change your mind.", 0)
        player:GossipComplete()
    end
end

function Trickerer.OnGossipHello(event, player, creature)
    if player:HasAura(80026) then
        player:SendBroadcastMessage("You cannot speak to Trickerer while you have the Easy Mode aura active.")
        player:GossipComplete()
        return
    end

    if player:IsInCombat() then
        player:SendBroadcastMessage("You cannot speak to Trickerer while in combat.")
        player:GossipComplete()
    else
        creature:SendUnitSay("Would you like to make this fight more NPC Bot Friendly for 100 Reward Points or 250 Gold?", 0)
        player:GossipMenuAddItem(0, "Use 100 Reward Points.", 1, 1)
        player:GossipMenuAddItem(0, "Use 250 Gold.", 1, 3)
        player:GossipSendMenu(1, creature)
    end
end

RegisterCreatureGossipEvent(Trickerer.NPC_ID, 1, Trickerer.OnGossipHello)
RegisterCreatureGossipEvent(Trickerer.NPC_ID, 2, Trickerer.OnGossipSelect)
