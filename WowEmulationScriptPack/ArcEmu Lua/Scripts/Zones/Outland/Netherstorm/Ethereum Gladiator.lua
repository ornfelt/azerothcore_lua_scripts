--[[ Netherstorm -- Ethereum Gladiator.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Gladiator_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Gladiator_Cleave",1000,0)
    Unit:RegisterEvent("Gladiator_Hamstring",1000,0)
    Unit:RegisterEvent("Gladiator_Strike",1000,0)
end

function Gladiator_Cleave(Unit,Event)
    Unit:FullCastSpellOnTarget(15284,Unit:GetClosestPlayer())
end

function Gladiator_Hamstring(Unit,Event)
    Unit:FullCastSpellOnTarget(9080,Unit:GetClosestPlayer())
end

function Gladiator_Strike(Unit,Event)
    Unit:FullCastSpellOnTarget(16856,Unit:GetClosestPlayer())
end

function Gladiator_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Gladiator_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20854, 1, "Gladiator_OnEnterCombat")
RegisterUnitEvent (20854, 2, "Gladiator_OnEnterCombat")
RegisterUnitEvent (20854, 4, "Gladiator_OnEnterCombat")