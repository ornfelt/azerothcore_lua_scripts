function Medivh_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(100, player, 0)
pUnit:GossipMenuAddItem(0, "I want to challenge the master of this temple.", 1, 0)
pUnit:GossipMenuAddItem(0, "This challenge is to hard, just kill me!", 2, 0)
pUnit:GossipMenuAddItem(0, "Make me stronger!", 3, 0)
pUnit:GossipSendMenu(player)
end
function Medivh_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
if (intid == 1) then
pUnit:SendChatMessage(14, 0, "Your doomed! Haha!")
pUnit:Despawn(1, 0)
pUnit:SpawnCreature(90001, -651, -268, 353, 0.711792, 14, 360000)
pUnit:GossipComplete(player)
end
if (intid == 2) then
pUnit:SendChatMessage(14, 0, "Die Worm!")
pUnit:FullCastSpellOnTarget(31984, player)
pUnit:GossipComplete(player)
end
if (intid == 3) then
pUnit:SendChatMessage(14, 0, "May the Lord watch over you!")
pUnit:FullCastSpellOnTarget(16609, player)
pUnit:PlaySoundToSet(8818)
pUnit:GossipComplete(player)
end
end
function Stompthea(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Who dares violate the sanctiny of my domain, be warned, all who tresspass here are doomed...")
pUnit:PlaySoundToSet(8820)
pUnit:RemoveEvents()
pUnit:SetCombatCapable(1)
pUnit:SetFaction(35)
pUnit:RegisterEvent("Stomptheaz", 8000, 0)
end
function Stomptheaz(pUnit, Event)
pUnit:RemoveEvents()
pUnit:SendChatMessage(14, 0, "There will be no escape!")
pUnit:PlaySoundToSet(8813)
pUnit:SetCombatCapable(0)
pUnit:SetFaction(20)
pUnit:RegisterEvent("Combatthe_Talk", 25000, 0)
pUnit:RegisterEvent("Stompthe", 45000, 0)
pUnit:RegisterEvent("Killthe", 30000, 0)
pUnit:RegisterEvent("Sillythe", 60000, 0)
end
function Stompthe(pUnit, Event)
pUnit:FullCastSpellOnTarget(36886, pUnit:GetRandomPlayer(0))
pUnit:CastSpell(38380)
Choice=math.random(1, 2)
if Choice==1 then
pUnit:FullCastSpellOnTarget(38918, pUnit:GetRandomPlayer(0))
end 
if Choice==2 then
pUnit:FullCastSpellOnTarget(46043, pUnit:GetRandomPlayer(0))
end 
end
function Killthe(pUnit, Event)
pUnit:CastSpell(38627)
end
function Sillythe(pUnit, Event)
pUnit:FullCastSpellOnTarget(36886, pUnit:GetRandomPlayer(0))
end
function Combatthe_Talk(pUnit, Event)
Choice=math.random(1, 3)
if Choice==1 then
pUnit:SendChatMessage(14, 0, "This can not be, I am the master here, you mortals are nothing to my kind, do you hear? NOTHING!!!")
pUnit:CastSpell(40845)
pUnit:PlaySoundToSet(8292)
end 
if Choice==2 then
pUnit:SendChatMessage(14, 0, "Impossible... Rise my minions, serve your master once more")
pUnit:PlaySoundToSet(8291)
pUnit:CastSpell(37201)
pUnit:CastSpell(37201)
end
if Choice==3 then
pUnit:SendChatMessage(14, 0, "Enough, now you vermin shall feel the force of my bearth right, the fury of the earth it's self...")
pUnit:PlaySoundToSet(8289)
pUnit:FullCastSpellOnTarget(11, pUnit:GetRandomPlayer(0))
end 
end
function Brutthe_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Enough, I grow tired of these distractions...")
pUnit:PlaySoundToSet(9090)
pUnit:CastSpell(44120)
pUnit:CastSpell(44868)
pUnit:CastSpell(41989)
pUnit:CastSpell(38771)
pUnit:SetFaction(35)
pUnit:SetCombatCapable(1)
pUnit:RegisterEvent("Stompthea", 5000, 0)
end
function Brutthe_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents()
pUnit:SpawnCreature(90003, -640, -259, 353, 0.65461, 35, 0)
pUnit:Despawn(1, 0)
end
function Brutthe_OnKilledTarget (pUnit, Event)
pUnit:SendChatMessage(14, 0, "Reckless wrech, your friend shall join you soon enough!")
pUnit:PlaySoundToSet(8293)
pUnit:CastSpell(40845)
end
function Brutthe_OnDied(pUnit, Event)
pUnit:RemoveEvents()
pUnit:Despawn(1, 0)
end
RegisterUnitEvent(90001, 1, "Brutthe_OnCombat")
RegisterUnitEvent(90001, 2, "Brutthe_OnLeaveCombat")
RegisterUnitEvent(90001, 3, "Brutthe_OnKilledTarget")
RegisterUnitEvent(90001, 4, "Brutthe_OnDied")
RegisterUnitGossipEvent(90003, 1, "Medivh_OnGossipTalk")
RegisterUnitGossipEvent(90003, 2, "Medivh_OnGossipSelect")