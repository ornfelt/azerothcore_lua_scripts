--[[ Netherstorm -- Severed Spirit.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Spirit_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Spirit_Nova",10000,0)
    Unit:RegisterEvent("Spirit_Bolt",4000,0)
end

function Spirit_Nova(Unit,Event)
    Unit:CastSpell(11831)
end   

function Spirit_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(20822,Unit:GetMainTank())
end

function Spirit_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Spirit_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (19881, 1, "Spirit_OnEnterCombat")
RegisterUnitEvent (19881, 2, "Spirit_OnLeaveCombat")
RegisterUnitEvent (19881, 4, "Spirit_OnDied")