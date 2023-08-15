--[[ Netherstorm -- Chief Engineer Lorthander.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 23th, 2008. ]]

function Chief_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Chief_Glaive",1000,0)
end

function Chief_Glaive(Unit,Event)
    Unit:FullCastSpellOnTarget(38204,Unit:GetClosestPlayer())
end

function Chief_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Chief_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (18697, 1, "Chief_OnEnterCombat")
RegisterUnitEvent (18697, 2, "Chief_OnLeaveCombat")
RegisterUnitEvent (18697, 4, "Chief_OnDied")
