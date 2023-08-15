--[[ Netherstorm -- Conjurer Luminrath.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 24th, 2008. ]]

function Conjurer_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Conjurer_Bolt",3000,0)
    Unit:RegisterEvent("Conjurer_Sword",30000,0)
end

function Conjurer_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(9532,Unit:GetClosestPlayer())
end

function Conjurer_Sword(Unit,Event)
    Unit:CastSpell(36110)
end

function Conjurer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Conjurer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19544, 1, "Conjurer_OnEnterCombat")
RegisterUnitEvent (19544, 2, "Conjurer_OnLeaveCombat")
RegisterUnitEvent (19544, 4, "Conjurer_OnDied")
