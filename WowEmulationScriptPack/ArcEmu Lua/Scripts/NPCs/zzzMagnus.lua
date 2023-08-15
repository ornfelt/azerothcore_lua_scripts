--************************************************************
--*                                                          *
--*               ******************************             *                   
--*               *                            *             *
--*               *   The FrostTeam Project    *             *     
--*               *        stoneharry          *             *
--*               ******************************             *            
--*                                                          *
--*                                                          *
--*      --FrostTeam SVN consists of the latest WotLK        *   
--*      scripts, both Lua and C++. Some will be our own,    *
--*      some will be others with credits attatched. Our     *
--*      Svn includes all scripts that you may need          *
--*      to help make your server a more fun environment.--  *
--*                                                          *
--************************************************************


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
pUnit:FullCastSpell(45855)
end
if Choice==3 then
pUnit:SendChatMessage(14, 0, "Enough, now you vermin shall feel the force of my bearth right, the fury of the earth it's self...")
pUnit:PlaySoundToSet(8289)
pUnit:FullCastSpellOnTarget(31984, pUnit:GetRandomPlayer(0))
end 
end
function Brutthe_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Burn you wretches, Burn!")
pUnit:PlaySoundToSet(8290)
pUnit:RegisterEvent("Combatthe_Talk", 25000, 0)
pUnit:RegisterEvent("Stompthe", 45000, 0)
pUnit:RegisterEvent("Killthe", 30000, 0)
pUnit:RegisterEvent("Sillythe", 60000, 0)
pUnit:CastSpell(44120)
pUnit:CastSpell(44868)
pUnit:CastSpell(41989)
pUnit:CastSpell(38771)
end
function Brutthe_OnLeaveCombat(pUnit, Event)
pUnit:RemoveEvents() 
end
function Brutthe_OnKilledTarget (pUnit, Event)
pUnit:SendChatMessage(14, 0, "Reckless wrech, your friend shall join you soon enough!")
pUnit:PlaySoundToSet(8293)
pUnit:CastSpell(40845)
end
function Brutthe_OnDied(pUnit, Event)
pUnit:RemoveEvents() 
end
RegisterUnitEvent(632252, 1, "Brutthe_OnCombat")
RegisterUnitEvent(632252, 2, "Brutthe_OnLeaveCombat")
RegisterUnitEvent(632252, 3, "Brutthe_OnKilledTarget")
RegisterUnitEvent(632252, 4, "Brutthe_OnDied")
