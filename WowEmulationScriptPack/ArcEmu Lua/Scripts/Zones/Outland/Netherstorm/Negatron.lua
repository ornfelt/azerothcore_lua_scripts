--[[ Netherstorm -- Negatron.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Negatron_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Negatron_Charge",1000,(1))
    Unit:RegisterEvent("Negatron_Demolish",1000,0)
    Unit:RegisterEvent("Negatron_Quake",1000,0)
    Unit:RegisterEvent("Negatron_Enrage",1000,0)
end

function Negatron_Charge(Unit,Event)
    Unit:FullCastSpellOnTarget(35570,Unit:GetClosestPlayer())
end

function Negatron_Demolish(Unit,Event)
    Unit:FullCastSpellOnTarget(34625,Unit:GetClosestPlayer())
end

function Negatron_Quake(Unit,Event)
    Unit:FullCastSpellOnTarget(35565,Unit:GetClosestPlayer())
end

function Negatron_Enrage(Unit,Event)
    Unit:CastSpell(34624)
end

function Negatron_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Negatron_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19851, 1, "Negatron_OnEnterCombat")
RegisterUnitEvent (19851, 2, "Negatron_OnLeaveCombat")
RegisterUnitEvent (19851, 4, "Negatron_OnDied")