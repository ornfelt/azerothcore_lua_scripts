--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CrimsonTemplar_OnCombat(Unit, Event)
	Unit:RegisterEvent("CrimsonTemplar_FireballVolley", 10000, 0)
	Unit:RegisterEvent("CrimsonTemplar_FlameBuffet", 8000, 0)
end

function CrimsonTemplar_FireballVolley(Unit, Event) 
	Unit:CastSpell(11989) 
end

function CrimsonTemplar_FlameBuffet(Unit, Event) 
	Unit:FullCastSpellOnTarget(16536, 	Unit:GetMainTank()) 
end

function CrimsonTemplar_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CrimsonTemplar_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function CrimsonTemplar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15209, 1, "CrimsonTemplar_OnCombat")
RegisterUnitEvent(15209, 2, "CrimsonTemplar_OnLeaveCombat")
RegisterUnitEvent(15209, 3, "CrimsonTemplar_OnKilledTarget")
RegisterUnitEvent(15209, 4, "CrimsonTemplar_OnDied")