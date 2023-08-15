--[[ Netherstorm -- Nether Drake.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Drake_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Drake_Presence",1000,0)
end

function Drake_Presence(Unit,Event)
    Unit:FullCastSpellOnTarget(36513,Unit:GetClosestPlayer())
end

function Drake_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Drake_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (18877, 1, "Drake_OnEnterCombat")
RegisterUnitEvent (18877, 2, "Drake_OnLeaveCombat")
RegisterUnitEvent (18877, 4, "Drake_OnDied")