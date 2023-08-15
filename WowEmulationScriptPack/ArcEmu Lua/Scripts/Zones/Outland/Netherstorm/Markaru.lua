--[[ Netherstorm -- Markaru.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Markaru_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Markaru_Spit",2500,0)
end

function Markaru_Spit(Unit,Event)
    Unit:FullCastSpellOnTarget(36627,Unit:GetClosestPlayer())
end

function Markaru_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Markaru_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20775, 1, "Markaru_OnEnterCombat")
RegisterUnitEvent (20775, 2, "Markaru_OnLeaveCombat")
RegisterUnitEvent (20775, 4, "Markaru_OnDied")
