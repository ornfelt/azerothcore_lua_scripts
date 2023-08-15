--[[ Darkshore -- Moonstalker Runt.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 04th, 2008. ]]


function MoonstalkerRunt_OnCombat(Unit, Event)
	Unit:RegisterEvent("MoonstalkerRunt_Claw", 6000, 0)
	Unit:RegisterEvent("MoonstalkerRunt_Rake", 10000, 0)
end

function MoonstalkerRunt_Claw(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(16828, 	pUnit:GetMainTank()) 
end

function MoonstalkerRunt_Rake(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(59881, 	pUnit:GetMainTank()) 
end

function MoonstalkerRunt_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MoonstalkerRunt_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2070, 1, "MoonstalkerRunt_OnCombat")
RegisterUnitEvent(2070, 2, "MoonstalkerRunt_OnLeaveCombat")
RegisterUnitEvent(2070, 4, "MoonstalkerRunt_OnDied")