--[[ Netherstorm -- Captain Zovax.lua

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
    Unit:RegisterEvent("Captain_Toughen",1000,0)
end

function Captain_Cleave(Unit,Event)
    Unit:FullCastSpellOnTarget(15576,Unit:GetClosestPlayer())
end

function Captain_Thougen(Unit,Event)
    Unit:CastSpell(33962)
end

function Captain_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Captain_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20727, 1, "Captain_OnEnterCombat")
RegisterUnitEvent (20727, 2, "Captain_OnLeaveCombat")
RegisterUnitEvent (20727, 4, "Captain_OnDied")

