--[[ Netherstorm -- Master Daellis Dawnstrike.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Master_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Master_Arrow",1000,0)
    Unit:RegisterEvent("Master_Clip",1000,0)
    Unit:RegisterEvent("Master_Shoot",1000,0)
end

function Master_Arrow(Unit,Event)
    Unit:FullCastSpellOnTarget(35964,Unit:GetClosestPlayer())
end

function Master_Clip(Unit,Event)
    Unit:FullCastSpellOnTarget(35963,Unit:GetClosestPlayer())
end

function Master_Shoot(Unit,Event)
    Unit:FullCastSpellOnTarget(6660,Unit:GetClosestPlayer())
end

function Master_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Master_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19705, 1, "Master_OnEnterCombat")
RegisterUnitEvent (19705, 2, "Master_OnLeaveCombat")
RegisterUnitEvent (19705, 4, "Master_OnDied")