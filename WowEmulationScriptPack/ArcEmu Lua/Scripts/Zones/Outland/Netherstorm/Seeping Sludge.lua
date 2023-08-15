--[[ Netherstorm -- Seeping Sludge.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 30th, 2008. ]]

function Sludge_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Sludge_Split",2500,0)
end

function Sludge_Split(Unit,Event)
    Unit:CastSpell(36465)
    local x = Unit:GetX()
	local y = Unit:GetY()
	local z = Unit:GetZ()
	local o = Unit:GetO()
    Unit:SpawnCreature(21264, x-1, y, z, o, 14, o)
end   
    
function Sludge_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Sludge_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20501, 1, "Sludge_OnEnterCombat")
RegisterUnitEvent (20501, 2, "Sludge_OnLeaveCombat")
RegisterUnitEvent (20501, 4, "Sludge_OnDied")