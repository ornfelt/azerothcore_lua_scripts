--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Arakis_OnCombat(Unit, Event)
	Unit:RegisterEvent("Arakis_BerserkerCharge", 6000, 0)
end

function Arakis_BerserkerCharge(Unit, Event) 
	Unit:FullCastSpellOnTarget(19471, 	Unit:GetRandomPlayer(0)) 
end

function Arakis_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Arakis_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Arakis_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15290, 1, "Arakis_OnCombat")
RegisterUnitEvent(15290, 2, "Arakis_OnLeaveCombat")
RegisterUnitEvent(15290, 3, "Arakis_OnKilledTarget")
RegisterUnitEvent(15290, 4, "Arakis_OnDied")