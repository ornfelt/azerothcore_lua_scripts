function Gambler_On_Gossip(unit, event, player)
if (player:IsPlayer() == true) then
unit:GossipCreateMenu(1, player, 0)
unit:GossipMenuAddItem(0, "If you give me 5 coins, I will give you a 25% chance to win 25 coins. Interested?", 1, 0)
unit:GossipSendMenu(player)
else
unit:GossipCreateMenu(1, player, 0)
unit:GossipSendMenu(player)
end
end

function Gambler_Gossip_Submenus(unit, event, player, id, intid, code)

if (intid == 1) then
if (player:GetItemCount(43676) < 5) then --Remember to set the item id!
player:SendAreaTriggerMessage("You don't have enough Coins to bet!")
player:GossipComplete()
else
Choice=math.random(1, 100)
if Choice >= 1 and Choice <= 25 then -- Change 20 to another procent. Currently the chance for u win is 25%
player:SendAreaTriggerMessage("You won 25 Coins! Lucky you >.<")
unit:FullCastSpellOnTarget(33082, player)
unit:FullCastSpellOnTarget(33081, player)
unit:FullCastSpellOnTarget(33077, player)
unit:FullCastSpellOnTarget(33078, player)
unit:FullCastSpellOnTarget(33079, player)
unit:FullCastSpellOnTarget(33080, player)
player:AddItem(43676, 25) -- REMEMBER TO SET ITEMID and 50 u win 50 coins. Be free to change it
player:GossipComplete()
else
player:SendAreaTriggerMessage("You lost 5 coins, and that means more money to Me!!! ")
player:RemoveItem(43676, 5)
player:GossipComplete()
end
end

if (intid == 2) then -- Ignore this <.> to fix the you can only have 1 gossip submenu bug :P
player:SendAreaTriggerMessage("")
player:GossipComplete()
end
end
end


RegisterUnitGossipEvent(6, 1, "Gambler_On_Gossip") -- Remember the npc id!
RegisterUnitGossipEvent(6, 2, "Gambler_Gossip_Submenus") 