--[[ Netherstorm -- Cohlien Frostweaver.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 23th, 2008. ]]

function Frost_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Frost_Nova",8000,0)
    Unit:RegisterEvent("Frost_Bolt",3000,0)
    Unit:RegisterEvent("Frost_Barrier",30000,0)
end

function Frost_Nova(Unit,Event)
    Unit:FullCastSpellOnTarget(11831,Unit:GetClosestPlayer())
end

function Frost_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(9672,Unit:GetClosestPlayer())
end

function Frost_Barrier(Unit,Event)
    Unit:CastSpell(33245)
end

function Frost_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Frost_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19545, 1, "Frost_OnEnterCombat")
RegisterUnitEvent (19545, 2, "Frost_OnLeaveCombat")
RegisterUnitEvent (19545, 4, "Frost_OnDied")
