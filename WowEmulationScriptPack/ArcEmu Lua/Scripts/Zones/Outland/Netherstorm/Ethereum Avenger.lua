--[[ Netherstorm -- Ethereum Avenger.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Avenger_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Avenger_Shout",1000,0)
    Unit:RegisterEvent("Avenger_Charge",1000,0)
    Unit:RegisterEvent("Avenger_Weapons",1000,0)
end

function Avenger_Charge(Unit,Event)
    Unit:FullCastSpellOnTarget(32064,Unit:GetClosestPlayer())
end

function Avenger_Intangible(Unit,Event)
    Unit:FullCastSpellOnTarget(36509,Unit:GetClosestPlayer())
end

function Avenger_Weapons(Unit,Event)
    Unit:FullCastSpellOnTarget(39489,Unit:GetClosestPlayer())
end

function Avenger_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Avenger_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (22821, 1, "Avenger_OnEnterCombat")
RegisterUnitEvent (22821, 2, "Avenger_OnEnterCombat")
RegisterUnitEvent (22821, 4, "Avenger_OnEnterCombat")