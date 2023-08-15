--[[ Netherstorm -- Mo'arg Warp-Master.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function WarpMaster_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("WarpMaster_Spray",2000,0)
end

function WarpMaster_Spray(Unit,Event)
    Unit:FullCastSpellOnTarget(36486,Unit:GetClosestPlayer())
end

function WarpMaster_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function WarpMaster_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20326, 1, "WarpMaster_OnEnterCombat")
RegisterUnitEvent (20326, 2, "WarpMaster_OnLeaveCombat")
RegisterUnitEvent (20326, 4, "WarpMaster_OnDied")