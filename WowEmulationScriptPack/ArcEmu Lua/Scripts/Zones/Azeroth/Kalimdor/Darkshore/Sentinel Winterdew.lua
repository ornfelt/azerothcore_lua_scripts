--[[ Darkshore -- Sentinel Winterdew.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 04th, 2008. ]]


function SentinelWinterdew_OnCombat(Unit, Event)
	Unit:RegisterEvent("SentinelWinterdew_Net", 10000, 0)
	Unit:RegisterEvent("SentinelWinterdew_Shoot", 6000, 0)
end

function SentinelWinterdew_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12024, 	pUnit:GetMainTank()) 
end

function SentinelWinterdew_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(23337, 	pUnit:GetMainTank()) 
end

function SentinelWinterdew_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SentinelWinterdew_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(25014, 1, "SentinelWinterdew_OnCombat")
RegisterUnitEvent(25014, 2, "SentinelWinterdew_OnLeaveCombat")
RegisterUnitEvent(25014, 4, "SentinelWinterdew_OnDied")