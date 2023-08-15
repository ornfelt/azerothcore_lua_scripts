--[[ Netherstorm -- Silroth.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Silroth_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Silroth_Flames1",10000,0)
    Unit:RegisterEvent("Silroth_Flames2",2000,0)
end

function Silroth_Flames1(Unit,Event)
    Unit:CastSpell(36253)
end   

function Silroth_Flames2(Unit,Event)
    Unit:FullCastSpellOnTarget(36252,Unit:GetMainTank())
end

function Silroth_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Silroth_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20801, 1, "Silroth_OnEnterCombat")
RegisterUnitEvent (20801, 2, "Silroth_OnLeaveCombat")
RegisterUnitEvent (20801, 4, "Silroth_OnDied")