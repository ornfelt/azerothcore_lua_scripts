-- Barthalus
local NPCID = 90100
 
function Spellmaster_OnCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Who dares disturbing me?")
pUnit:RegisterEvent("Spellmaster_Shadowbolt", 8000, 0)
pUnit:RegisterEvent("Spellmaster_Fireball", 3000, 0)
pUnit:RegisterEvent("Spellmaster_Frostbolt", 10000, 0)
pUnit:RegisterEvent("Spellmaster_Charge", 12000, 0)
end
 
function Spellmaster_Shadowbolt(pUnit, Event)
if(pUnit:GetCurrentSpell() == nil) then
pUnit:CastSpellOnTarget(22336, pUnit:GetRandomPlayer(0))
end
end
 
function Spellmaster_Fireball(pUnit, Event)
if(pUnit:GetCurrentSpell() == nil) then
pUnit:FullCastSpellOnTarget(10150, pUnit:GetRandomPlayer(0))
end
end
 
function Spellmaster_Frostbolt(pUnit, Event)
if(pUnit:GetCurrentSpell() == nil) then
pUnit:FullCastSpellOnTarget(10180, pUnit:GetMainTank())
end
end
 
function Spellmaster_Charge(pUnit, Event)
if(pUnit:GetCurrentSpell() == nil) then
pUnit:FullCastSpellOnTarget(26561, pUnit:GetRandomPlayer(0))
end
end
	
function Spellmaster_OnLeaveCombat(pUnit, Event)
pUnit:SendChatMessage(14, 0, "And another bunch of weaklings that spilled my time")
pUnit:RemoveEvents()
end
 
function Spellmaster_OnKilledTarget(pUnit, Event)
pUnit:SendChatMessage(14, 0, "Thanks for the heal!")
pUnit:CastSpell(66053)
end
 
function Spellmaster_OnDeath(pUnit, Event)
pUnit:SendChatMessage(14, 0, "How have you defeated me? NOOOO!")
pUnit:RemoveEvents()
end
 
RegisterUnitEvent(NPCID, 1, "Spellmaster_OnCombat")
RegisterUnitEvent(NPCID, 2, "Spellmaster_OnLeaveCombat")
RegisterUnitEvent(NPCID, 3, "Spellmaster_OnKilledTarget")
RegisterUnitEvent(NPCID, 4, "Spellmaster_OnDeath")