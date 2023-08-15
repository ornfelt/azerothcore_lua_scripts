--[[ Netherstorm -- Hatecryer.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, August, 2th, 2008. ]]

function Hatecryer_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Hatecryer_Curse",1000,0)
    Unit:RegisterEvent("Hatecryer_Rain",1000,0)
end

function Hatecryer_Curse(Unit,Event)
    Unit:FullCastSpellOnTarget(36541,Unit:GetClosestPlayer())
end

function Hatecryer_Rain(Unit,Event)
    Unit:FullCastSpellOnTarget(34017,Unit:GetClosestPlayer())
end

function Hatecryer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Hatecryer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20930, 1, "Hatecryer_OnEnterCombat")
RegisterUnitEvent (20930, 2, "Hatecryer_OnLeaveCombat")
RegisterUnitEvent (20930, 4, "Hatecryer_OnDied")