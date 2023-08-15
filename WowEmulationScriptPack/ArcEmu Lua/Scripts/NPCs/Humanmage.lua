function Humanmage_OnCombat(Unit, event)
Unit:RegisterEvent("Humanmage_Pyroblast", 8000, 4)
end

function Humanmage_Pyroblast(Unit, event) 
Unit:FullCastSpellOnTarget(31263, Unit:GetMainTank()) 
end

function Humanmage_OnDied(Unit, event) 
Unit:RemoveEvents()
end

RegisterUnitEvent(650016, 1, "Humanmage_OnCombat")
RegisterUnitEvent(650016, 4, "Humanmage_OnDied")