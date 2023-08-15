function orcworg_OnCombat(pUnit, event)
pUnit:RegisterEvent("orcworg_Transform",1000,0)
end

function orcworg_Transform(pUnit, event) 
if pUnit:GetHealthPct() < 45 then 
pUnit:RemoveEvents() 
pUnit:FullCastSpell(14202)
pUnit:SetModel(11419)
pUnit:SetScale(2)
end 
end

function orcworg_OnDied(pUnit, event) 
pUnit:RemoveEvents()
end

RegisterUnitEvent(65006, 1, "orcworg_OnCombat")
RegisterUnitEvent(65006, 4, "orcworg_OnDied")