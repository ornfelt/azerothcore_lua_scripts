--[[ Netherstorm -- Area 52 Big Bruiser.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 21th, 2008. ]]

function Bruiser_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Bruiser_Net",1000,0)
end

function Bruiser_Net(Unit,Event)
    Unit:FullCastSpellOnTarget(12024, Unit:GetClosestPlayer())
end

function Bruiser_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Bruiser_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20484, 1, "Bruiser_OnEnterCombat")
RegisterUnitEvent (20484, 2, "Bruiser_OnLeaveCombat")
RegisterUnitEvent (20484, 4, "Bruiser_OnDied")
