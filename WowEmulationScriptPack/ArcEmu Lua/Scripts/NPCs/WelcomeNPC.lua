function WelcomeNPC_OnGossipTalk(pUnit, event, player, pMisc)
if (player:IsInCombat() == true) then
player:SendAreaTriggerMessage("You Can't Claim Your Items While In Combat!")
else
pUnit:GossipCreateMenu(3544, player, 0)
pUnit:GossipMenuAddItem(2, "Weapons", 1, 0)
pUnit:GossipSendMenu(player)
end
end

function WelcomeNPC_OnGossipSelect(pUnit, event, player, id, intid, code)


if(intid == 1) then
pUnit:GossipCreateMenu(52, player, 0)
pUnit:GossipMenuAddItem(2, "1H Sword", 14, 0)
pUnit:GossipMenuAddItem(2, "2H Sword", 15, 0)
pUnit:GossipMenuAddItem(2, "Bow", 16, 0)
pUnit:GossipMenuAddItem(2, "Dagger", 17, 0)
pUnit:GossipMenuAddItem(2, "2H Axe", 18, 0)
pUnit:GossipMenuAddItem(2, "1H Mace", 19, 0)
pUnit:GossipMenuAddItem(2, "2H Mace", 20, 0)
pUnit:GossipMenuAddItem(2, "Staff", 21, 0)
pUnit:GossipMenuAddItem(2, "Gun", 22, 0)
pUnit:GossipMenuAddItem(2, "Arrows", 23, 0)
pUnit:GossipMenuAddItem(2, "Bullets", 24, 0)
pUnit:GossipMenuAddItem(2, "Bags", 25, 0)
pUnit:GossipMenuAddItem(2, "Ammo Pouch", 26, 0)
pUnit:GossipMenuAddItem(2, "Shields", 28, 0)
pUnit:GossipMenuAddItem(2, "Quiver", 27, 0)
pUnit:GossipMenuAddItem(2, "Totem", 29, 0)
pUnit:GossipSendMenu(player)
end



if(intid == 14) then
player:AddItem(42945, 1)
player:GossipComplete()
end

if(intid == 15) then
player:AddItem(44092, 1)
player:GossipComplete()
end

if(intid == 16) then
player:AddItem(42946, 1)
player:GossipComplete()
end

if(intid == 17) then
player:AddItem(42944, 1)
player:GossipComplete()
end

if(intid == 18) then
player:AddItem(42943, 1)
player:GossipComplete()
end

if(intid == 19) then
player:AddItem(48716, 1)
player:AddItem(42948, 1)
player:GossipComplete()
end

if(intid == 20) then
player:AddItem(48718, 1)
player:GossipComplete()
end

if(intid == 21) then
player:AddItem(42947, 1)
player:GossipComplete()
end

if(intid == 22) then
player:AddItem(44093, 1)
player:GossipComplete()
end

if(intid == 23) then
player:AddItem(3464, 1000)
player:GossipComplete()
end

if(intid == 24) then
player:AddItem(3465, 1000)
player:GossipComplete()
end

if(intid == 25) then
player:AddItem(21841, 4)
player:GossipComplete()
end

if(intid == 26) then
player:AddItem(3604, 1)
player:GossipComplete()
end

if(intid == 27) then
player:AddItem(3605, 1)
player:GossipComplete()
end

if(intid == 28) then
player:AddItem(23043, 1)
player:AddItem(22819, 1)
player:GossipComplete()
end

if(intid == 28) then
player:AddItem(46978, 1)
player:GossipComplete()
end


if(intid == 42) then
player:LearnSpell(750)
player:GossipComplete()
end

if(intid == 43) then
player:LearnSpell(8737)
player:GossipComplete()
end

if(intid == 44) then
player:LearnSpell(669)
player:LearnSpell(668)
player:GossipComplete()
end
end

RegisterUnitGossipEvent(900035, 1, "WelcomeNPC_OnGossipTalk")
RegisterUnitGossipEvent(900035, 2, "WelcomeNPC_OnGossipSelect")