--[[ Netherstorm -- Mana Seeker.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Seeker_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Seeker_Burn",3000,0)
    Unit:RegisterEvent("Seeker_Slow",2000,0)
end

function Seeker_Burn(Unit,Event)
    Unit:FullCastSpellOnTarget(11981,Unit:GetClosestPlayer())
end

function Seeker_Slow(Unit,Event)
    Unit:FullCastSpellOnTarget(36843,Unit:GetClosestPlayer())
end

function Seeker_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Seeker_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (18867, 1, "Seeker_OnEnterCombat")
RegisterUnitEvent (18867, 2, "Seeker_OnLeaveCombat")
RegisterUnitEvent (18867, 4, "Seeker_OnDied")