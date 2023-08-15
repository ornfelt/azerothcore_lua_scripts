--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function KreggKeelhaul_OnCombat(Unit, Event)
	Unit:RegisterEvent("KreggKeelhaul_Cleave", 4000, 0)
	Unit:RegisterEvent("KreggKeelhaul_Strike", 6000, 0)
end

function KreggKeelhaul_Cleave(Unit, Event) 
	Unit:CastSpell(40504) 
end

function KreggKeelhaul_Strike(Unit, Event) 
	Unit:FullCastSpellOnTarget(11976, 	Unit:GetMainTank()) 
end

function KreggKeelhaul_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function KreggKeelhaul_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function KreggKeelhaul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(8203, 1, "KreggKeelhaul_OnCombat")
RegisterUnitEvent(8203, 2, "KreggKeelhaul_OnLeaveCombat")
RegisterUnitEvent(8203, 3, "KreggKeelhaul_OnKilledTarget")
RegisterUnitEvent(8203, 4, "KreggKeelhaul_OnDied")