--[[ Netherstorm -- Legion Shocktrooper.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Shocktrooper_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Shocktrooper_Rand",1000,0)
end

function Shocktrooper_Rand(Unit,Event)
    Unit:FullCastSpellOnTarget(35144,Unit:GetClosestPlayer())
end

function Shocktrooper_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Shocktrooper_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20402, 1, "Shocktrooper_OnEnterCombat")
RegisterUnitEvent (20402, 2, "Shocktrooper_OnLeaveCombat")
RegisterUnitEvent (20402, 4, "Shocktrooper_OnDied")