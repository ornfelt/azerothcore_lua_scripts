--[[ Netherstorm -- Protectorate Defender.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Defender_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Defender_Claive",4000,0)
    Unit:RegisterEvent("Defender_Hamstring",5000,0)
end

function Defender_Claive(Unit,Event)
    Unit:FullCastSpellOnTarget(36500,Unit:GetMainTank())
end   
    
function Defender_Hamstring(Unit,Event)
    Unit:FullCastSpellOnTarget(31553,Unit:GetMainTank())
end 
    
function Defender_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Defender_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20984, 1, "Defender_OnEnterCombat")
RegisterUnitEvent (20984, 2, "Defender_OnLeaveCombat")
RegisterUnitEvent (20984, 4, "Defender_OnDied")