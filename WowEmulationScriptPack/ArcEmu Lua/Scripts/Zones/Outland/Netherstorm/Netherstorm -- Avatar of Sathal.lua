--[[ Netherstorm -- Avatar of Sathal.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 23th, 2008. ]]

function Avatar_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Avatar_Rain",1000,0)
    Unit:RegisterEvent("Avatar_Bolt",3000,0)
end

function Avatar_Rain(Unit,Event)
    Unit:FullCastSpellOnTarget(34017, Unit:GetClosestPlayer())
end

function Avatar_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(12471, Unit:GetClosestPlayer())
end

function Avatar_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Avatar_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (21925, 1, "Avatar_OnEnterCombat")
RegisterUnitEvent (21925, 2, "Avatar_OnLeaveCombat")
RegisterUnitEvent (21925, 4, "Avatar_OnDied")
