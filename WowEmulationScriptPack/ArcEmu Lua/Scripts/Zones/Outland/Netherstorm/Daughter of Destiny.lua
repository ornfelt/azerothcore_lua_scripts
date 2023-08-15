--[[ Netherstorm -- Daughter of Destiny.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 24th, 2008. ]]

function Daughter_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Daughter_Nova",2000,0)
end

function Daughter_Nova(Unit,Event)
    Unit:FullCastSpellOnTarget(36225, Unit:GetClosestPlayer())
end

function Daughter_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Daughter_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (18860, 1, "Daughter_OnEnterCombat")
RegisterUnitEvent (18860, 2, "Daughter_OnLeaveCombat")
RegisterUnitEvent (18860, 4, "Daughter_OnDied")
