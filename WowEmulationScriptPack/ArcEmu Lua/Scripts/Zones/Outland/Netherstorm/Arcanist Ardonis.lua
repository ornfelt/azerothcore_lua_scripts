--[[ Netherstorm -- Arcanist Ardonis.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 21th, 2008. ]]

function Ardonis_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Ardonis_Shadows",10000,0)
    Unit:RegisterEvent("Ardonis_Desecration",1000,0)
end

function Ardonis_Shadows(Unit,Event)
    Unit:CastSpell(36472)
end

function Ardonis_Desecration(Unit,Event)
    Unit:FullCastSpellOnTarget(36473, Unit:GetClosestPlayer())
end

function Ardonis_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Ardonis_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19830, 1, "Ardonis_OnEnterCombat")
RegisterUnitEvent (19830, 2, "Ardonis_OnLeaveCombat")
RegisterUnitEvent (19830, 4, "Ardonis_OnDied")