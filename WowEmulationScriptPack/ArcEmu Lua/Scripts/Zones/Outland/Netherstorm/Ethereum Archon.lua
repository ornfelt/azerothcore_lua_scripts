--[[ Netherstorm -- Ethereum Archon.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 26th, 2008. ]]

function Archon_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Archon_Flux",1000,0)
    Unit:RegisterEvent("Archon_Intangible",1000,0)
    Unit:RegisterEvent("Archon_Overspark",1000,0)
    Unit:RegisterEvent("Archon_Shadow",1000,0)
end

function Archon_Flux(Unit,Event)
    Unit:FullCastSpellOnTarget(35924,Unit:GetClosestPlayer())
end

function Archon_Intangible(Unit,Event)
    Unit:FullCastSpellOnTarget(36513,Unit:GetClosestPlayer())
end

function Archon_Overspark(Unit,Event)
    Unit:FullCastSpellOnTarget(35579,Unit:GetClosestPlayer())
end

function Archon_Shadow(Unit,Event)
    Unit:FullCastSpellOnTarget(36515,Unit:GetClosestPlayer())
end

function Archon_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Archon_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20458, 1, "Archon_OnEnterCombat")
RegisterUnitEvent (20458, 2, "Archon_OnEnterCombat")
RegisterUnitEvent (20458, 4, "Archon_OnEnterCombat")