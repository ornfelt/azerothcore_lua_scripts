--[[ Netherstorm -- Ethereum Overlord.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Overlord_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Overlord_Shout",1000,0)
    Unit:RegisterEvent("Overlord_Charge",1000,0)
    Unit:RegisterEvent("Overlord_Weapons",1000,0)
    Unit:RegisterEvent("Overlord_Shadowtouched",1000,0)
end

function Overlord_Charge(Unit,Event)
    Unit:FullCastSpellOnTarget(36509,Unit:GetMainTank())
end

function Overlord_Shout(Unit,Event)
    Unit:CastSpell(32064)
end

function Overlord_Weapons(Unit,Event)
    Unit:FullCastSpellOnTarget(36510,Unit:GetClosestPlayer())
end

function Overlord_Shadowtouched(Unit,Event)
    Unit:CastSpell(36515)
end

function Overlord_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Overlord_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20459, 1, "Overlord_OnEnterCombat")
RegisterUnitEvent (20459, 2, "Overlord_OnLeaveCombat")
RegisterUnitEvent (20459, 4, "Overlord_OnDied")