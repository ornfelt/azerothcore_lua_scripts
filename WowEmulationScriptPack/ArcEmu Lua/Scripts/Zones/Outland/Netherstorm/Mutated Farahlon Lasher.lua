--[[ Netherstorm -- Mutated Farahlon Lasher.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Lasher_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Lasher_Growth",1500,0)
end

function Lasher_Growth(Unit,Event)
    Unit:FullCastSpellOnTarget(36604,Unit:GetClosestPlayer())
end

function Lasher_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Lasher_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20983, 1, "Lasher_OnEnterCombat")
RegisterUnitEvent (20983, 2, "Lasher_OnLeaveCombat")
RegisterUnitEvent (20983, 4, "Lasher_OnDied")