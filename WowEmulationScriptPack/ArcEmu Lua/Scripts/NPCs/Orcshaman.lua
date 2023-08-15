function Orcshaman_OnCombat(pUnit, event) 
pUnit:SendChatMessage(12, 0, "Your dead!")
pUnit:RegisterEvent("Orcshaman_Lightning", 2000, 100)
pUnit:RegisterEvent("Orcshaman_Heal", 3000, 0)
end

function Orcshaman_Lightning(pUnit, event)
pUnit:StopMovement(2100)  
pUnit:FullCastSpellOnTarget(37273, pUnit:GetRandomPlayer(1))
end

function Orcshaman_Heal(pUnit, event) 
if pUnit:GetHealthPct() < 50 then
pUnit:FullCastSpell(38330)
end 
end

function Orcshaman_OnDied(pUnit, event) 
pUnit:RemoveEvents() 
pUnit:SendChatMessage(12, 0, "Damn...") 
end

RegisterUnitEvent(65002, 1, "Orcshaman_OnCombat")
RegisterUnitEvent(65002, 4, "Orcshaman_OnDied")