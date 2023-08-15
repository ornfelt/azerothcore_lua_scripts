--[[ Netherstorm -- Protectorate Regenerator.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Regenerator_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Regenerator_Bolt",2500,0)
end

function Regenerator_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(34232,Unit:ClosestPlayer())
end   
    
function Regenerator_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Regenerator_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (21783, 1, "Regenerator_OnEnterCombat")
RegisterUnitEvent (21783, 2, "Regenerator_OnLeaveCombat")
RegisterUnitEvent (21783, 4, "Regenerator_OnDied")