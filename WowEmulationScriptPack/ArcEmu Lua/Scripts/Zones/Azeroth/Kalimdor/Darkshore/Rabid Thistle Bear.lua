--[[ Darkshore -- Rabid Thistle Bear.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 04th, 2008. ]]


function RabidThistleBear_OnCombat(Unit, Event)
	Unit:RegisterEvent("RabidThistleBear_Rabies", 5000, 1)
end

function RabidThistleBear_Rabies(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3150, 	pUnit:GetMainTank()) 
end

function RabidThistleBear_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RabidThistleBear_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2164, 1, "RabidThistleBear_OnCombat")
RegisterUnitEvent(2164, 2, "RabidThistleBear_OnLeaveCombat")
RegisterUnitEvent(2164, 4, "RabidThistleBear_OnDied")