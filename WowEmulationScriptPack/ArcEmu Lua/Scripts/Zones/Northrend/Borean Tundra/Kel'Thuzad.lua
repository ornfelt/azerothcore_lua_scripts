--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KelThuzad_OnCombat(Unit, Event)
Unit:RegisterEvent("KelThuzad_SoulFlay", 15000, 0)
Unit:RegisterEvent("KelThuzad_UnholyFrenzy", 20000, 0)
end

function KelThuzad_SoulFlay(Unit, Event) 
Unit:FullCastSpellOnTarget(50319, Unit:GetMainTank()) 
end

function KelThuzad_UnholyFrenzy(Unit, Event) 
Unit:FullCastSpellOnTarget(50312, Unit:GetMainTank()) 
end

function KelThuzad_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function KelThuzad_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function KelThuzad_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25465, 1, "KelThuzad_OnCombat")
RegisterUnitEvent(25465, 2, "KelThuzad_OnLeaveCombat")
RegisterUnitEvent(25465, 3, "KelThuzad_OnKilledTarget")
RegisterUnitEvent(25465, 4, "KelThuzad_OnDied")