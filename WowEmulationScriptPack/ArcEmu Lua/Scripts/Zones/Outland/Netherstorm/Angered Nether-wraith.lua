--[[ Netherstorm -- Angered Nether-wraith.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 21th, 2008. ]]

function Angered_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Angered_Bolt", 1000, 0)
    Unit:RegisterEvent("Angered_Blast", 6000, 0)
end

function Angered_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(39337, Unit:GetClosestPlayer())
end

function Angered_Blast(Unit,Event)
    Unit:FullCastSpellOnTarget(38205, Unit:GetClosestPlayer())
end

function Angered_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Angered_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (17870, 1, "Angered_OnEnterCombat")
RegisterUnitEvent (17870, 2, "Angered_OnLeaveCombat")
RegisterUnitEvent (17870, 4, "Angered_OnDied")


