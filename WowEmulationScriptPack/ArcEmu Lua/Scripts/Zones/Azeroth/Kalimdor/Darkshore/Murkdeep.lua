--[[ Darkshore -- Murkdeep.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 04th, 2008. ]]


function Murkdeep_OnCombat(Unit, Event)
	Unit:RegisterEvent("Murkdeep_Net", 10000, 0)
	Unit:RegisterEvent("Murkdeep_SunderArmor", 6000, 0)
end

function Murkdeep_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6533, 	pUnit:GetMainTank()) 
end

function Murkdeep_SunderArmor(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(11971, 	pUnit:GetMainTank()) 
end

function Murkdeep_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Murkdeep_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(10323, 1, "Murkdeep_OnCombat")
RegisterUnitEvent(10323, 2, "Murkdeep_OnLeaveCombat")
RegisterUnitEvent(10323, 4, "Murkdeep_OnDied")