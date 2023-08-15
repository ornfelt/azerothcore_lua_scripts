--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Duskstalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("Duskstalker_TendonRip", 8000, 0)
end

function Duskstalker_TendonRip(Unit, Event) 
	Unit:FullCastSpellOnTarget(3604, 	Unit:GetMainTank()) 
end

function Duskstalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Duskstalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Duskstalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14430, 1, "Duskstalker_OnCombat")
RegisterUnitEvent(14430, 2, "Duskstalker_OnLeaveCombat")
RegisterUnitEvent(14430, 3, "Duskstalker_OnKilledTarget")
RegisterUnitEvent(14430, 4, "Duskstalker_OnDied")