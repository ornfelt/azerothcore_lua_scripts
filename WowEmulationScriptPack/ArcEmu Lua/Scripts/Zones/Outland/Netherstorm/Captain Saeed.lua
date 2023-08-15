--[[ Netherstorm -- Captain Saeed.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 23th, 2008. ]]

function Captain_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Captain_Cleave",1000,0)
end

function Captain_Cleave(Unit,Event)
    Unit:FullCastSpellOnTarget(15576,Unit:GetClosestPlayer())
end

function Captain_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Captain_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20985, 1, "Captain_OnEnterCombat")
RegisterUnitEvent (20985, 2, "Captain_OnLeaveCombat")
RegisterUnitEvent (20985, 4, "Captain_OnDied")
