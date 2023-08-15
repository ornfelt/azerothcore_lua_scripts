--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

local npcid = 7000024

function spellst_on_gossip(unit, Event, player)
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(7, "Absorb Life", 528, 0)
unit:GossipMenuAddItem(7, "Instant Cast", 527, 0)
unit:GossipMenuAddItem(7, "Chicken Form", 529, 0)
unit:GossipMenuAddItem(7, "Adored", 530, 0)
unit:GossipMenuAddItem(7, "Albino Snapjaw", 531, 0)
unit:GossipMenuAddItem(7, "Test Mount #1", 532, 0)
unit:GossipMenuAddItem(7, "Test Mount #2", 533, 0)
unit:GossipMenuAddItem(7, "Stun a Abuser", 534, 0)
unit:GossipMenuAddItem(7, "Corrupted Kitten", 535, 0)
unit:GossipMenuAddItem(7, "?", 536, 0)
unit:GossipMenuAddItem(7, "?", 537, 0)
unit:GossipMenuAddItem(7, "?", 538, 0)
unit:GossipMenuAddItem(7, "Alliance Flag Capture", 539, 0)
unit:GossipMenuAddItem(7, "Alliance Flag Drop", 540, 0)
unit:GossipSendMenu(player)
end

function spellst_submenus(unit, event, player, id, intid, code, pMisc)
if(intid == 527) then
player:LearnSpell(45813)
player:GossipComplete()
end

if(intid == 528) then
player:LearnSpell(34036)
player:GossipComplete()
end

if(intid == 529) then
player:LearnSpell(9220)
player:GossipComplete()
end

if(intid == 530) then
player:LearnSpell(26680)
player:GossipComplete()
end

if(intid == 531) then
player:LearnSpell(23428)
player:GossipComplete()
end

if(intid == 532) then
player:LearnSpell(46980)
player:GossipComplete()
end

if(intid == 533) then
player:LearnSpell(42929)
player:GossipComplete()
end

if(intid == 534) then
player:LearnSpell(73536)
player:GossipComplete()
end

if(intid == 535) then
player:LearnSpell(15648)
player:GossipComplete()
end

if(intid == 536) then
player:LearnSpell()
player:GossipComplete()
end

if(intid == 537) then
player:LearnSpell()
player:GossipComplete()
end

if(intid == 538) then
player:LearnSpell()
player:GossipComplete()
end

if(intid == 539) then
player:LearnSpell(23389)
player:GossipComplete()
end

if(intid == 540) then
player:LearnSpell(23336)
player:GossipComplete()
end
end

RegisterUnitGossipEvent(npcid, 1, "spellst_on_gossip")
RegisterUnitGossipEvent(npcid, 2, "spellst_submenus")