--[[ Netherstorm -- Disembodied Vindicator.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 24th, 2008. ]]

function Vindicator_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Vindicator_Revenge",1000,0)
    Unit:RegisterEvent("Vindicator_Vindication",1000,0)
end

function Vindicator_Revenge(Unit,Event)
    Unit:CastSpellOnTarget(36647,GetInRangeFriends())
end

function Vindicator_Vindication(Unit,Event)
    Unit:FullCastSpellOnTarget(36002,Unit:GetClosestPlayer())
end

function Vindicator_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Vindicator_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (18872, 1, "Vindicator_OnEnterCombat")
RegisterUnitEvent (18872, 2, "Vindicator_OnLeaveCombat")
RegisterUnitEvent (18872, 4, "Vindicator_OnDied")