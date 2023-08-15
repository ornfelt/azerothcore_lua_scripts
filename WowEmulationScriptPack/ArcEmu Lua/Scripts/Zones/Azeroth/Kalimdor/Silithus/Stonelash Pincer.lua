--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function StonelashPincer_OnCombat(Unit, Event)
	Unit:RegisterEvent("StonelashPincer_TendonRip", 6000, 0)
	Unit:RegisterEvent("StonelashPincer_VenomSting", 8000, 0)
end

function StonelashPincer_TendonRip(Unit, Event) 
	Unit:FullCastSpellOnTarget(3604, 	Unit:GetMainTank()) 
end

function StonelashPincer_VenomSting(Unit, Event) 
	Unit:FullCastSpellOnTarget(5416, 	Unit:GetMainTank()) 
end

function StonelashPincer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function StonelashPincer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function StonelashPincer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11736, 1, "StonelashPincer_OnCombat")
RegisterUnitEvent(11736, 2, "StonelashPincer_OnLeaveCombat")
RegisterUnitEvent(11736, 3, "StonelashPincer_OnKilledTarget")
RegisterUnitEvent(11736, 4, "StonelashPincer_OnDied")