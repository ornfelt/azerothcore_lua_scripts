--[[ Netherstorm -- Ethereum Shocktrooper.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Shocktrooper_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Shocktrooper_Glaive",1000,0)
    Unit:RegisterEvent("Shocktrooper_Hamstring",1000,0)
end

function Shocktrooper_Glaive(Unit,Event)
    Unit:FullCastSpellOnTarget(36500,Unit:GetClosestPlayer())
end

function Shocktrooper_Hamstring(Unit,Event)
    Unit:FullCastSpellOnTarget(31553,Unit:GetClosestPlayer())
end

function Shocktrooper_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Shocktrooper_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20453, 1, "Shocktrooper_OnEnterCombat")
RegisterUnitEvent (20453, 2, "Shocktrooper_OnLeaveCombat")
RegisterUnitEvent (20453, 4, "Shocktrooper_OnDied")
