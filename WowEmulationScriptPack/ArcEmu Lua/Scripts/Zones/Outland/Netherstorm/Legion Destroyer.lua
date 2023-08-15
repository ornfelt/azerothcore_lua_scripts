--[[ Netherstorm -- Legion Destroyer.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Destroyer_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Destroyer_Knock",1000,0)
    Unit:RegisterEvent("Destroyer_Strike",1000,0)
end

function Destroyer_Knock(Unit,Event)
    Unit:FullCastSpellOnTarget(11428,Unit:GetClosestPlayer())
end

function Destroyer_Strike(Unit,Event)
    Unit:FullCastSpellOnTarget(13737,Unit:GetClosestPlayer())
end

function Destroyer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Destroyer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20403, 1, "Destroyer_OnEnterCombat")
RegisterUnitEvent (20403, 2, "Destroyer_OnLeaveCombat")
RegisterUnitEvent (20403, 4, "Destroyer_OnDied")