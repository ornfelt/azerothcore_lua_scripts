--[[ Netherstorm -- Forgemaster Morug.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Morug_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Morug_Blade",1500,0)
    Unit:RegisterEvent("Morug_Spray",1000,0)
end

function Morug_Blade(Unit,Event)
    Unit:FullCastSpellOnTarget(36228,Unit:GetClosestPlayer())
end

function Morug_Spray(Unit,Event)
    Unit:FullCastSpellOnTarget(34261,Unit:GetClosestPlayer())
end

function Morug_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Morug_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20800, 1, "Morug_OnEnterCombat")
RegisterUnitEvent (20800, 2, "Morug_OnLeaveCombat")
RegisterUnitEvent (20800, 4, "Morug_OnDied")