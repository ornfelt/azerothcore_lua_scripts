--[[ Netherstorm -- Nether Ray.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Ray_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Ray_Drain",1000,0)
    Unit:RegisterEvent("Ray_Shock",1000,0)
    Unit:RegisterEvent("Ray_Sting",1000,0)
end

function Ray_Drain(Unit,Event)
    Unit:FullCastSpellOnTarget(17008,Unit:GetClosestPlayer())
end

function Ray_Shock(Unit,Event)
    Unit:FullCastSpellOnTarget(35334,Unit:GetClosestPlayer())
end

function Ray_Sting(Unit,Event)
    Unit:FullCastSpellOnTarget(36659,Unit:GetClosestPlayer())
end

function Ray_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Ray_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (18880, 1, "Ray_OnEnterCombat")
RegisterUnitEvent (18880, 2, "Ray_OnLeaveCombat")
RegisterUnitEvent (18880, 4, "Ray_OnDied")