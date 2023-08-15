--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CorruptedDreadmawCrocolisk_OnCombat(Unit, Event)
	Unit:RegisterEvent("CorruptedDreadmawCrocolisk_DecayedAgility", 10000, 1)
end

function CorruptedDreadmawCrocolisk_DecayedAgility(Unit, Event) 
	Unit:FullCastSpellOnTarget(7901, 	Unit:GetMainTank()) 
end

function CorruptedDreadmawCrocolisk_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CorruptedDreadmawCrocolisk_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function CorruptedDreadmawCrocolisk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3231, 1, "CorruptedDreadmawCrocolisk_OnCombat")
RegisterUnitEvent(3231, 2, "CorruptedDreadmawCrocolisk_OnLeaveCombat")
RegisterUnitEvent(3231, 3, "CorruptedDreadmawCrocolisk_OnKilledTarget")
RegisterUnitEvent(3231, 4, "CorruptedDreadmawCrocolisk_OnDied")