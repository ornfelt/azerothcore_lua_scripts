--[[ Netherstorm -- Overseer Theredis.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 29th, 2008. ]]

function Theredis_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Theredis_Disarm",8000,0)
    Unit:RegisterEvent("Theredis_Breaker",9000,0)
end

function Theredis_Crystal(Unit,Event)
    Unit:FullCastSpellOnTarget(6713,Unit:GetMainTank())
end   
   
function Theredis_Breaker(Unit,Event)
    Unit:FullCastSpellOnTarget(35871,Unit:GetMainTank())
end
    
function Theredis_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Theredis_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20416, 1, "Theredis_OnEnterCombat")
RegisterUnitEvent (20416, 2, "Theredis_OnLeaveCombat")
RegisterUnitEvent (20416, 4, "Theredis_OnDied")