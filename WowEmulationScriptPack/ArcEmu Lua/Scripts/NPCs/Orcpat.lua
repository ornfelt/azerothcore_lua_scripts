function Orcpat_OnCombat(pUnit, event) 
pUnit:SendChatMessage(14, 0, "Your not gonna get past me!")
pUnit:RegisterEvent("Orcpat_Transform", 1000, 0)
end

function Orcpat_Transform(pUnit, event) 
if pUnit:GetHealthPct() < 50 then 
pUnit:RemoveEvents()
pUnit:FullCastSpell(20370)
pUnit:FullCastSpell(44779)
pUnit:SetFaction(14)
pUnit:SetModel(17053)
end 
end

function Orcpat_OnDied(pUnit, event) 
pUnit:RemoveEvents() 
pUnit:SendChatMessage(12, 0, "sorry... i.....failed.....") 
end

function Orcpat_OnKilledTarget(pUnit, event) 
pUnit:SendChatMessage(12, 0, "hehe, as i thought you are weak...") 
end

RegisterUnitEvent(65003, 1, "Orcpat_OnCombat")
RegisterUnitEvent(65003, 3, "Orcpat_OnKilledTarget")
RegisterUnitEvent(65003, 4, "Orcpat_OnDied")