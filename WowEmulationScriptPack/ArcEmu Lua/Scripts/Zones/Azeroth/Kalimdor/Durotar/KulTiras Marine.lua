--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function KulTirasMarine_OnCombat(Unit, Event)
	Unit:RegisterEvent("KulTirasMarine_ShieldBash", 6000, 0)
end

function KulTirasMarine_ShieldBash(Unit, Event) 
	Unit:FullCastSpellOnTarget(11972, 	Unit:GetMainTank()) 
end

function KulTirasMarine_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KulTirasMarine_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KulTirasMarine_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3129, 1, "KulTirasMarine_OnCombat")
RegisterUnitEvent(3129, 2, "KulTirasMarine_OnLeaveCombat")
RegisterUnitEvent(3129, 3, "KulTirasMarine_OnKilledTarget")
RegisterUnitEvent(3129, 4, "KulTirasMarine_OnDied")