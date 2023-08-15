--[[ Netherstorm -- Ekkorash the Inquisitor.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 26th, 2008. ]]

function Inquisitor_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Inquisitor_Weakness",1000,0)
    Unit:RegisterEvent("Inquisitor_Flamestrike",3000,0)
end

function Inquisitor_Weakness(Unit,Event)
    Unit:FullCastSpellOnTarget(11980,Unit:GetClosestPlayer())
end

function Inquisitor_Flamestrike(Unit,Event)
    Unit:FullCastSpellOnTarget(36040,Unit:GetClosestPlayer())
end

function Inquisitor_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Inquisitor_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19493, 1, "Inquisitor_OnEnterCombat")
RegisterUnitEvent (19493, 2, "Inquisitor_OnEnterCombat")
RegisterUnitEvent (19493, 4, "Inquisitor_OnEnterCombat")