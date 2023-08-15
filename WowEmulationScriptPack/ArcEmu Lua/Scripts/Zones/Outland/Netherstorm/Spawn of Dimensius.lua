--[[ Netherstorm -- Spawn of Dimensius.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 01th, 2008. ]]

function Dimensius_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Dimensius_Feed",5000,0)
end

function Dimensius_Feed(Unit,Event)
    Unit:FullCastSpellOnTarget(37450,Unit:GetMainTank())
end   

function Dimensius_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Dimensius_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (21780, 1, "Dimensius_OnEnterCombat")
RegisterUnitEvent (21780, 2, "Dimensius_OnLeaveCombat")
RegisterUnitEvent (21780, 4, "Dimensius_OnDied")