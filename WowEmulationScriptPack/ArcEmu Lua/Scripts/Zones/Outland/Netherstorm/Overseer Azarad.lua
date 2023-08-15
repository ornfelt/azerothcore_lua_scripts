--[[ Netherstorm -- Overseer Azarad.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 29th, 2008. ]]

function Azarad_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Azarad_Rage",12000,0)
end

function Azarad_Rage(Unit,Event)
    Unit:CastSpell(35491)
end   
    
function Azarad_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Azarad_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20685, 1, "Azarad_OnEnterCombat")
RegisterUnitEvent (20685, 2, "Azarad_OnLeaveCombat")
RegisterUnitEvent (20685, 4, "Azarad_OnDied")