--[[ Netherstorm -- Farahlon Lasher.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Lasher_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Lasher_Enrage",1000,0)
    Unit:RegisterEvent("Lasher_Roots",1500,0)
    Unit:RegisterEvent("Lasher_Growth",500,0)
end

function Lasher_Enrage(Unit,Event)
    Unit:CastSpell(3019)
end

function Lasher_Roots(Unit,Event)
    Unit:FullCastSpellOnTarget(12747,Unit:GetClosestPlayer())
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

RegisterUnitEvent (20774, 1, "Lasher_OnEnterCombat")
RegisterUnitEvent (20774, 2, "Lasher_OnLeaveCombat")
RegisterUnitEvent (20774, 4, "Lasher_OnDied")
