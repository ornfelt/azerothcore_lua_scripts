--[[ Netherstorm -- Mo'arg Doomsmith.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Doomsmith_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Doomsmith_Doomsaw",1300,0)
end

function Doomsmith_Doomsaw(Unit,Event)
    Unit:FullCastSpellOnTarget(36200,Unit:GetClosestPlayer())
end

function Doomsmith_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Doomsmith_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (16944, 1, "Doomsmith_OnEnterCombat")
RegisterUnitEvent (16944, 2, "Doomsmith_OnLeaveCombat")
RegisterUnitEvent (16944, 4, "Doomsmith_OnDied")