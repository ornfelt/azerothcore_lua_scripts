--[[ Netherstorm -- Furious Nether-wraith.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 29th, 2008. ]]

function Wraith_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Wraith_Bolt",1000,0)
    Unit:RegisterEvent("Wraith_Blast",6000,0)
end

function Wraith_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(39337,Unit:GetClosestPlayer())
end

function Wraith_Blast(Unit,Event)
    Unit:FullCastSpellOnTarget(38205,Unit:GetClosestPlayer())
end

function Wraith_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Wraith_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (22408, 1, "Wraith_OnEnterCombat")
RegisterUnitEvent (22408, 2, "Wraith_OnLeaveCombat")
RegisterUnitEvent (22408, 4, "Wraith_OnDied")