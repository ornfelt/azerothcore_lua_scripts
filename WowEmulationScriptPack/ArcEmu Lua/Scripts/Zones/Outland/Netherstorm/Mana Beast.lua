--[[ Netherstorm -- Mana Beast.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Beast_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Beast_Burn",1000,0)
end

function Beast_Burn(Unit,Event)
    Unit:FullCastSpellOnTarget(36484,Unit:GetClosestPlayer())
end

function Beast_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Beast_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (21267, 1, "Beast_OnEnterCombat")
RegisterUnitEvent (21267, 2, "Beast_OnLeaveCombat")
RegisterUnitEvent (21267, 4, "Beast_OnDied")