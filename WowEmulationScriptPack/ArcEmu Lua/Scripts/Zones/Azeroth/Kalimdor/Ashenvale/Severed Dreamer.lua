--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SeveredDreamer_OnCombat(Unit, Event)
	Unit:RegisterEvent("SeveredDreamer_SummonIllusionaryNightmare", 1000, 1)
end

function SeveredDreamer_SummonIllusionaryNightmare(pUnit, Event) 
	pUnit:CastSpell(6905) 
end

function SeveredDreamer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SeveredDreamer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3802, 1, "SeveredDreamer_OnCombat")
RegisterUnitEvent(3802, 2, "SeveredDreamer_OnLeaveCombat")
RegisterUnitEvent(3802, 4, "SeveredDreamer_OnDied")