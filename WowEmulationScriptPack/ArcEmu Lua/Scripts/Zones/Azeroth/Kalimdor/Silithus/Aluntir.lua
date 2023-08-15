--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Aluntir_OnCombat(Unit, Event)
	Unit:RegisterEvent("Aluntir_BerserkerCharge", 6000, 0)
end

function Aluntir_BerserkerCharge(Unit, Event) 
	Unit:FullCastSpellOnTarget(19471, 	Unit:GetRandomPlayer(0)) 
end

function Aluntir_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Aluntir_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Aluntir_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15288, 1, "Aluntir_OnCombat")
RegisterUnitEvent(15288, 2, "Aluntir_OnLeaveCombat")
RegisterUnitEvent(15288, 3, "Aluntir_OnKilledTarget")
RegisterUnitEvent(15288, 4, "Aluntir_OnDied")