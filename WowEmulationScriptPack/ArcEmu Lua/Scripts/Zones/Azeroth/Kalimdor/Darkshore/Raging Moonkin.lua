--[[ Darkshore -- Raging Moonkin.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 04th, 2008. ]]


function RagingMoonkin_OnCombat(Unit, Event)
	Unit:RegisterEvent("RagingMoonkin_Enrage", 10000, 1)
	Unit:RegisterEvent("RagingMoonkin_Rend", 8000, 0)
end

function RagingMoonkin_Enrage(pUnit, Event) 
	pUnit:CastSpell(8599) 
end

function RagingMoonkin_Rend(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(13443, 	pUnit:GetMainTank()) 
end

function RagingMoonkin_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RagingMoonkin_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(10160, 1, "RagingMoonkin_OnCombat")
RegisterUnitEvent(10160, 2, "RagingMoonkin_OnLeaveCombat")
RegisterUnitEvent(10160, 4, "RagingMoonkin_OnDied")