--[[ Netherstorm -- Dr. Boom.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 26th, 2008. ]]

function Boom_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Boom_Dynamite",1000,0)
end

function Boom_Dynamite(Unit,Event)
    Unit:FullCastSpellOnTarget(35276,Unit:GetClosestPlayer())
end

function Boom_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Boom_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20284, 1, "Boom_OnEnterCombat")
RegisterUnitEvent (20284, 2, "Boom_OnLeaveCombat")
RegisterUnitEvent (20284, 4, "Boom_OnDied")