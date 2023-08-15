--[[ Netherstorm -- Naberius.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Naberius_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Naberius_Nova",1000,0)
    Unit:RegisterEvent("Naberius_Bolt",3000,0)
end

function Naberius_Nova(Unit,Event)
    Unit:FullCastSpellOnTarget(36148,Unit:GetClosestPlayer())
end

function Naberius_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(15497,Unit:GetClosestPlayer())
end

function Naberius_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Naberius_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20483, 1, "Naberius_OnEnterCombat")
RegisterUnitEvent (20483, 2, "Naberius_OnLeaveCombat")
RegisterUnitEvent (20483, 4, "Naberius_OnDied")