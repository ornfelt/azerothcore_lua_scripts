--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DreadmawCrocolisk_OnCombat(Unit, Event)
	Unit:RegisterEvent("DreadmawCrocolisk_MuscleTear", 8000, 0)
end

function DreadmawCrocolisk_MuscleTear(Unit, Event) 
	Unit:FullCastSpellOnTarget(12166, 	Unit:GetMainTank()) 
end

function DreadmawCrocolisk_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DreadmawCrocolisk_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DreadmawCrocolisk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3110, 1, "DreadmawCrocolisk_OnCombat")
RegisterUnitEvent(3110, 2, "DreadmawCrocolisk_OnLeaveCombat")
RegisterUnitEvent(3110, 3, "DreadmawCrocolisk_OnKilledTarget")
RegisterUnitEvent(3110, 4, "DreadmawCrocolisk_OnDied")