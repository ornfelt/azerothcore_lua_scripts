function Orcbossguard_OnCombat(pUnit, event)
pUnit:SendChatMessage(14, 0, "Your not gonna kill my master!")
pUnit:RegisterEvent("Orcbossguard_Rend", 0, 2)
pUnit:RegisterEvent("Orcbossguard_HeroStri", 10, 20)
pUnit:RegisterEvent("Orcbossguard_Transform",1000,0)
end

function Orcbossguard_Rend(pUnit, event) 
pUnit:FullCastSpellOnTarget(17504, pUnit:GetMainTank(1)) 
end

function Orcbossguard_HeroStri(pUnit, event) 
pUnit:FullCastSpellOnTarget(41975, pUnit:GetMainTank(1)) 
end

function Orcbossguard_Transform(pUnit, event) 
if pUnit:GetHealthPct() < 30 then
pUnit:SendChatMessage(14, 0, "Your makeing me angry!")
pUnit:RemoveEvents()
pUnit:SetModel(17398)
end 
end

function Orcbossguard_OnDied(pUnit, event) 
pUnit:RemoveEvents()
end

RegisterUnitEvent(65007, 1, "Orcbossguard_OnCombat")
RegisterUnitEvent(65007, 4, "Orcbossguard_OnDied")