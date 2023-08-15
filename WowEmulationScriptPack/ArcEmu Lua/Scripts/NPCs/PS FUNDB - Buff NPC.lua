local npcid = #######

function Buff_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(100, player, 0)
pUnit:GossipMenuAddItem(5, "Please give me power!", 1, 0)
pUnit:GossipMenuAddItem(9, "Cure me from Resurection Sickness!", 2, 0)
pUnit:GossipMenuAddItem(9, "Give me life!", 10, 0)
pUnit:GossipSendMenu(player)
end

function Buff_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
if (intid == 1) then
pUnit:GossipCreateMenu(99, player, 0)
pUnit:GossipMenuAddItem(3, "I need more agility.", 3, 0)
pUnit:GossipMenuAddItem(3, "I must have intellect.", 4, 0)
pUnit:GossipMenuAddItem(3, "I need protection.", 5, 0)
pUnit:GossipMenuAddItem(3, "I lost my spirit, give me more.", 6, 0)
pUnit:GossipMenuAddItem(3, "Stamina is what I need.", 7, 0)
pUnit:GossipMenuAddItem(3, "I'm not strong enough. Give me strength.", 8, 0)
pUnit:GossipSendMenu(player)
end
if (intid == 2) then
pUnit:CastSpellOnTarget(15007) 
player:UnlearnSpell(15007)
pUnit:GossipComplete(player)
end
if (intid == 3) then
pUnit:CastSpellOnTarget(33077, player)
pUnit:GossipComplete(player)
end
if (intid == 4) then
pUnit:CastSpellOnTarget(33078, player)
pUnit:GossipComplete(player)
end
if (intid == 5) then
pUnit:CastSpellOnTarget(33079, player)
pUnit:GossipComplete(player)
end
if (intid == 6) then
pUnit:CastSpellOnTarget(33080, player)
pUnit:GossipComplete(player)
end
if (intid == 7) then
pUnit:CastSpellOnTarget(33081, player)
pUnit:GossipComplete(player)
end
if (intid == 8) then
pUnit:CastSpellOnTarget(33082, player)
pUnit:GossipComplete(player)
end
if (intid == 10) then
pUnit:CastSpellOnTarget(17683, player)
pUnit:GossipComplete(player)
end
end

RegisterUnitGossipEvent(npcid, 1, "Buff_OnGossipTalk")
RegisterUnitGossipEvent(npcid, 2, "Buff_OnGossipSelect")