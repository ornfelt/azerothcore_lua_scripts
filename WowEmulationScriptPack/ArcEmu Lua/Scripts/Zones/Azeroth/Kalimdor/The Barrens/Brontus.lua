--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function Brontus_OnCombat(Unit, Event)
	Unit:RegisterEvent("Brontus_PierceArmor", 10000, 0)
	Unit:RegisterEvent("Brontus_RushingCharge", 8000, 0)
end

function Brontus_PierceArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(6016, 	Unit:GetMainTank()) 
end

function Brontus_RushingCharge(Unit, Event) 
	Unit:CastSpell(6268) 
end

function Brontus_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Brontus_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Brontus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5827, 1, "Brontus_OnCombat")
RegisterUnitEvent(5827, 2, "Brontus_OnLeaveCombat")
RegisterUnitEvent(5827, 3, "Brontus_OnKilledTarget")
RegisterUnitEvent(5827, 4, "Brontus_OnDied")