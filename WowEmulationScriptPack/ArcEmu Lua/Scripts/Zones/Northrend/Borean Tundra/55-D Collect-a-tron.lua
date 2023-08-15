--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DCollectatron_OnCombat(Unit, Event)
	Unit:RegisterEvent("DCollectatron_DumpOil", 10000, 0)
end

function DCollectatron_DumpOil(Unit, Event) 
	Unit:FullCastSpellOnTarget(50269, 	Unit:GetMainTank()) 
end

function DCollectatron_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DCollectatron_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DCollectatron_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25793, 1, "DCollectatron_OnCombat")
RegisterUnitEvent(25793, 2, "DCollectatron_OnLeaveCombat")
RegisterUnitEvent(25793, 3, "DCollectatron_OnKilledTarget")
RegisterUnitEvent(25793, 4, "DCollectatron_OnDied")