--[[ Netherstorm -- Culuthas.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 24th, 2008. ]]

function Culuthas_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Culuthas_Felfire",3000,0)
end

function Culuthas_Felfire(Unit,Event)
    Unit:FullCastSpellOnTarget(37089, Unit:GetClosestPlayer())
end

function Culuthas_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Culuthas_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20138, 1, "Culuthas_OnEnterCombat")
RegisterUnitEvent (20138, 2, "Culuthas_OnLeaveCombat")
RegisterUnitEvent (20138, 4, "Culuthas_OnDied")