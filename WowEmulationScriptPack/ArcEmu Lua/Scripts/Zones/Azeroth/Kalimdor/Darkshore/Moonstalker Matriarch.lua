--[[ Darkshore -- Moonstalker Matriarch.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 04th, 2008. ]]


function MoonstalkerMatriarch_OnCombat(Unit, Event)
	Unit:RegisterEvent("MoonstalkerMatriarch_SummonMoonstalkerRunt", 2000, 1)
end

function MoonstalkerMatriarch_SummonMoonstalkerRunt(pUnit, Event) 
	pUnit:CastSpell(8594) 
end

function MoonstalkerMatriarch_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MoonstalkerMatriarch_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2071, 1, "MoonstalkerMatriarch_OnCombat")
RegisterUnitEvent(2071, 2, "MoonstalkerMatriarch_OnLeaveCombat")
RegisterUnitEvent(2071, 4, "MoonstalkerMatriarch_OnDied")