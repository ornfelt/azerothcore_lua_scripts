--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TempestRevenant_OnCombat(Unit, Event)
Unit:RegisterEvent("TempestRevenant_SeethingFlames", 6000, 0)
end

function TempestRevenant_SeethingFlames(Unit, Event) 
Unit:FullCastSpellOnTarget(56620, Unit:GetMainTank()) 
end

function TempestRevenant_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function TempestRevenant_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function TempestRevenant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30875, 1, "TempestRevenant_OnCombat")
RegisterUnitEvent(30875, 2, "TempestRevenant_OnLeaveCombat")
RegisterUnitEvent(30875, 3, "TempestRevenant_OnKilledTarget")
RegisterUnitEvent(30875, 4, "TempestRevenant_OnDied")