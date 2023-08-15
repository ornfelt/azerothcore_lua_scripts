--[[ Darkshore -- Reef Shark.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 04th, 2008. ]]


function ReefShark_OnCombat(Unit, Event)
	Unit:RegisterEvent("ReefShark_Thrash", 6000, 0)
end

function ReefShark_Thrash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3391, 	pUnit:GetMainTank()) 
end

function ReefShark_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ReefShark_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(12123, 1, "ReefShark_OnCombat")
RegisterUnitEvent(12123, 2, "ReefShark_OnLeaveCombat")
RegisterUnitEvent(12123, 4, "ReefShark_OnDied")