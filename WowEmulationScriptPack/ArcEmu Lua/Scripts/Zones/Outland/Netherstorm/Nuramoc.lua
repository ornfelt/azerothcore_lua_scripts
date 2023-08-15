--[[ Netherstorm -- Nuramoc.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 29th, 2008. ]]

function Nuramoc_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Nuramoc_Lightning",2000,0)
    Unit:RegisterEvent("Nuramoc_Bolt",4000,0)
    Unit:RegisterEvent("Nuramoc_Shield",5000,0)
end

function Nuramoc_Lightning(Unit,Event)
    Unit:FullCastSpellOnTarget(15797,Unit:GetClosestPlayer())
end   
   
function Nuramoc_Bolt(Unit,Event)
    Unit:FullCastSpellOnTarget(21971,Unit:GetClosestPlayer())
end

function Nuramoc_Shield(Unit,Event)
    Unit:CastSpell(38905)
end
    
function Nuramoc_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Nuramoc_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20932, 1, "Nuramoc_OnEnterCombat")
RegisterUnitEvent (20932, 2, "Nuramoc_OnLeaveCombat")
RegisterUnitEvent (20932, 4, "Nuramoc_OnDied")