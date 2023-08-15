function sar_OnCombat(pUnit, Event) 
pUnit:SendChatMessage(14, 1, "BY THE MIGHT OF THE LICH KING!")
pUnit:RegisterEvent("sar_blood1", 25000, 0)
pUnit:RegisterEvent("sar_blood2", 26000, 0)
pUnit:RegisterEvent("sar_boiling", 30000, 0)
pUnit:RegisterEvent("sar_nova", 39000, 0)
pUnit:RegisterEvent("bloodbeast_spawn", 45000, 0)
pUnit:RegisterEvent("sar_mark", 65000, 0)
pUnit:RegisterEvent("sar_phase2", 1000, 0)
end

function sar_blood1(pUnit, Event)
pUnit:CastSpellOnTarget(72410, pUnit:GetMainTank())
end

function sar_blood2(pUnit, Event)
pUnit:CastSpellOnTarget(72408, pUnit:GetMainTank())
end

function sar_boiling(pUnit, Event)
pUnit:CastSpellOnTarget(72385, pUnit:GetRandomPlayer(0))
end

function sar_nova(pUnit, Event)
pUnit:CastSpellOnTarget(72380, pUnit:GetRandomPlayer(0))
end

function bloodbeast_spawn(pUnit, Event) 
pUnit:SendChatMessage(14, 1, "Feast my minions!")
pUnit:CastSpell(72172)
x = pUnit:GetX()
y = pUnit:GetY()
z = pUnit:GetZ()
o = pUnit:GetO()
pUnit:SpawnCreature(99926,x+10,y,z,o,2,0)
pUnit:SetFaction(90)
end

function sar_mark(pUnit, Event)
pUnit:CastSpellOnTarget(72293, pUnit:GetRandomPlayer(0))
end

function sar_phase2(pUnit, Event)
if pUnit:GetHealthPct() < 30 then
pUnit:RemoveEvents()
pUnit:CastSpell(72737)
pUnit:RegisterEvent("sar_blood1", 25000, 0)
pUnit:RegisterEvent("sar_blood2", 26000, 0)
pUnit:RegisterEvent("sar_boiling", 30000, 0)
pUnit:RegisterEvent("sar_nova", 39000, 0)
pUnit:RegisterEvent("bloodbeast_spawn", 45000, 0)
pUnit:RegisterEvent("sar_mark", 65000, 0)
end
end

function sar_blood1(pUnit, Event)
pUnit:CastSpellOnTarget(72410, pUnit:GetMainTank())
end

function sar_blood2(pUnit, Event)
pUnit:CastSpellOnTarget(72408, pUnit:GetMainTank())
end

function sar_boiling(pUnit, Event)
pUnit:CastSpellOnTarget(72385, pUnit:GetRandomPlayer(0))
end

function sar_nova(pUnit, Event)
pUnit:CastSpellOnTarget(72380, pUnit:GetRandomPlayer(0))
end

function bloodbeast_spawn(pUnit, Event) 
pUnit:SendChatMessage(14, 1, "Feast my minions!")
pUnit:CastSpell(72172)
x = pUnit:GetX()
y = pUnit:GetY()
z = pUnit:GetZ()
o = pUnit:GetO()
pUnit:SpawnCreature(99926,x+10,y,z,o,2,0)
pUnit:SetFaction(90)
end

function sar_mark(pUnit, Event)
pUnit:CastSpellOnTarget(72293, pUnit:GetRandomPlayer(0))
pUnit:SendChatMessage(14, 1, "The ground runs red with your blood!")
end

function sar_OnLeaveCombat(pUnit, Event) 
pUnit:RemoveAura(72737)
pUnit:RemoveEvents() 
end

function sar_OnKilledTarget(pUnit, Event) 
pUnit:CastSpell(72260)
pUnit:SendChatMessage(14, 1, "You are nothing!")
end

function sar_OnDied(pUnit, Event) 
pUnit:RemoveEvents() 
pUnit:SendChatMessage(14, 1, "I...Am...Released") 
end


RegisterUnitEvent(99916, 1, "sar_OnCombat")
RegisterUnitEvent(99916, 2, "sar_OnLeaveCombat")
RegisterUnitEvent(99916, 3, "sar_OnKilledTarget")
RegisterUnitEvent(99916, 4, "sar_OnDied")