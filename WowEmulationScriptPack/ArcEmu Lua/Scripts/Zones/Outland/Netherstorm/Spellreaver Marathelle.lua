--[[ Netherstorm -- Spellreaver Marathelle.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 01th, 2008. ]]

function Marathelle_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Marathelle_Tempest",4500,0)
    Unit:RegisterEvent("Marathelle_Ring",20000,0)
end

function Marathelle_Tempest(Unit,Event)
    Unit:FullCastSpellOnTarget(35843,Unit:GetClosestPlayer())
end   

function Marathelle_Ring(Unit,Event)
    Unit:FullCastSpellOnTarget(35831,Unit:GetRandomPlayer(0))
end

function Marathelle_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Marathelle_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19926, 1, "Marathelle_OnEnterCombat")
RegisterUnitEvent (19926, 2, "Marathelle_OnLeaveCombat")
RegisterUnitEvent (19926, 4, "Marathelle_OnDied")