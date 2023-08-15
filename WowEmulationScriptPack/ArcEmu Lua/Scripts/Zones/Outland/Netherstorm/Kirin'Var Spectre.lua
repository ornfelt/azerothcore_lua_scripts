--[[ Netherstorm -- Kirin'Var Spectre.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Spectre_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Spectre_Curse",1000,0)
    Unit:RegisterEvent("Spectre_Bolt",3000,0)
end

function Spectre_Curse(Unit,Event)
    Unit:FullCastSpellOnTarget(11980,Unit:GetClosestPlayer())
end

function Spectre_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(9613,Unit:GetClosestPlayer())
end

function Spectre_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Spectre_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20496, 1, "Spectre_OnEnterCombat")
RegisterUnitEvent (20496, 2, "Spectre_OnLeaveCombat")
RegisterUnitEvent (20496, 4, "Spectre_OnDied")