--[[ Darkshore -- Sentinel Brightgrass.lua

This script was written and is protected
by the GPL v2. This script was released
by MikeBeck  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- MikeBeck, December, 04th, 2008. ]]


function SentinelBrightgrass_OnCombat(Unit, Event)
	Unit:RegisterEvent("SentinelBrightgrass_Net", 10000, 0)
	Unit:RegisterEvent("SentinelBrightgrass_Shoot", 6000, 0)
end

function SentinelBrightgrass_Net(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12024, 	pUnit:GetMainTank()) 
end

function SentinelBrightgrass_Shoot(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(23337, 	pUnit:GetMainTank()) 
end

function SentinelBrightgrass_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SentinelBrightgrass_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(25013, 1, "SentinelBrightgrass_OnCombat")
RegisterUnitEvent(25013, 2, "SentinelBrightgrass_OnLeaveCombat")
RegisterUnitEvent(25013, 4, "SentinelBrightgrass_OnDied")