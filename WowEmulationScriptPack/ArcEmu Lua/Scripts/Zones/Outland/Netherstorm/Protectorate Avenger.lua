--[[ Netherstorm -- Protectorate Avenger.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Avenger_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Avenger_Claive",4000,0)
end

function Avenger_Claive(Unit,Event)
    Unit:FullCastSpellOnTarget(36500,Unit:GetMainTank())
end   
    
function Avenger_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Avenger_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (21805, 1, "Avenger_OnEnterCombat")
RegisterUnitEvent (21805, 2, "Avenger_OnLeaveCombat")
RegisterUnitEvent (21805, 4, "Avenger_OnDied")