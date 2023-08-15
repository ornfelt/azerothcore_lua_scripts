--[[ Netherstorm -- Overmaster Grindgarr.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 29th, 2008. ]]

function Grindgarr_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Grindgarr_Flames",5000,0)
    Unit:RegisterEvent("Grindgarr_Stomp",4000,0)
end

function Grindgarr_Flames(Unit,Event)
    Unit:FullCastSpellOnTarget(36487,Unit:GetClosestPlayer())
end   
   
function Grindgarr_Stomp(Unit,Event)
    Unit:FullCastSpellOnTarget(35238,Unit:GetClosestPlayer())
end
    
function Grindgarr_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Grindgarr_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20803, 1, "Grindgarr_OnEnterCombat")
RegisterUnitEvent (20803, 2, "Grindgarr_OnLeaveCombat")
RegisterUnitEvent (20803, 4, "Grindgarr_OnDied")