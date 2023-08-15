--[[ Netherstorm -- Rhonsus.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Rhonsus_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Rhonsus_Smithery",4000,0)
end

function Rhonsus_Smithery(Unit,Event)
    Unit:FullCastSpellOnTarget(36103,Unit:ClosestPlayer())
end   
    
function Rhonsus_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Rhonsus_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20410, 1, "Rhonsus_OnEnterCombat")
RegisterUnitEvent (20410, 2, "Rhonsus_OnLeaveCombat")
RegisterUnitEvent (20410, 4, "Rhonsus_OnDied")