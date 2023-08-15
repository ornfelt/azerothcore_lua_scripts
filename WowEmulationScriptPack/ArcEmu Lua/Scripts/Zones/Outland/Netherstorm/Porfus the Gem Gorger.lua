--[[ Netherstorm -- Porfus the Gem Gorger.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Porfus_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Porfus_Hamstring",5000,0)
end

function Porfus_Hamstring(Unit,Event)
    Unit:FullCastSpellOnTarget(31553,Unit:GetMainTank())
end   
    
function Porfus_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Porfus_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20783, 1, "Porfus_OnEnterCombat")
RegisterUnitEvent (20783, 2, "Porfus_OnLeaveCombat")
RegisterUnitEvent (20783, 4, "Porfus_OnDied")