--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EarthenTemplar_OnCombat(Unit, Event)
	Unit:RegisterEvent("EarthenTemplar_KnockAway", 6000, 0)
	Unit:RegisterEvent("EarthenTemplar_EntanglingRoots", 8000, 0)
end

function EarthenTemplar_KnockAway(Unit, Event) 
	Unit:FullCastSpellOnTarget(18813, 	Unit:GetMainTank()) 
end

function EarthenTemplar_EntanglingRoots(Unit, Event) 
	Unit:FullCastSpellOnTarget(22127, 	Unit:GetRandomPlayer(0)) 
end

function EarthenTemplar_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function EarthenTemplar_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function EarthenTemplar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15307, 1, "EarthenTemplar_OnCombat")
RegisterUnitEvent(15307, 2, "EarthenTemplar_OnLeaveCombat")
RegisterUnitEvent(15307, 3, "EarthenTemplar_OnKilledTarget")
RegisterUnitEvent(15307, 4, "EarthenTemplar_OnDied")